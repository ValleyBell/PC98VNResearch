# various unsorted tools and documents

- [uk2DlbUnpack.py](uk2DlbUnpack.py) - `DLB` archive unpacker for the format used by the *AyPio UK2* engine
- [dshellDlbUnpack.py](dshellDlbUnpack.py) - `DLB` archive unpacker for the format used by the *Four･Nine D-SHELL* engine
- [rekiai_unpack.py](rekiai_unpack.py) - archive unpacker for `REKIAI.DAT` used by the game "Rekiai", published by Blucky ([format documentation](rekiai_dat.txt))
- NEC PC-9801 JIS ↔ Unicode mapping: [NEC-C-6226-visual3.txt](NEC-C-6226-visual3.txt) (downloaded from [HarJIT's Website](https://harjit.moe/jismappings.html))
- Python tool to read the text file and create look-up tables: [NEC-C-6226-reader.py](NEC-C-6226-reader.py)
- Python tool to convert the NEC PC-9801 `FONT.ROM` to an image: [fontrom2img.py](fontrom2img.py) (supports BMP/PNG/... through Pillow library)

## Hatchake Ayayo-san 2

I was helping *danham* from the PC-9800 Series Central Discord server by researching this game a bit.

- [Aya2MesTool.py](Aya2MesTool.py) - converts MES.DAT to/from text file
- [MES.DAT format documentation](Aya2MesFormat.txt)
- [AYA2-ASCII.EXE](AYA2-ASCII.EXE) - patched `AYA2.EXE` file that displays ASCII characters properly
- [notes and description for AYA2.EXE ASCII patch](Aya2-ASCII-Patch.md)
- `AYA2.EXE` disassembly: [ASM file](AYA2-DEC.asm) / [IDB database](AYA2-DEC.idb)
