# Drum Kit Brief — FL Studio
## Image-Line / tonal_design branch

---

## Context

Doru Malaia published SUPERDRUMS 8000 in collaboration with Image-Line,
the makers of FL Studio. The 230 Ethnic Drums library followed.
FL Studio is the natural home for this material. It was designed here.

---

## What FL Studio Supports

FL Studio has full, native, unrestricted custom sample import.
Any WAV at any sample rate, bit depth, or channel count.
FL converts internally at the project sample rate.
This is the most direct path of the three drum machine targets.

Three FL Studio instruments can host the Doru kit:

---

## Instrument A — FPC (Fruity Pad Controller)

16 pads. Each pad holds one sample. Velocity-sensitive.
Saves as `.fpc` preset. Loads in any FL Studio project.

**Best for:** live performance mapping, quick kit assembly, 16-pad controllers.

### Pad layout for the Doru seasonal kit

```
PAD  1  [meripihka pp]   DM-CLV 43.wav    31ms  -- the ghost
PAD  2  [meripihka mp]   DM-CLV 07.wav    97ms  -- the snap
PAD  3  [meripihka mf]   DM-CLV 01.wav   204ms  -- the click
PAD  4  [meripihka ff]   DM-CLV 33.wav   260ms  -- the full ring

PAD  5  [talvi soft]     DM-LGD 10.wav   268ms  -- muted
PAD  6  [talvi mid]      DM-LGD 01.wav   477ms  -- standard
PAD  7  [talvi hard]     DM-LGD 07.wav   538ms  -- resonant
PAD  8  [-- empty --]

PAD  9  [kevat muted]    DM-TRI 36.wav   295ms  -- dampened
PAD 10  [kevat short]    DM-TRI 02.wav   987ms  -- brief ring
PAD 11  [kevat standard] DM-TRI 01.wav  1477ms  -- standard
PAD 12  [kesa]           DM-TRI 12.wav  7335ms  -- one day

PAD 13  [hiljaisuus]     DM-TING 01.wav 4532ms  -- standard ring
PAD 14  [hiljaisuus max] DM-TING 02.wav 15410ms -- terminal only
PAD 15  [vaara soft]     DM-ANV 13.wav   348ms  -- muted anvil
PAD 16  [vaara]          DM-ANV 01.wav   922ms  -- full strike
```

FPC velocity per pad: set each pad's volume envelope to respond to
MIDI velocity. No additional setup needed — FPC handles this natively.

**Sample format:** Use `sounds/web/hi/` (44100Hz 16-bit mono).
FPC does not need 96kHz source. It does not benefit from stereo on one-shots.

---

## Instrument B — Fruity DrumSynth Live / BooBass alternative: **DirectWave**

**DirectWave** is FL Studio's full-featured sampler.
Supports: velocity layers, round-robin, key mapping, loop points, envelopes.
This is the correct instrument for a production-quality Doru kit in FL.

### DirectWave bank definition

DirectWave uses a `.dwp` (DirectWave Program) format.
Samples mapped across MIDI notes with velocity zones.

**Mapping the meripihka register with round-robin:**
DirectWave supports multiple samples per velocity zone (round-robin).
59 claves files → assign all 59 as round-robin across the meripihka velocity zone.
Each hit cycles through a different claves recording.
No machine-gun effect. Doru's 59 recordings were made for this.

**Full bank layout:**

| MIDI note | register | velocity zone | files | mode |
|-----------|----------|--------------|-------|------|
| C2 (36) | talvi | pp 1-50 | DM-LGD 10.wav | single |
| C2 (36) | talvi | mf 51-90 | DM-LGD 01.wav | single |
| C2 (36) | talvi | ff 91-127 | DM-LGD 07.wav | single |
| D2 (38) | meripihka | pp 1-40 | DM-CLV 43.wav | single |
| D2 (38) | meripihka | mp 41-70 | DM-CLV 03-18.wav | round-robin |
| D2 (38) | meripihka | mf 71-100 | DM-CLV 01-12.wav | round-robin |
| D2 (38) | meripihka | ff 101-127 | DM-CLV 29-40.wav | round-robin |
| F#2 (42) | meripihka short | any | DM-CLV 41-59.wav | round-robin |
| A#2 (46) | kevat short | any | DM-TRI 35-50.wav | round-robin |
| C#3 (49) | kevat standard | pp 1-60 | DM-TRI 02.wav | single |
| C#3 (49) | kevat standard | ff 61-127 | DM-TRI 01.wav | single |
| D#3 (51) | kesa | any | DM-TRI 12.wav | single |
| G3 (55) | hiljaisuus | soft 1-70 | DM-TING 01.wav | single |
| G3 (55) | hiljaisuus | full 71-127 | DM-TING 02.wav | single |
| A3 (57) | vaara | any | DM-ANV 01.wav | single |

Round-robin file groups to be fully defined when DirectWave bank is built.
The claves round-robin is the priority — 59 files, natural variation, no repeats.

---

## Instrument C — Step Sequencer (channel-per-sample)

The original FL Studio workflow. One channel per sample.
Each channel: a WAV file, a step pattern, volume/pan per step.

**Best for:** pattern-based composition, the KAAMOS condensation logic.
The Condensation section (Section 2 of the track) maps naturally to this.

### Condensation pattern template

```
Channel 1: talvi       [DM-LGD 01.wav]  -- the beat that was always there
Channel 2: meripihka   [DM-CLV 01.wav]  -- the click that crystallizes
Channel 3: meripihka-g [DM-CLV 43.wav]  -- ghost hits, softer velocity
Channel 4: kevat       [DM-TRI 01.wav]  -- the signal that something changes
Channel 5: hiljaisuus  [DM-TING 01.wav] -- one ring per section, not per beat
```

Volume automation on talvi: starts at 0, fades in over 8-16 bars.
The step pattern exists from bar 1. The volume makes it audible gradually.
This is how Section 1 (Hiljaisuus) becomes Section 2 (Condensation).

---

## Bitcrushed Versions in FL Studio

FL Studio's Fruity Peak Controller and Gross Beat can process samples
in real time. But the pre-crushed files are better for the vintage target.

For the vintage emulation track (4bit-4k files):
- Load from `sounds/crush/4bit-4k/`
- Do not apply additional processing — the crush is the sound
- Route through the station IR for room placement only

---

## Export Format for FL Studio Kit

```
sounds/kits/flstudio/
  fpc/
    doru-kaamos.fpc       -- 16-pad FPC preset
  directwave/
    doru-kaamos.dwp       -- DirectWave bank definition
    samples/              -- symlinks or copies of web/hi files
  stepseq/
    condensation.flp      -- FL project fragment (step sequencer template)
```

The .fpc and .dwp files reference sample paths.
Path anchoring: use relative paths where possible.
Absolute paths will break when moved — use FL's "bundle samples" on export.

---

## Pending

- Build the .fpc preset (requires FL Studio on Windows — Beeza)
- Build the DirectWave bank definition
- Round-robin group finalization for meripihka (which 59 files go in which velocity zone)
- Step sequencer condensation template as standalone .flp fragment
- Test with FL Studio 21 on Beeza

---

*Doru Malaia published his first library with Image-Line in the early 2000s.*
*This is the correct host for his work. It was always going to come back here.*

---

*tonal_design branch. Not for public.*
*Cross-reference: doru_pipeline.md, drumkit_ezdrummer2.md, drumkit_addictive_drums.md*
