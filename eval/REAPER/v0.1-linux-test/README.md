# v0.1-linux-test — Kaiku ear/IR test rig

Three sources × four IRs. Stays in F# Phrygian per the kantakirja.

## Layout

| # | Track | Source | Notes |
|---|-------|--------|-------|
| 1 | Kaiku — F# Phrygian tenor | `midi/fis_phrygian_tenor.midi` | mid-tenor melodic, ~3 min @ ♩=120 |
| 2 | Kaiku — F# Phrygian ostinato | `midi/fis_phrygian_ostinato.midi` | bass cycle + soprano answer, two voices |
| 3 | Trabant radio (audio) | `../../../ir/trabant_radio.wav` | 60s loop, the dry contents of the cabin |
| 4 | BUS · Hiljaisuus Station | ReaVerb + IR | 40m corridor, RT60 2.2s |
| 5 | BUS · Voidborn Forest | ReaVerb + IR | boreal interior, RT60 0.62s |
| 6 | BUS · Sedlec Ossuary | ReaVerb + IR | bone-lined chapel, RT60 1.8s |
| 7 | BUS · Trabant Interior | ReaVerb + IR | tiny cabin, RT60 0.18s |

## Sends (set by hand on first open)

- Tracks 1, 2, 3 → all four IR buses (post-fader, 0 dB)
- Mute the buses you don't want to hear, A/B by solo

## Recursion

Track 3 routed through the Trabant Interior bus = car listening to its own radio.

## Render targets

48 kHz / 24-bit stereo per the rebraining.org instructions. Don't change them.

## What got skipped

- ReaVerb's `<IR ... >` line is best-effort syntax; if it doesn't pick up the file on first load, point ReaVerb at the IR manually. The track name tells you which.
- No track sends are written into the .rpp — REAPER's send block is finicky to hand-author. Add the 1→{4,5,6,7} sends in the routing matrix on first open.
