# Optimization audit

The current performance-sensitive changes are deliberately narrow and guarded:

- The FX clear covers rows 3–21 and columns 0–34 using absolute stores; columns 35–39 are sealed after drawing.
- `COLOR_PTR` keeps colour-RAM addressing independent of `VISUAL_PTR` in main, tail, shadow, scale, and detail plotters.
- The shared overlay plot loop is inlined to remove one `JSR`/`RTS` pair per overlay point.
- The release audit checks label resolution, table coordinates, viewport guards, clear-store counts, IRQ wiring, and legacy-regression markers.

No global unchecked plot path is enabled: coordinate checks remain part of the right-edge no-wrap contract.
