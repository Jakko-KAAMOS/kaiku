# Drum Kit Brief — Addictive Drums 2
## XLN Audio / tonal_design branch

---

## What Addictive Drums 2 Supports

Addictive Drums 2 is a closed sample ecosystem. XLN Audio ships prebuilt
ADpacks (.adpack files) containing their own proprietary samples.
There is no official custom WAV import pathway for end users.

**What AD2 does well:**
- Extremely tight kit sound design within its own library
- Per-piece EQ, compression, transient shaping
- Bleed and room simulation built in
- Strong MIDI groove library with humanization

**What AD2 does not do:**
- Accept arbitrary WAV files as kit pieces
- Allow user sample import at the piece level

---

## Recommended Implementation: MIDI Routing

Same principle as EZdrummer 2 Option B — use AD2 as a groove and feel engine,
route MIDI to an external sampler holding the Doru palette.

AD2 has better kit feel and humanization than EZdrummer 2.
Use it for that. Use the Doru samples for the actual sound.

### Signal chain

```
Addictive Drums 2
  |
  | MIDI out (per-piece routing, or full kit MIDI output)
  v
REAPER sampler (ReaSamplOmatic5000 or Kontakt)
  |
  | Doru WAVs mapped to incoming MIDI notes
  v
hiljaisuus_station.wav convolution send
  |
  v
Mix
```

### AD2 MIDI output configuration

AD2 can route each kit piece to its own MIDI channel or note.
In REAPER: set AD2 as a MIDI source, capture its output on a new track,
route to the sampler. The sampler receives notes, fires Doru samples.

The AD2 humanization (velocity variation, timing micro-shifts, ghost notes)
applies to the MIDI before it reaches the Doru samples.
This gives the Doru palette AD2's feel engine — which is the point.

---

## Addictive Trigger (separate XLN product)

XLN Audio makes **Addictive Trigger** — a drum trigger / sample replacement plugin.
It analyzes an incoming drum track and replaces or layers hits with custom WAV files.

This IS a supported WAV import pathway, and it is the correct XLN tool
for using custom samples in an XLN context.

**Addictive Trigger workflow with Doru:**
1. Use AD2 to generate or record a drum performance
2. Route AD2 audio output to Addictive Trigger
3. AT detects hits, fires corresponding Doru WAV on each hit
4. Blend: AT output (Doru) + AD2 direct (XLN kit coloring)

This allows the Doru samples to sit on top of or replace the AD2 kit sound
while retaining AD2's room, bleed, and processing character.

**Addictive Trigger sample format:**
- WAV, any standard SR (44.1/48kHz recommended), 16 or 24-bit
- Mono or stereo accepted
- Use `sounds/web/hi/` (44100Hz 16-bit mono) from the pipeline

---

## Velocity Layers in Addictive Trigger

AT supports velocity-mapped sample banks.
Same layering strategy as EZdrummer 2 brief applies.
See `drumkit_ezdrummer2.md` — Velocity Layers section.

AT additionally supports:
- Round-robin (multiple files per velocity layer, cycled to avoid machine-gun effect)
- The 59 claves files are ideal for round-robin on the meripihka register

---

## Kit Mapping for Addictive Trigger

| AD2 piece | trigger input | Doru file | mode |
|-----------|--------------|-----------|------|
| Kick | kick transient | DM-LGD 01.wav (talvi) | replace |
| Snare (center) | snare transient | DM-CLV 01.wav (meripihka) | layer |
| Snare (rim) | rimshot transient | DM-CLV 43.wav (meripihka short) | replace |
| Hi-hat (closed) | hihat transient | DM-CLV 07.wav (meripihka mid) | layer |
| Crash | crash transient | DM-TRI 01.wav (kevat) | replace |
| Ride | ride transient | DM-TRI 12.wav (kesa) | replace |
| Extra | any | DM-TING 01.wav (hiljaisuus) | replace |

Mode key:
- **replace**: Doru sample replaces the AD2 sound entirely
- **layer**: Doru sample blends with AD2 sound (set blend ratio in AT)

---

## Pending

- Verify Addictive Trigger version compatibility with REAPER on Linux
- AT may require Wine or Windows host — confirm Beeza setup
- Round-robin bank definition for meripihka (claves 59-file set)
- Blend ratio calibration for layer mode pieces

---

*tonal_design branch. Not for public.*
*Cross-reference: doru_pipeline.md, drumkit_ezdrummer2.md, percussion_brief.md*
