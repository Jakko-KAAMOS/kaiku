# Doru Malaia Collection — Processing Pipeline

*Source: 193 WAVs extracted from the Doru Malaia library via collect_doru.sh*
*All processing reads from the archive. Source is not touched.*

---

## Phases

### Phase 1 — Collection and Segregation
Run `collect_doru.sh` once on the machine that holds the library.
Output: `~/doru-kaamos-YYYYMMDD.tar` (~122MB)
Copy to backup before extracting. Then done.

### Phase 2 — Processing (this document)
Extract archive to working location.
Run each processing mode against the extracted files.
Source WAVs inside the archive are never modified.

### Phase 3 — Kit Assembly
Build drum machine kits from the processed outputs.
See per-target briefs: drumkit_*.md

### Phase 4 — Synthesis Analysis
Per-sample analysis to inform synthesis experiments.
See synthesis_analysis.md (to be written after Phase 2 is running).

---

## Directory Structure (post-extraction)

```
doru-kaamos/
  Doru_Malia/                     -- extracted from tar, read-only
    CLAVES/          DM-CLV 01-59.wav
    LOG DRUM/        DM-LGD 01-10.wav
    TRIANGLE/        DM-TRI 01-91.wav
    TINGSHA ( TINGSHAG )/  DM-TING 01-13.wav
    ANVIL/           DM-ANV 01-20.wav

sounds/                           -- all processed outputs (kaiku repo)
  archival/                       -- lossless copies for archival use
    flac/                         -- FLAC from 24-bit source
      CLAVES/
      LOG DRUM/
      TRIANGLE/
      TINGSHA/
      ANVIL/
  web/                            -- web delivery, browser-safe
    hi/   44100Hz 16-bit mono     -- commodity high fidelity
    lo/   22050Hz 16-bit mono     -- bandwidth-constrained
  crush/                          -- bitcrushed derivatives
    8bit-11k/   8-bit  11025Hz    -- kevat quality (spring)
    6bit-8k/    6-bit   8000Hz    -- amber quality (signal)
    5bit-6k/    5-bit   6000Hz    -- hiljaisuus quality (silence)
    4bit-6k/    4-bit   6000Hz    -- talvi quality (dominant crush)
    4bit-4k/    4-bit   4000Hz    -- vintage minimum (emulated hardware floor)
  kits/                           -- drum machine kit exports
    ezdrummer2/
    addictive_drums/
    flstudio/
```

---

## Processing Modes

### Mode 1 — Archival WAV
The tar contains these. Do not process. Do not modify.
If you need an archival copy outside the tar: extract, verify checksum, store.
These are the Doru Malaia originals at 96kHz/24-bit/stereo. Nothing touches them.

### Mode 2 — Archival FLAC
Lossless compression of the 24-bit source for space-efficient archival.
Typical WAV-to-FLAC ratio for percussion: 50-65% size reduction.

```bash
# Requires flac CLI. One folder example:
for f in Doru_Malia/CLAVES/*.wav; do
    flac --best --silent "$f" -o "sounds/archival/flac/CLAVES/$(basename "${f%.wav}").flac"
done
```

Full pipeline: to be wrapped in `archive_flac.sh` (to be written).
Target: one FLAC per source WAV. No other changes. Bit-perfect on decode.

### Mode 3 — Web Delivery

**web/hi — 44100Hz 16-bit mono**
Standard web audio. Decent fidelity. Works in all browsers via Web Audio API.
Use for: REAPER session reference, plugin testing, anywhere quality matters.

```python
# In process.py (to be written):
# sox source.wav -r 44100 -b 16 -c 1 output.wav
# or via wave + numpy resampling (no sox dependency)
```

**web/lo — 22050Hz 16-bit mono**
Half the data rate of web/hi. Still recognizable. Use for: in-game audio
on bandwidth-constrained delivery (mobile, low-end web targets).
The triangle files at 22050Hz still sustain correctly.
The tingsha files at 22050Hz still ring for 4-15 seconds.

### Mode 4 — Bitcrushed Derivatives

Five crush stages. Each stage has a register identity and a use target.

| stage | bit | SR | register | use target |
|-------|-----|----|----------|------------|
| 8bit-11k | 8 | 11025 | kevat | web game, spring register |
| 6bit-8k | 6 | 8000 | amber | web game, signal register |
| 5bit-6k | 5 | 6000 | hiljaisuus | web game, silence register |
| 4bit-6k | 4 | 6000 | talvi | web game, winter register |
| 4bit-4k | 4 | 4000 | vintage | emulated hardware floor |

**Vintage minimum (4bit-4k):**
4000Hz is the Nyquist floor for intelligible voice.
For percussion it is extreme — the click becomes noise, the ring becomes
a low-frequency throb. This is the target for vintage hardware emulation:
Atari ST, Amiga Paula chip (8-bit, ~6.25kHz), ZX Spectrum beeper approximation.
At 4-bit/4kHz a claves hit is a blip. A log drum is a thud. A tingsha is
a sustained low wash. These are new instruments, not degraded ones.

`bitcrush.py` currently produces four of these five stages using the single
primary file per register. **Full pipeline extension needed:**
run all five stages against all 193 source files, not just the primaries.
This is `process_all.py` (to be written).

### Mode 5 — Synthesis Analysis

For each of the 193 source files, extract:

```
- duration_ms         : file length
- peak               : normalized peak amplitude (all 1.000 — source is normalized)
- rms                : RMS energy (proxy for perceived loudness)
- attack_ms          : time from onset to peak (transient speed)
- decay_tau_ms       : exponential decay time constant (fit to amplitude envelope)
- spectral_centroid  : weighted mean frequency (brightness proxy)
- fundamental_hz     : detected fundamental (if tonal) or None (if noise)
- resonant_peaks     : top 3 frequency peaks above noise floor
- noise_ratio        : ratio of noise energy to tonal energy (0=pure tone, 1=pure noise)
```

From this, each file gets a synthesis recipe tag:

| tag | description | synthesis approach |
|-----|-------------|-------------------|
| CLICK | fast attack, broadband decay <100ms | bandpass noise burst |
| THUD | fast attack, low-frequency decay | lowpass noise burst |
| RING | slow decay (>500ms), tonal | detuned sine pairs |
| TONE | sustained, clear fundamental | FM single stack |
| WASH | noise-dominant, long decay | filtered noise fade |
| COMPLEX | multiple resonant peaks | additive or resonator bank |

This becomes the input to `synthesis_analysis.md`.

---

## Register Summary (for all pipeline modes)

| register | folder | files | primary SR target | crush floor |
|----------|--------|-------|-------------------|-------------|
| meripihka | CLAVES | 59 | web/hi (transient — quality matters) | 4bit-4k |
| talvi | LOG DRUM | 10 | web/lo (low-frequency — SR less critical) | 4bit-4k |
| kevat/kesa | TRIANGLE | 91 | web/hi (sustain — quality matters) | 4bit-6k |
| hiljaisuus | TINGSHA | 13 | web/hi (long ring — quality matters) | 4bit-6k |
| vaara | ANVIL | 20 | web/hi (reserve) | 4bit-4k |

---

## What Comes Next

- `archive_flac.sh` — FLAC archival pass
- `process_all.py` — all five crush stages × all 193 files
- `synthesis_analysis.py` — per-file spectral extraction
- `synthesis_analysis.md` — populated analysis table
- drumkit_*.md — per drum machine assembly briefs (see those files)
- `process.py` — web/hi and web/lo resampling pass

---

*Cross-reference: collect_doru.sh, bitcrush.py, percussion_brief.md*
*Attribution in all derivative work: Percussion samples by Doru Malaia*
