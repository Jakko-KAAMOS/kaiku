#!/usr/bin/env bash
# collect_doru.sh -- one-time extraction of seasonal register files
# from the Doru Malaia library into a space-constrained archive.
#
# Run once on the machine that holds the Doru Malaia library. Do not run again.
# After this, all work reads from the archive. Source is not touched.
#
# Doru Malaia died February 10, 2006.
# What is on this drive may be one of the more complete surviving copies.
# It does not leave without a backup going somewhere safe first.
#
# Usage:
#   bash sounds/doru/collect_doru.sh [/path/to/Doru_Malia]
#
# Output:
#   ~/doru-kaamos-YYYYMMDD.tar   (~122MB, uncompressed)
#
# Five seasonal folders. 193 files. 122MB.
# Ten additional folders for Berlin punk kit. ~152MB additional.
# Total: fifteen folders, ~274MB of 4.4GB. Reduction: 16x.
# Everything else stays untouched.

set -euo pipefail

DORU_ROOT="${1:-/cygdrive/d/Doru_Malia}"
OUTFILE="$HOME/doru-collection-$(date +%Y%m%d).tar"

echo "-> source:  $DORU_ROOT"
echo "-> archive: $OUTFILE"
echo ""

# Verify source is present before touching anything
if [ ! -d "$DORU_ROOT" ]; then
  echo "ERROR: $DORU_ROOT not found. Is the drive mounted?" >&2
  exit 1
fi

# Spot-check a file from each selected folder
for CHECK in \
  "CLAVES/DM-CLV 01.wav" \
  "LOG DRUM/DM-LGD 01.wav" \
  "TRIANGLE/DM-TRI 01.wav" \
  "TINGSHA ( TINGSHAG )/DM-TING 01.wav" \
  "ANVIL/DM-ANV 01.wav" \
  "SURDO/DM-SUR 50.wav" \
  "DOUN DOUN/DM-DOU 01.wav" \
  "CAJON/DM-CAJ 01.wav" \
  "MANJEERA ( JHANJ )/DM-MAN 02.wav" \
  "SAGAT ( ZILL )/DM-SAG 30.wav" \
  "CHINESE CYMBALS/DM-CHI 01.wav" \
  "CONGA/DM-CON 010.wav" \
  "BONGOS/DM-BON 001.wav" \
  "COWBELL/DM-COW 01.wav" \
  "SLIT DRUM ( KRIN )/DM-SLI 10.wav"
do
  if [ ! -f "$DORU_ROOT/$CHECK" ]; then
    echo "ERROR: expected file not found: $DORU_ROOT/$CHECK" >&2
    exit 1
  fi
done

echo "-> source verified. all fifteen folders present."
echo "-> building archive (uncompressed -- WAVs do not compress meaningfully)..."
echo ""

# Build the tar from the Doru_Malia root so paths inside are relative:
#   Doru_Malia/CLAVES/DM-CLV 01.wav  etc.
#
# Uncompressed intentionally:
#   - 24-bit PCM does not compress well with gzip/xz
#   - speed matters more than marginal size reduction
#   - integrity is easier to verify on plain tar

cd "$(dirname "$DORU_ROOT")"

tar cf "$OUTFILE" \
  "Doru_Malia/CLAVES" \
  "Doru_Malia/LOG DRUM" \
  "Doru_Malia/TRIANGLE" \
  "Doru_Malia/TINGSHA ( TINGSHAG )" \
  "Doru_Malia/ANVIL" \
  "Doru_Malia/SURDO" \
  "Doru_Malia/DOUN DOUN" \
  "Doru_Malia/CAJON" \
  "Doru_Malia/MANJEERA ( JHANJ )" \
  "Doru_Malia/SAGAT ( ZILL )" \
  "Doru_Malia/CHINESE CYMBALS" \
  "Doru_Malia/CONGA" \
  "Doru_Malia/BONGOS" \
  "Doru_Malia/COWBELL" \
  "Doru_Malia/SLIT DRUM ( KRIN )"

# Report
SIZE=$(du -sh "$OUTFILE" | cut -f1)
COUNT=$(tar tf "$OUTFILE" | grep -c '\.wav$' || true)

echo ""
echo "-> done."
echo "   archive: $OUTFILE"
echo "   size:    $SIZE"
echo "   files:   $COUNT WAVs"
echo ""
echo "-> next: copy to a second location before doing anything else."
echo "   cp $OUTFILE /path/to/backup/"
echo ""
echo "   bitcrush.py --doru flag reads from extracted archive:"
echo "   tar xf $OUTFILE -C /your/working/dir"
echo "   python3 bitcrush.py --doru /your/working/dir/Doru_Malia"
echo ""
echo "-> fifteen folders included:"
echo "   seasonal (5): CLAVES, LOG DRUM, TRIANGLE, TINGSHA, ANVIL"
echo "   berlin punk (10): SURDO, DOUN DOUN, CAJON, MANJEERA, SAGAT,"
echo "                     CHINESE CYMBALS, CONGA, BONGOS, COWBELL, SLIT DRUM"
