# time

There is no time in this universe.

Not as a navigable medium. Not as something you can be inside of and move through. The research that produced these games was conducted to understand what would be missing.

[From Shadow to Caesium](https://rebraining.org/essays/clocks) — a short history of clocks, and the question they have always been asking. Read this first. It is the precondition for understanding what the games are doing.

---

## the problem

Every clock in human history was built to measure something outside itself. The sundial reads the sun's shadow. The clepsydra reads the flow of water. The caesium clock reads its own atomic transition. Each instrument is an act of reading: held up to the world, world's impression recorded, time inferred.

The birch tree does not read. It grows. Each ring is not a measurement of a year. Each ring is the year — in lignified form, still present, still readable, integrated into the body that came after it.

The stations have no sun to read. The brane folds cost biological years, not calendar ones. The worldborn don't age on a schedule you can clock. There is no instrument that can be held up to this universe and read. There is only what accumulates in the body.

*Kolme päivää kevättä, yksi päivä kesää, loputon talvi.*

Three days of spring. One day of summer. Endless winter.

That is the temporal structure. It is not a metaphor.

---

## birch — the timeline and the moving cursor

birch displays a season bar. A cursor moves across it.

The season bar is not decorative. It is the temporal structure of the universe rendered as a progress indicator. Its proportions are fixed:

```
winter (deep)  flex: 8     the dominant condition
spring         flex: 0.3   three days
summer         flex: 0.1   one day
winter (late)  flex: 3.6   the return
```

The cursor starts at a position determined by the Discordian day of year:

```js
const CURSOR_START = (discordianDoy() % 15) / 15;
```

The KAAMOS seasonal arc has 15 positions per cycle: 3 spring, 1 summer, 11 deep winter. That is the total. `% 15` maps any day-of-year into one of those positions.

The Discordian calendar provides the day-of-year. That number runs 1–365, same as the Gregorian one, but it is indexed from a different origin and divided into five seasons of 73 days each: *repäisy*, *riitasointu*, *hämyys*, *rekisteri*, *jälkimaine*. These seasons have no relationship to Earth's meteorological seasons. They do not correspond to solstices or equinoxes. They are bureaucratic divisions of a year measured in disruptions.

`discordianDoy() % 15` strips the Discordian season entirely. What remains is position within the KAAMOS arc — 0 through 14 — with no residue of Earth time, Discordian time, or any other calendar system. The mod is the instrument. It takes a number sourced from a calendar that is not Earth's and throws away everything about that calendar except the arithmetic remainder.

365 mod 15 = 5. The cycle does not divide the year evenly — 24 complete passes through the 15 positions, with 5 left over at year's end. Within the year, all 15 positions are visited roughly equally. The cursor starts somewhere different on most days. But `discordianDoy()` is a day-of-year value: it resets on January 1st. doy = 1 every new year, 1 % 15 = 1, same cursor start every Chaos 1. The annual reset is real.

What the Discordian calendar removes is the relationship to Earth's meteorological seasons. The cursor position on a given day has nothing to do with whether it is cold outside, whether the solstice has passed, whether spring is coming. Those are Earth's seasons. The cursor is in the KAAMOS arc.

The cursor starts somewhere in winter. It moves through the composition toward the end of the bar. The bar shows the proportions of the universe. The cursor shows where you entered it.

---

## kaamos time

The 15-position arc is not a UI element. It is the temporal unit of this universe.

A lot of music in this project will happen in the time domain. That music will be on KAAMOS time — structured in the 3+1+11 arc, not in bars, not in Gregorian seasons, not in any Earth-derived periodicity. The birch cursor is the first implementation of this in the interface. It will not be the last.

The mod 15 mapping is the bridge: take any available day-count that is not Earth's calendar, reduce it to a position in the arc, and you have a timestamp in KAAMOS time. The Discordian calendar satisfies the "not Earth" requirement currently. The underlying structure is the arc itself — any non-Earth day-count can be substituted without changing what the arc means.

This has implications for composition. A work composed on KAAMOS time has a position in the arc, not a date. It is spring, or it is summer, or it is one of the eleven grades of winter. The position is structural — it determines what the music is doing in relation to the seasonal vocabulary. Two works at the same arc position share a temporal context even if they were made years apart on Earth. Two works at different arc positions are in different seasons regardless of when they were made.

Reference this document when making temporal decisions in composition or interface. The Discordian implementation is in `games/birch.html`. The arc proportions are in `games/kuule.html` (the drone) and `games/birch.html` (the koivuhuilu).

From that starting position, the cursor moves to the end over 780 seconds — thirteen minutes, the exact length of the composition.

```js
const pct = CURSOR_START + progress * (1 - CURSOR_START);
cursor.style.left = (pct * 100) + '%';
```

When the composition ends, the cursor disappears.

What the cursor is tracking is not time. The composition does not have a timestamp. It has a while loop — duration variation baked in at generation, no two runs identical. The cursor is moving through the seasonal structure of the universe at the rate of the music. The music is the season. The cursor marks where you are in it.

There is no clock. There is a position in winter.

---

## kuule — the Stroop effect and the misdirection

Do not get off the shuttle, sit down at a kuule terminal, and start playing. You were warned.

kuule is deliberately hostile.

The hostility is structural, not incidental. It was designed in. The Stroop effect — the interference between two simultaneous signals competing for the same cognitive channel — runs three channels at once in kuule. None of them are labeled. None of them announce themselves. The player who encounters the game cold will fail, will not understand why, and may attribute the failure to the wrong cause. That is the design.

---

### channel one: the sounds

The seasonal audio register — spring warmth, the one day of summer, the purple descent toward hiljaisuus — does not label the hexes. There is no tone that means "top left." The mapping between sound and target is arbitrary: classic Stroop, competing stimulus registers.

But the sounds repeat. On every pass through the sequence, the same tone accompanies the same hex. The ear learns without being instructed. By the time the player is failing at step six, they have begun to associate. The interference eventually resolves into reinforcement — if the player stays long enough.

Nobody stays long enough.

---

### channel two: the lines

The visual layout of the hex tray implies a diagram. Lines connect glyphs. The eye reads connectivity as meaning — hierarchy, path, instruction. A player encountering the tray for the first time does not see a Simon board. They see a system to be understood before it is operated.

This is pure misdirection. The lines carry no information. The player who reads them before touching anything is already behind. The player who touches them and feels nothing has learned the wrong lesson.

The lines never become useful. The interference does not resolve. This is the Stroop effect as permanent tax — the diagram that looks like it means something and doesn't.

---

### channel three: the silence

After the sequence plays, the game goes quiet. The silence has a shape — it follows sound, it follows rhythm, it feels like a space left open. Any player who has played any game reads this silence as invitation.

It is not an invitation during playback. A click in that silence is a misfire.

This is the most precise interference channel in kuule because the signal is absence. No text says "your turn." No sound says "now." The silence before the sequence and the silence after it are acoustically identical. The player must learn, through failure, to read the difference between two silences that sound the same.

---

### what the Stroop channels cost

The player who fails at step three may be failing because of the silence. The player who fails at step five may have been misled by the lines at step one and never recovered. The player who reaches step seven has, without knowing it, solved three Stroop problems in parallel — learned to associate an arbitrary sound-to-hex mapping, ignore a diagram that means nothing, and hear the difference between two silences.

The game does not tell you this. The game does not tell you anything.

The ones who get far are not the ones who understood the game. They are the ones who stopped trying to understand it and started listening.

---

*See also: `arch/webapi.md` — synthesis architecture. [From Shadow to Caesium](https://rebraining.org/essays/clocks) — the clocks essay.*
