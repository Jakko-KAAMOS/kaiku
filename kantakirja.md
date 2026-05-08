# kaiku kantakirja
## Authoritative Reference — The Synthesizer, the Games, and the Acoustic Space

*McGill Cloud Enterprises. One artifact inside a larger project that shares one structural law and one sonic vocabulary.*

---

## I. WHAT KAIKU IS

kaiku is a free FM synthesizer built to approximate two things that don't exist inside it: a hurdy gurdy wheel and a human mouth.

It is one artifact inside a larger project — a novel, a game, a record, and a desktop environment that share one structural law and one sonic vocabulary. **Kaiku is the open door. Everything else has gates. This does not.**

Not a general-purpose FM synthesizer with a skin applied. Not a DX7 clone. Not a demo. Not a prototype someone will eventually replace. Not finished — but not provisional either.

The worldborn didn't build it. It arrived with the first settlers and nobody replaced it because it worked. The limitation is the form. The slot is full when it is full.

---

## II. THE INSTRUMENT ARCHITECTURE

**6 operators. 3 parallel stacks. 16-voice polyphony. VST3.**

```
stack 1 (F1): modulator → carrier    (vowel body formant — the chest)
stack 2 (F2): modulator → carrier    (nasal upper partial — the head)
stack 3 (Cw): modulator → carrier    (wheel carrier)
```

No cross-stack modulation. All three stacks run simultaneously; their outputs sum to the voice output.

### Tyhjyydenkaiku — Primary Voice

*Echo of the void.* The synthesizer is named for this sound.

The wheel carrier (Cw) runs at **1.008× the fundamental**. The slow beating between Cw and the fundamental is the wheel. This is not vibrato. This is not modulation depth. It is a ratio, fixed.

On accented notes a fourth transient voice fires and decays in **80ms**. No sustain. The trompette bark.

**The 8-cent detuning is not configurable. It is the instrument.**

Lineage: Louis and Bebe Barron (1956). The imperfection is the instrument. The instrument has a lifespan.

### Patch Family

Four patches ship with v0.1, all derived from the Tyhjyydenkaiku topology:

| patch | character |
|---|---|
| Tyhjyydenkaiku | primary — hurdy gurdy wheel + mouth |
| Kuilunsikiö | visceral — the thing before it becomes sound |
| Pohjankaiku | Mellotron-heavy — the echo across the north |
| Kuilukaiku | stripped — the wheel alone |

### The 0.15Hz Pulse

The Hiljaisuus pulse is available as a global LFO target. Period: **6.67s**. Rate: **0.15Hz**. Not 0.1Hz. Not 0.2Hz. Not user-configurable.

Any parameter that breathes, breathes at this rate. This is the Hiljaisuus frequency — canonical in the world cosmology, synchronized with the CSS `--pulse: 6.67s` variable in the games. Do not change.

---

## III. PLATFORM TARGETS

| platform | format | status |
|---|---|---|
| Linux | VST3 | primary |
| Windows | VST3 | ships |
| macOS | VST3 | ships |

Primary host: REAPER. Behavior in other hosts is tested but not prioritized.

**There is no iOS in the kaamos universe.** Mobile target for the games is Android only, via Web Vibration API. No Capacitor. No Apple haptic APIs.

---

## IV. PANEL REGISTER

Amber on void black. Monospace. Hex grid motifs where space allows. No chrome. No gradients except the amber rule. No rounded corners beyond 2–3px.

The panel is the instrument. It does not announce itself.

KaamOS palette (source of truth — `palette.css`):
- Void black: `#070711`
- Amber: `#C8A050`

Full visual specification: `contrib/STYLE.md`.

---

## V. THE GAMES

Two browser compositions. Single-file vanilla HTML/CSS/JS. No build step. No dependencies. The proof of concept — what Kaiku sounds like right now, at this minute. Enough to work from.

Both render in fosfori: void black, P39 phosphor green. No chrome. Bring headphones.

