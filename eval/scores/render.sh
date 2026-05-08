#!/usr/bin/env bash
# render.sh — render e01–e17 LilyPond exercises to PDF + MIDI
# Run from anywhere; script locates itself.
# Usage: bash eval/scores/render.sh

set -euo pipefail

SCORES="$(cd "$(dirname "$0")" && pwd)"
EXERCISES="$(cd "$SCORES/../exercises" && pwd)"
SHEETS="$EXERCISES/sheets"
MIDI_DIR="$EXERCISES/midi"
OUTDIR="$SCORES/_render"

mkdir -p "$SHEETS" "$MIDI_DIR" "$OUTDIR"

# ── LilyPond invocation helper ────────────────────────────────────────────────
# cd to the output dir and pass a bare stem so LilyPond never sees a Windows
# drive-letter path (Guile splits on ':' and chdir-fails on 'C:').
# Cygwin translates the absolute POSIX input path for native PE32+ binaries.
lily_render() {
  local ly="$1" stem="$2"
  (cd "$OUTDIR" && lilypond --output="$stem" "$ly")
}

# ── MIDI target name(s) per stem ─────────────────────────────────────────────
declare -A MIDI_MAP=(
  [e01_solo_soprano]="E01-solo"
  [e02_solo_high_tenor]="E02-solo"
  [e03_solo_low_tenor]="E03-solo"
  [e04_solo_contrabass]="E04-solo"
  [e05_b2_all_registers]="E05-solo"
  [e06_piano_reference]="E06-solo"
  [e07_similar_motion]="E07-ensemble"
  [e08_contrary_motion]="E08-ensemble"
  [e09_parallel_thirds]="E09-ensemble"
  [e10_parallel_fourths]="E10-ensemble"
  [e11_parallel_fifths]="E11-ensemble"
  [e12_full_texture_sustained]="E12-ensemble"
  [e13_full_texture_mixed]="E13-solo E13-ensemble"
  [e14_staccato_dynamics]="E14-solo"
  [e15_crescendo_sustained]="E15-solo"
  [e16_lfo_cycle]="E16-solo"
  [e17_retrigger]="E17-solo"
)

declare -A PDF_MAP=(
  [e01_solo_soprano]="E01"
  [e02_solo_high_tenor]="E02"
  [e03_solo_low_tenor]="E03"
  [e04_solo_contrabass]="E04"
  [e05_b2_all_registers]="E05"
  [e06_piano_reference]="E06"
  [e07_similar_motion]="E07"
  [e08_contrary_motion]="E08"
  [e09_parallel_thirds]="E09"
  [e10_parallel_fourths]="E10"
  [e11_parallel_fifths]="E11"
  [e12_full_texture_sustained]="E12"
  [e13_full_texture_mixed]="E13"
  [e14_staccato_dynamics]="E14"
  [e15_crescendo_sustained]="E15"
  [e16_lfo_cycle]="E16"
  [e17_retrigger]="E17"
)

# ── render ────────────────────────────────────────────────────────────────────
PASS=0; FAIL=0

for ly in "$SCORES"/e*.ly; do
  stem="$(basename "$ly" .ly)"
  printf "  %-36s" "$stem"

  if lily_render "$ly" "$stem" > "$OUTDIR/$stem.log" 2>&1; then

    # PDF
    if [[ -f "$OUTDIR/$stem.pdf" ]]; then
      target="${PDF_MAP[$stem]:-$stem}"
      cp "$OUTDIR/$stem.pdf" "$SHEETS/$target.pdf"
      printf "PDF "
    fi

    # MIDI — may map to one or two names (E13 gets both -solo and -ensemble)
    # LilyPond outputs .midi not .mid
    if [[ -f "$OUTDIR/$stem.midi" ]]; then
      for target in ${MIDI_MAP[$stem]:-$stem}; do
        cp "$OUTDIR/$stem.midi" "$MIDI_DIR/$target.mid"
      done
      printf "MIDI"
    fi

    printf "  OK\n"
    (( PASS++ )) || true
  else
    printf "  FAILED\n"
    cat "$OUTDIR/$stem.log"
    (( FAIL++ )) || true
  fi
done

echo ""
echo "Done: $PASS passed, $FAIL failed."
echo "  PDFs  → $SHEETS"
echo "  MIDI  → $MIDI_DIR"

# clean up render scratch (leave logs on failure for diagnosis)
if [[ $FAIL -eq 0 ]]; then
  rm -rf "$OUTDIR"
fi
