# Kaiku — SATB consort patch design

*A four-voice ensemble built from one instrument. Not a chorale. A consort.*

*Filed: 2026-05-14. For the v0.1+ Kaiku patch directory.*

---

## The four voices

Renaissance/baroque instrument-family logic. The voices aren't human singers
with vowel differences — they're four distinct *instruments* that happen to
share one FM engine. They live in the same room, breathe the same smoke,
and were built by the same maker — but they don't sound alike.

### S — *Formant flute*

The top voice. Hollow, breathy, vowel-shaped but not vocal.

- **Operator stack bias:** upper stack dominant. Low ops contribute air and breath noise only.
- **Formant target:** a held /u/ → /o/ smear. Not a /i/ flute — this is wooden, not silver.
- **Wheel carrier:** off, or vanishingly slow. The top voice doesn't waver.
- **LFO Hiljaisuus:** very shallow. A flute that's already tired.
- **Attack:** soft, ~30 ms. Release: medium, lets the room catch it.
- **Range:** D5 – G6, sweet spot D5 – D6.

### A — *Formant English horn*

The middle voice. Double-reed character. Nasal, slightly buzzed.

- **Operator stack bias:** middle stack carries the formant; upper stack adds the reed buzz as a high pair.
- **Formant target:** /ɛ/ → /æ/, the nasalized vowel double-reeds make naturally.
- **Wheel carrier:** present, slow — the reed-vibration analog. ~3 Hz.
- **LFO Hiljaisuus:** medium. A reed player's breath.
- **Attack:** medium with a slight bite (~15 ms with a brief op-3 transient).
- **Release:** short — reeds stop when air stops.
- **Range:** G3 – A5, sweet spot A3 – E5.

### T — *Drone baritenor*

The sustained tenor pad. Less a melodic instrument, more a *plane* the
other voices sit on. Half voice, half organ pipe.

- **Operator stack bias:** all three stacks balanced. The fundamental and 3rd partial both prominent.
- **Formant target:** open /ɑ/ with a slight chest resonance.
- **Wheel carrier:** present, medium-slow (~2 Hz). Audible as motion, not vibrato.
- **LFO Hiljaisuus:** medium-deep. Long swell over 4-8 bars.
- **Attack:** long (~80 ms). This voice arrives.
- **Release:** very long. This voice leaves over the IR.
- **Range:** D3 – D5, sweet spot G3 – G4.

### B — *Deep basso with the wheel*

The floor. Mostly grain. Pitch is almost a side effect.

- **Operator stack bias:** low stack heavy. Sub-harmonic op pair active.
- **Formant target:** /o/ → /u/, dark and rounded, jaw down.
- **Wheel carrier:** prominent, slow (~1 Hz). This is the hurdy-gurdy wheel,
  audible as period-1-second pulsing. Use the wheel carrier as a *feature*, not a coloration.
- **LFO Hiljaisuus:** deep. The whole voice moves in long arcs.
- **Grit:** light op-cross-modulation on op-6 → op-1 to produce gravel
  at fortissimo. Not distortion — *grain*.
- **Attack:** slow (~120 ms), the wheel needs to spin up.
- **Release:** the longest. The bass is the last thing in the room.
- **Range:** D1 – D3, sweet spot D2 – A2.

---

## How they relate

- **Tuning:** equal temperament for now. Spectral retuning (just intonation
  against a D fundamental) is a separate exercise. Not for this consort.
- **Voicings:** wide. Bass and baritenor an octave apart minimum. English horn
  sits a fifth or sixth above the baritenor. Flute floats wherever the line wants.
- **The wheel is the bottom-up clock.** Bass wheel at ~1 Hz, English horn at
  ~3 Hz, flute and tenor not strictly tied. The room hears the bass move,
  the reed move on top of that, the others above.

## The room

Not the ossuary. Smoke-filled room. That's not a chapel IR.

The four current IRs are wrong for this material. Future IR work:

- **Tavern interior** — wood, low ceiling, ~RT60 0.4s, with absorption
  from bodies and tobacco smoke (real acoustic — smoke and fabric damp HF).
- **Cellar** — stone walls but small volume, ~RT60 0.6s, very dark.
- **Roadhouse with tar paper** — flutter echo from parallel walls, mid-heavy.

Until those exist: **Voidborn Forest** is the closest IR we have. RT60 0.62s,
absorbent. Use it. The Trabant is too small; the Sedlec is too sacred;
the Hiljaisuus is too big and too clean.

## What this isn't

- A chorale. Four voices but not part-writing with cadences.
- A spectral piece. Pitches stay equal-tempered.
- Vocal mimicry. The voices sound like *instruments built by people who
  knew singers*, which is not the same.

## Next steps

1. Build the four patches in Kaiku's editor on the Windows side (minix).
2. Save them as `vsti/patches/consort/{S_flute,A_eh,T_baritenor,B_basso}.fxp` (or whatever Kaiku's preset format is).
3. Write a four-track REAPER project that maps a single SATB MIDI line to
   the four patches, routes all four to one bus, applies Voidborn Forest IR.
4. Compose for the consort — not a chorale, a piece for these four instruments.
   Slow, smoky, modal.

---

*"A formant flute, a formant English horn, a drone baritenor, and a deep,
deep, rich basso with lots of hurdy gurdy wheel and plenty of grit.
Smoke filled room."* — Jakko, 2026-05-14
