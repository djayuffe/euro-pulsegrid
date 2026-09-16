# v1.0 audit report

`tools/audit_release.py` validates the source without relying on generated binaries. The v1.0 audit passes and covers duplicate labels, unresolved references, coordinate-table ranges, IRQ wiring, viewport guards, clear-store coverage, right-edge sealing, and release markers.

The visual clear is checked as 665 absolute screen stores and 665 colour-RAM stores: 19 rows × 35 live columns. Columns 35–39 are intentionally excluded from normal drawing and are black-scrubbed after the frame.

The audit also verifies the dedicated `COLOR_PTR` path, the black background lock, and the KERNAL-safe IRQ exit. Run it from the repository root with:

```sh
python3 "C64 Structure/tools/audit_release.py"
```

It is a structural safety net, not an emulator replacement; the release checklist still requires a PAL VICE smoke test.
