---
document: kaiku — synthesis engine proposals, post-FM
status: proposal
register: internal
---

# Engines After FM

Kaiku's FM engine models the hurdy-gurdy as a voice: three operator stacks for
vowel body (F1), nasal partial (F2), and wheel breath (F3), with a velocity-
gated trompette for the bark on accented notes. Self-feedback on Op[1] gives the
vocal roughness. The 8-cent detuning on the second hurdy string is in the patch,
not in the room.

What comes next depends on what KAAMOS still doesn't have. The proposals below
are ordered by how directly they address a gap in the current material.

---

## 1. Physical Modeling — waveguide synthesis

**The gap it fills:** The voidborn recording is a real birch flute. There is no
synthetic correlate. The FM voice is the metal station; the birch flute has no
engine of its own.

A digital waveguide models a resonating object as a delay line with reflection
filters at each end. For a flute: a closed cylindrical bore, a jet-edge
excitation (nonlinear), loss at the open end. For a string: simpler — one delay
line per propagation direction, a loss filter at the nut and bridge.

The string waveguide (Karplus-Strong and descendants) is trivial to implement in
JUCE: `dsp::DelayLine<float>` already exists, the reflection filter is a
one-pole lowpass. A bowed string adds a velocity-dependent bow-table lookup to
model the stick-slip interaction — 50-100 lines of DSP code.

The flute waveguide is harder. Jet dynamics are nonlinear; the jet-edge
interaction is typically modeled as a lookup table (jet table) or as a soft
clipper on the jet velocity. Smith (1986) and Cook (1992) are the canonical
references. Implementation is medium complexity — two weeks of focused work for
a functional, playable result.

**What it would sound like in this project:** The waveguide flute is breathy and
harmonic where the FM voice is dense and inharmonic. In the station corridor the
waveguide flute would carry differently than FM — the HF content is different,
the formant pattern is different. Running both in the same session with the same
IR would make the space read as a space rather than as a reverb setting.

The waveguide string is more immediately useful. A plucked or bowed string in
Phrygian, through the station IR, gives the piece a drone-like sustain that the
FM voice cannot easily hold without the trompette triggering.

**Integration:** `WaveguideVoice` replacing or augmenting `KaikuVoice`. The
`Envelope` class can be reused for the excitation envelope. The `VoiceManager`
architecture is voice-agnostic if the interface contract is honored.

**Implementation cost:** Low for string (Karplus-Strong); medium for flute
(jet table + two-junction waveguide).

---

## 2. Waveshaping / Wavefolder — the metallic layer

**The gap it fills:** The station corridor preserves HF. The FM engine produces
FM sidebands. Neither produces the sustained harmonic scrape of a wheel pressing
too hard on a string — the sound that lives between the clean hurdy voice and the
trompette bark.

Waveshaping applies a transfer function to a waveform: the input sine comes out
with added harmonics. Chebyshev polynomials give clean partial control (Tn(x)
produces exactly the nth harmonic from a unit sine). A mirror-fold wavefolder
reflects the signal at ±1, then ±0.5, producing a dense spectrum that rises with
input amplitude — the harder the press, the harsher the output.

This is the simplest engine on this list. A 1024-point lookup table and a drive
parameter. Three days to make playable; two more to tune.

**What it would sound like:** A wavefolder running on a sine at the fundamental
frequency produces a bright, metallic tone that gets harder as the drive
increases. At low drive it is nearly clean. At high drive it is a grind. The
station corridor will love it. The forest IR will soften it in a way that is
almost certainly wrong — this voice belongs in the station.

**Integration:** The cleanest path is adding a `WaveshapeStage` to `FMEngine` as
a post-processing option on the carriers-summed output. One float parameter
(fold amount: 0 = bypass, 1 = full fold). Fits in the existing patch structure as
a new field in `FMPatch`.

Alternatively: a standalone `WaveshapeVoice` that takes a sine and folds it —
minimal parameter surface, no FM complexity, good for layer stacking.

**Implementation cost:** Very low. This could be done in a morning if the
Chebyshev table generation is written carefully. The time is in tuning, not in
code.

---

## 3. Modal Synthesis — struck metal

**The gap it fills:** KAAMOS has a sustained melodic voice (FM) and long
reverb tails. It does not have a percussive metallic voice that decays on its own
terms. The trompette is an accent on a sustained tone — it doesn't release
independently. Modal synthesis produces tones that ring out and stop, like a
struck metal surface.

