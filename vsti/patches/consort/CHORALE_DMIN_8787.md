# Kaiku — D minor chorale, 8.7.8.7

*A four-voice chorale. Dark. Low-tessitura. Trabant radio bed.*

*Filed: 2026-05-14. For the v0.1+ Kaiku patch directory.*

---

## Form

- **Meter:** 8.7.8.7 (hymn-stanza). Two lines of 8 and 7 syllables, sung twice.
- **Key:** D minor.
- **Tempo:** **63 BPM.** Closest even multiple of 0.15 Hz to 66 — LFO Hiljaisuus
  at 1.05 Hz (0.15 × 7) = 63 BPM. 66 is off-grid; widening the LFO step to
  0.05 Hz would put 66 back on the table. Defaulting to 63.
- **Character:** dark, slow, no high register until the arrangement asks for it.

## Voices, bottom to top

All four voices route to one bus → **Hiljaisuus Station** REAVERB IR.

### B — Sustaining bass
- Low and sustaining. Long attack, very long release.
- Sweet spot D2 – A2.
- Wheel carrier: minimal or off. The bass is the floor, not the motor.

### T — Wheel baritenor
- Baritonal tenor. **Hurdy-gurdy wheel prominent** as a feature, ~1–2 Hz.
- Sweet spot G3 – G4.
- The wheel is the audible pulse of the chorale.

### A2 — Lower contralto
- Dark register. Sweet spot G3 – C5, sitting in the lower half.
- No vibrato; light Hiljaisuus swell.

### A1 — Upper contralto
- Also dark. Sits a third to a fifth above A2.
- Sweet spot B3 – E5.
- **No higher voice enters unless the arrangement calls for it.**

## Radio bed

- **Trabant radio noise track**, low but present, runs the entire piece.
- **Drops out** for subtle drama (cadence approaches, harmonic shifts,
  end of stanza). Returns without ceremony.
- Routes to **Trabant Interior** REAVERB IR — *not* Hiljaisuus Station.
  The radio lives in a different room than the singers.

## Routing summary

| Track            | Source                  | Bus → IR                  |
|------------------|-------------------------|---------------------------|
| Bass             | Kaiku                   | Voice bus → Hiljaisuus St |
| Wheel baritenor  | Kaiku                   | Voice bus → Hiljaisuus St |
| Contralto 2      | Kaiku                   | Voice bus → Hiljaisuus St |
| Contralto 1      | Kaiku                   | Voice bus → Hiljaisuus St |
| Trabant radio    | noise source            | Radio bus → Trabant Int   |

## Next steps

1. Build/select the four Kaiku patches (B, T, A2, A1).
2. REAPER project: 5 tracks, 2 buses, 2 IRs.
3. Compose the 8.7.8.7 stanza in D minor at 63 BPM.
4. Mark radio drop-outs in the score, not in the mix — they're musical, not effects.

---

*"A four voice chorale. 8.7.8.7 in D minor. Dark."* — Jakko, 2026-05-14
