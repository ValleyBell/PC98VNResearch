# various unsorted tools and documents

- [uk2DlbUnpack.py](uk2DlbUnpack.py) - `DLB` archive unpacker for the format used by the *AyPio UK2* engine [^1]
- [dshellDlbUnpack.py](dshellDlbUnpack.py) - `DLB` archive unpacker for the format used by the *Four･Nine D-SHELL* engine [^1]
- [rekiai_unpack.py](rekiai_unpack.py) - archive unpacker for `REKIAI.DAT` used by the game "Rekiai", published by Blucky ([format documentation](rekiai_dat.txt))
- [lenam_packer.py](lenam_packer.py) - archive unpacker and repacker for "Lenam: Sword of Legend", published by Hertz [^1]
- [forest_packer.py](forest_packer.py) - archive unpacker and repacker for `.FA1` archives used by games published by Forest [^1]
- [mgr_packer.py](mgr_packer.py) - archive unpacker for `DISK#.NDX/LIB` archives used by the game "Merry Go Round", published by Mischief [^1]
- [mgr_ovl.txt](mgr_ovl.txt) - some documentation on OVL script files used by the game "Merry Go Round"  
  It was a byproduct of me trying to figure out where the one untitled song is used.
  (It is used in S05\_3, S09\_8 and S10\_4.)
- [visitte_packer.py](visitte_packer.py) - archive unpacker for `DISK#.LBX` archives used by the game "Visitte", published by Mischief [^1]
- NEC PC-9801 JIS ↔ Unicode mapping: [NEC-C-6226-visual3.txt](NEC-C-6226-visual3.txt) (downloaded from [HarJIT's Website](https://harjit.moe/jismappings.html))
- Python tool to read the text file and create look-up tables: [NEC-C-6226-reader.py](NEC-C-6226-reader.py)
- Python tool to convert the NEC PC-9801 `FONT.ROM` to an image: [fontrom2img.py](fontrom2img.py) (supports BMP/PNG/... through Pillow library)

[^1]: format documentation is at the top of the source file

## Hatchake Ayayo-san 2/3

I was helping *danham* from the PC-9800 Series Central Discord server by researching these games a bit.

- [aya_mes_tool.py](aya_mes_tool.py) - converts `AYA2MES.DAT` and `AYA3MES.DAT` to/from a text file
- [MES.DAT format documentation](aya_mes_format.txt) (covers Ayayo 2 and 3)
- [AYA2-ASCII.EXE](AYA2-ASCII.EXE) - patched `AYA2.EXE` file that displays ASCII characters properly
- [notes and description for AYA2.EXE ASCII patch](Aya2-ASCII-Patch.md)
- `AYA2.EXE` disassembly: [ASM file](AYA2-DEC.asm) / [IDB database](AYA2-DEC.idb)
- `AYA3.EXE` disassembly: [ASM file](AYA3.asm) / [IDB database](AYA3.idb)
- [aya3_extract-font.py](aya3_extract-font.py) - extracts Text RAM and font data from `AYA3.EXE`  
  The dumped font.bin file can be used with the [Four･Nine/System-98 font2img tool](../four-nine_system98/font2img.py).
