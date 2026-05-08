\version "2.24.0"
\header {
  title = "E06 — Piano Reference"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "Kaiku against a known timbre. The piano is the reference."
  tagline = ##f
}

% Use a piano (or any FM sine-based reference) on a second REAPER track.
% This is the baseline against which Kaiku's timbre is evaluated.
% Listen for how Kaiku's stack character differs from the reference.

upper = \relative c'' {
  \clef treble
  \key fis \phrygian
  \tempo 4 = 40
  \time 4/4
  fis1 r1
  g1  r1
  a1  r1
  b1  r1
  cis'1 r1
  d'1 r1
  e'1 r1
  fis'1 r1
  \bar "|."
}

lower = \relative c {
  \clef bass
  \key fis \phrygian
  \time 4/4
  fis1 r1
  g1  r1
  a1  r1
  b1  r1
  cis1 r1
  d1  r1
  e1  r1
  fis1 r1
  \bar "|."
}

\score {
  \new PianoStaff <<
    \new Staff { \upper }
    \new Staff { \lower }
  >>
  \layout {}
  \midi {}
}
