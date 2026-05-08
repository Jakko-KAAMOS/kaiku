# SID Branch — Planning Brief
## Chiptune instantiation of the KAAMOS audio domain

*Status: pre-production. Open questions documented below.*

---

## What this is

A SID-native translation of the Tyhjyydenkaiku timbre vocabulary. Not a port and not a cover version — a revoicing of the same instrument in a different register, the way a score gets arranged for a smaller ensemble without losing the structure.

The three-voice SID architecture maps cleanly onto the three-stack FM topology. The mapping is not approximate. It is the right shape for this material.

This is not the 6809 branch. KaamOS as a software platform is out of scope for this project. What remains is the audio domain and the 1982 constraint — and on both counts, the SID is not a compromise. It is the authentic item.

---

## Hardware inventory (known)

**In the Akro Mills drawer:**
- C64 SIDs — quantity and variant (6581 vs 8580) to be confirmed
- C128 SIDs — at least two; almost certainly 8580

This matters because the 6581 and 8580 are different instruments.

| Chip | Filter character | Voltage | Used in |
|------|-----------------|---------|---------|
| 6581 | Leaky, warm, dirty — the filter that defines the C64 sound | 12V audio rail | C64 (early) |
| 8580 | Clean, accurate, more linear | 9V audio rail | C64C (late), C128 |

The 6581's filter leakage is not a defect. It is why the chip sounds the way it does. For KAAMOS material — the hurdy grit, the formant roughness, the Barron/Scott imperfection-as-instrument lineage — the 6581 is the more interesting chip. The 8580 is more predictable, which is sometimes the right call.

**Open question 1:** What is the 6581/8580 split in the drawer? Pull and read the markings.

---

## Hardware options for driving the chips

The SID is a parallel-bus device. To use a raw chip for production you need something to clock it at 1MHz and address its registers. Options, roughly in order of complexity:

**SIDBlaster USB** (or equivalent) — a small PCB that holds one SID chip, provides the clock and voltage rails, and connects to a computer via USB. Software writes to SID registers directly from the host. Well-documented. Multiple open implementations. This is probably the right starting point — it gets chips off the shelf and into audio signal chain with minimal infrastructure.

**HardSID** — older, ISA/PCI hardware, supports up to four chips. More capability, much harder to source and install in a modern machine. Not the first step.

**MiSTer FPGA** — runs a cycle-accurate C64 core including SID. Can use real chips or FPGA emulation. High accuracy but doesn't use your physical chips, which may or may not matter.

**Full C64/C128 hardware with MIDI** — an in-circuit SID player (various cartridges and interfaces exist) lets you drive the chips inside a working machine. This is the most authentic signal chain and also the most complex to track with.

**reSID / libsidplayfp** — software emulation, no hardware required. Highly accurate, especially for 8580. Useful for drafting and iteration. Not the final instrument if you have real chips.

**Open question 2:** Is there working C64 or C128 hardware, or only the chips? This determines whether full-hardware routing is viable without additional PCB work.

---

## The 1982 alignment

The SID chip shipped in 1982. This is not an approximation of the world bible constraint. It is the constraint, physically instantiated. The same year as the vinyl spec. The same year as the production ethic. The musical culture of the station is pre-digital by historical fact, not aesthetic choice — and the SID predates the digital dawn by the same logic.

The world bible says: *KaamOS runs on hardware a 1982 engineer could build. The record plays on a phonograph Selli owns.* The SID record plays on a SID. This is all of a piece.

---

## The KAAMOS vocabulary in SID terms

The Tyhjyydenkaiku FM spec has three parallel stacks. The SID has three voices. The topology is the same instrument at different resolution.

### Voice assignment (draft)

| SID Voice | FM analog | Mechanism |
|-----------|-----------|-----------|
| 1 | F1 formant body | Pulse wave, PWM for vowel color, filter sweep on attack |
| 2 | F2 nasal/upper partial | Sawtooth, higher register, partial filter blend |
| 3 | Wheel/breath — the beating string | Ring mod off Voice 1 or slight detune — this is how SID makes the hurdy beat |

**The hurdy wheel in SID terms:** Ring modulation (Voice 3 ring-mods against Voice 1's oscillator) produces sum-and-difference frequencies that create the same beating effect as the 1.004629 ratio detune in the FM engine. This is not a workaround. It is how the chip was designed to work. Hard sync on Voice 3 adds roughness on transients — the consonant attack.

**The shared filter** is the key constraint and the key opportunity. SID has one filter routed to some or all voices. In the FM spec, each stack is independent. In SID, the formant is a single sculpted space. This collapses the independence — which means the vowel character has to be carried primarily by the filter's frequency and resonance trajectory rather than by per-voice spectral shaping. This is a different instrument. It is not a lesser one.

### The death whistle and birch flute

These are monophonic threshold instruments in the composition. SID handles them cleanly: single voice, noise waveform for the kuolinvihellys register (the death whistle's breathy, formant-free quality), triangle wave for the koivuhuilu (warm, slightly flat, low partial content). Neither requires the full three-voice setup.

---

## Production target

**Open question 3:** What is the relationship between this branch and the vinyl record?

Options:
- **Side C** — a SID version of Side A as a separate release format (cassette, flexi-disc, or .sid file)
- **Game audio** — the chiptune branch lives in the game, the vinyl lives in the novel/record
- **Source material** — the SID provides raw material that gets processed into the vinyl tracks
- **Parallel canon** — both exist, neither explains the other, the gap between them is part of the facet mechanism

The world bible's facet mechanic (same work refracts differently for each audience) suggests the parallel canon option has structural support. Software developers / gamers receive the world, not the apparatus. A SID version of the KAAMOS sound is the world. The vinyl is the apparatus. They don't need to converge.

---

## Open questions, collected

1. What is the 6581/8580 split in the drawer? Pull and read the markings.
2. Is there working C64/C128 hardware, or only chips?
3. What is the production target — game audio, parallel release, source material, other?
4. Is real-chip hardware recording the goal, or is high-accuracy emulation (reSID) acceptable for the final output?

---

## Next steps (pending answers above)

- Catalog the chips
- Identify hardware path (SIDBlaster or equivalent if chips-only)
- Draft a SID register map for the Tyhjyydenkaiku voice assignment
- A/B the 6581 vs 8580 filter character against the timbre brief targets — the dirty filter may be closer to the hurdy spec than the clean one

---

*Note: the 6809/KaamOS software platform is out of scope for this project. The KaamOS name in the visual layer (palette, LookAndFeel) remains — it refers to the aesthetic identity of the universe, not the software platform. No changes needed in the kaiku repo on that account.*
