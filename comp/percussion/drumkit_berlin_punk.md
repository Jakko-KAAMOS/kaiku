# Drum Kit Brief — Berlin Punk 1982
## tonal_design branch — working document

Taav's Wild Ride ends in West Berlin. This is the kit in the squat.
Zero budget. Wrong instruments used correctly. Playable by Chad Evans
on his e-kit, or by Jakko on the KeyLab 88 mk2 pads.

Reference for kick character: Markus Hirvonen, Insomnium.
The kit does not live in 1982 audio fidelity. It lives in 1982 context.

---

## Performers

**Primary:** Chad Evans — e-drum kit, full physical performance, MIDI into plugin.
**Fallback:** Jakko McGill — KeyLab 88 mk2 pads. See midi_keylab88_berlin.md.

---

## The Kit — 16 Pieces

### 1. KICK — SURDO
```
Folder:   SURDO/  (60 files, DM-SUR 01-60)
Primary:  DM-SUR 50.wav  (340ms) — tightest in set, fast enough for double kick
Alt:      DM-SUR 60.wav  (500ms) — slightly more body
Reserve:  DM-SUR 20-40   (878-896ms) — for slower tempos, more resonance

Character: Brazilian carnival bass drum. Large skin, mallet strike.
Not a kick drum. Used as one. That is correct for this kit.

Synthesis layer (required for Hirvonen viability):
  Sine sweep: 70Hz, 110ms decay, fast gate
  Layered under the SURDO body at -6dB
  The synthesis gives the attack definition at high BPM
  The SURDO gives the skin character
  Together: something that reads as kick at 200+ BPM

Round-robin: files 45-60 (shorter decay range, 340-600ms)
Velocity curve: linear — no compression at ff, the blast beat needs headroom
```

### 2. KICK 2 — DOUN DOUN
```
Folder:   DOUN DOUN/  (16 files, DM-DOU 01-16)
Primary:  DM-DOU 01.wav  (236ms) — tightest in library for this role
Alt:      DM-DOU 03.wav  (375ms)

Character: West African bass drum, hand-struck. Different tonal center
than the SURDO — slightly higher, drier. The double kick second voice
should not sound identical to the first. This doesn't.

Round-robin: all 16 files
No synthesis layer needed — DM-DOU 01 at 236ms is naturally fast enough.
```

### 3. SNARE — CAJON
```
Folder:   CAJON/  (38 files, DM-CAJ 01-38)
Primary:  DM-CAJ 01.wav  (231ms)
Range:    135-300ms across the set

Character: Wooden box, top-hit. The cajon's top face produces a
crack-and-body combination that reads as snare in a mix, especially
with the station IR placed on it. No snare rattle — this is a punk
kit, the snare might be broken. This is correct.

Round-robin: all 38 files. This is the most-hit piece in the kit.
38 files means Chad can play a full take without a repeated hit.
Velocity layers:
  pp (1-40):   DM-CAJ 38.wav  (135ms) — ghost
  mp (41-70):  DM-CAJ 20.wav  (200ms)
  mf (71-100): DM-CAJ 01.wav  (231ms)
  ff (101-127): DM-CAJ 03.wav (260ms) — full crack
```

### 4. SNARE GHOST — BONGOS
```
Folder:   BONGOS/  (104 files, DM-BON 001-104)
Primary:  DM-BON 104.wav  (120ms) — shortest, quietest character
Alt:      DM-BON 060.wav  (175ms)

Ghost notes are the hits between hits. This pad plays at low velocity.
The bongo gives a different skin texture than the cajon — higher-pitched,
thinner. Correct for ghost notes: they should be audible but not match
the main snare character.

Round-robin: BON 090-104 (shorter files, 120-206ms)
```

### 5. HI-HAT CLOSED — SAGAT (ZILL)
```
Folder:   SAGAT ( ZILL )/  (30 files, DM-SAG 01-30)
Primary:  DM-SAG 30.wav  (167ms) — tightest
Alt:      DM-SAG 20.wav  (220ms)

Character: Turkish/Middle Eastern finger cymbals. Small, metallic,
short decay. Not a hi-hat. Used as one. The Kreuzberg connection is
not accidental — these cymbals were already in that neighborhood.

Round-robin: SAG 20-30 (167-220ms range for closed feel)
```

### 6. HI-HAT HALF OPEN — SAGAT
```
Primary:  DM-SAG 10.wav  (278ms)
Alt:      DM-SAG 03.wav  (416ms)

Same folder, longer sustain files. The half-open position is the one
that drives grooves. Chad's hi-hat controller foot position maps here.
```

### 7. HI-HAT OPEN — MANJEERA (JHANJ)
```
Folder:   MANJEERA ( JHANJ )/  (14 files, DM-MAN 01-14)
Primary:  DM-MAN 02.wav  (625ms)
Long:     DM-MAN 03.wav  (2053ms) — for open hat sustained wash
Short:    DM-MAN 14.wav  (198ms)

Character: Indian finger cymbals. Slightly different timbre than SAGAT
— warmer, less harsh. The transition from SAGAT (closed) to MANJEERA
(open) produces a timbral shift that reads as the hat opening.
Not realistic. Effective.
```

### 8. HI-HAT PEDAL CHICK — SAGAT
```
Primary:  DM-SAG 02.wav  (252ms)

The foot chick — hat closing without a stick hit.
Short, metallic, below the mix. SAGAT at mid-length works.
```

