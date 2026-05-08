\version "2.24.0"
\header {
  title = "E03 — Solo Low Tenor"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "One voice. Whole notes. Wait for the beat."
  tagline = ##f
}

\score {
  \new Staff {
    \clef tenor
    \key fis \phrygian
    \tempo 4 = 40
    \time 4/4
    % F# Phrygian ascending, low tenor register (F#3–F#4)
    fis1  r1
    g1   r1
    a1   r1
    b1   r1
    cis'1 r1
    d'1  r1
    e'1  r1
    fis'1 r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
