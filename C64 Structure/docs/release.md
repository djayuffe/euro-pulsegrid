# v1.0 release checklist

## Release inputs

- `C64 Structure/src/euro_pulsegrid.asm` is the single source of truth.
- `build.sh` produces all three distribution variants from that source.
- `SHA256SUMS.txt` covers tracked release inputs, documentation, the audit tool, and the checked-in live capture. Generated binaries in `build/` are intentionally not committed.

## Gate

Run these commands from the repository root:

```sh
python3 "C64 Structure/tools/audit_release.py"
./build.sh
shasum -a 256 -c SHA256SUMS.txt
git diff --check
git status --short
```

Then perform a PAL VICE smoke test of the visualizer PRG. Confirm that the program starts, music continues, the border and background remain black, the rightmost five columns remain black, and Space advances the song section.

## Publish

Commit the verified source and documentation, tag the commit `v1.0`, push `main` and the tag, then create the GitHub release from that tag. Attach generated binaries only when distributing them intentionally; they are reproducible from the tagged source.
