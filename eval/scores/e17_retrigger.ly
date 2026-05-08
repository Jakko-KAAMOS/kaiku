\version "2.24.0"
\header {
  title = "E17 — Re-trigger, Same Pitch"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase IV: Envelope"
  piece = "Second note fires 1.5 s after the first ends. Release may not be complete."
  tagline = ##f
}

% At tempo 40: whole note = 6 s, quarter rest = 1.5 s.
% First note: 6 seconds. Gap: 1.5 seconds (within expected release tail).
% Second note fires before the first release completes.
% Listen for: phase cancellation, amplitude doubling, pop on re-attack.
% Tests the 16-voice allocator: does it steal the voice or add a second one?

\score {
  \new Staff {
    \clef treble
    \key fis \phrygian
    \tempo 4 = 40
    \time 4/4
    fis'1         % first trigger: 6 seconds
    r4 fis'2.     % 1.5 s gap, second trigger fires (3 beats = 4.5 s)
    r1            % rest
    \bar "|."
  }
  \layout {}
  \midi {}
}
