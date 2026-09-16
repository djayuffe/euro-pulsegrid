# V9.1 audit report

## Result

The current release audit passes. It found no duplicate labels, undefined references, invalid coordinate-table entries, checksum mismatches, shell-syntax errors, or whitespace errors.

## Code checks

`tools/audit_release.py` validates the complete assembly source and confirms:

- A PAL 50 Hz KERNAL-vector-safe raster IRQ and a `STEPFRAMES = 2` sequencer.
- The 665 screen and 665 colour absolute stores that clear the 19 × 35-cell FX band.
- Independent `VISUAL_PTR` and `COLOR_PTR` screen/colour paths in the hot plotters.
- Bounds checks for live plotters and detail tables, plus the post-draw right-edge scrub of columns 35–39.
- The forced black border/background lock, gated no-star release path, and intact music/visual feature markers.

## Build, files, and documentation

The audit also runs `python3 -m py_compile`, `bash -n build.sh`, all three ACME targets, `shasum -a 256 -c SHA256SUMS.txt`, and `git diff --check`. The README, changelog, build names, checksum manifest, source path, and release notes all agree on the v9.1 release identity and artifact names.

## Live emulator check

The built `euro-pulsegrid-v9.1.prg` was launched in VICE. The normal visualizer reached both a lower-intensity detail state and a high-energy colour peak without a CPU jam; captured frames are stored in `assets/` and displayed in the README. See `tools/audit_release.py` for the executable structural checks.
