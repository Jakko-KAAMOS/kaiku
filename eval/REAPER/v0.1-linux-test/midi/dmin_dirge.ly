\version "2.24.0"
\header { title = "Dirge -- D natural minor -- for the ossuary" tagline = ##f }

%% D natural minor: D E F G A Bb C D.  No leading tone.
%% 16 bars at quarter=72.  Hiljaisuus LFO (0.15 Hz) breathes once per 2 bars.
%% Phrase A (1-8): descent from A5 to D4 in the soprano.  Bass plants downbeats.
%% Phrase B (9-16): rises briefly to F5 and falls to a final iv-i plagal.
%% No leading tones.  No syncopation.  No relief.

global = { \key d \minor \time 4/4 }

soprano = \relative c'' {
  %% Phrase A -- the descent
  a1 | a1 | g1 | g1 |
  f1 | f1 | e1 | d1 |
  %% Phrase B -- the small rise and final fall
  d1 | f1 | e1 | f1 |
  e1 | d1 | c1 | d1 |
  \bar "|."
}

alto = \relative c' {
  f1 | f1 | e1 | e1 |
  d1 | d1 | c1 | a1 |
  a1 | d1 | c1 | d1 |
  c1 | a1 | a1 | f1 |
}

tenor = \relative c' {
  \clef "treble_8"
  d1 | c1 | c1 | bes1 |
  bes1 | a1 | a1 | f1 |
  f1 | a1 | a1 | a1 |
  a1 | f1 | f1 | a1 |
}

bass = \relative c {
  \clef bass
  d1 | f1 | c1 | g1 |
  bes,1 | f1 | a,1 | d1 |
  d1 | d1 | a1 | d1 |
  a,1 | d1 | f1 | d1 |
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "S" { \global \voiceOne \tempo 4 = 72 \soprano }
      \new Voice = "A" { \global \voiceTwo \alto }
    >>
    \new Staff = "men" <<
      \new Voice = "T" { \global \voiceOne \tenor }
      \new Voice = "B" { \global \voiceTwo \bass }
    >>
  >>
  \layout {}
  \midi { \tempo 4 = 72 }
}
