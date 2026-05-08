# SID Patch Plan — Tyhjyydenkaiku Basic Register
## Starting point for chiptune iteration

*Goal: get the basic kaiku register into a SID VSTi. Not accurate. Not final. Iterable.*

---

## Which VSTi

You said you don't care. Here are the honest options in the free tier:

**Magical 8bit Plug 2** (YMCK) — genuinely free, has pulse/triangle/sawtooth/noise, no native ring mod, good enough to draft voice assignments and envelopes. Start here if you want zero friction.

**SID Station VST / community reSID wrappers** — search "reSID VSTi freeware" or check KVR Audio. Quality varies, some are abandonware but still run. These get you ring mod, sync, and the actual SID filter character. Worth the 20 minutes to find one if you want the wheel to actually beat rather than approximate.

**Plogue chipsounds** — $95, not free, but the gold standard if you want to know what the plan actually sounds like before hardware. Note for later.

The parameter targets below work on any of these. Translate to whatever you've got.

---

## Voice assignment

The FM spec has three stacks. The SID has three voices. The topology is the same instrument.

| SID voice | FM analog | Role |
|-----------|-----------|------|
| V1 | F1 — vowel body formant | Chest. The fundamental carrier. Pulse wave with PWM. |
| V2 | F2 — nasal/upper partial | Head. Sawtooth, octave or fifth above fundamental. |
| V3 | Cw — wheel carrier | The hurdy string. Ring-modded against V1 for the beat. |

The trompette (transient bark on accented notes) has no dedicated voice. Map it to a brief hard sync on V3 at note-on — the consonant attack before the wheel settles. If the VSTi doesn't support per-note sync triggering, skip it for now. The trompette is ornament, not structure.

---

## Starting parameters — voice by voice

### Voice 1 — F1 body (pulse wave)

The vowel body. Pulse with PWM gives the formant movement the FM gets from modulation index sweep.

| Parameter | Target | Notes |
|-----------|--------|-------|
| Waveform | Pulse | Not sawtooth — pulse width does the formant work |
| Pulse width | 40–50% | Start at 45%, adjust by ear |
| PWM rate | slow, ~0.3Hz | Subtle. Not vibrato. Just vowel drift. |
| PWM depth | 5–15% | If it sounds like chorus it's too much |
| Attack | 5ms | Immediate but not percussive |
| Decay | 80ms | |
| Sustain | 85% | Voice sustains — this is the wheel tone, not a pluck |
| Release | 200ms | |
| Filter | Yes — route V1 through filter | |
| Volume | 85% | |

### Voice 2 — F2 nasal/upper partial (sawtooth)

The head register. Sawtooth for partial content. Sits above V1 in pitch to approximate the F2 formant role.

| Parameter | Target | Notes |
|-----------|--------|-------|
| Waveform | Sawtooth | Full harmonic content, reads as nasal/reedy |
| Pitch offset | +7 semitones (fifth) | Or +12 (octave). Ear will tell you. Fifth is more vocal, octave is more instrument. |
| Attack | 8ms | Slightly slower onset than V1 |
| Decay | 100ms | |
| Sustain | 70% | Lower sustain than V1 — this is the partial, not the body |
| Release | 180ms | |
| Filter | Yes — route V2 through filter | |
| Volume | 65% | Quieter than V1. It's supporting, not competing. |

### Voice 3 — Cw wheel carrier (ring mod)

This is the load-bearing voice. The FM version uses `ops[4].ratio = 1.004629` (8 cents sharp) to create a slow beat against the fundamental. SID ring modulation produces sum-and-difference tones between V3 and V1's oscillator — which is the right mechanism for the same effect, different math.

Ring mod against V1 will produce tones at `(V1_freq + V3_freq)` and `(V1_freq - V3_freq)`. The difference tone is the beating. You want the difference tone to be slow — a few Hz. That means V3 needs to be slightly above or below V1's frequency, not at a harmonic interval.

| Parameter | Target | Notes |
|-----------|--------|-------|
| Waveform | Triangle or pulse | Triangle for clean beat. Pulse if you want roughness from the start. |
| Ring mod | ON, modulated by V1 | This is the mechanism. If your VSTi doesn't have ring mod, tune V3 slightly sharp instead — same effect, less hardware-accurate. |
| Pitch offset | +8 cents | If ring mod: relative to V1 pitch. If no ring mod: absolute detune. |
| Hard sync | OFF for now | Add later to test consonant attack. Sync+ring together gets complex fast. |
| Attack | 5ms | Same as V1 — the wheel runs with the voice |
| Decay | 500ms | Slow decay — the wheel takes time to stop |
| Sustain | 100% | The wheel sustains fully |
| Release | 80ms | Quick release — the wheel stops when you stop |
| Filter | Maybe — test both | Routing V3 through the filter can either help or destroy the beat. Test unfiltered first. |
| Volume | 75% | |

