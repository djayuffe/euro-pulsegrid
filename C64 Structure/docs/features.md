# Features and code map

## Sound

Euro Pulsegrid contains its own event-based SID player; it does not depend on an external music file. `sound_init`, `play`, `next_step`, and the `trig_*` routines configure three SID voices for bass, lead, and drum/noise duties. The music code includes pulse-width movement, filter motion, retriggering, side-chain-like gain shaping, and transient noise treatments. `order` and the pattern data near the end of the source define the arrangement.

Two special builds use the same code:

- `MUSIC_IRQ_BASIC=1` produces a BASIC-loadable music-only player with its own IRQ.
- `BUILD_SID=1` produces a plain SID-player module with `sid_init` and `play` entry points.

## Reactive image

The normal build runs `visual_update` from the raster IRQ. `visual_prefetch_next_hits` can arm a one-frame pre-hit signal, while the trigger and decay logic supplies kick, lead, bass, light, and glow state. `visual_pick_style` turns the current song flags and energy into characters, colours, scale, and layer gates.

`visual_draw_cube` paints the principal table-driven wireframe. `visual_draw_cube_tail` and `visual_draw_cube_shadow` add temporal and spatial weight. `visual_draw_cube_details` is the shared point-list engine used by depth, grid, fog, glint, motion, camera, and perceptual layers.

## Depth system

The visual design combines several cheap C64-friendly techniques rather than expensive line or pixel rendering:

- Shadow, projected floor grid, rear slice, occlusion dots, and fog establish near/far ordering.
- Glints, chroma fringe, tunnel rings, vertex sparkle, prism/crystal/apex flashes, and colour cycles provide energy cues.
- Depth-normal, inertia, centroid, eased-vector, coherent-body, and orbital anchors make the cube's 16-frame movement read as one object.
- Camera settle/resolve plus perceptual fusion, occlusion-pop, foveal-vergence, and retinal-contrast micro-pairs add compact central depth cues only on strong musical events.

The visualizer deliberately omits star rendering and border flashing in the release path. The hidden phase counters remain useful for colour cycles without compromising the black background.

## Interaction

`scan_space_skip` samples the CIA1 keyboard matrix every fourth IRQ. It latches Space presses so a held key is not repeated, then `skip_to_next_part` advances the order pointer to the next arranged section. This is an audition control; it does not change the normal playback timing.

## Safe modification guide

When changing a visual table, keep every `x` coordinate below 35 and every `y` coordinate below 24. When changing a plotter, preserve its guards and the separate `VISUAL_PTR`/`COLOR_PTR` writes. When changing audio timing, retain the KERNAL-vector IRQ exit and verify both the visualizer and the two alternate build variants.
