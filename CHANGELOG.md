# Changelog

## Current release — Cycle hotpath black lock

- Reduced the frame-clear work to the live 35-column viewport; the post-draw scrub owns columns 35–39.
- Added a dedicated `COLOR_PTR` zero-page pointer so plot paths no longer repurpose the screen pointer for colour RAM.
- Inlined the shared detail/overlay plot loop while retaining coordinate guards.
- Corrected release metadata, build artifact names, audit reporting, and Git hygiene.

## Earlier visual milestones

V9.0 added retinal contrast cues; V8.6 locked the border/background and removed star drawing; V5.8–V6.1 introduced the no-wrap viewport and edge scrub.
