\version "2.24.0"

% ─────────────────────────────────────────────────────────────────────────────
% TYHJYYDENKAIKU — Da Riddim
% The condensation. Silence becoming rhythm.
%
% Meter: 6/8 — compound duple. The lilt is built in.
% Tempo: dotted quarter = 96. Uptempo, driven, not frantic.
% Key: F# Phrygian (D major key sig, starting on F#)
%
% STRUCTURAL LOGIC — Geographical Fugue condensation:
%
%   Bars 1-2:   Pohja pulse alone. The silence already had this.
%               It just wasn't visible until now.
%
%   Bars 3-4:   Condensation enters — syncopated FM percussion cell.
%               The silence subdivides. The pulse has flesh on it.
%
%   Bars 5-6:   Mouth music voice 1 (Lausuja). First syllable-rhythm entry.
%               The Kalevala cell: STRONG-weak-strong | STRONG-weak-strong
%
%   Bars 7-8:   Mouth music voice 2 (Kaiku). Enters 2 bars later.
%               Same cell, imitation. The echo arrives.
%
%   Bar 9+:     Ilma enters (sustained). The field is complete.
%               The Hurdy enters at bar 13. It has been earned.
%
% SYNCOPATION NOTE:
%   The mouth music cell displaces the strong beat by one eighth note.
%   The accent lands on the "and" of beat 1 in 6/8 terms.
%   The listener feels pulled forward — the rhythm leans into the next bar.
%   This is the silence condensing: not landing where expected,
%   arriving somewhere more interesting.
% ─────────────────────────────────────────────────────────────────────────────

\header {
  title = "Tyhjyydenkaiku — Da Riddim"
  subtitle = "Condensation sequence. 6/8. F# Phrygian."
  composer = "Kaamos"
  tagline = ##f
}

global = {
  \key d \major
  \time 6/8
  \tempo "Condensing" 4. = 96
}

% ── POHJA — bass drone with rhythmic articulation ────────────────────────────
% The pulse made explicit. Was always there.

pohja = \relative c, {
  \global
  % Bars 1-2: just the pulse
  fis4. fis4. |
  fis4. fis4. |
  % Bars 3-8: pulse holds, slight articulation
  fis4 fis8 fis4. |
  fis4. fis8 fis4 |
  fis4. fis4. |
  fis4. fis4. |
  fis4 fis8 fis4. |
  fis4. fis4. |
  % Bars 9-12: motion toward E (subtonic) — the rhythm is breathing
  fis4. e4. |
  e4. fis4. |
  fis4. fis4. |
  fis4. fis4. |
  % Bar 13+: Hurdy enters here — Pohja holds
  fis4. fis4. |
  fis4. fis4. |
  fis4. fis4. |
  fis4. fis4. |
}

% ── CONDENSATION — syncopated FM percussion cell ─────────────────────────────
% The silence subdivides. Enters bar 3.
% Notated on a single pitch (C5) — represents FM percussive attack voice.
% Rhythm is the content. Pitch is nominal.

condensation = \relative c'' {
  \global
  % Bars 1-2: silent
  R2. | R2. |
  % Bar 3: enters — syncopated cell
  % Pattern: rest eighth, two eighths, rest eighth, two eighths
  % Displaces the beat. Leans forward.
  r8 c8 c8 r8 c8 c8 |
  c8 r8 c8 c8 r8 c8 |
  % Variation — adds the "and" accent
  r8 c8 r8 c8 c8 r8 |
  c8 c8 r8 r8 c8 c8 |
  % Settles into groove
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
  % Hurdy enters bar 13 — condensation thins slightly, makes room
  r8 c8 r8 r8 c8 r8 |
  r8 c8 r8 r8 c8 r8 |
  r8 c8 c8 r8 c8 c8 |
  r8 c8 c8 r8 c8 c8 |
}

% ── LAUSUJA — mouth music voice 1, Geographical Fugue entry ──────────────────
% Kalevala cell: "hil-jai-suu | den aa-va"
% Syllable rhythm: ♪♩ ♪ | ♪♩ ♪
% The STRONG beat is displaced — arrives an eighth late. Syncopation.

