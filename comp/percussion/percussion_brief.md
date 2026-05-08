# Tyhjyydenkaiku — Percussion Brief
## Doru Malaia 230 Ethnic Drums & Percussions

*Doru Malaia. Romanian musician. Died February 10, 2006.*
*14,400 one-shot samples made by one person, sold for $29, now irreplaceable.*
*Their presence in this track is a memorial act as much as a production decision.*
*Credit in liner notes: Percussion samples by Doru Malaia.*

---

## Role in the Track

The percussion is the condensation mechanism — Section 2 of the track structure.

Section 1 (Hiljaisuus) is silence: the IR space, the pulse, nothing asking you to begin.
Section 2 (Condensation) is where rhythm crystallizes FROM the texture.
The percussion does not arrive. It emerges. It was always there.

The five seasonal registers are the rhythmic vocabulary of the station.
Each one marks a condition. Conditions determine what is possible.

---

## Source Library — Verified

Location: not included in this repository. See `sounds/doru/README.md`.
Verified May 2026. All files: 96kHz · 24-bit · stereo · normalized · clean.

Five folders selected. All others remain available for later work.

---

## The Five Registers

### meripihka — the signal (year-round)
```
Folder:    CLAVES/
Files:     DM-CLV 01–59  (59 files)
Duration:  31ms – 260ms
Character: sharp, dry, woody. Short attack, clean exponential decay.
           The station's click. Present in all seasons.
           The click is not a description of the station. The click IS the station.

Primary:   DM-CLV 01.wav  (204ms) — full click, natural ring
Short:     DM-CLV 43.wav  ( 31ms) — near-instant, approaching typewriter
Mid:       DM-CLV 03.wav  ( 76ms) — clean, fast sequences
Long:      DM-CLV 33.wav  (260ms) — maximum ring for the register

Track use: Condensation (Section 2) — the foundational pulse.
           Always present. The rhythm you hear before you know you're hearing it.
```

### talvi — winter (dominant condition)
```
Folder:    LOG DRUM/
Files:     DM-LGD 01–10  (10 files)
Duration:  268ms – 538ms
Character: low, muffled, slow exponential decay.
           Not a punctuation. A weather system.
           The dominant condition. Present in all sections except the brief seasons.

Primary:   DM-LGD 01.wav  (477ms) — longest ring, most resonant
Maximum:   DM-LGD 07.wav  (538ms) — for sustained winter passages
Muted:     DM-LGD 10.wav  (268ms) — shortest, most suppressed

Note: 10 files only. The limited palette is correct.
      Winter does not offer variety.

Track use: Sections 1–2 dominant. Persists under hurdy and chorus.
           Recedes but does not stop during the brief seasons.
           Returns in full for the descent (Koivuhuilu, Section 7).
```

### kevät / kesä — three days / one day
```
Folder:    TRIANGLE/
Files:     DM-TRI 01–91  (91 files)
Duration:  91ms – 7335ms
Character: bright, sustaining, high. Brief and present because brief.

Two sub-registers:

  kevät (spring, 3 days): 300ms – 2000ms ring
    Primary:  DM-TRI 01.wav (1477ms) — clean attack, standard ring
    Shorter:  DM-TRI 02.wav  (987ms)
    Shortest: DM-TRI 36.wav  (295ms) — muted, barely there

  kesä (summer, 1 day): 3000ms – 7335ms ring
    Threshold: DM-TRI 05.wav (3296ms) — where spring becomes summer
    Primary:   DM-TRI 12.wav (7335ms) — one day of summer, maximum presence
    Alternate: DM-TRI 14.wav (6924ms)

Track use: kevät — signals the hurdy entrance (Section 3) and the chorus (Section 4).
           kesä  — one note, sustained, under the sung verse (Section 5).
                   DM-TRI 12 only. One day. Not repeated.
```

### hiljaisuus — Station Nine (the silence)
```
Folder:    TINGSHA ( TINGSHAG )/
Files:     DM-TING 01–13  (13 files)
Duration:  3737ms – 15410ms
Character: near-inaudible. One ring. The vocabulary of six.

All files are long. The tingsha does not do short. This is correct.

  Short range: DM-TING 06.wav  (3737ms) — minimum duration
  Primary:     DM-TING 01.wav  (4532ms) — standard ring for most uses
  Extended:    DM-TING 07.wav  (7510ms) — for passages of deeper silence
  Maximum:     DM-TING 02.wav (15410ms) — 15.4 seconds
               Reserved for Section 6 (Kuolinvihellys) — the threshold only.
               Do not use elsewhere.

Track use: Section 1 (Hiljaisuus) — the one thing that sounds in the silence.
           Section 6 (Kuolinvihellys) — DM-TING 02 specifically.
                                         After the death whistle. Not before.
```

### vaara — reserve
```
Folder:    ANVIL/
Files:     DM-ANV 01–20  (20 files)
Duration:  348ms – 1050ms
Character: metallic, hard, resonant. Do not use casually.

Primary:   DM-ANV 01.wav ( 922ms)
Longest:   DM-ANV 04.wav (1050ms)
Shortest:  DM-ANV 13.wav ( 348ms) — muted anvil

Track use: Not currently assigned. When it is deployed, the context will be
           unambiguous. The vaara register exists. It waits.
```

---

## Processing Pipeline

### Path A — Bittimuserrus (bitcrushed derivatives)

Source files are 96kHz/24-bit stereo. The pipeline: mix to mono → decimate → quantize.
Naive decimation — aliasing is intentional. The artifact is the texture.
The Fairlight had 8 bits. The Akai S612 had 12. This is the method.