A modal synthesizer models a resonating object as a bank of damped sinusoid
resonators. Each mode has three parameters: frequency (where it rings),
amplitude (how loud), and decay time (how long). The object is excited by an
impulse or a noise burst; the modes respond and decay at their individual rates.
A 32-mode bank covers most of the audible character of a struck plate.

The connection to the IR work is direct. The IRs model the room's resonances at
the space level; modal synthesis models a specific object's resonances. A metal
platform (station floor), a steel rail, a bell — each is a different mode set.
The station corridor could have a modal voice tuned to its own dimensions.

**Implementation note:** Biquad resonator bank (32 × `dsp::IIR::Filter`).
Excitation is a Dirac or a short noise burst (< 5ms). The hard part is
not the code; it is finding a modal parameter set that sounds like actual metal
rather than a pitched bell or a water tank. References: Adrien (1991) on
modal synthesis, Cook (2002) on physical sound models.

Mode frequencies for a struck metal plate are dense and inharmonic below 1kHz,
spreading into near-harmonic clusters above. For pitched use (Phrygian mode),
the fundamental is set to the MIDI note, the other modes follow the plate's
inharmonicity ratios scaled from that fundamental. This is not physically
accurate but it is musically useful.

**What it would sound like:** Short, dense, metallic attacks that decay in 0.5-4
seconds depending on the mode damping. More physical than FM percussion (which
doesn't have a simple FM representation of a plate) and more pitched than a
sample. In the station room the modal voice would sustain differently than the FM
voice — the modes decay individually, not as a single tail.

**Integration:** `ModalVoice` as an alternative voice type. The `Envelope` class
is not needed — modal voices self-terminate via mode decay. A `noteOn` sets the
excitation amplitude; `noteOff` optionally mutes the excitation but lets the
ring continue.

**Implementation cost:** Low-medium. The biquad bank is easy; the modal parameter
design is the work.

---

## 4. Granular Synthesis — the texture engine

**The gap it fills:** The `hiljaisuusPulse()` function (0.15Hz slow breath) is
already in the LookAndFeel. The silence breathes. There is no synthesis engine
that produces that quality. The station IR is a space; granular can turn any
sound into texture.

A granular synthesizer reads short windowed fragments (grains: 20-200ms, Hann
window) from a source buffer and scatters them in time, pitch, and amplitude.
A cloud of grains from the same source creates a sustained texture that breathes
if the scatter parameters move slowly. A cloud from a narrow time window creates
a held pitch; a cloud from a wide window creates noise-like texture.

The source files are already in the repo: `hiljaisuus_station.wav`,
`voidborn_forest.wav`, `trabant_radio.wav`. A granular engine reading from these
files would produce: station breath (metallic static texture), forest scatter
(diffuse mid-frequency cloud), Trabant radio grain (fragmented carrier tones,
heterodyne noise).

This is the most atmospheric and least melodic engine on the list. It does not
produce pitched notes in the conventional sense — it produces sustained textures
that have a center frequency if the grains are narrow enough. In the KAAMOS
context: background presence during long rests, textural contrast against the FM
melodic foreground, the sound of the space becoming audible between notes.

**Implementation note:** The core is a grain scheduler with a pool of active
grains (grain count: 32-128). Each grain tracks: source position, playback speed
(for pitch), amplitude envelope (Hann), and a phase in its own life cycle
(attack/sustain/release). The scheduler triggers new grains at a rate determined
by the density parameter and scatters them by the spray parameter. The
`juce::AudioBuffer` machinery handles the read-with-interpolation.

Loading the IR WAV files as grain sources requires a `juce::AudioFormatReader`
and a resident `juce::AudioBuffer`. This is the most infrastructure-heavy of the
proposals — not algorithmically complex, but more code than the others.

**The `hiljaisuusPulse()` integration:** The pulse function returns a [0,1] float
at 0.15Hz. Routing this to granular grain density (fewer grains at the pulse
trough, more at the peak) would make the texture breathe at the same rate as the
UI's pulsing hex grid. Architectural coupling that costs almost nothing to
implement once the granular engine exists.

**Implementation cost:** Higher. One to two weeks for a stable, playable result.
The concepts are well-understood (Roads 2001 is the reference text); the work
is in engineering a real-time grain pool at low latency without glitches.

---

## 5. AM / Ring Modulation — the Trabant layer

**The gap it fills:** The Trabant radio generator already does AM synthesis —
bandlimited noise as a modulator, carrier tones, voice-fragment modulation. A
synthesis engine based on AM and ring modulation would give the Trabant material
a pitched, playable correlate.

AM synthesis: `output = carrier × (1 + m × modulator)`. The modulation index m
controls the sideband level relative to the carrier. At m=0: clean carrier. At
m=1: equal carrier and sidebands. Sidebands appear at `carrier ± modulator`.

Ring modulation: `output = carrier × modulator`, no carrier component in the
output. The result is pure sidebands: sum and difference frequencies. A ring-
modulated FM voice with modulator at `b2` (the minor second, G♮ in F# Phrygian)
produces sidebands that emphasize the Phrygian dissonance directly — the 8-cent
detuning is already doing this with beating; ring mod does it through frequency
translation instead.

This is the simplest engine here, computationally. A ring modulator is one
multiplication per sample. An AM voice adds a constant (1 + m) before the
multiplication. The interesting work is in the modulator design: a fixed sine, a
second FM voice, a noise burst, or the Trabant radio generator output used as a
modulator.

**What it would sound like:** Light AM: a tremolo-like flutter with sidebands
that sharpen with higher modulation depth. Heavy AM: the Trabant radio voice —
carrier fragmenting in and out of intelligibility. Ring mod at Phrygian ratios:
bell-like tones, not pitched in the conventional sense, landing between notes.
In the station corridor: the station's HF preservation would mean the sidebands
ring out clearly.

**Integration:** Ring modulation can be added to the FM engine output as a
post-process stage (one float parameter, the modulator frequency as a ratio) — a
ten-line change to `FMEngine::processSample()`. As a standalone `AMVoice` it is
slightly more work but more flexible. Given the existing `FMPatch::detuneAmount`
field (which sets 8-cent detuning for the second hurdy string), a `ringModRatio`
field in `FMPatch` is a natural extension.

**Implementation cost:** Very low. An afternoon. The design is the work.

---

## Summary

| Engine | Gap filled | Implementation cost | Fit with existing material |
|--------|-----------|-------------------|---------------------------|
| Physical modeling (string) | Sustain without FM density | Low | Station + forest both |
| Physical modeling (flute) | Birch flute synthetic correlate | Medium | Forest (voidborn) |
| Waveshaping / wavefolder | Metallic scrape, sustained grind | Very low | Station only |
| Modal synthesis | Struck metal, self-releasing attacks | Low-medium | Station |
| Granular | Texture, breathing silence | Higher | Station + Trabant |
| AM / Ring modulation | Trabant voice, Phrygian sideband | Very low | Station + Trabant |

**What to build first:** Waveshaping is a morning's work and extends what the FM
engine already does — add it to `FMPatch` as an optional post stage. Ring
modulation is equally cheap and the Trabant material already implies it.

**What to build for the next instrument:** Physical modeling string waveguide.
The Karplus-Strong implementation is small, the voice fits the VoiceManager
interface, and the birch flute world has been waiting for a synthetic voice since
the `voidborn_forest.wav` went into the IR folder.

**What to build when there is time:** Granular. It is the right engine for the
project's deepest aesthetic register — the silence that breathes between notes,
the station corridor becoming audible in its own right. It takes the IR files
already present and makes them playable. Build it when there is time to do it
correctly.

---

## On naming

If each instrument is to have its own KAAMOS-vocabulary name, the candidates by
register:

- Waveguide string/flute: **Värähtelyjä** (vibrations) or just **Kannel** (the
  Finnish zither, which is a plucked string instrument — wrong construction but
  right acoustic family)
- Modal metal: **Kilisevä** (jingling, chiming — the sound of metal at the edge
  of a pitch) or **Metallinen** (too literal)
- Granular texture: **Hiljaisuus** (silence — already used for the station IR;
  the granular engine would read from the same source)
- AM/ring mod voice: **Trabantkaiku** — the Trabant's echo

The FM engine is Kaiku (echo, reverberation) because the hurdy-gurdy voice is
itself an echo of an older instrument. The next name should come from what the
new engine actually does, not from what it resembles.
