\version "2.24.0"
\header { title = "F# Phrygian -- cross-register ostinato" tagline = ##f }

%% F# Phrygian. Bass ostinato + soprano answer. ~3 min at quarter=120.

dorlow = \relative c, {
  \repeat unfold 32 { fis8 cis e fis g cis, e fis }
}

dorhigh = \relative c'' {
  R1*4
  a4. cis8 d4 fis8 d8 | a4 g8 a8 cis4 d8 cis8 |
  a4. g8 fis4 d8 cis8 | d2 r2 |
  fis4 a8 cis8 d4 cis8 a8 | g8 a8 cis8 d8 fis4 a4 |
  cis8 a8 g8 fis8 d4 cis8 d8 | fis4 d4 a2 |
  cis'4 a4 g8 fis8 d8 cis8 | d4 a4 cis4 d4 |
  fis8 d8 cis8 a8 g8 fis8 d8 cis8 | d2 r2 |
  d4 fis8 a8 cis4 g8 fis8 | cis4 a8 g8 fis4 d4 |
  d8 fis8 a8 cis8 d4 fis4 | a2 cis2 |
  d''4 cis8 a8 g8 fis8 d8 cis8 | a4 g8 fis8 d4 a8 cis8 |
  d4. fis8 a4 cis8 a8 | d2 r2 |
  fis8 d cis a g fis d cis | d a cis d fis a cis d |
  fis4 d4 cis4 a4 | d2 a2 |
  d8 fis a cis d cis a fis | d4 a4 cis4 d4 |
  fis4 d2. | d1 |
}

\score {
  \new Staff <<
    \new Voice { \voiceOne \clef treble \tempo 4 = 120 \time 4/4 \dorhigh }
    \new Voice { \voiceTwo \clef bass \dorlow }
  >>
  \midi { \tempo 4 = 120 }
  \layout {}
}
