\version "2.24.0"
\header {
  title = "E04 — Solo Contrabass"
  subtitle = "Kaiku VST3i · F# Phrygian · Phase I: Timbre"
  piece = "Do not skip this register. The beat period is ~2.7 s at F#1."
  tagline = ##f
}

\score {
  \new Staff {
    \clef bass
    \key fis \phrygian
    \tempo 4 = 40
    \time 4/4
    % F# Phrygian ascending, contrabass register (F#1–F#2)
    % At F#1 the 1.008x beat period is approximately 2.7 seconds.
    % Each whole note at tempo 40 = 6 seconds. The beat completes twice per note.
    fis,,1  r1
    g,,1   r1
    a,,1   r1
    b,,1   r1
    cis,1  r1
    d,1   r1
    e,1   r1
    fis,1  r1
    \bar "|."
  }
  \layout {}
  \midi {}
}
