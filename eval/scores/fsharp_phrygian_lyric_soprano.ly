\version "2.24.0"
#(set-global-staff-size 24)
\paper {
  #(set-paper-size "a4")
  top-margin = 20\mm  bottom-margin = 20\mm
  left-margin = 25\mm  right-margin = 25\mm
}
\header {
  title    = "F# Phrygian — Lyric Soprano"
  subtitle = "scale exercise"
  tagline  = ##f
}
\score {
  \new Staff {
    \clef treble
    \key fis \phrygian
    \time 4/4
    \tempo 4 = 99
    fis'4 g' a' b' | cis'' d'' e'' fis'' |
    fis'' e'' d'' cis'' | b' a' g' fis' |
    fis'1
    \bar "|."
  }
}