Live at rebraining.org:
- [rebraining.org/birch](https://rebraining.org/birch)
- [rebraining.org/kuule](https://rebraining.org/kuule)

### The Cipher Layer — Both Games

The eight stations encode **flag semaphore letters A–H**. The `sem` arrays on each station are the arm angles. The birch tree shape IS the semaphore glyph — the trunk, fork, and two drooping branches are the signaller's body and arms. The player reads and replicates the cipher without being told there is a cipher. This is load-bearing. Do not add explanatory text.

The eight stations:

| key | name | hex position | semaphore |
|---|---|---|---|
| POH | Pohja | q:2, r:-1, s:-1 | A — [315°, 90°] |
| VÄY | Väylä | q:1, r:-2, s:1 | B — [270°, 90°] |
| GRI | Grilli | q:-1, r:-1, s:2 | C — [225°, 90°] |
| KAA | Kaamos | q:-2, r:1, s:1 | D — [180°, 90°] |
| AAV | Aava | q:-1, r:2, s:-1 | E — [90°, 135°] |
| HEH | Hehku | q:1, r:1, s:-2 | F — [90°, 180°] |
| SOL | Solmu | q:2, r:-2, s:0 | G — [90°, 225°] |
| TAI | Taivas | q:0, r:-2, s:2 | H — [90°, 270°] |

### birch.html — *yksi pilkku nolla*

Glyph renderer and palette tool. Also contains a sliding tile puzzle (8-puzzle, 3×3 grid) using the eight station glyphs.

**Audio:** 13-minute koivuhuilu duo (birch flute). Doru Malaia palette: warm, dark, slightly flat (−8¢). Taav carved the tuning. Congruent to 0.15Hz. 3-1-11 seasonal (kevät: 3 positions, kesä: 1 position, talvi: 11 — dominant). Minor pentatonic default. Phrygian blade enters in deep winter. Audio synthesized entirely via Web Audio API — no files.

**The move counter is in Finnish.** `toFinnish(n)` is not localization — it is the register. Do not replace with a library call.

**The puzzle does not distinguish between solving it and stopping. The void has no clocks.**

### kuule.html — *v0.1 (frites)*

"Listen." Simon-says hex memory game. Radius-2 hex grid. Eight stations at the outer ring, Hiljaisuus at center.

**Game loop:** System lights stations in sequence. Player replicates. Correct → sequence grows by one, glyph added to tray. Wrong → disruption. Sequence resets to zero. The disruption count is logged in Finnish. Quietly. One word.

**Seasonal sound progression:** 11 positions. Positions 0–2: kevät (bright, short decay). Position 3: kesä (random F# Phrygian pentatonic draw, shimmer). Positions 4–10: talvi (descending frequency and gain, increasing decay, darkening toward hiljaisuus).

**Hiljaisuus:** Center hex. Violet pulse at 6.67s — synchronized with `--pulse: 6.67s` and the instrument LFO. Station Nine. The fold that precedes all others.

**The glyph tray** is the accumulating cipher. The player has not been told to read it as letters.

**The vaara sound:** The anvil. From above. Once. Unambiguous.

**The game does not distinguish between stopping and failing. Neither does the system.**

---

## VI. THE ACOUSTIC SPACE

`ir/hiljaisuus_station.wav` — the IR space. The room the synthesizer breathes in. Provenance documented in `ir/`.

---

## VII. THE TIMBRE BRIEF

Three timbres — the core voices the FM operator parameters approximate:

**Koivuhuilu (birch flute):** Mouth music register. Warm, slightly flat, organic. Taav's instrument. Appears in birch.html ambient layer.

**Electric hurdy gurdy:** The Tyhjyydenkaiku model. Wheel + drone + trompette bark. The Cw stack at 1.008× is this instrument's characteristic sound.

**Choir drone:** The Kuilukaiku register — stripped, the wheel alone. Long decay. Hiljaisuus-adjacent.

Mellotron V integration: Pohjankaiku. The echo across the north. Not nostalgia — geography.

Full FM operator parameters: `vsti/timbre_brief.md`.

---

## VIII. THE COMPOSITION

The KVR submission track is the first complete use of the instrument in its own universe.

**7-section structure.** Mapped to the KaamOS characters as structural forces — not as a soundtrack but as a demonstration of the FM vocabulary doing narrative work.

| section | structural role |
|---|---|
| Reko passages | Journalist register — practical, on the surface |
| Turo passages | Pattern recognition — the machinery showing through |
| Keijo passages | Eureka topology — understood the structure, was not believed |

**Doru Malaia mandate:** Doru Malaia died February 10, 2006. The Superdrums 8000 and 230 Ethnic Drums sample libraries must appear in the KaamOS soundtrack as a memorial act. Not as homage. Not as citation. As presence. His name is in the comp notes.

Full track spec: `comp/kaiku_track_brief.md`.

---

## IX. GRILLI VERSIONING

*The grilli menu is the version. What's smoking is what's shipping or nearly shipping.*

Current: **v0.1**. Live games at rebraining.org are the proof of concept. The instrument source lives in the feature branch — uncompiled, as-is. Main holds the spec. The spec is the contract. Source follows when it passes Kaija.

---

## X. REPO STRUCTURE

```
games/    browser compositions — the open door
comp/     scores, notes, prose from the universe
ir/       impulse responses and provenance
arch/     technical commons
vsti/     synthesizer design and source
contrib/  how to read this, style guide, conduct, mission
```

---

## XI. CONTRIBUTING

Start with `contrib/READING.md`. Start anywhere in the repo — the games are the fastest way in.

Finnish language and Finnish culture are structural to this project — not decorative. You do not have to speak Finnish to contribute. You have to respect that the language is doing load-bearing work.

Before touching anything temporal: read [From Shadow to Caesium](https://rebraining.org/essays/clocks). The `arch/time.md` document is the technical implementation of what that essay establishes philosophically. Neither is optional context.

What good contribution looks like: it delights, it carries its cost honestly, it holds up to judgment. All three, or it does not ship.

AI assistance is being used in the development of this instrument. This is not vibe coding. *(It is, though.)*

---

## XII. RELATIONSHIP TO KAAMOOS UNIVERSE

kaiku is one artifact inside the larger KaamOS project. The eight stations are not game elements with musical associations — they are stations in a cosmological system that the game, the novel, the record, and the desktop environment all instantiate.

The structural law is the same across all of them: **Hegelian Triadic Epiphany — Dual Correctness.** Two truths collide. Both valid. Neither resolves. The epiphany is the collision held in permanent tension.

The Hiljaisuus pulse (0.15Hz / 6.67s) is not a design choice. It is the frequency of Station Nine — the ninth fold in the brane, the fold that precedes all others. It appears in the CSS, in the synthesizer LFO, and in the pulse animation in kuule.html because these are the same thing wearing different forms.

The semaphore cipher the player has not been told about: this is also the same law. The truth is legible. The system does not announce it.

For full cosmology, characters, and world structure: `kantakirja.md` (root).

---

## XIII. CROSS-REFERENCES

| file | purpose |
|---|---|
| `kantakirja.md` | Authoritative KaamOS creative and cosmological reference |
| `vsti/SPEC.md` | Synthesizer specification and operator topology |
| `vsti/timbre_brief.md` | FM operator parameters for the three core timbres |
| `comp/kaiku_track_brief.md` | KVR submission track structure |
| `ir/` | Impulse responses and provenance |
| `arch/time.md` | Technical implementation of KaamOS temporal model |
| `contrib/READING.md` | Entry point for new contributors |
| `contrib/MISSION.md` | What kaiku is and is not |
| `contrib/STYLE.md` | Visual specification — panel register |
| `contrib/SANASTO.md` | Vocabulary — Finnish terms and KaamOS coinages |
| `claude_memory/birch_kuule_programming_brief.md` | Game programming techniques — glyph renderer, Web Audio, hex math, BFS |
| `claude_memory/kaiku_synthesis_brief.md` | Synthesis model in the AI collaborator context |
| `rebraining/kantakirja.md` | rebraining.org domain identity reference |

---

*Prepared: May 2026.*
