#!/usr/bin/env python3
"""
bitcrush.py -- Doru Malaia sample bitcrusher
tonal_design branch -- kaiku

Reads source WAVs from the Doru Malaia library.
Produces crushed mono derivatives for web / game use.

Source files: 96kHz / 24-bit / stereo / normalized
Output files: 16-bit mono, reduced sample rate, quantized

Aliasing from naive decimation is intentional. The artifact is the texture.

Usage:
    python3 bitcrush.py                    # produce all targets
    python3 bitcrush.py --register amber   # single register
    python3 bitcrush.py --list             # show targets and exit
    python3 bitcrush.py --verify           # check source files only
    python3 bitcrush.py --doru /path/to/Doru_Malia  # override root

Requirements: numpy (stdlib wave used for I/O)
"""

import numpy as np
import wave
import argparse
import os
import sys

# Source library root. Override with --doru or DORU_ROOT env var.
DORU_ROOT = os.environ.get('DORU_ROOT', '/cygdrive/d/Doru_Malia')

# Output directory (relative to this script)
OUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sounds')

TARGETS = {
    'amber': {
        'name':      'meripihka -- the signal',
        'source':    'CLAVES/DM-CLV 01.wav',
        'output':    'clk-amber.wav',
        'bit_depth': 6,
        'target_sr': 8000,
        'note':      'woody grain, amber grit -- the click that is the station',
    },
    'winter': {
        'name':      'talvi -- the dominant condition',
        'source':    'LOG DRUM/DM-LGD 01.wav',
        'output':    'clk-winter.wav',
        'bit_depth': 4,
        'target_sr': 6000,
        'note':      'maximum crush -- muffled, low, barely a signal',
    },
    'spring': {
        'name':      'kevat -- three days of spring',
        'source':    'TRIANGLE/DM-TRI 01.wav',
        'output':    'clk-spring.wav',
        'bit_depth': 8,
        'target_sr': 11025,
        'note':      'highest fidelity of the set -- brief but present, this is why',
    },
    'silence': {
        'name':      'hiljaisuus -- Station Nine',
        'source':    'TINGSHA ( TINGSHAG )/DM-TING 01.wav',
        'output':    'clk-silence.wav',
        'bit_depth': 5,
        'target_sr': 6000,
        'note':      'near-inaudible grain -- the texture of the silence',
    },
}


def read_wav(path):
    """Read WAV, return (sample_rate, float32 mono ndarray)."""
    with wave.open(path, 'rb') as w:
        sr      = w.getframerate()
        nch     = w.getnchannels()
        sw      = w.getsampwidth()
        nframes = w.getnframes()
        raw     = w.readframes(nframes)

    bits = sw * 8

    if bits == 16:
        data = np.frombuffer(raw, dtype=np.int16).astype(np.float32) / 32768.0
    elif bits == 24:
        arr  = np.frombuffer(raw, dtype=np.uint8)
        pad  = np.zeros((len(arr) // 3, 4), dtype=np.uint8)
        pad[:, 1] = arr[0::3]
        pad[:, 2] = arr[1::3]
        pad[:, 3] = arr[2::3]
        data = pad.view(np.int32).flatten().astype(np.float32) / 2147483648.0
    elif bits == 32:
        data = np.frombuffer(raw, dtype=np.int32).astype(np.float32) / 2147483648.0
    elif bits == 8:
        data = (np.frombuffer(raw, dtype=np.uint8).astype(np.float32) - 128.0) / 128.0
    else:
        raise ValueError('Unsupported bit depth: {}'.format(bits))

    if nch >= 2:
        data = data.reshape(-1, nch).mean(axis=1)

    return sr, data


def write_wav(path, data, sr):
    """Write float32 mono ndarray as 16-bit WAV."""
    out = (np.clip(data, -1.0, 1.0) * 32767).astype(np.int16)
    with wave.open(path, 'wb') as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(sr)
        w.writeframes(out.tobytes())


def crush(data, source_sr, target_sr, bit_depth):
    """Decimate then quantize. Aliasing retained by design."""
    if source_sr != target_sr:
        step = source_sr // target_sr
        data = data[::step]
    levels = 2 ** bit_depth
    half   = levels // 2
    data   = np.round(data * half) / half
    return np.clip(data, -1.0, 1.0)


def verify_source(key, target, root):
    src = os.path.join(root, target['source'])
    if not os.path.exists(src):
        return False, 'NOT FOUND: {}'.format(src)
    try:
        sr, data = read_wav(src)
        dur_ms = int(len(data) / sr * 1000)
        kb = os.path.getsize(src) // 1024
        return True, 'OK  {}Hz  {}ms  {}KB'.format(sr, dur_ms, kb)
    except Exception as e:
        return False, 'ERROR: {}'.format(e)


def process(key, target, root, verbose=True):
    src_path = os.path.join(root, target['source'])
    out_path = os.path.join(OUT_DIR, target['output'])

    if verbose:
        print('\n-- {} ({}) --'.format(key, target['name']))
        print('   source:  {}'.format(target['source']))
        print('   output:  {}'.format(target['output']))
        print('   crush:   {}-bit @ {}Hz'.format(target['bit_depth'], target['target_sr']))
        print('   note:    {}'.format(target['note']))

    try:
        sr, data = read_wav(src_path)
    except Exception as e:
        print('   ERROR reading source: {}'.format(e), file=sys.stderr)
        return False

    crushed = crush(data, sr, target['target_sr'], target['bit_depth'])

    try:
        os.makedirs(OUT_DIR, exist_ok=True)
        write_wav(out_path, crushed, target['target_sr'])
        kb     = os.path.getsize(out_path) // 1024
        dur_ms = int(len(crushed) / target['target_sr'] * 1000)
        if verbose:
            print('   written: {}'.format(out_path))
            print('   result:  {}Hz  {}ms  {}KB'.format(target['target_sr'], dur_ms, kb))
        return True
    except Exception as e:
        print('   ERROR writing: {}'.format(e), file=sys.stderr)
        return False


def main():
    global DORU_ROOT
    parser = argparse.ArgumentParser(description='Bitcrush Doru Malaia samples for kaiku')
    parser.add_argument('--register', choices=list(TARGETS.keys()))
    parser.add_argument('--list',   action='store_true')
    parser.add_argument('--verify', action='store_true')
    parser.add_argument('--doru',   default=None)
    args = parser.parse_args()

    if args.doru:
        DORU_ROOT = args.doru

    root = DORU_ROOT

    if args.list:
        print('DORU_ROOT: {}'.format(root))
        print('OUT_DIR:   {}\n'.format(OUT_DIR))
        for key, t in TARGETS.items():
            print('  {:8}  {}-bit @ {}Hz  {}  ->  {}'.format(
                key, t['bit_depth'], t['target_sr'], t['source'], t['output']))
            print('           {}'.format(t['note']))
        return

    if args.verify:
        print('Verifying source files in: {}\n'.format(root))
        all_ok = True
        for key, t in TARGETS.items():
            ok, msg = verify_source(key, t, root)
            print('  {} {:8}  {}'.format('OK' if ok else 'XX', key, msg))
            if not ok:
                all_ok = False
        sys.exit(0 if all_ok else 1)

    targets = {args.register: TARGETS[args.register]} if args.register else TARGETS
    results = {key: process(key, t, root) for key, t in targets.items()}

    print('\n-- results --')
    for key, ok in results.items():
        print('  {} {}'.format('OK' if ok else 'XX', key))

    if not all(results.values()):
        sys.exit(1)


if __name__ == '__main__':
    main()
