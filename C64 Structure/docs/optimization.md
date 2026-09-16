# v1.0 performance and safety notes

Euro Pulsegrid is designed around a 50 Hz raster budget. The mainline idles; timing-sensitive audio and drawing happen in the IRQ at `$f8`. Expensive visual work is table driven and gated by short music events.

- The FX clear writes only the 19 × 35 live-cell band with absolute stores. It avoids runtime pointer arithmetic in the highest-frequency clear path.
- `COLOR_PTR` is separate from `VISUAL_PTR`, so screen and colour writes do not mutate one another's high byte in plot hot paths.
- Common overlay plotting is inlined inside `visual_detail_loop_start`, removing a call/return pair for every overlay point while retaining coordinate guards.
- The body, camera, and perceptual overlay stacks each have broad activity gates. Quiet frames skip complete groups of decorative calls.
- A cached colour-phase index is shared by colour-cycle lookups, and the release path leaves border effects and star plotting disabled.

Performance changes must preserve the non-negotiable viewport contract: live drawing uses `x = 0..34`; detail points must also use `y = 0..23`; columns `35..39` are owned by `visual_scrub_right_edge`; blank screen and colour cells remain black.
