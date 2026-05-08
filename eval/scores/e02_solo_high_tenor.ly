\version "2.24.0"
\header {
  title = "E02 — Solo High Tenor"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "One voice. Whole notes. Wait for the beat."
  tagline = ##f
}

\score {
  \new Staff {
    \clef treble
    \key fis \phrygian
    \tempo 4 = 40
    \time 4/4
    % F# Phrygian ascending, high tenor register (F#4–F#5)
    fis'1  r1
    g'1   r1
    a'1   r1
    b'1   r1
    cis''1 r1
    d''1  r1
    e''1  r1
    fis''1 r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
