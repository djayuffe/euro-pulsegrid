# Changelog

## v1.0 — First release

- Promoted Euro Pulsegrid to its first stable release.
- Moved all C64 implementation material into `C64 Structure/`, separating it cleanly from root release metadata.
- Documented the build variants, raster IRQ model, SID sequencer, visual pipeline, memory use, safety boundaries, and audit process.
- Preserved the established 35-column live viewport, black background, sealed right edge, and dedicated colour-RAM pointer hot paths.
- Renamed generated artifacts to the stable `euro-pulsegrid-v1.0-*` scheme.

## Pre-release development

The pre-1.0 work established the raster-safe visualizer, table-driven SID sequence, reactive depth stack, black-background style, and right-edge no-wrap contract that ship in v1.0.
