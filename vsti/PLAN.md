# vsti — development plan

If this were a challenge, the challenge would be: do anything remotely resembling any of this, in any way, with your agent. Bring whatever you want.

[rebraining.org/essays/direction](https://rebraining.org/essays/direction)

---

## the layers

In order to be real and not performative, we build in layers. Each layer is a PR. Each layer that introduces something technical earns a paper in `arch/` that demonstrates full understanding of what was introduced. The paper is not a tutorial. It is proof of work.

The confrontation is the archive. It doesn't need to say anything.

---

### layer 1 — noop VST

A PR showing what the project looks like to build a VST that compiles, loads into a host, and does nothing. No sound. No panel. No parameters. It exists, it initialises, it closes cleanly.

This is the scaffold. The build system is the deliverable. Everything after depends on it.

---

### layer 2 — one oscillator

A single oscillator. Audible. Correct. One voice, one waveform, MIDI pitch tracked.

Nothing else. Not a filter. Not an envelope. One oscillator that works and is understood.

---

### arch paper: the oscillator

Filed in `arch/` alongside `webapi.md`. Not a how-to. A demonstration that the following are understood:

- what a digital oscillator is at the sample level
- naive vs band-limited synthesis — aliasing, why it matters, what it costs
- wavetable approaches vs computed waveforms
- the specific choices made for this oscillator and why

The paper exists so that no one needs to ask whether the oscillator was understood. The answer is already there. They can read it or not.

---

### layer 3 — 6-operator FM

Three parallel stacks. F1, F2, carrier at 1.008x. The Tyhjyydenkaiku topology from `SPEC.md`, implemented. The 8-cent detuning is in the architecture, not exposed as a parameter.

This layer does not ship until the oscillator paper is written and the single oscillator layer passes Kaija.

---

## methodology

AI assistance is in use. The work is directed. The decisions are made by the composer. The instrument serves the music.

The feature branch accumulates. Main ships when it passes Kaija.

---

## open questions

- JUCE vs iPlug2 — licensing, Linux VST3 support, panel rendering
- Build system — CMake; CI target platforms
- Panel layout — hex grid motifs, control density
- Patch format — binary or human-readable; versioning

Sequenced, not blocked. The proof of concept runs. The spec is written. Layer 1 is next.
