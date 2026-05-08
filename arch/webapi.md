# web audio api — synthesis architecture

The two browser compositions in `games/` use the Web Audio API as a minimal FM/subtractive engine. No wavetables. No samples. No external dependencies. Everything that sounds is computed from first principles at the oscillator level.

This document describes the shared architecture. It is the technical ground from which the VST3 synthesizer grows.

---

## signal chain

```
oscillator(s)
  → biquad lowpass filter   (cutoff moves seasonally)
  → gain envelope           (attack / sustain / release)
  → master gain
  → AudioContext.destination
```

Both compositions follow this chain exactly. The differences are in oscillator type, filter parameters, gain values, and the seasonal trajectory of the cutoff.

---

## the 8-cent detuning

Both compositions use a paired oscillator running at ×1.008 of the fundamental — 8 cents sharp.

```js
const DETUNE_RATIO = 1.008;   // 8 cents sharp
osc2.frequency.value = freq * DETUNE_RATIO;
```

The beating between the two oscillators is the texture. This is not vibrato. It is the wheel. The imperfection is the instrument.

Lineage: Louis and Bebe Barron, *Forbidden Planet* (1956). Circuits as organisms. The instrument has a lifespan.

**Do not tune this out. Do not make it a user parameter. It is not configurable.**

---

## the 0.15Hz pulse

A tremolo LFO at 0.15Hz runs through both compositions. It also drives the wordmark animation in kuule and the breath noise in birch.

```js
const PULSE_HZ  = 0.15;          // Hiljaisuus rate
const PULSE_S   = 1 / PULSE_HZ;  // 6.67s period

const lfo = ctx.createOscillator();
lfo.type = 'sine';
lfo.frequency.value = PULSE_HZ;
```

Everything alive in this universe breathes at 0.15Hz. Not 0.1. Not 0.2.

---

## kuule — drone architecture

**Oscillator type:** sawtooth. Hurdy-gurdy register — the bourdon string, not a bowed string.

**The Hiljaisuus pulse (continuous):**

```
G2 bourdon. Two sawtooth voices:
  osc1: 98.0Hz
  osc2: 98.784Hz   (98.0 × 1.008)

Lowpass: cutoff 380Hz, Q 1.8
Master gain: 0.007

LFO: 0.15Hz, modulates gain ±0.5 scale
```

This drone never stops. It is the station.

**Ambient composition (13 minutes):**

Key: F# Phrygian. Range: F#2 through B3. Eleven pitches. Seven cycles, each containing:

| season | notes | filter cutoff |
|--------|-------|---------------|
| spring | 3 | 340–445Hz |
| summer | 1 | 540Hz (wide open, long decay) |
| purple | 7 | 425Hz → 152Hz (descending) |

Duration variation: base × (0.78–1.22), uniform random. Notes overlap. No sharp edges. The composition is a while loop — the organic irregularity is in the architecture.

**What it sounds like:** a hurdy-gurdy left alone in a room on a long winter. The drone is the room. The composition is what happens to the light.

---

## birch — koivuhuilu architecture

**Oscillator type:** sine. Flute register — pure, breathy by virtue of attack and slight flatness.

**Tuning:** −8 cents throughout.

```js
const FLAT = Math.pow(2, -8/1200);  // −8 cents
freq = baseFreq * FLAT;
```

The instrument is slightly flat because Taav's koivuhuilu is slightly flat. He carved it himself. This is not corrected.

**Two voices per note:**

```
voice 1: full filter cutoff
voice 2: cutoff × 0.88 (slightly darker), tremolo depth 0.13 vs 0.16
```

The two voices are the koivuhuilu duo. They breathe together but not identically.

**Tremolo per note:**

```js
const lfo = ctx.createOscillator();
lfo.frequency.value = 0.15;
// depth: 0.16 (voice 1), 0.13 (voice 2)
// modulates gain amplitude — this is breath, not vibrato
```

**Breath noise (forest at rest):**

```
white noise → bandpass (340Hz, Q 0.4, gain 0.040)
0.15Hz swell
runs continuously underneath the duo
```

**Seasonal structure (13 minutes, 7 cycles):**

| season | notes | register | filter |
|--------|-------|----------|--------|
| spring | 3 | F#4–E5, minor thirds | 540–580Hz |
| summer | 1 | C#5–E5, perfect fifth | 660Hz (long decay) |
| deep winter | 11 | F#3–F#2, descending | 490Hz → 170Hz |

At notes 9–10 the Phrygian blade enters (G3/G4 — the characteristic b2). At notes 10–11 the weird pitches arrive (C3, Bb2, Eb4 — outside the scale). Deep winter gets strange. This is correct.

**What it sounds like:** two birch flutes played in an empty forest in late autumn. The forest breathes. The summer was brief. The winter is long and gets strange at the edges.

---

## what both compositions share

| property | value |
|----------|-------|
| duration | exactly 13 minutes |
| key | F# Phrygian |
| pulse | 0.15Hz throughout |
| fade | silence in final 30 seconds |
| composition method | while loop with duration variation |
| dependencies | none |
| samples | none |
| wavetables | none |

The seasonal proportion is fixed: brief warmth, dominant winter. This is the structure of the universe made audible.

---

## score extraction

Both compositions are fully deterministic except for the `vary()` duration randomization. The pitch sequences, interval relationships, filter trajectories, and seasonal proportions can be extracted from the source.

A short script (Python or JS) can render either composition as a timestamped event list:

```
[time_s, pitch_hz, duration_s, filter_cutoff_hz, voice_interval]
```

From there: MIDI export, or direct REAPER notation. The extraction task is approximately 50 lines.

---

## relationship to the VST3

The Web Audio compositions are structural sketches. The harmonic language, seasonal architecture, and proportional form are correct and finished. The instruments are placeholder — sawtooth-through-lowpass for hurdy, sine-through-lowpass for koivuhuilu.

The VST3 (`vsti/`) is the correct instrument for both. When it exists, both compositions migrate to REAPER with proper instrumentation. The architecture described here is the specification for what the VST3 must reproduce and extend.
