# kaiku

An FM synthesizer. 6 operators. 3 parallel stacks. 16 voices.

Built to approximate two things that don't exist inside it: a hurdy gurdy wheel and a human mouth.

Primary target: REAPER on Linux. VST3.

KVR: [kvraudio.com/forum/viewtopic.php?t=629750](https://kvraudio.com/forum/viewtopic.php?t=629750)

First Music Cafe submission: [AM Radio Inside a Soviet Engineering Hallucination / Funeral Dirge for a Tourist Who Didn't Silence His Phone Inside the Ossuary](https://www.kvraudio.com/forum/viewtopic.php?t=630151)

Practice exercises: [rebraining.org/practice/music/kaiku](https://rebraining.org/practice/music/kaiku)

---

## on the grilli

*The grilli menu is the version. What's smoking is what's shipping or nearly shipping.*

**v0.2** — the knobs work now.

In v0.1 the UI was correctly wired and the parameters were all registered. The synthesis engine never read them. Sixty per-operator parameters were ignored every block. One commit fixed the seam. If you loaded v0.1 and heard nothing move: that was why.

Linux VST3: [github.com/Jakko-KAAMOS/kaiku/releases](https://github.com/Jakko-KAAMOS/kaiku/releases)

**v0.1** — archived. Both demos render in fosfori. You were warned.

- kuule — [rebraining.org/kuule](https://rebraining.org/kuule)
- birch — [rebraining.org/birch](https://rebraining.org/birch)

---

## the repo

```
games/    browser compositions — the open door
comp/     scores, notes, prose from the universe
ir/       impulse responses and provenance
sounds/   click voices and the doru processing pipeline
arch/     technical commons
eval/     testing framework, REAPER sessions, exercise evaluation
vsti/     synthesizer source — C++, JUCE, CMake
contrib/  how to read this, style guide, conduct, mission
```

---

## on the code

The instrument's scope is still changing to meet the composer's needs. The third reason is left as an exercise.

AI assistance is being used in the development of this instrument. This is not vibe coding.

*(It is, though.)*

The spec is in `vsti/SPEC.md`. Source is in `vsti/Source/` — PluginProcessor, PluginEditor, FM, GUI, Synth. The proof of concept lives in `games/` — that is what Kaiku sounds like right now, at this minute, and it is enough to work from.

---

## contributing

Start with [contrib/READING.md](contrib/READING.md) — it will tell you what's load-bearing and what's depth. Make a PR.

---

## a note on ai usage

[contrib/AI.md](contrib/AI.md)
