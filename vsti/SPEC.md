# kaiku — synthesizer specification

FM synthesizer. 6 operators. 3 parallel stacks. 16-voice polyphony.

Primary target: REAPER on Linux. Also ships Windows and macOS. VST3.

---

Source lives in the feature branch — as-is, uncompiled. Main holds the spec. The spec is the contract. Source follows when it passes Kaija.

---

## design constraint

The worldborn didn't build Kaiku. It arrived with the first settlers and nobody replaced it because it worked. This is how all infrastructure works.

The 1982 ethic governs: the constraint is the form. The slot is full when it is full. Do not add more because you can.

---

## operator topology

6 operators arranged as 3 parallel stacks. Each stack is independent — no cross-stack modulation. The three stacks run simultaneously; their outputs sum to the voice output.

```
stack 1 (F1): modulator → carrier    (vowel body formant)
stack 2 (F2): modulator → carrier    (nasal upper partial)
stack 3 (Cw): modulator → carrier    (wheel carrier)
```

Voice count: 16. Polyphony is full — all 16 voices may be active simultaneously.

---

## tyhjyydenkaiku — primary voice

*Echo of the void.* The synthesizer is named for this sound.

| stack | role | character |
|-------|------|-----------|
| F1 | vowel body formant | the chest |
| F2 | nasal upper partial | the head |
| Cw | wheel carrier | running 8 cents sharp against fundamental |

The wheel carrier (Cw) runs at 1.008× the fundamental. The slow beating between Cw and the fundamental is the wheel. This is not vibrato. This is not modulation depth. It is a ratio, fixed.

```
Cw frequency = fundamental × 1.008
```

On accented notes a fourth transient voice fires and decays in 80ms. No sustain. The trompette bark.

**The 8-cent detuning is not configurable. It is the instrument.**

Lineage: Louis and Bebe Barron (1956). The imperfection is the instrument. The instrument has a lifespan.

---

## patch family

Four patches ship with v0.1, all derived from the Tyhjyydenkaiku topology:

| patch | character |
|-------|-----------|
| Tyhjyydenkaiku | primary — hurdy gurdy wheel + mouth |
| Kuilunsikiö | visceral — the thing before it becomes sound |
| Pohjankaiku | Mellotron-heavy — the echo across the north |
| Kuilukaiku | stripped — the wheel alone |

---

## voice parameters (per voice)

| parameter | description |
|-----------|-------------|
| fundamental | MIDI note + pitch bend |
| stack ratios | operator frequency as multiple of fundamental |
| modulation index | per-operator FM depth |
| envelope | ADSR per operator |
| wheel ratio | fixed at 1.008 — not exposed |
| trompette gate | accent velocity threshold |
| trompette decay | fixed at 80ms — not exposed |

The wheel ratio and trompette decay are architecture, not user parameters. They are not on the panel.

---

## platform targets

| platform | format | status |
|----------|--------|--------|
| Linux | VST3 | primary |
| Windows | VST3 | ships |
| macOS | VST3 | ships |

Build system: TBD — see `arch/` for technical commons decisions.

REAPER is the primary host. Behavior in other hosts is tested but not prioritized.

---

## the 0.15Hz pulse

The Hiljaisuus pulse is available as a global LFO target. Period: 6.67s. Rate: 0.15Hz.

Any parameter that breathes, breathes at this rate. Not 0.1Hz. Not 0.2Hz. Not user-configurable.

---

## panel register

Amber on void black. Monospace. Hex grid motifs where space allows. No chrome. No gradients except the amber rule. No rounded corners beyond 2–3px.

The panel is the instrument. It does not announce itself.

See `contrib/STYLE.md` for the full visual specification.

---

## what this is not

Not a general-purpose 6-operator FM synthesizer with a skin applied.
Not a DX7 clone.
Not a modular system.

The operator topology serves the sound it was built for. The sound was built first. The topology followed.
