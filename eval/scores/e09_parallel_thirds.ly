\version "2.24.0"
\header {
  title = "E09 — Parallel Thirds"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase II: Motion"
  piece = "Stack A and B can interact unpredictably at this interval."
  tagline = ##f
}

% Diatonic thirds in F# Phrygian (soprano part, piano a third below):
% fis -> d, g -> e, a -> fis, b -> g

soprano = {
  \clef treble
  \key d \major
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
  \key d \major
  \time 4/4
  d'1  r1
  e'1  r1
  fis'1 r1
  g'1  r1
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
