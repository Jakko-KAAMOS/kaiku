\version "2.24.0"
\header { title = "F# Phrygian -- mid-tenor audition" tagline = ##f }

%% F# Phrygian: F# G A B C# D E F#  (b2=G, b3=A, b6=D, b7=E)
%% ~3 min at quarter=120. Eighths and quarters, minimal rest. Strong-beat b2 (G).

\score {
  \new Staff {
    \clef treble
    \key fis \phrygian
    \tempo 4 = 120
    \time 4/4
    \relative c'' {
      fis8 a g8 fis e8 d cis8 b | g'8 fis a8 g fis4 e4 |
      fis8 g a8 b cis8 b a8 g | fis4 e4 d4 cis4 |
      fis8 g a8 b cis8 d e8 fis | g8 fis e8 d cis8 b a8 g |
      fis4 g4 a4 b4 | cis8 b a8 g fis2 |
      fis8 cis' b8 a g8 fis e8 d | cis8 b a8 g fis8 e d8 cis |
      g'4 fis4 e4 d4 | cis4 b4 a4 fis4 |
      fis'8 g a8 g fis8 e d8 cis | b8 a g8 fis g8 a b8 cis |
      d8 cis b8 a g8 fis e8 d | cis4 d4 e4 fis4 |
      fis8 g fis8 e d8 cis b8 a | g8 fis g8 a b8 cis d8 e |
      fis8 e d8 cis b8 a g8 fis | g4 fis4 a8 g fis4 |
      fis''8 e d8 cis b8 a g8 fis | e8 d cis8 b a8 g fis8 e |
      d8 e fis8 g a8 b cis8 d | e8 d cis8 b a8 g fis4 |
      g4 fis4 e4 fis4 | fis1 |
      \bar "|."
    }
  }
  \midi { \tempo 4 = 120 }
  \layout {}
}
