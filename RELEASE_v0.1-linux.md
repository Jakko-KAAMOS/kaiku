---
title: Kaiku v0.1 — Linux build
date: 2026-05-14
target: REAPER on Linux x86_64
status: shipping
---

# Kaiku — Linux x86_64
*An FM synthesizer. 6 operators. 3 parallel stacks. 16 voices.*
*Built to approximate two things that don't exist inside it: a hurdy gurdy wheel and a human mouth.*

Primary target met. Linux first, as the kantakirja says.

---

## What this is

The Linux VST3 build of Kaiku. JUCE 7.0.9, CMake, GCC 13. Built on a salvaged Beelink SER3 (Ryzen 5 3550H / Vega 8) running Linux Mint Noble. Tested in REAPER 7.72 on the same machine.

Same instrument the KVR thread has been watching, on the platform the development was always pointed at. **It worked as staged in main.** No patches. No drift between the published recipe and the working binary. Pull, build, install, play.

## Install

```
mkdir -p ~/.vst3
cp -r Kaiku.vst3 ~/.vst3/
```

Then in REAPER: **Options → Preferences → Plug-ins → VST → Re-scan.**

The plugin appears under VST3i as **Kaiku (Kaamos)**.

## What's in the box

- **VST3 instrument plugin** — `Kaiku.vst3` (3.3 MB)
- **Standalone binary** — `Kaiku` (4.0 MB) for testing without a host
- **Ear-testing exercises** — 17 exercises across solo, ensemble, and dynamics
  - Full suite with PDFs, MIDI files, and detailed instructions: https://rebraining.org/practice/music/kaiku
  - Local copies also in `eval/exercises/` (F# Phrygian canonical test register)
- **Source repo** — github.com/Jakko-KAAMOS/kaiku
- **Spec** — `vsti/SPEC.md`
- **Reading order for contributors** — `contrib/READING.md`

## First ear test

Download the exercises from https://rebraining.org/practice/music/kaiku, or use the local copies in `eval/exercises/`. Open `E01-solo.mid` on a Kaiku track in REAPER. F# Phrygian, whole notes, rests between each note. Listen for what's described in `TESTING.md` Phase I: Timbre. The rest is not silence. It is the test.

---

## Build recipe (verified on Linux Mint Noble / Ubuntu 24.04)

For those building from source:

```
sudo apt install cmake git build-essential \
    libx11-dev libxrandr-dev libxinerama-dev \
    libxcursor-dev libfreetype-dev \
    libasound2-dev libwebkit2gtk-4.1-dev \
    libcurl4-openssl-dev
cd vsti
cmake -B build -DCMAKE_BUILD_TYPE=Release -G Ninja
cmake --build build --parallel
```

First-time configure pulls JUCE 7.0.9 via FetchContent (~200 MB). Builds clean on Noble; the BUILD.md still says `libwebkit2gtk-4.0-dev` but Noble ships 4.1 — works, since JUCE's WebBrowser is disabled in `CMakeLists.txt` (`JUCE_WEB_BROWSER=0`). Update to BUILD.md pending.

Output: `build/Kaiku_artefacts/Release/VST3/Kaiku.vst3`

## Known caveats

- **System audio config matters.** Tested with the AMD Ryzen 5 3550H on a `lowlatency` kernel with the CPU governor pinned to `performance`. The schedutil governor causes audible chunked playback on low-power hardware; locking to performance fixes it. See the systemd unit recipe in our companion brief.
- **No reverb yet.** The next release adds one. The exercises in `eval/exercises/` are designed to be auditioned dry — that is the point.
- **F# Phrygian is the test register.** All seventeen ear-testing exercises target F# Phrygian. The instrument speaks other modes; this is the canonical audit set.
- **REAPER on Linux is the development target.** Other hosts will probably work — JUCE's VST3 wrapper is portable — but they are not under test.

## A note on AI usage

`contrib/AI.md`. Read it before the tool gets used.

The three conditions: Reko, thoughtfully. Turo, accurately. Kaija, truthfully.

## Credit

Built and signed under the KAAMOS company name. Source CC. The instrument is intended to be played, not sold. If you produce the record described in the world bible, Jakko would very much like a copy.

---

*Filed: 2026-05-14. Tested through a UMC404HD on a salvaged Beelink. Worked on the launch the kernel allowed it.*
