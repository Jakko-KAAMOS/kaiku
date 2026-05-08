# Kaamos — Timbre Brief
## FM Synthesis Specifications + Mellotron Integration

*Promethean instruments for the worldborn. Approximate. Refine in performance.*

---

## Patch Name

**Tyhjyydenkaiku** — *Echo of the void*
The instrument is an echo of things that don't physically exist inside it.
No mouth. No wheel. No tape. Mathematics remembering the shape those things make in air.

### Variant Names (patch family)

| Name | Translation | Register |
|------|-------------|----------|
| **Tyhjyydenkaiku** | Echo of the void | Primary patch — the instrument as given |
| **Kuilunsikiö** | Spawn of the abyss | More visceral variant — high modulation index, trompette forward |
| **Pohjankaiku** | Echo from the deep north | Mellotron-heavy variant — tape body dominant, FM recessed |
| **Kuilukaiku** | Abyss echo | Stripped variant — minimal, dry, what you'd carve on a tombstone |

---

## TIMBRE 1 — Mouth Music Voice
### Puirt-à-beul formant register, FM synthesis

**Sonic target:** The rhythmic oral syllables of Scottish diddling —
the consonant-vowel bursts of "dirt a doodle oodle," "hi ri di ri di rum."
Not a sampled voice. A machine that learned what mouths do from the outside.
The formants are real. The breath is not.

**Key acoustic properties:**
- Two primary formant peaks (F1 ~700Hz, F2 ~1200Hz, "ah/oh" vowel center)
- Percussive consonant attack — the mouth closing and opening
- Slightly nasal resonance (F3 hint ~2600Hz)
- Vowel color shifts via modulation index envelope (consonant → vowel transition)

---

### FM Architecture — 6 Operator, 3 Parallel Stacks

```
Op2 ──► Op1 ──► [OUT]   F1 formant stack
Op4 ──► Op3 ──► [OUT]   F2 formant stack
Op6 ──► Op5 ──► [OUT]   breath / upper partial stack
```

Each stack: one modulator driving one carrier. All three carriers sum to output.
This is DX7 Algorithm 19 / FM8 equivalent.

---

### Operator Parameters

```
┌──────┬────────┬───────┬───────┬──────────────────────────────────────────┐
│  Op  │  Role  │ Ratio │ Index │ Envelope (A / D / S% / R)                │
├──────┼────────┼───────┼───────┼──────────────────────────────────────────┤
│  1   │ F1 car │  1.00 │  —    │ 5ms / 80ms / 85% / 200ms  output: 85    │
│  2   │ F1 mod │  1.00 │  2.8  │ 1ms / 60ms / 40% / 150ms               │
│      │        │       │       │ (index envelope: 3.5 at attack → 2.0)   │
├──────┼────────┼───────┼───────┼──────────────────────────────────────────┤
│  3   │ F2 car │  2.00 │  —    │ 8ms / 100ms / 70% / 180ms  output: 65  │
│  4   │ F2 mod │  3.00 │  1.8  │ 2ms / 80ms / 30% / 120ms               │
│      │        │       │       │ (index envelope: 2.5 at attack → 1.2)  │
├──────┼────────┼───────┼───────┼──────────────────────────────────────────┤
│  5   │ F3 car │  4.01 │  —    │ 12ms / 200ms / 20% / 300ms  output: 30 │
│  6   │ F3 mod │  1.00 │  3.5  │ 0ms / 40ms / 10% / 200ms               │
│      │        │       │       │ (breath / whisper register)             │
└──────┴────────┴───────┴───────┴──────────────────────────────────────────┘
```

**Op2 feedback:** Self-feedback ~25% (DX7 feedback 4/7) — adds the slight
roughness of the vocal tract. Too much → buzzy. Too little → too pure.

**The consonant trick:** The modulation index at note onset is higher than at
sustain. This shifts spectral energy toward the upper partials on attack
(consonant = edge, turbulence) then settles into the vowel formant
(sustained = open, resonant). If your FM engine supports index envelopes, use them.
If not: raise Op2 output level by 15 points for the first 40ms via velocity → level.

---

### Additional Processing (post-FM)

```
Formant filter (if available):
  - Vowel: "ah" center (F1/F2 as above)
  - Width: moderate — don't over-sharpen. Mouths are not EQ.

Subtle chorus:
  - Rate: 0.3Hz  Depth: 8 cents  Mix: 20%
  - Mouths are never perfectly in tune with themselves.

Convolution reverb:
  - IR: hiljaisuus_station.wav (the room we built)
  - Mix: 15-25% — present in the space but not dissolved into it.
```

---

## TIMBRE 2 — Electric Hurdy Gurdy Lead
### Anna Murphy register, FM + Mellotron layer

**Sonic target:** The chromatic hurdy gurdy as Murphy plays it in Eluveitie —
wheel-driven continuous tone, strong odd harmonics, the trompette bark
on accented notes, electric pickup adding amp saturation and presence.
Dorian/modal character. Not a drone. A lead instrument that happens to buzz.

**Key acoustic properties:**
- Continuous excitation (wheel = never-ending bow) → very fast attack, infinite sustain
- Rich odd harmonics: strong 1st, 3rd, 5th partials
- Slight detuning between unison strings (~8 cents) — the "chorus" of the wheel
- Trompette bridge: a buzzy transient on accented notes, not a sustained buzz
- Electric character: midrange presence, slight overdrive, no bass bloom

---

### Layer Architecture