lausuja = \relative c' {
  \global
  % Bars 1-4: silent — condensation establishes first
  R2. | R2. | R2. | R2. |
  % Bar 5: Lausuja enters
  % Melodic cell: F# G A G F# — the Phrygian pull in miniature
  % Rhythmic cell: eighth-quarter-eighth | eighth-quarter-eighth
  r8 fis8~ fis4 g8~ |
  g4 fis8~ fis4 e8~ |
  e8 fis4~ fis4 g8~ |
  g4. fis4 r8 |
  % Second phrase — wider arc
  r8 fis8~ fis4 a8~ |
  a4 g8~ g4 fis8~ |
  fis4. r4. |
  r8 fis8 g8 a8 g8 fis8 |
  % Bar 13+: holds under hurdy
  fis4.~ fis4. |
  fis4.~ fis4. |
  r4. r4. |
  r4. r4. |
}

% ── KAIKU — mouth music voice 2, echo entry ──────────────────────────────────
% Same cell as Lausuja, enters 2 bars later.
% This is how runolaulu works. The echo is not behind. It is alongside, in time.

kaiku = \relative c' {
  \global
  % Bars 1-6: silent
  R2. | R2. | R2. | R2. | R2. | R2. |
  % Bar 7: Kaiku enters — same material as Lausuja bar 5
  r8 fis8~ fis4 g8~ |
  g4 fis8~ fis4 e8~ |
  e8 fis4~ fis4 g8~ |
  g4. fis4 r8 |
  r8 fis8~ fis4 a8~ |
  a4 g8~ g4 fis8~ |
  fis4.~ fis4. |
  fis4.~ fis4. |
  R2. |
  R2. |
}

% ── ILMA — sustained air voice, enters bar 9 ─────────────────────────────────
% The field completes. When Ilma enters, the texture is full.
% After this: the Hurdy has been earned.

ilma = \relative c'' {
  \global
  R2. | R2. | R2. | R2. |
  R2. | R2. | R2. | R2. |
  % Bar 9: Ilma enters on C# (the 5th)
  cis4.~ cis4. |
  cis4. d4.~ |
  d4. cis4.~ |
  cis4.~ cis4. |
  % Bar 13: Hurdy enters. Ilma thins.
  cis4.~ cis4. |
  b4.~ b4. |
  cis4.~ cis4. |
  cis4.~ cis4. |
}

% ── HURDY ENTRY — bar 13, marked ─────────────────────────────────────────────
% Tyhjyydenkaiku lead. Not notated here in full — see timbre_brief.md.
% This staff marks the entry point and gives the opening phrase.

hurdy = \relative c' {
  \global
  R2. | R2. | R2. | R2. |
  R2. | R2. | R2. | R2. |
  R2. | R2. | R2. | R2. |
  % Bar 13: the Hurdy enters. It was earned.
  \mark "TYHJYYDENKAIKU"
  fis4 g8 a4.~ |
  a4 g8 fis4 e8~ |
  e4 fis8~ fis4.~ |
  fis4.~ fis4 r8 |
}

\score {
  \new StaffGroup <<
    \new Staff \with {
      instrumentName = \markup { \italic "Hurdy" }
      shortInstrumentName = "H"
    } { \clef treble \hurdy }

    \new Staff \with {
      instrumentName = \markup { \italic "Ilma" }
      shortInstrumentName = "Il"
    } { \clef treble \ilma }

    \new Staff \with {
      instrumentName = \markup { \italic "Lausuja" }
      shortInstrumentName = "L"
    } { \clef treble \lausuja }

    \new Staff \with {
      instrumentName = \markup { \italic "Kaiku" }
      shortInstrumentName = "K"
    } { \clef treble \kaiku }

    \new RhythmicStaff \with {
      instrumentName = \markup { \italic "Cond." }
      shortInstrumentName = "C"
    } { \condensation }

    \new Staff \with {
      instrumentName = \markup { \italic "Pohja" }
      shortInstrumentName = "P"
    } { \clef bass \pohja }
  >>
  \layout {
    \context {
      \Score
      \omit BarNumber
      indent = 2\cm
    }
  }
  \midi { }
}
