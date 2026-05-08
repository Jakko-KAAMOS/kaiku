\version "2.24.0"

% ─────────────────────────────────────────────────────────────────────────────
% TYHJYYDENKAIKU — Four Performance Prompts
% Play all. Humanize. Report back for refinement.
%
% F# Phrygian throughout. D major key signature. 6/8 at dotted quarter = 96.
% ─────────────────────────────────────────────────────────────────────────────

% ═════════════════════════════════════════════════════════════════════════════
% PROMPT A — THE DRUM KIT
% The condensation groove. Full percussion staff.
% Calibrate VST. Play with humanization. Does it breathe or just sit?
%
% LAYERING LOGIC — silence becomes rhythm in stages:
%   Bars 1-2:  Kick alone. The pulse made visible. Nothing else.
%   Bars 3-4:  Hi-hat enters on all eighths. The silence subdivides.
%   Bars 5-6:  Snare enters on beat 2 (dotted quarter 2). Backbeat arrives.
%   Bars 7-8:  Full syncopated displacement. The groove is condensed.
%   Bars 9-16: The pattern. Repeat with humanization. This is the data.
%
% SYNCOPATION CELL (bars 7-8):
%   Hi-hat: OFF the main beats — positions 2,3,5,6 of the eighth grid.
%   Kick: 1 and 4. The anchor. Doesn't move.
%   Snare: beat 4 (second dotted quarter). The lean.
%   Rim: position 2 and 5. Ghost. The whisper of the other voice.
% ═════════════════════════════════════════════════════════════════════════════

drumPatternA = \drummode {
  \time 6/8
  \tempo "Condensing" 4. = 96

  % Bars 1-2: kick alone — the pulse
  bd4. bd4. |
  bd4. bd4. |

  % Bars 3-4: hi-hat enters — subdivisions fill in
  << { hh8 hh8 hh8 hh8 hh8 hh8 } \\ { bd4. bd4. } >> |
  << { hh8 hh8 hh8 hh8 hh8 hh8 } \\ { bd4. bd4. } >> |

  % Bars 5-6: snare enters on beat 2 (fourth eighth note position)
  << { hh8 hh8 hh8 hh8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |
  << { hh8 hh8 hh8 hh8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |

  % Bars 7-8: full syncopated cell — hi-hat displaced off the beat
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |

  % Bars 9-16: the pattern — humanize this section
  % Rim on position 2 and 5 adds the ghost of the mouth music syllable
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r8 ss8 r8 sn8 r8 r8 } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r8 ss8 r8 sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4 bd8 bd4. } \\
     { r8 ss8 r8 sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r8 ss8 r8 sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r8 ss8 r8 sn4. } >> |
  << { r8 hh8 hh8 r8 hh8 hh8 } \\
     { bd4 bd8 bd4. } \\
     { r4. sn4. } >> |
  << { r8 hh8 ho8 r8 hh8 hh8 } \\
     { bd4. bd4. } \\
     { r4. sn4. } >> |
}

\score {
  \header { piece = "PROMPT A — The Drum Kit" }
  \new DrumStaff \with {
    \consists "Instrument_name_engraver"
    instrumentName = "Kit"
  } {
    \drumPatternA
  }
  \layout { }
  \midi { }
}


% ═════════════════════════════════════════════════════════════════════════════
% PROMPT B — PIANO AS THE VOID
% Left hand: F# drone. Pedal down. Does not move except when it must.
% Right hand: one note at a time. Narrow range. No chords yet.
% The G→F# pull is the only rule.
%
% Play slowly. You are not looking for anything. You are letting it arrive.
% The notes in the right hand are suggestions. Deviate. That is the prompt.
% What you find is the data.
%
% INSTRUCTION: After the written material, continue freely in F# Phrygian.
% Stay in the range F#4 to B4. Stay sparse. One note. Then silence.
% Then another note. The silence is not empty.
% ═════════════════════════════════════════════════════════════════════════════

pianoVoidRH = \relative c'' {
  \key d \major
  \time 6/8
  \tempo "Adrift" 4. = 60

  % Bars 1-4: right hand silent — left hand alone first
  R2. | R2. | R2. | R2. |

  % Bar 5: one note. Just F#. Listen to it.
  fis4.~ fis4 r8 |

  % Bar 6: G. The Phrygian semitone. One note.
  g4.~ g4 r8 |

  % Bar 7: G resolves to F#. The pull.
  g4 fis8~ fis4. |

  % Bar 8: silence
  R2. |

  % Bar 9: A. The third. Slightly surprising.
  a4.~ a4 r8 |

  % Bar 10: back to G. Hover.
  g4.~ g4 r8 |

  % Bars 11-12: the phrase — F# G A G F# in slow time
  fis8 g8 a8~ a4 g8~ |
  g4 fis8~ fis4. |

  % Bars 13-16: deviate here. Continue freely.
  % Written material is a scaffold only.
  fis4.~ fis4 r8 |
  g4.~ g4 r8 |
  g8~ g4~ g8 fis4~ |
  fis2. |
}

