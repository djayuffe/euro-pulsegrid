# Release lock

Release only when all of the following pass:

1. `python3 tools/audit_release.py` exits successfully.
2. `./build.sh` assembles the visualizer, BASIC music IRQ, and song-module targets.
3. A PAL C64/VICE smoke test runs the visualizer without a CPU jam and keeps the border, background, and sealed right edge black.
4. `shasum -a 256 -c SHA256SUMS.txt` verifies the tracked release inputs.

Generated binaries belong in `build/` and are not committed. The checked-in live visualizer capture is `assets/euro-pulsegrid-live.png`.