---

## The filter — the real constraint

The SID has one filter. In the FM spec, each stack is independent. Here, the filter is shared. This is not a problem to solve — it's a constraint that defines the SID version of the instrument.

**Starting filter targets:**

| Parameter | Target | Notes |
|-----------|--------|-------|
| Filter type | Low-pass | Start here. The FM vowel formant is mostly sub-3kHz energy. |
| Cutoff | 800–1200Hz at sustain | Sweep it. The FM modulation index does what this does. |
| Resonance | 20–30% | Mild peak. Enough to add the formant notch without screaming. |
| Envelope amount | +400–600Hz on attack | The consonant attack opens the filter, then it settles. |
| Filter env attack | 2ms | Fast |
| Filter env decay | 60ms | Corresponds to the FM indexDecay of 60ms |
| Voices routed | V1 + V2, not V3 | Start with V3 unfiltered. The wheel beat survives better unfiltered. |

**What will happen:** The vowel formant will sound more like a single static tone character than the FM version's continuous spectral movement. That's correct — the SID version is lower resolution. The character is still there. The mouth is smaller.

---

## What will sound wrong

**The vowel is flatter.** FM gets formant movement from index envelopes on each stack independently. SID gets one filter sweep for all voices. The FM version breathes. The SID version has one breath. This is the constraint, not a bug.

**The wheel beat may be too obvious or too subtle.** The FM version's 8-cent ratio creates about 1–2Hz beating at concert A. Ring mod gives you sum-and-difference tones that aren't quite the same shape — they can sound more metallic and less periodic. Tune V3 by ear until the beating feels like a slow wheel, not a flange.

**No polyphony.** SID has three voices total. The FM spec runs 16-voice polyphony. This means the SID version is monophonic — one note at a time, all three voices assigned to a single pitch. That's fine for now. Polyphony is the hardware problem, not the software draft problem.

**The trompette will be absent or approximate.** A noise burst or hard-sync hit on V3 at attack is the closest approximation. If it sounds bad, skip it. The trompette is ornament.

---

## First iteration sequence

1. **Get V1 running alone** — pulse wave, 45% width, ADSR as above, through filter. Does it read as a sustained vocal/bowed tone? If yes, continue. If it reads as a C64 lead, widen the pulse width and reduce resonance.

2. **Add V3 with ring mod (or detune)** — 8 cents sharp against V1. Does the beating start? Should be 1–3Hz at concert A. Too fast = sounds like chorus or flange. Too slow = inaudible. Adjust V3 pitch until the wheel is felt.

3. **Add V2** — fifth above at 65% volume. Does it add head register without drowning the body? Adjust pitch offset and volume. If it reads as a chord rather than a formant layer, drop it an octave or reduce volume to 40%.

4. **Filter sweep** — open and close the cutoff while holding a note. Find the range where the vowel character lives. Set that as the sustain cutoff. Set the attack peak 400–600Hz above it.

5. **Compare to FM.** They won't sound the same. Listen for whether the *shape* is the same — sustained tone with slow beating, formant body, slight nasal partial above. If the shape is there, the register is there. The resolution difference is correct.

---

## What this plan doesn't solve

**The trompette.** The fourth transient voice fires on accented notes in the FM spec. SID has no fourth voice. Options: repurpose V3 briefly (interrupt the wheel, fire a noise/sync burst, restart the wheel), or accept that the SID version doesn't have the trompette. The second option is probably right — the SID version is a smaller ensemble. Smaller ensembles don't have all the instruments.

**Polyphony.** One note at a time. Deal with it later.

**The Kuilunsikiö, Pohjankaiku, and Kuilukaiku patches.** The FM spec has four patches, all derived from Tyhjyydenkaiku. The SID version should derive the same way — waveform and filter character shifts, same voice topology. That's second-session work. Get the primary voice right first.

---

*The SID version is not trying to be the FM version at lower fidelity. It's the same instrument in a different material. The FM version is what the synthesizer sounds like with six operators. The SID version is what it sounds like with three oscillators and one filter. Both are Kaiku. Different resolution of the same thing.*
