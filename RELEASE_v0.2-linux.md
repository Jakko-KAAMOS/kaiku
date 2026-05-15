---
title: Kaiku v0.2 — Linux build
date: 2026-05-15
target: REAPER on Linux x86_64
status: shipping
---

# Kaiku v0.2 — Linux x86_64
*An FM synthesizer. 6 operators. 3 parallel stacks. 16 voices.*

---

## What changed

**v0.2 fixes the one thing that made v0.1 a silent instrument.**

UI knobs now affect audio.

In v0.1, the APVTS parameter tree was correctly wired to the editor sliders and correctly registered all 63 parameters — but `processBlock()` never read them back into the synthesis engine. The only parameter that worked was master level. All 60 per-operator parameters (ratio, index, indexPeak, indexDecayMs, level, feedback, attackMs, decayMs, sustainLevel, releaseMs × 6 ops) were ignored every block.

Fix: `KaikuProcessor::patchFromAPVTS()` reads all 60 parameters each block via `getRawParameterValue()->load()` and the result is applied to the voice manager before the MIDI loop. The `FMPatch` struct was already the correct boundary object; the seam just wasn't being used.

One commit: `4627521`.

---

## What this is

The Linux VST3 build of Kaiku. JUCE 7.0.9, CMake, GCC. Built on a salvaged Beelink SER3 (Ryzen 5 3550H / Vega 8) running Linux Mint Noble. Tested in REAPER 7.72 on the same machine.

## Install

```
mkdir -p ~/.vst3
cp -r Kaiku.vst3 ~/.vst3/
```

Then in REAPER: **Options → Preferences → Plug-ins → VST → Re-scan.**

Plugin appears as **Kaiku (Kaamos)** under VST3i.

## Build recipe (Linux Mint Noble / Ubuntu 24.04)

```
sudo apt install cmake git build-essential \
    libx11-dev libxrandr-dev libxinerama-dev \
    libxcursor-dev libfreetype-dev \
    libasound2-dev libwebkit2gtk-4.1-dev \
    libcurl4-openssl-dev
cd vsti
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
```

Output: `build/Kaiku_artefacts/Release/VST3/Kaiku.vst3`

## Checksum (this build)

```
a803416d96fc096bf3bdc2c963bdbd14  Kaiku.vst3/Contents/x86_64-linux/Kaiku.so
```

## Known caveats

- **setCurrentProgram clobbers knob state.** Selecting a preset overwrites voices directly rather than pushing values into the APVTS — knobs will not reflect the loaded preset. Tracked, fix in next release.
- **No reverb yet.** Exercises in `eval/exercises/` are designed dry.
- **REAPER on Linux is the development target.** Other hosts untested.

## Source

github.com/Jakko-KAAMOS/kaiku — `contrib/AI.md` before the tool gets used.

---

*Filed: 2026-05-15. One commit. The knobs work now.*
