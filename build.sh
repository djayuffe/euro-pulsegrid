#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="src/euro_pulsegrid.asm"
BUILD_DIR="build"
PROJECT_NAME="euro-pulsegrid"

cd "$ROOT_DIR"
python3 tools/audit_release.py
mkdir -p "$BUILD_DIR"

OUTPUT_PREFIX="$BUILD_DIR/$PROJECT_NAME"
visual_prg="$OUTPUT_PREFIX.prg"
music_prg="$OUTPUT_PREFIX-music.prg"
song_bin="$OUTPUT_PREFIX-song.bin"

if command -v acme >/dev/null 2>&1; then
  acme -f cbm -o "$visual_prg" "$SOURCE_FILE"
  acme -DMUSIC_IRQ_BASIC=1 -f cbm -o "$music_prg" "$SOURCE_FILE"
  acme -DBUILD_SID=1 -f plain -o "$song_bin" "$SOURCE_FILE"
  test -s "$visual_prg"
  test -s "$music_prg"
  test -s "$song_bin"
  echo "OK: $visual_prg"
  echo "OK: $music_prg"
  echo "OK: $song_bin"
else
  echo "WARN: acme not found; static audit passed, binary build skipped."
fi
