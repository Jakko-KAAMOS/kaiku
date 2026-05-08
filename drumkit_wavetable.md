# Drum Kit Brief — Wavetable Synthesis
## Blofeld / Microwave XT / Pigments — tonal_design branch

---

## Context

The Doru collection in 16-bit/48kHz is the source.
The goal is not to play back the samples as one-shots.
The goal is to find the oscillating periods inside them and use those as wavetable material.

The long-decay files are the primary targets:
- TINGSHA (DM-TING 01: 4532ms, DM-TING 02: 15410ms) — the longest stable ring in the collection
- TRIANGLE (DM-TRI 01: 1477ms, DM-TRI 12: 7335ms) — the kesa file especially
- MANJEERA (DM-MAN 03: 2053ms) — warm, slower decay than triangle

The short-transient files are secondary targets — attack character, not oscillation:
- CLAVES (DM-CLV 01: 204ms) — the meripihka click
- SLIT DRUM (DM-SLI 10: 249ms) — woody fundamental

---

## What a Wavetable Frame Is

A single cycle of a waveform at a given moment in the sample's decay.
At the start of the TINGSHA ring: bright, complex, many harmonics.
50ms in: mellower, the attack partials have decayed.
500ms in: nearly pure tone, fundamental dominant.
2000ms in: sub-fundamental ghost, nearly silence.

Each of those moments, captured at a zero-crossing-aligned single cycle, is one wavetable frame.
A wavetable is a sequence of those frames — 32 or 64 of them — that the synth scans through.

---

## Extraction Workflow

### Step 1 — Identify stable oscillation region

For each target file, find where the transient has settled into periodic oscillation.
The TINGSHA: stable from ~20ms onward.
The TRIANGLE kesa: stable from ~30ms.
The CLAVES: the click is the whole event — harvest from the body, not the attack.

### Step 2 — Find fundamental period

Measure the zero-crossing period at the stable region.
This defines the single-cycle window size in samples at 48kHz.

Example: TINGSHA fundamental ~2000Hz → period = 48000 / 2000 = 24 samples.
Actual pitch will vary — measure, don't assume.

### Step 3 — Extract frames across the decay

Take 32–64 evenly-spaced single-cycle windows from the stable region to near-silence.
Each window: aligned to a zero crossing, length = one fundamental period.
Resample each window to the target wavetable frame size (Blofeld: 128 or 256 samples).

### Step 4 — Assemble wavetable

Concatenate frames in decay order: bright → dark → silent edge.
Or reverse for a swell character. Or non-linear spacing for specific timbral shapes.

---

## Target Platforms

### Waldorf Blofeld

Format: Waldorf Wavetable Editor (.mid sysex upload) or direct USB on later firmware.
Frame size: 128 samples (standard) or 256 samples (extended).
Wavetable size: 64 frames per table.
Max tables: 64 user wavetables.

Blofeld wavetable scan: morph position controlled by LFO, envelope, or mod wheel.
Scanning the TINGSHA decay on a slow LFO: the synth ages the bell in real time.

Import tool: Blofeld Wavetable Editor (Waldorf, free Windows/Mac).
Alternatively: SysEx-format wavetable generators exist for command-line use.

Beeza workflow:
1. Extract frames (Python script, see below)
2. Assemble into Waldorf WAV format (128-sample frames, concatenated, 16-bit)
3. Import via Waldorf Wavetable Editor or SysEx

### Waldorf Microwave XT

Older hardware. More restricted.
Format: SysEx via MIDI. Single wavetable = 64 waves × 128 samples.
The Microwave XT has 32 ROM wavetables + user RAM slots.

Import path: SysEx librarian (MIDI-OX on Windows, or amidi on Linux via USB-MIDI).
On Beeza: `amidi` is in the `alsa-utils` package.

The Microwave XT's character differs from Blofeld — older DAC, specific aliasing behavior.
Same wavetable source can sound quite different between the two. Run both.

