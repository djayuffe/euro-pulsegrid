# C64 architecture and code tour

## Execution model

`src/euro_pulsegrid.asm` targets the MOS 6510 with ACME. The normal PRG starts at `$0801` through a BASIC `SYS 2064` stub, then enters `init`. The SID-module build instead starts at `$1000` and exports jump-table entries for `sid_init` and `play`.

`install_true_raster_vsync_irq` installs `irq` through the KERNAL vector at `$0314/$0315` and schedules it on PAL raster line `$f8`. The IRQ acknowledges VIC interrupt bit 0, runs `play`, runs `visual_update` for the normal visualizer build, throttles keyboard scanning, then jumps to the KERNAL restore/RTI tail at `$ea81`. The foreground code is an intentional infinite loop, so it cannot race the timing-sensitive work.

## Memory and state

| Area | Purpose |
| --- | --- |
| `$0400` | Screen RAM |
| `$d800` | Colour RAM |
| `$d400–$d418` | SID voices, filter, and volume |
| `$d011/$d012/$d019/$d01a` | VIC raster control and IRQ acknowledgement |
| `$dc00/$dc01` | CIA1 keyboard matrix for Space |
| `$02/$03` | `VISUAL_PTR`, the indirect screen pointer |
| `$04/$05` | `CUBE_PTR`, table/point-list pointer |
| `$3f/$40` | `COLOR_PTR`, the independent indirect colour pointer |
| `$06–$3e` | Zero-page music, visual, envelope, phase, and control state |

The source defines `SCREEN_TO_COLOR_HI_DELTA` so a row offset can address screen and colour RAM in parallel. `mul40_lo` and `mul40_hi` turn a text row into a 40-column byte offset for guarded plotters.

## Music path

`tune_init` clears and configures the SID, assigns the song-order pointer, and loads the first pattern. `play` executes on every raster IRQ; `STEPFRAMES = 2` advances the pattern sequencer every second frame while allowing synthesis envelopes and visual triggers to evolve at 50 Hz.

The sequence consists of order entries and pattern streams for bass, drum, and lead. `next_step` fetches the next event, `trig_bass`, `trig_lead`, and `trig_drum` program the SID voices, and short runtime envelopes keep both sound and image reactive. The program also maintains `visual_kick_sync`, `visual_lead_sync`, `visual_pre_sync`, and `visual_light_gate`: these are visual-only, short-lived indicators that align the image with note attacks instead of long audio decays.

## Visual path

`visual_update` is the frame coordinator. In outline it:

1. Derives animation and colour phases from music state.
2. Clears the live FX band with `visual_clear_fx_band`.
3. Draws tails, shadow, cube, and gated detail/depth layers.
4. Scrubs the non-live right edge with `visual_scrub_right_edge`.
5. Forces border and background black with `visual_black_background_lock`.

The cube and every decorative layer are point lists. A 16-entry frame-pointer table selects a list from `vis_frame`; each list contains `x, y` pairs and ends with `$ff`. `visual_detail_loop_start` walks a selected list and writes a character plus colour after validating its coordinate. This keeps animation data-driven and makes the static audit able to check every table point.

## Layers and ordering

The core cube is drawn over decay tails and a small shadow. Optional layers add projected shadow, occlusion, floor grid, rear slice, glints, fog, chromatic edge cues, tunnel rings, sparkles, motion anchors, camera anchors, and compact central perceptual cues. Most are activated only during kick, lead, build, chorus, or short pre-hit states. The final perceptual passes are deliberately constrained to the centre of the screen and use `vis_frame`, not the decorative colour clock, so they reinforce body movement rather than produce uncontrolled shimmer.

## Viewport safety contract

The C64 screen is 40 columns wide, but the visualizer's active band is deliberately 35 columns wide. Normal plotters reject `x >= 35`; detail plotters also reject `y >= 24`. After drawing, `visual_scrub_right_edge` owns columns 35–39 and restores both their screen and colour bytes to black. This prevents stale data and right-edge wraps from becoming visible.

No optimization may bypass those guards. The release audit checks the table data and the source-level guard/clear/scrub contracts; emulator testing validates the final on-screen result.
