\version "2.24.0"
\header {
  title = "E14 — Staccato, pp through ff"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase IV: Envelope"
  piece = "Each velocity level is a separate question. Listen for click on attack and release."
  tagline = ##f
}

% Single pitch F#4, staccato, at five dynamic levels with rests between.
% A click on attack = attack parameter too short or phase alignment issue.
% A pop on release = release curve problem.
% Amplitude inconsistency across levels = velocity scaling problem.

\score {
  \new Staff {
    \clef treble
    \key d \major
    \tempo 4 = 40
    \time 4/4
    fis'2.\staccato\pp  r4 r1
    fis'2.\staccato\mp  r4 r1
    fis'2.\staccato\mf  r4 r1
    fis'2.\staccato\f   r4 r1
    fis'2.\staccato\ff  r4 r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
