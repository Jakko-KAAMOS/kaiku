#!/usr/bin/env python3
"""
trabant_radio.py -- shortwave/MW tuning ambience generator
The Trabant's radio. Scanning across the dial somewhere in Central Europe.
Produces a mono float32 WAV: static, carriers, fragments of signal.

Usage:
  python3 trabant_radio.py                  # 60s, output trabant_radio.wav
  python3 trabant_radio.py -d 120 -o out.wav
"""
import argparse, struct, sys
import numpy as np

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

def bandpass(data, lo, hi, sr, taps=255):
    """Bandpass via two windowed-sinc FIR filters."""
    def lp(d, cut):
        if cut >= sr / 2.0: return d.copy()
        fc = cut / (sr / 2.0)
        n = np.arange(taps) - (taps - 1) / 2.0
        h = np.sinc(fc * n) * np.blackman(taps)
        h /= h.sum()
        N = len(d) + taps - 1
        fl = 1 << int(np.ceil(np.log2(N)))
        y = np.fft.irfft(np.fft.rfft(h, fl) * np.fft.rfft(d, fl), fl)
        dly = (taps - 1) // 2
        return y[dly:dly + len(d)].astype(np.float32)
    return lp(data, hi) - lp(data, lo)

def envelope(n, attack, release, sr):
    """Simple trapezoid envelope."""
    env = np.ones(n)
    a = min(int(attack * sr), n // 2)
    r = min(int(release * sr), n // 2)
    if a > 0: env[:a] *= np.linspace(0, 1, a)
    if r > 0: env[-r:] *= np.linspace(1, 0, r)
    return env

def generate(duration_s=60, sr=48000, seed=7):
    rng = np.random.default_rng(seed)
    N = int(duration_s * sr)
    out = np.zeros(N, dtype=np.float64)
    t = np.arange(N) / sr

    # ── background: shaped static ──────────────────────────────────────────
    # Shortwave static is not white -- it has a pink-ish slope and
    # band-limited character. Two layers: wideband hiss + lower crackle.
    white = rng.standard_normal(N)
    hiss = bandpass(white, 800, 6000, sr).astype(np.float64)
    crackle = bandpass(rng.standard_normal(N), 200, 1200, sr).astype(np.float64)
    static = hiss * 0.18 + crackle * 0.08
    # Slow amplitude variation -- the static breathes
    lfo_static = 0.75 + 0.25 * np.sin(2 * np.pi * 0.07 * t + rng.uniform(0, 6))
    out += static * lfo_static

    # ── carriers: sine tones that fade in and out ──────────────────────────
    # AM/shortwave carriers. Heterodyne whistle when two carriers mix.
    carrier_freqs = [
        455,   # classic IF heterodyne whistle
        800,
        1240,
        2300,
        3900,
        5000,
        6150,  # shortwave broadcast band
        7200,
        9600,
    ]
    for cf in carrier_freqs:
        # Each carrier appears 1-3 times across the duration
        appearances = rng.integers(1, 4)
        for _ in range(appearances):
            start = rng.uniform(0, duration_s - 4)
            dur   = rng.uniform(1.5, 6.0)
            i0, i1 = int(start * sr), min(int((start + dur) * sr), N)
            if i1 <= i0: continue
            seg_t = np.arange(i1 - i0) / sr
            # Slight frequency wobble -- cheap AFC instability
            wobble = 1.0 + rng.uniform(-0.002, 0.002) * np.sin(2 * np.pi * 1.3 * seg_t)
            carrier = np.sin(2 * np.pi * cf * wobble * seg_t)
            amp = rng.uniform(0.04, 0.14)
            env = envelope(len(carrier), 0.3, 0.4, sr)
            out[i0:i1] += carrier * env * amp

    # ── voice-like fragments: AM modulated carriers ────────────────────────
    # Not real speech -- bandlimited noise modulating a carrier,
    # shaped to sit in the 300-3000Hz speech band. Reads as voice
    # from the next room through a wall of static.
    n_voices = rng.integers(4, 9)
    for _ in range(n_voices):
        start = rng.uniform(2, duration_s - 8)
        dur   = rng.uniform(2.0, 7.0)
        i0, i1 = int(start * sr), min(int((start + dur) * sr), N)
        if i1 <= i0: continue
        seg_len = i1 - i0
        seg_t   = np.arange(seg_len) / sr

        # Carrier frequency -- SW broadcast bands
        fc = rng.choice([3900, 5010, 6150, 7325, 9600, 11750, 15300])
        carrier = np.sin(2 * np.pi * fc * seg_t)

        # Modulator: bandlimited noise in speech range, shaped with
        # slow amplitude envelope to suggest phrase rhythm
        mod_noise = bandpass(rng.standard_normal(seg_len), 300, 3000, sr).astype(np.float64)
        # Phrase rhythm: 0.5-2Hz envelope variations
        phrase_rate = rng.uniform(0.5, 2.0)
        phrase_env  = 0.5 + 0.5 * np.abs(np.sin(np.pi * phrase_rate * seg_t +
                                                  rng.uniform(0, 3)))
        mod = mod_noise * phrase_env
        mod_rms = np.sqrt(np.mean(mod**2) + 1e-20)
        mod = mod / mod_rms  # normalize

        # AM modulation depth 0.4-0.8
        depth = rng.uniform(0.4, 0.8)
        am_signal = carrier * (1.0 + depth * mod)
        # Bandpass the result to speech+carrier region
        am_signal = bandpass(am_signal, 200, 4000, sr).astype(np.float64)

        amp = rng.uniform(0.05, 0.15)
        env = envelope(seg_len, 0.5, 0.6, sr)
        out[i0:i1] += am_signal * env * amp

    # ── tuning sweeps: brief whoosh of static as dial turns ───────────────
    n_sweeps = rng.integers(3, 8)
    for _ in range(n_sweeps):
        start = rng.uniform(1, duration_s - 2)
        dur   = rng.uniform(0.3, 1.2)
        i0, i1 = int(start * sr), min(int((start + dur) * sr), N)
        if i1 <= i0: continue
        seg_len = i1 - i0
        # Sweep: white noise burst with rising or falling tone
        sweep_noise = rng.standard_normal(seg_len)
        direction = rng.choice([-1, 1])
        f_start = rng.uniform(400, 2000)
        f_end   = f_start + direction * rng.uniform(500, 3000)
        seg_t   = np.arange(seg_len) / sr
        freq    = np.linspace(f_start, f_end, seg_len)
        phase   = np.cumsum(freq / sr) * 2 * np.pi
        sweep_tone = np.sin(phase)
        sweep = sweep_noise * 0.3 + sweep_tone * 0.5
        env = envelope(seg_len, 0.05, 0.1, sr)
        amp = rng.uniform(0.15, 0.35)
        out[i0:i1] += sweep * env * amp

    # ── final shaping ──────────────────────────────────────────────────────
    # Roll off below 150Hz (small speaker) and above 7kHz (AM bandwidth)
    out = bandpass(out, 150, 7000, sr).astype(np.float64)
    # Normalize with headroom
    peak = np.max(np.abs(out))
    if peak > 0:
        out *= 0.85 / peak
    return out.astype(np.float32)

def main():
    pa = argparse.ArgumentParser(description='Trabant radio SFX generator')
    pa.add_argument('-d', '--duration', type=float, default=60.0,
                    help='Duration in seconds (default 60)')
    pa.add_argument('-o', '--output', type=str, default='trabant_radio.wav')
    pa.add_argument('-r', '--sample-rate', type=int, default=48000)
    pa.add_argument('--seed', type=int, default=7)
    args = pa.parse_args()
    print(f"generating {args.duration}s Trabant radio ...", file=sys.stderr)
    ir = generate(args.duration, args.sample_rate, args.seed)
    write_float32_wav(args.output, ir, args.sample_rate)
    print(f"-> {args.output}  ({len(ir)/args.sample_rate:.1f}s, float32, {args.sample_rate}Hz)", file=sys.stderr)

if __name__ == '__main__':
    main()
