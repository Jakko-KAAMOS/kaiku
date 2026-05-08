\version "2.24.0"
\header {
  title = "E10 — Parallel Fourths"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase II: Motion"
  piece = "Soprano and piano a diatonic fourth apart."
  tagline = ##f
}

% Diatonic fourths in F# Phrygian (piano a fourth below soprano):
% fis -> cis, g -> d, a -> e, b -> fis

soprano = {
  \clef treble
  \key fis \phrygian
  \tempo 4 = 40
  \time 4/4
  fis''1 r1
  g''1  r1
  a''1  r1
  b''1  r1
  \bar "|."
}

reference = {
  \clef treble
  \key fis \phrygian
  \time 4/4
  cis'1 r1
  d'1  r1
  e'1  r1
  fis'1 r1
  \bar "|."
}

\score {
  \new StaffGroup <<
    \new Staff {
      \set Staff.instrumentName = "Kaiku"
      \soprano
    }
    \new Staff {
      \set Staff.instrumentName = "Piano"
      \reference
    }
  >>
  \layout {}
  \midi {}
}
