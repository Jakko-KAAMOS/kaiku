\version "2.24.0"
\header {
  title = "E12 — Full Texture, Sustained"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase III: Ensemble"
  piece = "Blend, mask, alias. Does Stack B take over or disappear?"
  tagline = ##f
}

% All four parts sustain the tonic F# for 4 bars, rest 4 bars.
% Then sustain the b2 G natural for 4 bars, rest 4 bars.
% The question is not timbre — Phase I settled that.
% The question is what happens when all stacks run simultaneously.

soprano = {
  \clef treble
  \key fis \phrygian
  \tempo 4 = 40
  \time 4/4
  fis''1 fis''1 fis''1 fis''1
  r1 r1 r1 r1
  g''1 g''1 g''1 g''1
  r1 r1 r1 r1
  \bar "|."
}

highTenor = {
  \clef treble
  \key fis \phrygian
  \time 4/4
  fis'1 fis'1 fis'1 fis'1
  r1 r1 r1 r1
  g'1 g'1 g'1 g'1
  r1 r1 r1 r1
  \bar "|."
}

lowTenor = {
  \clef tenor
  \key fis \phrygian
  \time 4/4
  fis1 fis1 fis1 fis1
  r1 r1 r1 r1
  g1 g1 g1 g1
  r1 r1 r1 r1
  \bar "|."
}

contrabass = {
  \clef bass
  \key fis \phrygian
  \time 4/4
  fis,1 fis,1 fis,1 fis,1
  r1 r1 r1 r1
  g,1 g,1 g,1 g,1
  r1 r1 r1 r1
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
