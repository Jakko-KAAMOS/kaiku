\version "2.26.0"

%% formatted for print annotation and Fire HD10 pen input
#(set-global-staff-size 24)

\paper {
  #(set-paper-size "a4")
  top-margin    = 20\mm
  bottom-margin = 20\mm
  left-margin   = 25\mm
  right-margin  = 25\mm
  system-system-spacing =
    #'((basic-distance . 28)
       (minimum-distance . 20)
       (padding . 8))
  score-system-spacing =
    #'((basic-distance . 24)
       (padding . 8))
  ragged-last-bottom = ##f
}

\header {
  title    = "3-1-11"
  subtitle = "skeleton"
  tagline  = ##f
}

global = {
  \tempo "moderato" 4 = 99
  \mark \markup { \box "3/4" }
  \time 3/4
  s2. s2. s2.
  \mark \markup { \box "2/4" }
  \time 2/4
  s2
  \mark \markup { \box "4/4" }
  \time 4/4
  s1 s1 s1 s1 s1
  s1 s1 s1 s1 s1
  s1
  \bar "|."
}

treble = \relative c'' {
  \clef treble
  \time 3/4
  R2. R2. R2.
  \time 2/4
  R2
  \time 4/4
  R1 R1 R1 R1 R1
  R1 R1 R1 R1 R1
  R1
}

bass = \relative c {
  \clef bass
  \time 3/4
  R2. R2. R2.
  \time 2/4
  R2
  \time 4/4
  R1 R1 R1 R1 R1
  R1 R1 R1 R1 R1
  R1
}

cajon = \drummode {
  \time 3/4
  r2. r2. r2.
  \time 2/4
  r2
  \time 4/4
  r1 r1 r1 r1 r1
  r1 r1 r1 r1 r1
  r1
}

\score {
  \new StaffGroup <<
    \new PianoStaff <<
      \new Staff { \global \treble }
      \new Staff { \global \bass }
    >>
    \new DrumStaff \with {
      \override StaffSymbol.line-count = #1
      instrumentName = \markup { \small "cajon" }
    } {
      \global
      \cajon
    }
  >>
  \layout {
    \context {
      \Score
      \override BarNumber.break-visibility = ##(#t #t #t)
      barNumberVisibility = #all-bar-numbers-visible
      \override BarNumber.font-size = #-1
    }
  }
}