pianoVoidLH = \relative c, {
  \key d \major
  \time 6/8

  % Left hand: F# drone. Octaves. Pedal down from bar 1.
  % The instruction "Ped." means: down now and mostly stay down.
  fis2.~ \sustainOn |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  % Bar 9: move to low E once — the subtonic breath
  e2.~ |
  e2.~ |
  % Bar 11: return
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2.~ |
  fis2. \sustainOff |
}

\score {
  \header { piece = "PROMPT B — Piano as the Void" }
  \new PianoStaff <<
    \new Staff {
      \clef treble
      \pianoVoidRH
    }
    \new Staff {
      \clef bass
      \pianoVoidLH
    }
  >>
  \layout { }
  \midi { }
}


% ═════════════════════════════════════════════════════════════════════════════
% PROMPT C — PIANO AS THE FULL CONDENSATION
% All six voices on one instrument. One take.
%
% LEFT HAND:
%   Low register — Pohja drone (octave F#, held)
%   Mid-low register — condensation rhythm (staccato stabs, syncopated cell)
%
% RIGHT HAND:
%   Mid register — Lausuja melodic cell (bar 5)
%   Upper register — Kaiku echo (bar 7, same material, cross to upper octave)
%   Ilma — occasional sustained high note above everything
%
% This is the architecture played by one person.
% The Hurdy enters at bar 13 — marked. Leave space for it.
% What breaks under your hands is what needs redesigning.
% ═════════════════════════════════════════════════════════════════════════════

pianoCondRH = \relative c' {
  \key d \major
  \time 6/8
  \tempo "Condensing" 4. = 96

  % Bars 1-2: right hand silent — left establishes
  R2. | R2. |

  % Bars 3-4: condensation stabs in mid register (right hand, staccato)
  r8 fis8-. fis8-. r8 fis8-. fis8-. |
  fis8-. r8 fis8-. fis8-. r8 fis8-. |

  % Bar 5: Lausuja enters — melodic cell
  r8 fis8~ fis4 g8~ |
  g4 fis8~ fis4 e8~ |

  % Bar 7: Kaiku enters in upper octave — echo of Lausuja bar 5
  % Right hand splits: lower voice continues Lausuja, upper voice echoes
  << { r8 fis''8~ fis4 g''8~ } \\ { e'8 fis'4~ fis'4 g'8~ } >> |
  << { g''4 fis''8~ fis''4 e''8~ } \\ { g'4 fis'8~ fis'4 e'8~ } >> |

  % Bar 9: Ilma enters — high sustained note crowns the texture
  << { cis'''4.~ cis''' } \\ { e'8 fis'4~ fis'4 g'8~ } >> |
  << { cis'''4. d'''4.~ } \\ { g'4 fis'8~ fis'4. } >> |

  % Bars 11-12: full texture held
  << { d'''4. cis'''4.~ } \\ { r8 fis'8~ fis'4 a'8~ } >> |
  << { cis'''4.~ cis'''4. } \\ { a'4 g'8~ g'4 fis'8~ } >> |

  % Bar 13: HURDY ENTERS — right hand thins to make room
  \mark "HURDY ENTERS — make room"
  << { cis'''4.~ cis'''4. } \\ { fis'4.~ fis'4. } >> |
  << { cis'''4. b''4.~ } \\ { r4. r4. } >> |
  << { cis'''4.~ cis'''4. } \\ { r4. r4. } >> |
  << { cis'''4.~ cis'''4. } \\ { r4. r4. } >> |
}

pianoCondLH = \relative c, {
  \key d \major
  \time 6/8

  % Bars 1-2: Pohja only — low F# octave, held
  <fis fis,>2.~ |
  <fis fis,>2.~ |

  % Bars 3-4: condensation enters in left hand — syncopated stabs
  << { r8 fis8-. fis8-. r8 fis8-. fis8-. } \\ { <fis, fis,,>2.~ } >> |
  << { fis8-. r8 fis8-. fis8-. r8 fis8-. } \\ { <fis, fis,,>2.~ } >> |

  % Bars 5-12: left hand holds Pohja + occasional syncopated stab
  << { r8 fis8-. fis8-. r8 fis8-. fis8-. } \\ { <fis, fis,,>2.~ } >> |
  << { fis8-. r8 fis8-. r8 fis8-. r8 } \\ { <fis, fis,,>2.~ } >> |
  << { r8 fis8-. fis8-. r8 fis8-. fis8-. } \\ { <fis, fis,,>2.~ } >> |
  << { fis8-. r8 fis8-. fis8-. r8 fis8-. } \\ { <fis, fis,,>2.~ } >> |
  % Bar 9: move to E (subtonic)
  << { r8 e8-. e8-. r8 e8-. e8-. } \\ { <e, e,,>2.~ } >> |
  << { e8-. r8 e8-. r8 fis8-. r8 } \\ { <e, e,,>2.~ } >> |
  << { r8 fis8-. fis8-. r8 fis8-. fis8-. } \\ { <fis, fis,,>2.~ } >> |
  << { fis8-. r8 fis8-. fis8-. r8 fis8-. } \\ { <fis, fis,,>2.~ } >> |
  % Bars 13-16: Hurdy enters — left hand holds drone only
  <fis fis,>2.~ |
  <fis fis,>2.~ |
  <fis fis,>2.~ |
  <fis fis,>2. |
}

\score {
  \header { piece = "PROMPT C — Piano as the Full Condensation" }
  \new PianoStaff <<
    \new Staff {
      \clef treble
      \pianoCondRH
    }
    \new Staff {
      \clef bass
      \pianoCondLH
    }
  >>
  \layout { }
  \midi { }
}


% ═════════════════════════════════════════════════════════════════════════════
% PROMPT D — PIANO AS TOCH
% No pitches. Rhythm only. Flat of the hand. Muted strings or muted keys.
% Three voices entering in Geographical Fugue imitation.
%
% PLAYING INSTRUCTION:
%   Rest the flat of both hands lightly on the keys in their register.
%   Play the rhythms with finger pads, muted — percussive, not tonal.
%   The three voices are three registers: LOW / MID / HIGH
%   Alternatively: play on fallboard, music stand, or any resonant surface.
%   The pitches don't matter. The voices do.
%
% RHYTHMIC CELLS:
%   Voice 1 (LOW):   The Kalevala cell — ♪♩♪ | ♪♩♪
%                    "hil-JAI-suu | den-AA-va" — strong beat displaced
%
%   Voice 2 (MID):   Same cell, enters 2 bars later in imitation
%                    The echo. Runolaulu second singer.
%
%   Voice 3 (HIGH):  Enters 2 bars after Voice 2.
%                    Syncopated against both — positions 2,3,5 of the grid
%                    The displacement that makes the polyrhythm interesting.
%
% What you report: does the three-voice texture have internal logic when
% played by a body? Or does it collapse? What wants to shift?
% ═════════════════════════════════════════════════════════════════════════════

% Notated on single-pitch staves (c = the hand)

tochHigh = \relative c'' {
  \time 6/8
  \tempo "Percussive" 4. = 96

  % Bars 1-4: silent
  R2. | R2. | R2. | R2. |

  % Bar 5: Voice 2 enters (imitation of bar 3)
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |

  % Bar 7: Voice 3 enters — syncopated displacement
  r8 c8 r8 c8 c8 r8 |
  c8 r8 c8 r8 c8 c8 |

  % Bars 9-16: stretto — all three voices overlapping
  r8 c8 r8 c8 c8 r8 |
  c8 c8 r8 r8 c8 c8 |
  r8 c8 r8 c8 c8 r8 |
  c8 r8 c8 r8 c8 c8 |
  r8 c8 r8 c8 c8 r8 |
  c8 c8 r8 r8 c8 c8 |
  r8 c8 r8 c8 c8 r8 |
  c8 r8 c8 r8 c8 r8 |
}

tochMid = \relative c' {
  \time 6/8

  % Bars 1-2: silent
  R2. | R2. |

  % Bar 3: Voice 2 enters — same cell as Voice 1 bar 1, imitation
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |

  % Bar 5: Voice 2 continues
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |

  % Bars 7-16: continues, slightly varied
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8 c8 r8 c8 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8 c8~ c4 |
}

tochLow = \relative c {
  \time 6/8

  % Bar 1: Voice 1 — first entry
  % Cell: "hil-JAI-suu den-AA-va"
  % Rhythm: eighth-quarter-eighth | eighth-quarter-eighth
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |

  % Bars 3-16: continues, Voice 2 and 3 enter above
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8 c8 r8 c8 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
  r8 c8~ c4 c8~ |
  c4 c8 c8~ c4 |
  r8 c8~ c4 c8~ |
  c4 c8~ c4 r8 |
}

\score {
  \header { piece = "PROMPT D — Piano as Toch (rhythm only, no pitch)" }
  \new StaffGroup <<
    \new Staff \with {
      instrumentName = "HIGH"
      \remove "Clef_engraver"
      \remove "Key_engraver"
      \override StaffSymbol.line-count = #1
    } {
      \override Staff.TimeSignature.stencil = ##f
      \tochHigh
    }
    \new Staff \with {
      instrumentName = "MID"
      \remove "Clef_engraver"
      \remove "Key_engraver"
      \override StaffSymbol.line-count = #1
    } {
      \override Staff.TimeSignature.stencil = ##f
      \tochMid
    }
    \new Staff \with {
      instrumentName = "LOW"
      \remove "Clef_engraver"
      \remove "Key_engraver"
      \override StaffSymbol.line-count = #1
    } {
      \tochLow
    }
  >>
  \layout { }
  \midi { }
}
