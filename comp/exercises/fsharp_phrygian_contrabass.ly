\version "2.26.0"
#(set-global-staff-size 24)
\paper {
  #(set-paper-size "a4")
  top-margin = 20\mm  bottom-margin = 20\mm
  left-margin = 25\mm  right-margin = 25\mm
}
\header {
  title    = "F# Phrygian — Contrabass"
  subtitle = "scale exercise — written pitch, sounds 8va bassa"
  tagline  = ##f
}
\score {
  \new Staff {
    \clef bass
    \key fis \phrygian
    \time 4/4
    \tempo 4 = 99
    fis,4 g, a, b, | cis4 d4 e4 fis4 |
    fis4 e4 d4 cis4 | b,4 a,4 g,4 fis,4 |
    fis,1
    \bar "|."
  }
}