### 9. TOM HI — BONGOS
```
Primary:  DM-BON 001.wav  (307ms)
Round-robin: BON 001-030 (307-357ms range)

High bongo hit as high tom. Punchy, defined, higher pitch than the
congas. In a punk context this reads as a cracked high tom.
```

### 10. TOM MID — CONGA
```
Folder:   CONGA/  (155 files, DM-CON 001-155)
Primary:  DM-CON 010.wav  (463ms)
Round-robin: CON 001-050

155 conga files cover every articulation and dynamic.
Mid-range files for mid tom. The conga body is warm enough
to read as a rack tom in a dense punk mix.
```

### 11. FLOOR TOM — SURDO (ungated)
```
Primary:  DM-SUR 20.wav  (878ms)
Alt:      DM-SUR 10.wav  (1038ms)

The same surdo used for kick, but from the longer-decay end of the file set.
No synthesis layer. No gating. Let it ring.
In the mix: kick is tight and fast, floor tom is the same instrument
with its actual character restored. They share DNA. That's the kit.
```

### 12. COWBELL — COWBELL
```
Folder:   COWBELL/  (63 files, DM-COW 01-63)
Primary:  DM-COW 01.wav  (235ms)
Round-robin: all 63 files

63 cowbell recordings. Doru made 63 cowbell recordings.
That is who he was. Use all of them.
```

### 13. CRASH — CHINESE CYMBALS
```
Folder:   CHINESE CYMBALS/  (24 files, DM-CHI 01-24)
Primary:  DM-CHI 01.wav  (2330ms) — full crash ring
Short:    DM-CHI 24.wav  (873ms)  — quick crash, choked
Long:     DM-CHI 08.wav  (6463ms) — the big crash, use sparingly

Character: Chinese cymbals have an intentionally trashy, slightly wrong
quality — upturned bell, rivets, raw edge. This is the correct crash for
a zero-budget Berlin punk kit. A proper Zildjian A would be wrong here.

Velocity layers:
  mf (1-80):   DM-CHI 24.wav  (873ms)  — quick
  ff (81-127): DM-CHI 01.wav  (2330ms) — ring it out
```

### 14. RIDE — TRIANGLE (KESA)
```
File:   TRIANGLE/DM-TRI 12.wav  (7335ms)

The kesa file. One day of summer. Used as ride cymbal.
A 7-second pure triangle ring as ride is not realistic.
It is the correct ride for this universe.
The ride in the Berlin squat plays all night.
```

### 15. RIDE BELL — SLIT DRUM
```
Folder:   SLIT DRUM ( KRIN )/  (33 files, DM-SLI 01-33)
Primary:  DM-SLI 10.wav  (249ms)
Round-robin: SLI 10-20

Woody, tonal ping. The slit drum as ride bell is another wrong
instrument used correctly. The bell in the Berlin kit is wood.
```

### 16. MORE COWBELL
```
Files:    DM-COW 20.wav  (534ms), DM-COW 63.wav  (519ms)
Round-robin: COW 50-63 — the longer-ring files

Same folder, different end of the file set. More sustain.
This pad plays the cowbell part that the other pad can't reach in time.
Two cowbell pads is not a joke. It is a production decision.
```

---

## Additional Folders Required in Collection

The seasonal register collection (collect_doru.sh) covers 5 folders.
The Berlin punk kit requires 6 additional folders.

Update collect_doru.sh to add:
```bash
"Doru_Malia/SURDO"
"Doru_Malia/DOUN DOUN"
"Doru_Malia/CAJON"
"Doru_Malia/MANJEERA ( JHANJ )"
"Doru_Malia/SAGAT ( ZILL )"
"Doru_Malia/CHINESE CYMBALS"
"Doru_Malia/CONGA"
"Doru_Malia/BONGOS"
"Doru_Malia/COWBELL"
"Doru_Malia/SLIT DRUM ( KRIN )"
```

Estimated additional size: ~152MB
Total collection (seasonal + punk kit): ~274MB from 4.4GB source

---

## Kick Synthesis Layer — Implementation Note

The SURDO kick needs a synthesis sub-layer for blast-beat viability.
This is not optional at Hirvonen tempos. The SURDO alone at 340ms
will blur at 200+ BPM double-kick. The synthesis layer provides
the definition that lets each kick speak individually at speed.

Web Audio (for game/prototype context):
```javascript
function synthKickLayer(ctx) {
  const osc = ctx.createOscillator();
  const env = ctx.createGain();
  osc.type = 'sine';
  osc.frequency.setValueAtTime(150, ctx.currentTime);
  osc.frequency.exponentialRampToValueAtTime(55, ctx.currentTime + 0.08);
  env.gain.setValueAtTime(0.9, ctx.currentTime);
  env.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.11);
  osc.connect(env);
  env.connect(ctx.destination);
  osc.start();
  osc.stop(ctx.currentTime + 0.12);
}
```

In REAPER: sine sweep track alongside SURDO track, gated and layered.
In plugin context (AD2 Addictive Trigger, DirectWave): layer mode,
synthesis sample pre-rendered to WAV in sounds/synthesis/kick-sub.wav.

---

## Station IR on This Kit

The hiljaisuus_station.wav IR (40×12×7m metal corridor, RT60 2.2s)
applies to this kit at reduced wet — 10-15%, not 20-30%.
The Berlin squat is not the station. But the drummer in the squat
came from somewhere. The room remembers where.

---

*tonal_design branch. Not for public.*
*Cross-reference: doru_pipeline.md, percussion_brief.md, midi_keylab88_berlin.md*
*Performers: Chad Evans (primary), Jakko McGill / KeyLab 88 mk2 (fallback)*