### Arturia Pigments

Wavetable engine accepts standard WAV import directly.
Format: WAV file, any sample rate, with frames arranged linearly.
Pigments reads frame size from file length / number of frames, or detects automatically.

Most flexible of the three targets for custom wavetable import.
No format conversion tool needed — drop the assembled WAV into Pigments.

Pigments additionally supports:
- Sub-oscillator stacking from the same wavetable
- Spectral engine (FFT-based) as alternative to wavetable scan — useful for TINGSHA analysis
- Granular engine — can run Doru one-shots directly, separate from wavetable work

---

## Python Extraction Script (to be written — sounds/tools/extract_wavetable.py)

```python
# Pseudocode outline — full implementation pending

def extract_wavetable(wav_path, start_ms, end_ms, n_frames=64, frame_size=128):
    """
    Extract n_frames single-cycle windows from wav_path
    between start_ms and end_ms (stable region).
    Resample each to frame_size samples.
    Return concatenated array suitable for Blofeld/Pigments import.
    """
    # 1. Load wav (48kHz/16-bit from pipeline output)
    # 2. Find fundamental period via autocorrelation at start_ms
    # 3. Find zero crossing at each of n_frames evenly-spaced positions
    # 4. Extract one period, resample to frame_size
    # 5. Concatenate and export as 16-bit WAV

# Targets:
# TINGSHA 01: start=20ms, end=3000ms, 64 frames → tingsha-wavetable.wav
# TRIANGLE 12 (kesa): start=30ms, end=5000ms, 64 frames → kesa-wavetable.wav
# MANJEERA 03: start=25ms, end=1500ms, 32 frames → manjeera-wavetable.wav
# CLAVES 01: start=5ms, end=150ms, 32 frames → claves-wavetable.wav (attack texture)
```

---

## Tonal Character — What to Expect

**TINGSHA wavetable:** A bell decay scan. Bright metallic at position 0, pure tone at midpoint,
near-silence at end. On a slow LFO this becomes an evolving bell pad.
The Microwave XT will add its own aliasing character to the bright end — that's useful.

**Kesa (triangle) wavetable:** Warmer than TINGSHA. Slower harmonic decay.
The fundamental persists longer relative to overtones. A cleaner scan.
On Blofeld with a fast envelope on the morph position: a plucked triangle articulation.

**Manjeera wavetable:** The warmest of the three. Low harmonic density.
The difference between MANJEERA and TRIANGLE is the same as in the Berlin kit —
the character shift between open hat positions. That character carries into the wavetable.

**Claves wavetable:** Not a decay scan — a transient texture scan.
The meripihka click dissected into 32 frames of attack character.
Useful for FM-like percussive timbres in Pigments.

---

## Output Directory

```
sounds/wavetables/
  tingsha-wavetable.wav       -- 64 frames × 128 samples, 16-bit
  kesa-wavetable.wav          -- 64 frames × 128 samples, 16-bit
  manjeera-wavetable.wav      -- 32 frames × 128 samples, 16-bit
  claves-wavetable.wav        -- 32 frames × 128 samples, 16-bit
  blofeld/                    -- SysEx-ready format for Blofeld import
  microwave-xt/               -- SysEx-ready format for Microwave XT
```

---

## Pending

- Write extract_wavetable.py (autocorrelation-based frame extraction)
- Verify fundamental frequency of TINGSHA via sox spectrogram or Python FFT
- Determine Microwave XT SysEx format — check if amidi is available on KaamOS
- Test Pigments direct WAV import with assembled wavetable
- Run both Blofeld and Microwave XT in parallel on same wavetable source — compare character

---

*tonal_design branch. Not for public.*
*Cross-reference: doru_pipeline.md, drumkit_berlin_punk.md, percussion_brief.md*
*Hardware: Waldorf Blofeld, Waldorf Microwave XT, Arturia Pigments*
