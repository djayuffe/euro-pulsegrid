# Euro Pulsegrid v1.0

Euro Pulsegrid is a self-contained Commodore 64 PAL music visualizer for the ACME 6510 assembler. It plays an original eurodance-style arrangement on the SID while a raster IRQ drives a black-background, music-reactive wireframe display.

![Live VICE capture of Euro Pulsegrid v1.0](C64%20Structure/assets/euro-pulsegrid-live.png)

## Features

- PAL 50 Hz KERNAL-vector-safe raster IRQ with the main thread deliberately idle.
- Three-voice SID arrangement: bass, lead, drum/noise, PWM movement, filter motion, and short musical envelopes that also drive the visuals.
- 16-frame table-driven cube animation with tails, shadow, depth layers, colour cycles, pulse-scaled edges, and transient detail overlays.
- Music-aware visual triggers: kick, lead, pre-hit, and peak latches make flashes land with note attacks rather than trailing the SID envelope.
- Layered depth treatment: cast and volumetric shadows, grid and rear slices, fog, glints, chroma fringe, tunnel rings, body/camera anchors, and compact perceptual depth cues.
- A strict black visual language: no star drawing or border effects in the release path, a forced black background, and an explicit right-edge scrub.
- Space bar section skip for quickly auditioning the arrangement.

## Quick start

Requirements: `python3` and [ACME](https://sourceforge.net/projects/acme-crossass/).

```sh
./build.sh
```

The build runs the static release audit first and then produces these ignored files in `build/` when ACME is available:

- `euro-pulsegrid-v1.0.prg` — visualizer program with the raster IRQ.
- `euro-pulsegrid-v1.0-music.prg` — BASIC-startable music-only IRQ build.
- `euro-pulsegrid-v1.0-song.bin` — SID-player module build with `init` and `play` entry points.

Run the visualizer in a PAL C64 emulator such as VICE. Press Space to advance to the next musical section.

## C64 Structure

All C64-specific material lives under [`C64 Structure/`](C64%20Structure/):

```text
C64 Structure/
├── assets/                 Live VICE capture used by this README
├── docs/
│   ├── architecture.md      Memory, IRQ, audio, visual, and data-flow guide
│   ├── features.md          Feature-to-code reference
│   ├── audit.md             Static-audit scope and current result
│   ├── optimization.md      Hot-path and safety design notes
│   └── release.md           Reproducible release checklist
├── src/
│   └── euro_pulsegrid.asm   Complete ACME 6510 source
└── tools/
    └── audit_release.py     Source-level release verifier
```

The repository root is intentionally minimal: it holds the build entry point, release metadata, checksums, and Git configuration.

## Verify a checkout

```sh
python3 "C64 Structure/tools/audit_release.py"
./build.sh
shasum -a 256 -c SHA256SUMS.txt
```

Read the [architecture guide](C64%20Structure/docs/architecture.md) for a code tour, the [feature guide](C64%20Structure/docs/features.md) for behaviour, and the [release checklist](C64%20Structure/docs/release.md) before publishing a build.
