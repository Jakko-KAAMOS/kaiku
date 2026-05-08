\version "2.24.0"
\header {
  title = "E15 — Crescendo, Sustained"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase IV: Envelope"
  piece = "Does the sustain hold without drift? Does FM character shift with amplitude?"
  tagline = ##f
}

% F#4 held across three tied whole notes with a full crescendo pp to ff.
% At tempo 40, this is 18 seconds of sustained tone.
% Watch the spectrogram: FM sidebands shift with amplitude if the sustain is unstable.
% The LFO is also active — the slow modulation is expected. The crescendo is the variable.

\score {
  \new Staff {
    \clef treble
    \key d \major
    \tempo 4 = 40
    \time 4/4
    fis'1~\pp\<
    fis'1~
    fis'1\ff\!
    r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
