# various unsorted tools and documents

- [uk2DlbUnpack.py](uk2DlbUnpack.py) - `DLB` archive unpacker for the format used by the *AyPio UK2* engine [^1]
- [dshellDlbUnpack.py](dshellDlbUnpack.py) - `DLB` archive unpacker for the format used by the *Four･Nine D-SHELL* engine [^1]
- [lenam_packer.py](lenam_packer.py) - archive (un-)packer for "Lenam: Sword of Legend", published by Hertz [^1]
- [forest_packer.py](forest_packer.py) - archive (un-)packer for `.FA1` archives used by games published by Forest [^1]
- [mgr_packer.py](mgr_packer.py) - archive (un-)packer for `DISK#.NDX/LIB` archives used by the game "Merry Go Round", published by Mischief [^1]
- [mgr_ovl.txt](mgr_ovl.txt) - some documentation on OVL script files used by the game "Merry Go Round"  
  It was a byproduct of me trying to figure out where the one untitled song is used.
  (It is used in S05\_3, S09\_8 and S10\_4.)
- [twilight_packer.py](twilight_packer.py) - archive (un-)packer for archives used by the game "Twilight", published by Studio Twinkle [^1]
  - [twilight_decompress.py](twilight_decompress.py) - original Python port of the Twilight decompression code
- Twilight `TW.EXE` disassembly: [ASM file](TW.asm) / [IDB database](TW.idb)
- [visitte_packer.py](visitte_packer.py) - archive (un-)packer for `DISK#.LBX` archives used by the game "Visitte", published by Mischief [^1]
- [valkyrie_save-decoder.py](valkyrie_save-decoder.py) - de-/encryption tool for story save games (`DATA#.SAV`) of "Valkyrie: The Power Beauties", published by DISCOVERY
- Valkyrie `GSIC.EXE` disassembly: [ASM file](valkyrie_GSIC.asm) / [IDB database](valkyrie_GSIC.idb)
- [vg-txt-tool.py](vg-txt-tool.py) - tool for decoding/reencoding the `TXT` message files in "V.G.: Variable Geo"
  - The game uses the ASCII letter `n` to indicate line breaks, which the tool converts to `\n`.
  - ASCII letters can be converted to the JIS ASCII mirror page (default) or to full-width characters.
  - The `TXT` message format consists of a list of 2-byte pointers (each pointing to a message), followed by the actual message data.
    Messages are encoded in Shift-JIS and are terminated with a 00 byte.
- NEC PC-9801 JIS ↔ Unicode mapping: [NEC-C-6226-visual3.txt](NEC-C-6226-visual3.txt) (downloaded from [HarJIT's Website](https://harjit.moe/jismappings.html))
- Python tool to read the text file and create look-up tables: [NEC-C-6226-reader.py](NEC-C-6226-reader.py)
- Python tools dealing with the NEC PC-9801 font:
  - convert the NEC PC-9801 `FONT.ROM` to an image: [fontrom2img.py](fontrom2img.py)
  - use the PC-98 font to convert image to text: [font-transcribe.py](font-transcribe.py) (requires font image dumped with *fontrom2img*)
  - use the PC-98 font to convert text to image: [font-write.py](font-write.py) (requires font image dumped with *fontrom2img*)
  - All the tools use the [Pillow](https://python-pillow.org/) library and thus support various image formats like BMP/PNG/...

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

## Rekiai

I only wanted to be able to hack my way to the staff roll ...  
... and I eventually ended up reverse-engineering large parts of the script format, because this is one of the few games where file swapping doesn't work.

The fact that the developer Blucky decided to add a text encryption (using bit rotation) just made things more annoying.

So here is what I've got:

- `SCE.EXE` disassembly: [ASM file](rekiai_SCE.asm) / [IDB database](rekiai_SCE.idb) (The code looks like an unoptimized debug build, btw.)
- [MAINCON.SCE format documentation](rekiai_sce_format.txt)
- [rekiai_sce_decode.py](rekiai_sce_decode.py) - converts `MAINCON.SCE` into two text files, one with text strings and one with the script code (mostly a hex dump with labels, but with optional text strings as comments)
- [rekiai_dat_unpack.py](rekiai_dat_unpack.py) - archive unpacker for `REKIAI.DAT` ([format documentation](rekiai_dat.txt))
