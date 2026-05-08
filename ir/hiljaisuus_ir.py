#!/usr/bin/env python3
"""
hiljaisuus_ir.py -- KAAMOS synthetic impulse response generator
Portability fallback. Primary tool is Voxengo Impulse Modeler.
Requires: Python 3.8+, numpy.
Usage:
  python3 hiljaisuus_ir.py                    # station (default)
  python3 hiljaisuus_ir.py --preset forest
  python3 hiljaisuus_ir.py --preset ossuary
  python3 hiljaisuus_ir.py --preset trabant
  python3 hiljaisuus_ir.py --all
"""
import argparse, struct, sys, time
import numpy as np

C = 343.0

def write_float32_wav(filename, data, sr):
    data = np.clip(data, -1.0, 1.0).astype(np.float32)
    raw = data.tobytes()
    with open(filename, 'wb') as f:
        f.write(b'RIFF')
        f.write(struct.pack('<I', 36 + len(raw)))
        f.write(b'WAVE')
        f.write(b'fmt ')
        f.write(struct.pack('<I', 16))
        f.write(struct.pack('<H', 3))
        f.write(struct.pack('<H', 1))
        f.write(struct.pack('<I', sr))
        f.write(struct.pack('<I', sr * 4))
        f.write(struct.pack('<H', 4))
        f.write(struct.pack('<H', 32))
        f.write(b'data')
        f.write(struct.pack('<I', len(raw)))
        f.write(raw)

def lowpass(data, cutoff_hz, sr, taps=513):
    if cutoff_hz >= sr / 2.0:
        return data.copy()
    fc = cutoff_hz / (sr / 2.0)
    n = np.arange(taps) - (taps - 1) / 2.0
    h = np.sinc(fc * n) * np.blackman(taps)
    h /= h.sum()
    N = len(data) + taps - 1
    fft_len = 1 << int(np.ceil(np.log2(N)))
    y = np.fft.irfft(np.fft.rfft(h, fft_len) * np.fft.rfft(data, fft_len), fft_len)
    d = (taps - 1) // 2
    return y[d:d + len(data)].astype(np.float32)

def image_sources(room, src, mic, sr, ir_len, refl, order):
    Lx, Ly, Lz = room
    sx, sy, sz = src
    mx, my, mz = mic
    ir = np.zeros(ir_len, dtype=np.float64)
    max_dist = ir_len / sr * C
    count = 0
    for px in range(-order, order + 1):
        for qx in range(2):
            ix = 2*px*Lx + ((-1)**qx)*sx
            rx = 2*abs(px) if qx == 0 else abs(2*px - 1)
            for py in range(-order, order + 1):
                for qy in range(2):
                    iy = 2*py*Ly + ((-1)**qy)*sy
                    ry = 2*abs(py) if qy == 0 else abs(2*py - 1)
                    for pz in range(-order, order + 1):
                        for qz in range(2):
                            iz = 2*pz*Lz + ((-1)**qz)*sz
                            rz = 2*abs(pz) if qz == 0 else abs(2*pz - 1)
                            dist = np.sqrt((ix-mx)**2 + (iy-my)**2 + (iz-mz)**2)
                            if dist < 1e-6 or dist > max_dist:
                                continue
                            n_refl = rx + ry + rz
                            ds = int(dist / C * sr)
                            if ds >= ir_len:
                                continue
                            ir[ds] += (refl ** n_refl) / dist
                            count += 1
    print(f"    {count} image sources", file=sys.stderr)
    return ir

def generate_ir(p, sr=48000):
    ir_len = int(p['length_s'] * sr)
    decay  = 3.0 * np.log(10.0) / p['rt60']
    t      = np.arange(ir_len) / sr
    print(f"  early reflections ...", file=sys.stderr)
    t0 = time.time()
    early = image_sources(p['room'], p['src'], p['mic'], sr, ir_len, p['refl'], p['order'])
    early *= np.exp(-decay * t)
    print(f"  done in {time.time()-t0:.1f}s", file=sys.stderr)
    tr  = int(p.get('transition_s', 0.08) * sr)
    win = max(1, int(0.015 * sr))
    rms = np.sqrt(np.mean(early[max(0,tr-win):tr]**2) + 1e-20)
    rng = np.random.default_rng(seed=42)
    noise = rng.standard_normal(ir_len) * np.exp(-decay * t)
    if p['hf_hz'] < sr / 2:
        noise = lowpass(noise, p['hf_hz'], sr)
    noise_rms = np.sqrt(np.mean(noise[max(0,tr-win):tr]**2) + 1e-20)
    noise *= (rms * 0.4) / noise_rms
    noise[:tr] = 0.0
    ir = early + noise
    if p['hf_hz'] < sr * 0.45:
        ir = lowpass(ir, p['hf_hz'], sr)
    peak = np.max(np.abs(ir))
    if peak > 0:
        ir *= 0.9 / peak
    return ir.astype(np.float32)

