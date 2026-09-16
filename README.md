# Euro Pulsegrid V9.1

Euro Pulsegrid is a Commodore 64 PAL 50 Hz music visualizer written for the ACME 6510 assembler. V9.1 keeps the black background and right-edge safety locks while tightening the visual hot paths.

![Euro Pulsegrid V9.1 live VICE capture](assets/euro-pulsegrid-live.png)

## Build

Requirements: `python3` and [ACME](https://sourceforge.net/projects/acme-crossass/).

```sh
./build.sh
```

The build first runs the release audit, then writes these generated artifacts under `build/`:

- `euro-pulsegrid-v9.1.prg` — visualizer program
- `euro-pulsegrid-v9.1-music.prg` — BASIC-startable music IRQ build
- `euro-pulsegrid-v9.1-song.bin` — SID-player module build

`build/` is intentionally ignored by Git. Press Space in the visualizer to advance to the next song section.

## Verification

Run `python3 tools/audit_release.py` for source-level checks, or `./build.sh` for the full static audit and all three ACME targets.

Supporting release notes: [audit](docs/audit.md), [optimization notes](docs/optimization.md), and [release checklist](docs/release.md).
