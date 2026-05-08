\version "2.24.0"
\header {
  title = "E08 — Contrary Motion"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase II: Motion"
  piece = "Soprano ascends. Piano descends. Both from F#."
  tagline = ##f
}

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
  fis'1  r1
  e'1   r1
  d'1   r1
  cis'1  r1
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
