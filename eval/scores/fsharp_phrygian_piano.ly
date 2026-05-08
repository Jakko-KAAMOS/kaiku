\version "2.24.0"
#(set-global-staff-size 24)
\paper {
  #(set-paper-size "a4")
  top-margin = 20\mm  bottom-margin = 20\mm
  left-margin = 25\mm  right-margin = 25\mm
  system-system-spacing =
    #'((basic-distance . 28) (padding . 8))
}
\header {
  title    = "F# Phrygian — Piano"
  subtitle = "scale and primary triads"
  tagline  = ##f
}

%% ── SCALE ──────────────────────────────────────────────────────────────────
\score {
  \header { piece = "Scale — parallel motion" }
  \new PianoStaff <<
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
    \new Staff {
      \clef bass
      \key fis \phrygian
      \time 4/4
      fis4 g a b | cis' d' e' fis' |
      fis' e' d' cis' | b a g fis |
      fis1
      \bar "|."
    }
  >>
}

%% ── ARPEGGIOS ───────────────────────────────────────────────────────────────
\score {
  \header { piece = "Primary triads — arpeggios" }
  \new PianoStaff <<
    \new Staff {
      \clef treble
      \key fis \phrygian
      \time 4/4
      \tempo 4 = 99
      %% i — F# minor
      \mark \markup { \bold { "i  F" \sharp "m" } }
      fis'4 a' cis'' fis'' | fis'' cis'' a' fis' |
      %% II — G major
      \mark \markup { \bold "II  G" }
      g'4 b' d'' g'' | g'' d'' b' g' |
      %% iv — B minor
      \mark \markup { \bold "iv  Bm" }
      b'4 d'' fis'' b'' | b'' fis'' d'' b' |
      %% VII — E minor
      \mark \markup { \bold "VII  Em" }
      e'4 g' b' e'' | e'' b' g' e' |
      e'1
      \bar "|."
    }
    \new Staff {
      \clef bass
      \key fis \phrygian
      \time 4/4
      fis4 a cis' fis' | fis' cis' a fis |
      g4 b d' g' | g' d' b g |
      b,4 d fis b | b fis d b, |
      e,4 g, b, e | e b, g, e, |
      e,1
      \bar "|."
    }
  >>
}

