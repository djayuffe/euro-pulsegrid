# Euro Pulsegrid

Euro Pulsegrid is a self-contained Commodore 64 PAL 50 Hz music visualizer written for the ACME 6510 assembler. An event-driven three-voice SID arrangement drives a table-based wireframe cube, reactive depth layers, and short attack-synchronised flashes. The current release preserves the intentionally black background, black border, and sealed right edge while tightening the highest-frequency visual paths.

![Euro Pulsegrid live VICE capture](assets/euro-pulsegrid-live.png)

## Live VICE frames

The following frames were captured from the current PRG running in VICE; they show the visualizer's quieter detail state and a higher-energy colour peak.

| Detail frame | Peak frame |
| --- | --- |
| ![Live VICE detail frame](assets/euro-pulsegrid-live-frame-01.png) | ![Live VICE peak frame](assets/euro-pulsegrid-live-frame-02.png) |

## Build

Requirements: `python3` and [ACME](https://sourceforge.net/projects/acme-crossass/).

```sh
./build.sh
```

The build first runs the release audit, then writes these generated artifacts under `build/`:

- `euro-pulsegrid.prg` — visualizer program
- `euro-pulsegrid-music.prg` — BASIC-startable music IRQ build
- `euro-pulsegrid-song.bin` — SID-player module build

`build/` is intentionally ignored by Git. Press Space in the visualizer to advance to the next song section. The music-only PRG and SID module reuse the same sequencer and SID routines without the visual IRQ work.

## Verification

Run `python3 tools/audit_release.py` for source-level checks, or `./build.sh` for the full static audit and all three ACME targets. The audit verifies labels and references, pointer and viewport guards, coordinate tables, raster IRQ wiring, clear coverage, black locks, and hot-path safety contracts.

Supporting release notes: [audit](docs/audit.md), [optimization notes](docs/optimization.md), and [release checklist](docs/release.md).