```
LAYER A: FM voice — wheel tone fundamentals
LAYER B: Mellotron V — Cello or Strings tape (the body, the breath of the tape)
LAYER C: FM voice — trompette (triggered by velocity or aftertouch)

A + B blended as lead. C triggered on accents only.
```

---

### LAYER A — FM Wheel Tone

```
Algorithm:
  Op2 ──► Op1 ──► [OUT]   fundamental + odd harmonic stack
  Op4 ──► Op3 ──► [OUT]   detuned unison (the second string)

Op 1 — carrier:    ratio 1.00,  level 90,  A: 3ms / S: 100% / R: 80ms
Op 2 — modulator:  ratio 1.00,  index 1.4  A: 5ms / D: 500ms / S: 60% / R: 100ms
                   (index 1.4 creates 3rd harmonic emphasis — the hurdy character)
                   feedback: 15% (adds slight wheel roughness)

Op 3 — carrier:    ratio 1.008, level 75,  A: 5ms / S: 100% / R: 80ms
                   (8 cents sharp — the second string, slightly off-tune from the wheel)
Op 4 — modulator:  ratio 1.00,  index 1.2  A: 5ms / D: 500ms / S: 55% / R: 100ms
```

**Note:** The 1.008 ratio on Op3 creates beating against Op1 at about 8 cents.
This is the defining character of the hurdy gurdy tone — two strings never
perfectly in agreement. Do not tune it out. The roughness is the instrument.

---

### LAYER B — Mellotron V Integration

**Patch starting point:** Cello (or Strings A)

```
Mellotron V settings:
  Tape speed: +0.3 semitones (slightly sharp — the tape breathes upward)
  Attack softener: 30% (reduces the tape "clunk" on note onset)
  Release: 60ms (tapes don't stop instantly)
  Tone control: slight mid presence boost (100-200Hz cut, 1-3kHz +2dB)

Layer blend:
  FM wheel (Layer A): 60%
  Mellotron Cello:    40%
  The Mellotron gives the bow-body resonance. The FM gives the string tension.
```

**Alternative starting point:** Arturia Pigments — FM engine for Layer A,
Wavetable or Sample engine with cello sample for Layer B, blend in Pigments mixer.

---

### LAYER C — Trompette (the bark)

The trompette is a second bridge on the hurdy gurdy that rattles against
a specific string when the wheel pressure increases. It produces a short,
clangorous buzz-bark — the rhythmic accent of the instrument.

```
FM architecture: single modulator → carrier, high index

Op 1 — carrier:    ratio 1.00,  level 95
Op 2 — modulator:  ratio 1.00,  index 6.5  (high index = clangorous, buzzy)
                   A: 0ms / D: 80ms / S: 0% / R: 40ms
                   (pure transient — no sustain. The bark, not the tone.)

Trigger: velocity > 90, or aftertouch, or separate MIDI channel
Pitch: fixed to root (trompette doesn't track pitch — it buzzes at resonance)
Mix: -12dB relative to Layer A. Present but not dominant.
```

---

### Additional Processing — Lead Voice

```
Amp simulation:
  - Mild overdrive: ~3dB of soft saturation (the electric pickup + small amp)
  - NOT a guitar amp. Closer to a bass DI with slight tube warmth.
  - Target: presence and wire, not crunch.

Tone shaping:
  - High-pass: 80Hz (hurdy gurdy has no bass bloom — the wheel removes it)
  - Presence: gentle 2kHz boost +2dB (the nasal register of the chanter string)
  - Air cut: 10kHz -3dB (not a bright instrument)

Convolution reverb:
  - Same IR: hiljaisuus_station.wav
  - Mix: 20-30% — the lead sits in the room, not on top of it.
```

---

## TIMBRE 3 — Choir Drone (Mellotron + FM hybrid)
### The Pohja voice — the foundation that does not move

**Sonic target:** The bass drone beneath the choir exercise (hiljaisuus_choir.ly).
Not a voice. Not a string. The hum of the station before anyone speaks.

```
Mellotron V: "Cello Low" or "Bass" tape
  - Single sustained note: F# below staff
  - Tape speed: -0.5 semitones (warmer, slightly flat — old tape)
  - Volume envelope: very slow attack (300ms), infinite sustain, slow release (500ms)

Layer with FM sub:
  - Single carrier, ratio 0.5 (subharmonic)
  - Modulation index: 0.3 (barely modulated — almost sine)
  - Level: -18dB (felt, not heard)

The drone does not ornament. It endures.
```

---

## Palette → Timbre Mapping

```
F# drone (Pohja):          Timbre 3  — Cello/bass tape + FM sub
F# Phrygian melody line:   Timbre 2  — Electric hurdy gurdy lead
Call voices (Lausuja):     Timbre 1  — Mouth music FM, moderate velocity
Echo voices (Kaiku):       Timbre 1  — Same patch, 2 bars delay, -3dB, +8ms pre-delay
Air voices (Ilma):         Timbre 1  — Same patch, long attack (200ms), low index (0.8)
Trompette accents:         Timbre 2C — Boss phase only

Convolution space: hiljaisuus_station.wav on all voices
Dry/wet: 15-25% — we are in the room, not drowning in it
```

---

## On Refinement

These are starting coordinates, not final positions.
The FM indices in particular are ears-on decisions — what reads as "formant"
in isolation may wash out or bite in context. Trust the studio.

The principle that doesn't change: classical composition approach, not effects.
The reverb is a room we built. The timbres are physics we approximated.
The refinement is finding what the instruments want to say in this language.

The worldborn didn't invent these instruments. They inherited them.
They made them work in conditions the inventors never imagined.
That's the brief.
