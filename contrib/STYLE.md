# style guide

Everything that leaves this project — code, documentation, UI, music, the website — passes through here. If it does not look, smell, and joik like Kaiku it does not go out.

---

## the evaluative standard

- **Reko** — does it delight?
- **Turo** — does it carry its cost honestly?
- **Kaija** — does it hold up to judgment?

All three or it does not ship.

---

## visual register

Amber on void black. Hex grid motifs. Monospace. No chrome. The Hiljaisuus pulse runs at 0.15Hz — 6.67 seconds. Everything breathes at that rate or slower.

### tokens

Backgrounds and borders:

```css
--bg:           #0c0c0c   /* void — base */
--bg-raised:    #141210   /* tile surface */
--bg-inset:     #181614   /* recessed element */
--rule:         #222018   /* divider */
--border-dim:   #201e18   /* subtle border */
--border:       #2e2418   /* standard border */
```

Amber scale, brightest to darkest. This is Kaiku's primary identity:

```css
--amber-bright: #f5c060
--amber:        #f0a030
--amber-mid:    #9a6820
--amber-dim:    #5a3810
--amber-low:    #3a2810
--amber-ghost:  #3a2010
```

Text:

```css
--text:         #dfd0b0
--text-sub:     #8a7a60
--text-muted:   #4a4030
```

Accents:

```css
--violet:       #702890   /* Hiljaisuus signal */
--violet-mid:   #4a1858
--violet-dim:   #280d30
--green:        #90c830   /* station — go state */
--danger:       #e83820
```

Timing:

```css
--pulse:        6.67s     /* 0.15Hz — Hiljaisuus */
```

The pulse is not decorative. The 0.15Hz rate is the Hiljaisuus breath — the only motion in the interface that is permitted without communicating information. Time in this universe runs on the KAAMOS arc (3 spring + 1 summer + 11 winter positions), not on a clock. If you are making something that moves or progresses, read [`arch/time.md`](../arch/time.md) and [From Shadow to Caesium](https://rebraining.org/essays/clocks) before you decide how it counts.

The full KaamOS token set — season colors, sky, lake, grey — exists but does not belong to Kaiku. It belongs to the universe. Kaiku is one instrument in that universe. Its palette reflects that scope.

### typography

Monospace throughout. `'Courier New', Courier, monospace`. Uppercase sparingly — labels, navigation, system identifiers. Lowercase preferred for everything else. Letter-spacing on uppercase: 0.15–0.25em. Never Inter. Never system-ui.

### what not to do

No gradients except the amber fade-to-transparent used in ruled dividers. No drop shadows. No rounded corners beyond 2–3px. No color outside the token set without a design decision on record. No brightness above `--amber-bright`. The void is the ground. Everything else is signal emerging from it.

---

## sonic register

Warm, not bright. Frequency ceiling at 14kHz. Mono below 150Hz. Dynamic range left in — do not compress to streaming standard. One room, committed. Saturation on the buss, not the tracks.

The imperfection is the instrument. The 8-cent detuning in Tyhjyydenkaiku is not an error. Do not tune it out.

The 1982 ethic applies: the constraint is the form. Add nothing because you can. The slot is full when it is full.

---

## language

Finnish is structural, not decorative. Terminology established in the sanasto is not changed without a design decision. When in doubt, ask before you name.

Code identifiers, file names, and variable names follow the project vocabulary. When a Finnish word exists for the concept, use it.

Documentation is written in the same register as this document: declarative, terse, no hedging. The work is serious. The prose reflects that.
