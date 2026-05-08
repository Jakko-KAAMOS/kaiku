# games

Two browser compositions. Web Audio API. No dependencies. Each runs in a single HTML file.

These are demos and proofs of concept. Deliberately hostile. 13 minutes each. You play them for 13 minutes or you don't. Either way takes 13 minutes.

---

## kuule

Station Nine — a Simon-pattern memory game on a hex grid. Eight stations. A glyph tray that accumulates on progress.

The audio engine: sawtooth oscillators through a lowpass filter. Two voices per tone, the second running 8 cents sharp against the fundamental. The beating between them is the wheel. A 0.15Hz tremolo runs continuously — the Hiljaisuus pulse. The drone underneath the game never stops.

Live: [rebraining.org/kuule.html](https://rebraining.org/kuule.html)

---

## birch

A birch glyph tool and palette explorer. An 8-tile sliding puzzle using station glyphs, a parametric birch tree renderer, Finnish move counting, a season bar.

The audio engine: sine oscillators through a lowpass filter. Two voices per tone, interval-separated. Voice 2 is slightly darker — lower filter cutoff, lower tremolo depth. Both voices tuned 8 cents flat. The instrument is warm, imprecise, and correct. The forest breathes at 0.15Hz underneath the duo.

The sliding puzzle uses station glyphs — abstract symbols from the KaamOS alphabet. The symbol recognition it builds is the same muscle you'd use learning a new script. An easy way into the palette. The author uses it as a fidget.

Live: [rebraining.org/birch.html](https://rebraining.org/birch.html)

---

## shared architecture

Both compositions:

- run exactly 13 minutes
- use F# Phrygian throughout (G natural is always present — the characteristic semitone, the pull toward the root)
- breathe at 0.15Hz
- fade to silence in the final 30 seconds
- were composed in a while loop — duration variation baked in at generation, no two runs identical
- use no samples, no wavetables, no external dependencies

The 8-cent detuning is not an error. Do not tune it out.

For synthesis architecture detail: `arch/webapi.md`.

---

## a note on the visual experience

The author is a musician. The music is weird. The font is small because monospace at that size is what the palette asked for, and the author is not a web designer and does not want to be one.

*Ei taa oo pankki. Eika tarvi olla.*

This is not a bank. And it doesn't need to be. What a Finn from the country means by this: you arrived with the wrong expectations. That is a you problem. We are done discussing it.

UX bug reports are welcome. The reporter is also welcome to fix them and submit a PR.

---

*See also: `arch/webapi.md` — synthesis architecture. `arch/time.md` — time, the Stroop effect, and why kuule is deliberately hostile.*