PRESETS = {
    'station': {
        'label': 'Hiljaisuus Station Corridor',
        'file':  'hiljaisuus_station.wav',
        # 40x12x7m metal corridor. Far-wall reflection at ~221ms.
        # Sabine RT60=2.2s, refl=0.924 (14.6% energy absorption -- metal)
        'room': (40.0, 12.0, 7.0), 'src': (2.0,  6.0, 1.8), 'mic': (2.05, 6.0, 1.8),
        'rt60': 2.2, 'refl': 0.924, 'hf_hz': 22000, 'order': 10,
        'length_s': 4.0, 'transition_s': 0.10,
    },
    'forest': {
        'label': 'Voidborn Forest',
        'file':  'voidborn_forest.wav',
        # 18x14x11m Karelian boreal forest (pine/spruce/birch).
        # Sabine RT60=0.62s, refl=0.636 (59.6% energy absorption -- moss/pine)
        # HF rolloff above 4kHz: canopy + pine needle absorption.
        'room': (18.0, 14.0, 11.0), 'src': (9.0, 7.0, 1.8), 'mic': (9.05, 7.0, 1.8),
        'rt60': 0.62, 'refl': 0.636, 'hf_hz': 4000, 'order': 6,
        'length_s': 2.0, 'transition_s': 0.06,
    },
    'ossuary': {
        'label': 'Ossuary at Sedlec',
        'file':  'sedlec_ossuary.wav',
        # 12x8x5m Gothic underground chapel, stone vaults, bone surfaces.
        # Skulls act as broadband diffusers -- dense scatter, no strong echoes.
        # Sabine RT60=1.8s, refl=0.88 (22.5% absorption -- stone + bone scatter)
        # Mild HF rolloff above 6kHz. Short transition: surrounded, not corridor.
        'room': (12.0, 8.0, 5.0), 'src': (6.0, 4.0, 1.8), 'mic': (6.05, 4.0, 1.8),
        'rt60': 1.8, 'refl': 0.880, 'hf_hz': 6000, 'order': 8,
        'length_s': 4.0, 'transition_s': 0.04,
    },
    'trabant': {
        'label': 'Inside the Trabant',
        'file':  'trabant_interior.wav',
        # ~2.8x1.5x1.3m Trabant 601 cabin. Thin Duroplast shell, cloth seats,
        # hard dash. Very small -- resonant. Resonance peaks at ~120Hz (length)
        # and ~230Hz (width). Thin shell transmits and resonates; does not
        # isolate. RT60 short (0.18s) but dense -- every surface is close.
        # HF rolloff above 3kHz: cloth and headliner absorb. Body buzz lives
        # in the low-mids. Source/mic centered, close to dash -- driver position.
        # Sabine RT60=0.18s, refl=0.52 (73% absorption -- cloth, thin plastic)
        'room': (2.8, 1.5, 1.3), 'src': (0.9, 0.75, 0.9), 'mic': (0.95, 0.75, 0.9),
        'rt60': 0.18, 'refl': 0.520, 'hf_hz': 3000, 'order': 12,
        'length_s': 0.5, 'transition_s': 0.008,
    },
}

def main():
    pa = argparse.ArgumentParser(description='KAAMOS IR generator')
    pa.add_argument('--preset', choices=list(PRESETS), default='station')
    pa.add_argument('--all', action='store_true', help='Generate all presets')
    pa.add_argument('--sample-rate', '-r', type=int, default=48000)
    pa.add_argument('--output', '-o', type=str, default=None)
    pa.add_argument('--rt60', type=float, default=None)
    pa.add_argument('--refl', type=float, default=None)
    args = pa.parse_args()
    targets = list(PRESETS) if args.all else [args.preset]
    for name in targets:
        p = dict(PRESETS[name])
        if args.rt60: p['rt60'] = args.rt60
        if args.refl: p['refl'] = args.refl
        if args.output and len(targets) == 1: p['file'] = args.output
        print(f"\n[ {p['label']} ]", file=sys.stderr)
        print(f"  {p['room']}  RT60={p['rt60']}s  refl={p['refl']}  HF={p['hf_hz']}Hz  {p['length_s']}s @ {args.sample_rate}Hz", file=sys.stderr)
        ir = generate_ir(p, sr=args.sample_rate)
        write_float32_wav(p['file'], ir, args.sample_rate)
        print(f"  -> {p['file']}  ({len(ir)/args.sample_rate:.2f}s, float32, {args.sample_rate}Hz)", file=sys.stderr)

if __name__ == '__main__':
    main()