```
bitcrush.py — see adjacent file.
```

| register | source | bit depth | target SR | output |
|----------|--------|-----------|-----------|--------|
| meripihka | CLAVES/DM-CLV 01.wav | 6-bit | 8000Hz | sounds/clk-amber.wav |
| talvi | LOG DRUM/DM-LGD 01.wav | 4-bit | 6000Hz | sounds/clk-winter.wav |
| kevät | TRIANGLE/DM-TRI 01.wav | 8-bit | 11025Hz | sounds/clk-spring.wav |
| hiljaisuus | TINGSHA ( TINGSHAG )/DM-TING 01.wav | 5-bit | 6000Hz | sounds/clk-silence.wav |

Note on bit depth rationale:
- meripihka 6-bit: woody grain, amber grit, still recognizable
- talvi 4-bit: maximum crush — muffled, low, barely a signal
- kevät 8-bit: highest fidelity of the set — brief but present, this is why
- hiljaisuus 5-bit: near-inaudible grain, the texture of the silence

### Path B — Synteesi (Web Audio approximations)

Self-contained. No files. The physics of each family from first principles.
Used in birch.html (game audio) and as reference for REAPER session design.
See `timbre_brief.md` for the FM voice architecture.

```javascript
// meripihka — claves
function synthClaves(ctx, gain = 0.28) {
  const osc = ctx.createOscillator(), env = ctx.createGain(),
        filt = ctx.createBiquadFilter();
  osc.type = 'sine'; osc.frequency.value = 2000;
  filt.type = 'bandpass'; filt.frequency.value = 2000; filt.Q.value = 8;
  env.gain.setValueAtTime(gain, ctx.currentTime);
  env.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.04);
  osc.connect(filt); filt.connect(env); env.connect(ctx.destination);
  osc.start(); osc.stop(ctx.currentTime + 0.05);
}

// talvi — log drum
function synthLogDrum(ctx, gain = 0.07) {
  const buf = ctx.createBuffer(1, ctx.sampleRate * 0.3, ctx.sampleRate);
  const data = buf.getChannelData(0);
  for (let i = 0; i < data.length; i++)
    data[i] = (Math.random() * 2 - 1) * Math.pow(1 - i / data.length, 9);
  const src = ctx.createBufferSource(); src.buffer = buf;
  const filt = ctx.createBiquadFilter();
  filt.type = 'lowpass'; filt.frequency.value = 130; filt.Q.value = 1.5;
  const env = ctx.createGain(); env.gain.value = gain;
  src.connect(filt); filt.connect(env); env.connect(ctx.destination);
  src.start();
}

// kevät / kesä — triangle (decay controls season: 1.2s = kevät, 6.0s = kesä)
function synthTriangle(ctx, gain = 0.55, decayS = 1.2) {
  const t = ctx.currentTime;
  [2800, 2812].forEach(freq => {
    const osc = ctx.createOscillator(), env = ctx.createGain();
    osc.type = 'sine'; osc.frequency.value = freq;
    env.gain.setValueAtTime(gain / 2, t);
    env.gain.exponentialRampToValueAtTime(0.001, t + decayS);
    osc.connect(env); env.connect(ctx.destination);
    osc.start(t); osc.stop(t + decayS + 0.1);
  });
}

// hiljaisuus — tingsha
function synthTingsha(ctx, gain = 0.05) {
  const t = ctx.currentTime;
  [900, 918].forEach(freq => {
    const osc = ctx.createOscillator(), env = ctx.createGain();
    osc.type = 'sine'; osc.frequency.value = freq;
    env.gain.setValueAtTime(gain / 2, t);
    env.gain.exponentialRampToValueAtTime(0.001, t + 2.5);
    osc.connect(env); env.connect(ctx.destination);
    osc.start(t); osc.stop(t + 2.6);
  });
}
```

---

## In the REAPER Session

The percussion runs alongside Kaiku, not beneath it.
All three elements share hiljaisuus_station.wav (40×12×7m corridor, RT60 2.2s).

```
Track layout:
  [Kaiku FM voice    ] — Tyhjyydenkaiku primary + trompette on accents
  [Doru Malaia perc  ] — meripihka bus + talvi bus + brief season triggers
  [Station IR send   ] — all tracks → hiljaisuus_station.wav convolution

Percussion routing:
  meripihka → Bus A (the pulse, always present)
  talvi     → Bus B (low shelf only, -12dB high-pass at 180Hz to keep it low)
  kevät/kesä → Bus C (single one-shot triggers, not looped)
  hiljaisuus → Bus D (tail only — feeds long into the station IR)
  vaara      → Bus E (offline until needed)
```

The Doru Malaia samples are not processed until they reach the REAPER session.
The bitcrushed derivatives are for web / game use. In REAPER: source files at full 96kHz.
Let the station IR do the work of placing them in the room.

---

## Condensation Logic (Section 2)

Section 2 rhythm crystallizes from Section 1 texture — not a new section, a phase change.
The meripihka click is the seed. It was always in the static. You begin to hear it.

Suggested entry sequence:
1. talvi enters first — submerged, below perception, barely there
2. meripihka crystallizes from the talvi body — the click emerges from the muffled drum
3. Syncopation builds — the click anticipates the beat, not sits on it
4. Triangle (kevät) enters once — announces what comes next
5. Hurdy enters (Section 3) into a rhythm that has been running for a while

The listener should not be able to identify the moment Section 2 began.
That is correct. That is the design.

---

*Cross-reference: timbre_brief.md (FM voices), hiljaisuus_ir.py (room)*
