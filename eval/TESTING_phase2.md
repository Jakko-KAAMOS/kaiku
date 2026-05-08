---
document: kaiku — eval brief, Phase 2
status: draft
register: external tester
---

# Kaiku — Ear Testing, Phase 2
## The Two Reverb Units

Phase 1 tested the dry synthesizer voice in isolation. Phase 2 tests how Kaiku sits in a room.

There are two rooms. Each is a reverb unit loaded in Voxengo Pristine Space. They are parallel sends — both run simultaneously, at different levels. You are not choosing between them. You are learning how each one changes what you hear.

---

## Setup

Same REAPER project as Phase 1. Two additional tracks will be present:

- **Track: Station** — Pristine Space loaded with `hiljaisuus_station.wav`. Wet level: −6dB to start.
- **Track: Forest** — Pristine Space loaded with `voidborn_forest.wav`. Wet level: −6dB to start.

Both run as sends from the Kaiku MIDI track. Kaiku itself is dry.

Do not change the send levels until you have listened to each unit solo first.

---

## The Station

`hiljaisuus_station.wav`

A 40-metre metal corridor. Long, hard, directional. Think station underpass — the kind where a voice carries further than it should and comes back to you from the far wall. Pre-delay of 25–30ms separates Kaiku's attack from the tail; you will hear the dry note first, then the room opens behind it.

**Reverb time: 2.2 seconds.** The tail is long. At ♩=40, one bar is 6 seconds — the reverb does not decay before the next note arrives. This is intentional. The space accumulates.

**What to listen for:**
- The far-wall return at ~221ms. A single distinct late arrival, not a wash. Does it read as corridor or as blur?
- High frequencies preserved. The Station does not soften Kaiku — it extends it. The FM sideband character should remain audible in the tail.
- The b2 (G♮) in the Station. This interval was designed for this room. If it sounds wrong here, note it.
- At full texture (Phase III exercises, E12–E13): does the Station make the ensemble feel like a chord or a smear?

**The Station is Kaiku's room.** The 8-cent detuning and the metal corridor were designed together.

---

## The Forest

`voidborn_forest.wav`

A Karelian boreal forest — Scots pine, Norway spruce, silver birch. You are standing between trunks at irregular spacing, canopy 10 metres overhead, moss underfoot. The space is intimate without being small. Everything above 4kHz softens immediately. The low-mids stay warm and present.

**Reverb time: 0.62 seconds.** Short compared to the Station. The Forest releases before the next note. At ♩=40, there is space between notes.

**What to listen for:**
- Whether the Forest makes Kaiku sound natural or buried. This unit was not designed for Kaiku — it is here for comparison and secondary applications. If it feels wrong, that is information.
- The high-frequency softening. The Station preserves Kaiku's upper partials; the Forest absorbs them. Note which you prefer for which register (soprano versus contrabass).
- Pre-delay: 8–15ms. Shorter than the Station. The room arrives closer behind the attack.
- At full texture: the Forest may reduce beating between parts. Note whether this is a relief or a loss.

**The Forest is not Kaiku's room.** It is included because the birch flute voices on Side B may need it, and because the ear-check was always part of the plan. Trust what you hear.

---

## Listening order

1. Station solo — bypass Forest send. Run E01–E06 (single voice, Phase I exercises).
2. Forest solo — bypass Station send. Run E01–E06 again.
3. Both together at −6dB each — run E12 (full texture, sustained).
4. Adjust levels by ear. Document what ratio felt right and why.

---

## Report fields

Same format as Phase 1 — one entry per exercise per unit:

| field | content |
|-------|---------|
| Exercise | E01–E17 |
| Unit | Station / Forest / Both |
| Expected | what the spec says you should hear |
| Observed | what you actually heard |
| Rating | Pass / Marginal / Fail |
| Notes | free text — what you heard, not what you think is wrong |

**Marginal:** something changed that you can't characterize.
**Fail:** wrong pitch, silence, pop, click, or the room destroyed the note.

---

## What this means for Phase 3

- **Station passes, Forest passes independently** → blend testing. What ratio makes sense on which material?
- **Station passes, Forest buried the voice** → Forest is confirmed secondary-only. Use it only on birch flutes, not on Kaiku.
- **Station smears at full texture** → pre-delay adjustment needed before commit.
- **Either unit fails on the b2 (G♮, E05)** → something is wrong with the operator balance. Fix before the room.

---

*The room should place, not wash.*
*If you are listening for the reverb, the reverb is too loud.*
