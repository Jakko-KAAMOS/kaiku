\version "2.24.0"
\header { title = "F# Phrygian tenor + D drone (v2)" tagline = ##f }

%% v2: octave down from v1, tempo 99, D pedal drone underneath as voice 2.
%% F# Phrygian preserved (F# G A B C# D E F#). D is the b6 -- holding it
%% under the tenor line tilts the ear toward D minor pentatonic without
%% retuning a single melody pitch.

melody = \relative c' {
  %% Phrase A
  fis8 a g8 fis e8 d cis8 b | g'8 fis a8 g fis4 e4 |
  fis8 g a8 b cis8 b a8 g | fis4 e4 d4 cis4 |
  %% Phrase B -- ascend through b2-b3
  fis8 g a8 b cis8 d e8 fis | g8 fis e8 d cis8 b a8 g |
  fis4 g4 a4 b4 | cis8 b a8 g fis2 |
  %% Phrase C -- leap and fall
  fis8 cis' b8 a g8 fis e8 d | cis8 b a8 g fis8 e d8 cis |
  g'4 fis4 e4 d4 | cis4 b4 a4 fis4 |
  %% Phrase D -- upper octave variation
  fis'8 g a8 g fis8 e d8 cis | b8 a g8 fis g8 a b8 cis |
  d8 cis b8 a g8 fis e8 d | cis4 d4 e4 fis4 |
  %% Phrase E -- cycling
  fis8 g fis8 e d8 cis b8 a | g8 fis g8 a b8 cis d8 e |
  fis8 e d8 cis b8 a g8 fis | g4 fis4 a8 g fis4 |
  %% Phrase F -- extended descent
  fis''8 e d8 cis b8 a g8 fis | e8 d cis8 b a8 g fis8 e |
  d8 e fis8 g a8 b cis8 d | e8 d cis8 b a8 g fis4 |
  g4 fis4 e4 fis4 | fis1 |
}

%% Drone: D2 + D3 sustained for the whole piece.
%% Each measure = whole note for clarity (REAPER/Kaiku will sustain).
%% 26 measures total in the melody (count above).
drone = \relative c, {
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1 <d d'>1 <d d'>1
  <d d'>1 <d d'>1
}

\score {
  \new Staff <<
    \new Voice { \voiceOne \clef treble \key fis \phrygian \tempo 4 = 99 \time 4/4 \melody }
    \new Voice { \voiceTwo \clef bass \drone }
  >>
  \midi { \tempo 4 = 99 }
  \layout {}
}
