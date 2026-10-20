# Nostalgia 1907

This folder contains various research information regarding the game "Nostalgia 1907" developed by Sur Dé Wave.

I did the research to help BNK to make an English translation of the game.

## Folder contents

- `NOSMAIN.EXE` disassembly: [original EXE](NOSMAIN.EXE) / [decompressed EXE](NOSMAIN.DEC.EXE) / [ASM file](NOSMAIN.asm) / [IDB database](NOSMAIN.idb)
- `OYA.EXE` (loader executable) disassembly: [original EXE](OYA.EXE) / [ASM file](OYA.asm) / [IDB database](OYA.idb)
  - This tool just executes `cut112x.pbd` (actually an EXE file), `musdrvt.com` and `nosmain.exe` in that order.
- [scenario format description](SD-Format.txt) for `PART*.SD` files
- [scenario decompiler](ScenarioDecompile.py)
- [scenario compiler](ScenarioCompile.py)
- a [patch to support ASCII text](NOSMAIN-ASC.asm) in `NOSMAIN.EXE`
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [NOSMAIN-ASC.EXE](NOSMAIN-ASC.EXE).

## Notes

- The game has 3 main formats:
  - `.SD` files: scenario scripts
  - `.PBD` files: graphics in "PBD v2.0" format
    - Note: Not all PBD files are graphics. The game hides a few other files using a fake PBD file extension.
  - `NOSMUS/*.COM` files: music
- special files:
  - `CUT.PBD` - save game data
  - `CUT112X.PBD` - some driver executable
  - `TEST.PBD` - unknown (alternate save game?)
  - `USER.PBD` - unknown (alternate save game?)
- graphics file layout:
  - 7 bytes: `PBDv2.0` signature
  - 1 bytes: number of frames *fn*
  - fn*8 bytes: frame TOC:
    - 2 bytes: file offset (absolute) where frame data begins
    - 1 byte: image ID
    - 1 byte: ?? (varies between PBD files, identical for all frames in the same PBD)
    - 2 byte: ?? (always 0000h)
    - 2 byte: ?? (always 00C8h)
- music file layout:
  - FM and SSG instruments is stored as binary data.
  - The actual sequence data is readable MML-style ASCII text.
  - Basic layout:
    - 2 bytes: pointer to sequence data
    - 2 bytes: ?? (always 0006h)
    - 2 bytes: length of FM instrument data *fl*
    - fl bytes: FM instrument data
    - ? bytes: SSG instrument data?
    - ? bytes: sequence data
- The system disk contains a leftover scenario script called `DEMO.SD`, which was probably intended as an advertisement demonstration.
  Unfortunately, the script stops after showing the "Sur Dé Wave" logo, because nearly all of the required graphics files are missing.
