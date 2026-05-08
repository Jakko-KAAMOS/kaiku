\version "2.24.0"
\header {
  title = "E16 — LFO Cycle (Hiljaisuus)"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase IV: Envelope"
  piece = "The LFO completes one cycle every 6.67 s. At ♩=40, one bar = 6 s."
  tagline = ##f
}

% The Hiljaisuus LFO runs at 0.15 Hz — period = 6.67 seconds.
% At tempo 40, a whole note = 6 seconds. A tied 3-bar note = 18 seconds (~2.7 cycles).
% The modulation should be visible in the spectrogram as slow amplitude periodicity.
% This is expected behavior. If the LFO is invisible, that is the defect.

\score {
  \new Staff {
    \clef treble
    \key fis \phrygian
    \tempo 4 = 40
    \time 4/4
    fis'1~
    fis'1~
    fis'1
    r1
    r1
    r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
