# Drum Kit Brief — EZdrummer 2
## Toontrack / tonal_design branch

---

## What EZdrummer 2 Supports

EZdrummer 2 ships with Toontrack's own sample libraries (.EZX packs).
It does not natively import arbitrary WAV files into its kit browser.

**The practical route for custom WAV integration:**

Toontrack's **EZdrummer 2 MIDI** engine triggers samples. The samples
it triggers are its own. To use Doru Malaia samples *alongside* EZdrummer 2:

**Option A — Superior Drummer 3 (upgrade path)**
SD3 has full custom sample import: any WAV, any slot, velocity layers,
round-robin, mic bleed simulation. If the budget allows, this is the
correct Toontrack tool for this job. EZdrummer 2 is not.
Note: `kaiku.md` lists Superior Drummer as out of scope. Revisit if priorities shift.

**Option B — EZdrummer 2 as MIDI groove source only**
Use EZdrummer 2 purely to generate MIDI groove patterns.
Route MIDI out to a sampler (see below) that holds the Doru samples.
EZdrummer 2 does the rhythm programming. The Doru samples do the sound.

**Option C — Toontrack Custom Shop / EZX creation (advanced)**
Toontrack provides an EZX Creator for licensed partners.
This is not a public DIY path. Noted for completeness.

---

## Recommended Implementation: Option B

### Signal chain

```
EZdrummer 2 (MIDI groove source)
  |
  | MIDI out -- GM-mapped or custom map
  v
REAPER sampler track (ReaSamplOmatic5000 or similar)
  |
  | per-pad: one Doru WAV per MIDI note
  v
hiljaisuus_station.wav convolution
  |
  v
Mix
```

### MIDI Mapping for Doru palette

Standard GM drum map assignments for the five registers:

| GM note | GM name | Doru assignment | file |
|---------|---------|-----------------|------|
| 36 | Bass Drum 1 | talvi (log drum) | DM-LGD 01.wav |
| 38 | Snare | meripihka (claves) | DM-CLV 01.wav |
| 42 | Closed Hi-Hat | meripihka short | DM-CLV 43.wav |
| 46 | Open Hi-Hat | meripihka long | DM-CLV 33.wav |
| 49 | Crash Cymbal | kevat (triangle) | DM-TRI 01.wav |
| 51 | Ride Cymbal | kesa (triangle long) | DM-TRI 12.wav |
| 55 | Splash Cymbal | hiljaisuus | DM-TING 01.wav |
| 57 | Crash Cymbal 2 | hiljaisuus long | DM-TING 02.wav |
| 59 | Ride Bell | vaara (anvil) | DM-ANV 01.wav |

EZdrummer 2 groove patterns output to these GM notes by default.
The sampler receives them and fires the corresponding Doru file.

### Sample format for this route

ReaSamplOmatic5000 reads directly from the processed pipeline outputs.
Use `sounds/web/hi/` (44100Hz 16-bit mono) for REAPER session use.
No special export format needed.

---

## Velocity Layers

EZdrummer 2 sends velocity 1-127.
For a proper feel, each Doru register needs multiple velocity layers.

Suggested layering per register using available files:

**meripihka (claves) — 4 velocity layers**
```
pp  (1-40):   DM-CLV 43.wav  (31ms  -- barely there)
mp  (41-70):  DM-CLV 03.wav  (76ms  -- clean short)
mf  (71-100): DM-CLV 01.wav  (204ms -- standard)
ff  (101-127): DM-CLV 33.wav (260ms -- full ring)
```

**talvi (log drum) — 3 velocity layers**
```
pp  (1-50):   DM-LGD 10.wav  (268ms -- muted)
mf  (51-90):  DM-LGD 01.wav  (477ms -- standard)
ff  (91-127): DM-LGD 07.wav  (538ms -- maximum resonance)
```

**kevat (triangle) — 4 velocity layers**
```
pp  (1-40):   DM-TRI 36.wav  (295ms -- muted strike)
mp  (41-70):  DM-TRI 02.wav  (987ms -- short ring)
mf  (71-100): DM-TRI 01.wav  (1477ms -- standard)
ff  (101-127): DM-TRI 05.wav (3296ms -- long ring)
```

**kesa (summer triangle) — 1 layer**
```
any velocity: DM-TRI 12.wav  (7335ms -- one day. not velocity-sensitive.)
```

**hiljaisuus (tingsha) — 2 layers**
```
soft (1-70):  DM-TING 01.wav (4532ms -- standard ring)
full (71-127): DM-TING 02.wav (15410ms -- reserved for terminal events)
```

---

## Pending

- ReaSamplOmatic5000 patch definition (REAPER-specific config)
- Round-robin configuration for meripihka (59 claves files available)
- Velocity curve calibration against EZdrummer 2 groove dynamics
- Decision on Superior Drummer 3 scope

---

*tonal_design branch. Not for public.*
*Cross-reference: doru_pipeline.md, percussion_brief.md*
