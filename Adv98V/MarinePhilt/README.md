# Marine Philt

This folder contains some research information regarding the game "Marine Philt" developed by Fairytale.

I helped out with some coding for an English translation that balplato and HT used to work on in 2025.

## Folder contents

- `ROLL.TCM` disassembly: [IDB file](ROLL.idb), [ASM file](ROLL.asm)
- a [patch to support ASCII text](ROLL-ASC.TCM) in `ROLL.TCM`
  - The patch allows for ASCII text in `OPEN.DAT`. Unlike most of my other patches, it is a very simple patch that supports only 1-byte ASCII codes and no 2-byte Shift-JIS codes.

## Notes

- `OPEN.DAT` has a few requirements that must be fullfilled to make sure that the text scrolls out of the window properly at the end.
  - It must have at least 10 empty lines after the last line with actual text.
  - It must be terminated with a `1A` byte.
  - Failing to do so will cause the text to vanish mid-way.
  - The file must be at most 2832 bytes large. (The buffer is handled by the game scripts and those apparently set the limit.)
