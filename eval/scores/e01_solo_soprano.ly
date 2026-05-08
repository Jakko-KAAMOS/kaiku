\version "2.24.0"
\header {
  title = "E01 — Solo Soprano"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "One voice. Whole notes. Wait for the beat."
  tagline = ##f
}

\score {
  \new Staff {
    \clef treble
    \key d \major
    \tempo 4 = 40
    \time 4/4
    % F# Phrygian ascending, soprano register (F#5–F#6)
    % Each pitch class followed by a whole rest.
    % The rest is not silence — it is the test.
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
  \layout {}
  \midi {}
}
