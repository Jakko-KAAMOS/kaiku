# Real SID — Project Brief
## The physical instrument

*Status: pre-build. Visual design: under embargo until release.*

---

## What this is

One SID-based hardware instrument, handmade, built to carry the Tyhjyydenkaiku register in physical form. Not a modified C64. Not a SIDBlaster in an enclosure. A purpose-built instrument that happens to run a SID chip, the way a theremin is a purpose-built instrument that happens to run a vacuum tube.

Limited edition: one unit. Limited by the number of C64s we are willing to destroy. That number is currently one.

---

## Form factor decision

**Eurorack module.**

Not a guitar pedal. Not a bench case.

Eurorack is the right call for three reasons.

First: power. The 6581 needs 12V. The Eurorack power rail is +12V. The chip plugs into the infrastructure that every modular rack already has. No wall wart, no separate supply, no voltage regulation kludge. The ecosystem was built for this chip's requirements before anyone planned it that way.

Second: the panel IS the canvas. A Eurorack panel is a specific, constrained surface — 3U tall, width in HP. Spray and drill on that surface reads as intentional, not modified. Boutique Eurorack has a visual culture of treated panels. KAAMOS visual language on a 3U panel — cold, geometric, specific — will be immediately legible as a point of view, not a hack.

Third: it lives in a rack with other modules. It is part of a system. The KAAMOS instrument arrived with the settlers and integrated with what was there. A Eurorack module integrates. It has CV inputs. It speaks the language of the environment without explaining itself.

The C64 board does not fit in a Eurorack module. The board is not entombed in the instrument. The chip is extracted and the board is retired. The instrument carries the chip's origin, not the board's body. This is correct — the chip is the instrument. The board was its housing.

---

## Physical parameters (draft)

*These are starting constraints, not final specs.*

| Parameter | Target |
|-----------|--------|
| Enclosure type | Eurorack module — standard 3U, width TBD |
| Width | TBD in HP — enough for panel elements, to be determined in panel layout |
| Panel material | Aluminum — standard Eurorack, drillable, spray-paintable |
| Internal layout | SID chip + driver PCB, power section (Eurorack ribbon), CV/gate input, audio output |
| Visual surface | Front panel only. Spray + drill. See embargo note. |
| C64 board | Retired. Not part of the module. The chip is extracted; the board is decommissioned. |
| Power | Eurorack ±12V ribbon — 6581 runs on +12V rail directly |

---

## Signal chain

```
CV/gate in → Arduino/microcontroller → SID register writes → SID audio out → output jack
```

The microcontroller clocks the SID at 1MHz, accepts CV pitch and gate, translates to SID register writes. Audio out is the raw SID pin — no onboard FX, no digital processing. The instrument's character is the chip's character. Nothing added.

MIDI input is a secondary consideration — a MIDI-to-CV front end or a dedicated MIDI input header on the PCB. CV/gate is the native language of the environment. Start there.

The module outputs into whatever the rack routes it to. It does not impose a signal chain. The rack is the chain.

---

## Hardware path

The Arduino brief in the workbench inventory is currently a stub — horticulture automation, no SID content. The SID driver brief needs to be written before the build begins.

Key open questions for the driver brief:
- Which Arduino model — Uno is marginal for 1MHz clock generation; Mega or Teensy 4.x are better candidates
- 6581 or 8580 — different voltage requirements, different filter character (see sid_brief.md)
- MIDI interface — simple 5-pin DIN or USB MIDI
- Whether the patch (Tyhjyydenkaiku voice assignment from sid_patch_plan.md) is hardcoded firmware or a loadable config

---

## Embargo

The visual design — surface treatment, drilling pattern, typography, palette — is under embargo from this moment until release. Nothing about the visual goes into the repo until the instrument is photographed and the release is ready.

The technical brief (this document, the driver brief, the patch plan) is not embargoed. The sound is not embargoed. The look is.

---

## Production run

One unit.

This is not a constraint. This is the correct edition size. The instrument is singular. If a second C64 is ever sacrificed, a second instrument may exist. They will not be identical. Each one is built from a specific board. The board is part of the instrument.

---

## Next steps

1. Earcheck the VSTi patch — sid_patch_plan.md — confirm the register is right
2. Write the Arduino driver brief — clock generation, register interface, MIDI translation
3. Identify and pull the SID chip — confirm 6581 vs 8580, inform power design
4. Source the enclosure
5. Build

The visual design happens in parallel with steps 2–4 and is not documented here.

---
