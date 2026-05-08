# TESTING

Ear testing for the Kaiku VST3i. Windows64 build. F# Phrygian.

The instrument makes sound. These exercises confirm which sound, and whether it is the correct one.

This is the first iteration of [musicians-memory.com](https://musicians-memory.com) — practice materials for an instrument that does not exist anywhere else. Before testing, read [contrib/MISSION.md](contrib/MISSION.md) for the context that makes these exercises mean something.

---

## Directory layout

```
eval/
  exercises/     — HTML index, rendered PDF practice sheets, card thumbnails
  scores/        — LilyPond source (.ly) and MIDI renders (.mid)
TESTING.md       — this file
```

---

## Setup

### A note before you install

If you know the author, you've probably known him since the seventies — when he was likely the first person you ever met with a computer in the house. He is not trying to install a virus.

Windows will flag this. It should. It is a debug-symbols-enabled, highly experimental VST plugin from the free version of Visual Studio. It is the first thing the author has ever compiled with CMake on Windows, and it is the last thing he will do on this Windows 10 machine before upgrading it to 11. After that there will be a Windows 11 build and a proper installer. But the next task is the ear testing, and that task needs you.

There are practice sheets for Soprano, high Tenor, low Tenor, Contrabass, and piano reference. There are exercises for solo timbre, two-voice motion, full ensemble texture, and envelope behavior. The instructions in this document describe what to listen for in any drone synth — and this one needs that evaluation badly. The next release will have reverb.

### Installing the plugin

This is a test build. It carries debugging symbols and has not been installed to the system VST3 folder. The bundle is in the build tree:

```
vsti/build/Kaiku_artefacts/Release/VST3/Kaiku.vst3
```

In REAPER: **Options → Preferences → Plug-ins → VST**. Add the folder containing `Kaiku.vst3` to the VST plug-in paths, then click **Re-scan**. Kaiku will appear in the instrument list as `Kaiku (Kaamos)`.

A standalone build exists but has no on-screen keyboard and cannot drive MIDI from a score. It is not useful for these exercises. Use REAPER.

### Tempo and gain

**Tempo:** Set REAPER project tempo to **40 BPM** before loading any eval MIDI. REAPER ignores the MIDI file's embedded tempo and uses the project tempo. At 40 BPM: 6s sustain, 6s rest per note. At 120 BPM (REAPER default): 2s/2s — too short to evaluate decay or IR tails.

**Gain:** One instance of Kaiku per MIDI track for solo tests. For ensemble, pull each track fader to **−14 dB** before rendering — five voices at unity will clip (+14 dBTP).

### Loading exercises

Open [rebraining.org/practice/music/kaiku](https://rebraining.org/practice/music/kaiku) to see the full exercise index with practice sheets and download links.

In REAPER:
- Load the REAPER template from `eval/exercises/reaper-template.rpp`
- Kaiku is pre-instantiated on the MIDI track
- Render settings are pre-configured: 48 kHz, 24-bit, stereo
- Enable the spectrum analyser on the master bus before rendering

Use headphones or nearfield monitors. This is not a casual listen.

---

## Files

**Score sheets** — [rebraining.org/practice/music/kaiku/scores](https://rebraining.org/practice/music/kaiku/scores)

| file | voice | sounding range |
|---|---|---|
| [`fsharp_phrygian_contrabass.ly`](https://rebraining.org/practice/music/kaiku/scores/fsharp_phrygian_contrabass.ly) | contrabass | F#1–F#2 |
| [`fsharp_phrygian_low_tenor.ly`](https://rebraining.org/practice/music/kaiku/scores/fsharp_phrygian_low_tenor.ly) | low tenor | F#3–F#4 |
| [`fsharp_phrygian_lyric_soprano.ly`](https://rebraining.org/practice/music/kaiku/scores/fsharp_phrygian_lyric_soprano.ly) | lyric soprano | F#4–F#5 |
| [`fsharp_phrygian_piano.ly`](https://rebraining.org/practice/music/kaiku/scores/fsharp_phrygian_piano.ly) | piano (2 hands) | B1–B5 |

**MIDI eval suite** — [rebraining.org/practice/music/kaiku/midi](https://rebraining.org/practice/music/kaiku/midi)

| file | type | content |
|---|---|---|
| [`eval_contrabass.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_contrabass.mid) | Type 0 | 8 notes, F#1–F#2 |
| [`eval_low_tenor.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_low_tenor.mid) | Type 0 | 8 notes, F#3–F#4 |
| [`eval_lyric_soprano.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_lyric_soprano.mid) | Type 0 | 8 notes, F#4–F#5 |
| [`eval_piano.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_piano.mid) | Type 1, 2 tracks | treble 11 pitches (F#4–B5), bass 18 pitches (B1–F#4) |
| [`eval_ensemble.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_ensemble.mid) | Type 1, 5 tracks | all voices, channels 0–4, synchronized |

All MIDI: 40 BPM, TPQN 480, whole note + whole rest, sounding pitch.

**Renders** — `eval/`

| file | status | notes |
|---|---|---|
| `Contrabass-001.wav` | ✓ clean | baseline solo reference |
| `Ensemble_Preset_2.wav` | ✓ clean | baseline ensemble reference |
| `Contrabass.wav` | legacy | 120 BPM (short notes) — discard |
| `Ensemble.wav` | clipped | +9.4 dBTP, gain staging failure — discard |

---

## What we are testing

Kaiku has three FM stacks running in parallel (Tyhjyydenkaiku topology):

| Stack | Role | Ratio |
|-------|------|-------|
| A | F1 formant body | ~1.0× |
| B | F2 nasal partial | ~2.0× |
| C | Wheel carrier | 1.008× |

Stack C runs at 1.008× the fundamental. This creates a slow beating — the wheel imperfection. At F#1 the beat period is approximately 2.7 seconds. At F#5 it reads as fast vibrato (~5.9 Hz). **This beating is the instrument. Do not report it as a defect.**

The Hiljaisuus LFO runs at 0.15 Hz — one cycle every 6.67 seconds. At ♩=40, a whole note is 6 seconds. Slow-tempo exercises are slow deliberately: to let the LFO complete a visible cycle.

---

## Phases

### Phase I — Timbre (Solo)

One pitch class at a time. One voice. Whole notes with whole rests between.

The rest is not silence — it is the test. Listen for the reverb tail, the release envelope, and the 1.008× beat. Each register presents differently. Do not skip contrabass.

**Exercises E01–E06.** Soprano, high tenor, low tenor, contrabass, and the b2 (G♮) isolated across all registers, plus piano reference.

The b2 (G♮) is load-bearing for the Phrygian character. It gets its own exercise. If it sounds wrong, everything downstream is wrong.

### Phase II — Motion (Two Voices)

Soprano against piano reference. Whole notes throughout.

Two things are tested simultaneously: FM formant interaction between voices (Stack A and B can stack unpredictably in parallel thirds), and the REAPER ensemble render path.

**Exercises E07–E11.** Similar motion, contrary motion, parallel thirds, parallel fourths, parallel fifths.

### Phase III — Ensemble (Full Texture)

All parts. Long notes, long rests.

The question at this phase is not timbre — Phase I settled that. The question is blend, mask, and alias. Does the nasal partial (Stack B) disappear in full texture or take over? Does the wheel carrier create beating artifacts between parts at close intervals?

**Exercises E12–E13.** Full texture sustained; full texture mixed motion.

### Phase IV — Envelope and Dynamics

Attack, sustain, release, tail. Velocity response. Voice stealing.

**Exercises E14–E17.**

- **E14 — Staccato, pp through ff.** Reveals click artifacts and release behavior. Each velocity level is a separate question.
- **E15 — Crescendo, sustained.** Does the sustain hold without drift? Does the FM character shift with amplitude?
- **E16 — LFO cycle, ♩=40.** The Hiljaisuus LFO completes one full cycle at this tempo. The modulation should be visible in the spectrogram as a slow periodicity on the amplitude envelope.
- **E17 — Re-trigger, same pitch.** Same note fired before the previous release completes. Tests the 16-voice allocator's behavior: phase cancellation, amplitude doubling, pop on re-attack.

---

## What to listen for

### Pitch

The F# Phrygian scale ascending: F#, G, A, B, C#, D, E, F#.

Each note should land on the correct scale degree and hold without drift.

**Known property:** a consistent +1–4¢ sharp offset across all patches and voices. This is stable — the Cw wheel stack at 1.008× interacting with the tuning reference. It is not a defect. It is the instrument. Flag any pitch that drifts *within* a sustained note, or any note that misses its scale degree.

### Patch character

Run each solo MIDI through all four patches:

| patch | what you are listening for |
|---|---|
| **Tyhjyydenkaiku** | the wheel beating — slow amplitude modulation from Cw at 1.008×. Present on every note across the full range. This is the instrument. |
| **Kuilunsikiö** | visceral, before-it-becomes-sound quality. Rougher than Tyhjyydenkaiku. |
| **Pohjankaiku** | Mellotron weight. Slower attack character. The echo across the north. |
| **Kuilukaiku** | stripped. The wheel alone. No formant body. Should feel sparse. |

### Range consistency

Check that each patch holds its character from the bottom of the range to the top. Specific things to flag:

- F#1 (contrabass low) — present and defined, not thin or missing
- F#5 (soprano high) — in character, not hardened or distorted
- Level variation across the scale — up to ~3 dB natural variation is expected; more than that is worth noting

### Trompette

On accented notes (high velocity), a fourth transient voice fires and decays in 80ms. This is the trompette bark. The eval MIDIs use moderate velocity (80) and may not trigger it. Test separately with a high-velocity note to confirm the transient fires and decays cleanly.

### Ensemble

Load [`eval_ensemble.mid`](https://rebraining.org/practice/music/kaiku/midi/eval_ensemble.mid). Five parts on channels 0–4: lyric soprano, low tenor, contrabass, piano treble, piano bass.

After gain staging (−14 dB per track or master):

- Listen for beating artifacts between voices on shared pitch classes (contrabass and soprano share F# an octave apart — interaction is expected; the question is whether it is musical or phasey)
- Check that the wheel beating in Tyhjyydenkaiku adds rather than subtracts across the 4-octave stack
- Confirm the bass register (F#1) is audible and not masked

**In the spectrogram:**
- Clean harmonic series with consistent FM sidebands
- Sideband pairs at ±1.008× intervals from each harmonic (the wheel carrier)
- Flat noise floor — no unexpected spikes
- Aliasing appears as energy above 15 kHz; this is a defect
- The LFO at 0.15 Hz is visible as slow amplitude periodicity on long notes

---

## IR evaluation

Not part of the pre-release eval. Scheduled for next phase.

When ready: use `Contrabass-001.wav` as the dry reference. Run through `ir/hiljaisuus_station.wav` in REAPER (ReaVerb). Compare dry and wet at matched levels. Listen for tail length, color, and whether the room complements or obscures the wheel beating.

Flag: any additional clipping in the wet signal. The +0.8 dBTP intersample peak present in the dry solo render may compound through convolution.

---

## Render settings

- Format: WAV, 48kHz, 16-bit
- Target peak: −5 to −6 dBFS sample peak
- Check true peak (dBTP) in render stats — flag anything above 0 dBTP
- Check integrated LUFS — solo reference is −6.1 LUFS; ensemble reference is −14.6 LUFS

---

## Reporting

Record findings in the GitHub wiki. One entry per exercise.

**Fields:** expected / observed / rating (Pass · Marginal · Fail) / notes.

Marginal = something audible that cannot be characterized. Fail = artifact, wrong pitch, silence where there should not be silence, pop, or spectrogram anomaly. If uncertain: Marginal. Write what was heard.

**Include with Marginal or Fail entries:**
- WAV render of the exercise
- Spectrogram screenshot of the anomaly

**Do not include:**
- REAPER project files
- Spectrogram screenshots for passing exercises
- Aesthetic opinions about the sound design
- Corrected or revised MIDI

---

## Phase 2 criteria

| Phase 1 result | Phase 2 action |
|----------------|----------------|
| All pass | Polyphony stress testing; full harmonic field at tempo |
| b2 exercises fail | Operator rebalancing before anything else |
| Envelope artifacts | ADSR parameter review; release curve adjustment |
| Beat inconsistent across registers | Stack C ratio implementation audit |
| Ensemble mask/alias | Stack B level calibration |

---

*Cross-ref: `vsti/SPEC.md` — patch topology and Cw detuning*
*Cross-ref: `ir/` — impulse responses*
