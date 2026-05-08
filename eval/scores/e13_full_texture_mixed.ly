\version "2.24.0"
\header {
  title = "E13 — Full Texture, Mixed Motion"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase III: Ensemble"
  piece = "Soprano moves. Lower parts hold. Does the wheel carrier alias at close intervals?"
  tagline = ##f
}

% Soprano traces the F# Phrygian scale.
% Lower parts hold the tonic F# as a drone.
% Listen for beating artifacts as the soprano crosses each scale degree.

soprano = {
  \clef treble
  \key fis \phrygian
  \tempo 4 = 40
  \time 4/4
  fis''1 r1
  g''1  r1
  a''1  r1
  b''1  r1
  cis'''1 r1
  d'''1 r1
  e'''1 r1
  fis'''1 r1
  \bar "|."
}

highTenor = {
  \clef treble
  \key fis \phrygian
  \time 4/4
  fis'1 r1 fis'1 r1 fis'1 r1 fis'1 r1
  fis'1 r1 fis'1 r1 fis'1 r1 fis'1 r1
  \bar "|."
}

lowTenor = {
  \clef tenor
  \key fis \phrygian
  \time 4/4
  fis1 r1 fis1 r1 fis1 r1 fis1 r1
  fis1 r1 fis1 r1 fis1 r1 fis1 r1
  \bar "|."
}

contrabass = {
  \clef bass
  \key fis \phrygian
  \time 4/4
  fis,1 r1 fis,1 r1 fis,1 r1 fis,1 r1
  fis,1 r1 fis,1 r1 fis,1 r1 fis,1 r1
  \bar "|."
}

\score {
  \new StaffGroup <<
    \new Staff {
      \set Staff.instrumentName = "Soprano"
      \soprano
    }
    \new Staff {
      \set Staff.instrumentName = "High Ten."
      \highTenor
    }
    \new Staff {
      \set Staff.instrumentName = "Low Ten."
      \lowTenor
    }
    \new Staff {
      \set Staff.instrumentName = "Cbass"
      \contrabass
    }
  >>
  \layout {}
  \midi {}
}
