# Forest IR Specification — *Voidborn Forest*

*Working filename: `voidborn_forest.wav`*
*Generator: `forest_ir.py` (to be written alongside `hiljaisuus_ir.py`)*

---

## The source

Karelian lake. Midsummer — the minute summer lasts this far north.
Standing outside the cabin sauna. Still glistening. Sore from the
wattles. Red from the heat. Native Finns. The heat was like a sweat
lodge; a tourist couldn't handle it.

The lake has a sound: water on a shore. Very, very quiet. The kind
of quiet that has texture. If one were to step into the woods —
as one would — there is an immediate transition between two sonic
spaces. That transition is what this IR captures.

We are as happy in this moment as any worldborn has ever been happy
in their lifetimes. We take this happiness for granted because we
are it. We are in it. The happiness of solitude, of scarcity, of
abundance. Later there will be a huge bonfire and imported vodka.
In this moment we are basking in what passes for full sunshine
in Karelia.

---

## Two sonic spaces

The scene contains two distinct acoustic environments separated by
a hard perceptual boundary. The boundary is the tree line.

**Lakeside** — the space you step out of the sauna into.

Open above — energy escapes upward without ceiling.
The lake surface is a long flat reflector: sound travels across
water with very little degradation. A voice projected across the
lake returns from the far shore clear, delayed by distance alone.
No scatter in the upper frequencies. The stillness is horizontal.
This space has almost no reverberant field — it is directional,
open, and clean. What it has is a single long early reflection
off the water surface, arriving from below at near-zero angle.

This is not the IR. This is the world the song comes from.

**Forest interior** — the space you step into.

Boreal forest: Scots pine, Norway spruce, silver birch.
Trunks at irregular spacing — 3 to 8 meters, no pattern.
Canopy at 8–15 meters closing the vertical space.
Ground: deep moss. Highly absorptive. No hard floor.
The transition from lakeside to forest is felt in the body
before the ears process it. Pressure changes. The high end
softens immediately. The space is intimate without being small.

This is the IR. This is the room the song lives in.

---

## Technical parameters

| parameter | value | derivation |
|-----------|-------|------------|
| Space type | boreal forest interior | pine/spruce/birch, irregular |
| Room model (rectangular approx.) | 18 × 14 × 11m | felt space between trunks |
| RT60 | 0.62s | Sabine-verified for these dimensions + reflection |
| Reflection coefficient (amplitude) | 0.636 | yields energy absorption 59.6% — in range for moss/pine |
| Energy absorption | 59.6% | vs. 14.6% for station metal; physically correct |
| Early reflections | dense, diffuse, 30–120ms | trunk scatter — no single strong echo, complex texture |
| HF rolloff | significant above 4kHz | canopy absorption + pine needle scatter + air |
| MF character | warm, slightly forward 300–1200Hz | trunk resonance, enclosed feel without boxiness |
| LF character | open, no modal buildup | no parallel walls; ground absorbs, doesn't reflect |
| Directionality | diffuse | trunks scatter in all directions, no dominant axis |
| Pre-delay | 8–15ms | distance to nearest trunk surface |

**Compare to the station corridor (`hiljaisuus_station.wav`):**

| | Forest | Station |
|---|---|---|
| RT60 | 0.55–0.70s | 2.2s |
| Character | soft, diffuse, absorptive | hard, directional, metallic |
| HF | rolled off above 4kHz | preserved to 10kHz+ |
| Reflection | organic scatter | specular metal bounce |
| Feeling | enclosed in living matter | enclosed in infrastructure |

They are both enclosures. One is alive. One is built.

---

## The lakeside reflection — optional layer

The water surface reflection is not part of the forest IR but may
be useful as a distinct layer in the Éamonn an Chnoic recording:
a single early reflection arriving from below with a delay
proportional to the lake width. Clean, undegraded, long-delayed
(80–200ms depending on spec). Not a reverb — a single echo from
across the water.

If implemented: one reflection only. No tail. The lake is not
a room. It is a mirror.

---

## Intended use

**Primary:** Éamonn an Chnoic — the voidborn version. This is the
room that recording lives in. The song is about a man in the woods.
He is not in a concert hall. He is not in a station. He is outside,
at the edge of the Finnish summer, wet from the lake or the rain,
probably both.

**Secondary:** Side B birch flute voices, if the station corridor IR
reads as too hard against the transparency of the paired flutes.
Application: as a secondary blend under the station send, not a
replacement. The forest softens what the metal amplifies.

**Not for:** Kaiku (Tyhjyydenkaiku). The station is Kaiku's room.
The 8-cent detuning and the metal corridor were designed together.
Do not put the FM voice in the forest.

---

## Generator spec notes

When writing `forest_ir.py`, the key parameters to expose:

- `rt60` — target reverb time in seconds (default 0.62)
- `trunk_density` — average trunks per 100m² (affects early scatter density)
- `canopy_height` — meters (affects first ceiling reflection delay and HF cutoff)
- `moss_absorption` — coefficient 0.0–1.0 (default 0.75, very high)
- `hf_rolloff_hz` — frequency above which absorption increases (default 4000)
- `lake_reflection` — bool, whether to include the single water-surface bounce
- `lake_delay_ms` — if lake_reflection=True, delay in ms for the water echo

The forest IR and the station IR should be generatable from the same
underlying engine with different parameter sets. The architecture is
shared; the rooms are different.

---

*spec — iterate against ear*
*The forest exists. The IR doesn't yet.*
