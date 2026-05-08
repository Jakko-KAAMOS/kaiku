\version "2.24.0"
\header {
  title = "E05 — b2 (G♮) Across All Registers"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "If this sounds wrong, everything downstream is wrong."
  tagline = ##f
}

% The b2 (G natural) is the load-bearing interval of F# Phrygian.
% This exercise isolates G across all four registers simultaneously.
% Listen for FM formant interaction between stacks at this pitch.

\score {
  \new StaffGroup <<
    \new Staff {
      \clef treble
      \key d \major
      \tempo 4 = 40
      \time 4/4
      \set Staff.instrumentName = "Soprano"
      g''1 r1 r1 r1
    }
    \new Staff {
      \clef treble
      \key d \major
      \time 4/4
      \set Staff.instrumentName = "High Ten."
      r1 g'1 r1 r1
    }
    \new Staff {
      \clef tenor
      \key d \major
      \time 4/4
      \set Staff.instrumentName = "Low Ten."
      r1 r1 g1 r1
    }
    \new Staff {
      \clef bass
      \key d \major
      \time 4/4
      \set Staff.instrumentName = "Cbass"
      r1 r1 r1 g,1
    }
  >>
  \layout {}
  \midi {}
}
