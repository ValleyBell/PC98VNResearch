# Four･Nine System-98 ADV/Visual Novel engine

Research on the System-98 engine, using the version used by "Gao Gao! 4th: Canaan ~Yakusoku no Chi~".

There is also a bit of information on the "DIANA" engine used by Waku Waku Mahjong Panic! 1/2.

## Folder contents

- [list of games using the engine](game-list.md)
- [an archive with all known game executables](executables.7z)
- [archive unpacking tool](Unpack.py) for `DISK_#.LIB/CAT` files
- decompression tool for the game's LZSS-packed data: [cleaned up version](Decompress.py), [original disassembly translation](Decompress.py.bak)
- [scenario format description](SceneFormat.txt)
- [scenario descrambler](ScenarioDecode.py)
- [scenario decompiler](ScenarioDecompile.py)
- [scenario compiler](ScenarioCompile.py)
- [scenario include insertion tool](ScenarioIncludeInsert.py) - helper tool for factoring out common code between scenario files.  
  It takes two (decompiled) scenario files and tries to match find a match between the "include" and "source" file.
  When a match is found, the matching part is replaced with an "include" statement and labels are renamed according to the include file.
- [image format documentation](ImageFormat.txt) and a tool to convert [images files to the .PI format](Graphics2Pi.py)
- [tool to De-/Interlace Canaan's intro images](PrologueImgInterlace.py)
- `SYS98.COM` v3.10 disassembly ([IDB file](SYS98.idb), [ASM file](SYS98.asm))
- Python tool to convert a four･nine font file (`.FNT`) to an image: [font2img.py](font2img.py) (supports BMP/PNG/... through Pillow library)
- Gaogao 4 font:
  - an [image conversion of GAO4.FNT](GAO4_FNT.PNG)
  - a [JIS to Unicode mapping](Gao4-Font.txt), for use with the scenario decompiler

## Extras

- Windows `.bat` scripts to quickly decode data from the game "Canaan".
- a [patch to support ASCII text](Sys98_ANK-patch.asm) for `SYS98.EXE` v3.10
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [SYS98ANK.EXE](SYS98ANK.EXE).
- an English translation patch for parts of the game Canaan can be found in the [canaan-en folder](canaan-en)
  - `.ASM` files are decompiled game scripts.
  - `.S` files are compiled game scripts, ready to be inserted into the game.  
    You can just place them in the game's root directory and they will take priority over the files inside the `DISK_#.LIB` archives.
  - The English translations require the ASCII patch (SYS98ANK) linked above in order to be shown correctly.
- NEC PC-9801 JIS ↔ Unicode mapping:
  - [Python Pickle file](NEC-C-6226-lut.pkl), generated from HarJIT's `NEC-C-6226-visual3.txt` (see [z\_misc folder](z_misc/README.md))
  - Shift JIS/JIS ↔ Unicode [Python converter module](nec_jis_conv.py) (used by the scenario decompiler)

## Notes

- The engine's image format is the [Pi image format](https://mooncore.eu/bunny/txt/pi-pic.htm), but with stripped header.
- Scenario files use a simple `XOR 01h` scrambling algorithm that is applied to all "payload" bytes, which begin at offset 100h.
- LZSS is used to compress the data inside archives. The nametable is initialized with all `00` bytes.
- Archive files, when used, consist of a pair of `.CAT` and `.LIB` files.
  - `.CAT` (catalogue) contains the file list
  - `.LIB` (library) contains the actual file data
- The engine uses Shift-JIS for text encoding.
- Some games use half-width Katakana characters, which use non-standard JIS codes that most Shift-JIS parsers can not read.  
  see [this JIS table](https://harjit.moe/jistables2/jisplane1a.html), plane 01-10 (JIS 2a21..2a7e / Shift-JIS 859f..85fc), column "NEC 78JIS"  
  further information: [Specialised JIS related mappings by HarJIT](https://harjit.moe/jismappings.html)  
  Example: *WAKUWAKU\_Greeting* [Shift-JIS text file](ExampleFiles/WAKUWAKU_Greeting.txt), [PNG reference image for first 4 text boxes](ExampleFiles/WAKUWAKU_Greeting.png)
- Games may load custom fonts for stylised punctiation symbols and emojis.
  Those occupy JIS planes 01-86/01-87 (Shift-JIS eb9f..ec9e).
- The four･nine font file (`.FNT`) stores the 8x8 character parts of the 16x16 font in a *different* order compared to the PC-98 font ROM.
  - PC-98 font ROM 8x8 character order: upper left, lower left, upper right, lower right
  - four･nine font 8x8 character order: upper left, upper right, lower left, lower right

## DIANA engine

- The DIANA engine used by Waku Waku Mahjong Panic! 1 and 2 is probably based on System-98.  
  Its scenario format uses largely the same command IDs as System-98.  
  The formats are not compatible though: Byte-sized values are not padded to words anymore, some commands were moved (e.g. string-related commands), others were added.
- DIANA [scenario format description](Diana_SceneFormat.txt)
- Waku Waku Mahjong Panic! 1 [decompression tool](wmp1_decompress.py)
- Waku Waku Mahjong Panic! 2 [scenario descrambler](wmp2_dsd_decode.py)
- Waku Waku Mahjong Panic! 2 [archive (un-)packer](wmp2_packer.py)
- `DIANA.EXE` v1 disassembly ([IDB file](DIANA_v1.idb), [ASM file](DIANA_v1.asm))
- `DIANA.EXE` v2 disassembly ([IDB file](DIANA_v2.idb), [ASM file](DIANA_v2.asm))
- "Waku Waku Mahjong Panic!" games usually consist of multiple executables.
  - NAVAL: program loader (also seems to be in control of memory shared between the various sub-applications)
  - DIANA: adventure engine
  - SONNET: 2-player mahjong engine
  - PYTHON: 4-player mahjong engine
  - MAKEG: "external character file maker"
  - AE: "Auto Expander" (WMP 1 only), handles decompression of "eLZ0" files
- Most executables and data files in WMP 1 are compressed. For some reason, WMP 2 did away with any sort of compression in both, executables and data files.
  The only exception is MAKEG, which was uncompressed in WMP 1 but is LZ91-compressed in WMP 2.
- Although only Waku Waku Mahjong Panic! 2 uses encrypted scenario files, WMP 1 seems to support scenario encryption as well. (Maybe it is used on uncompressed files only?)
  Interestingly, WMP 1 does `INC [ofs+0] / DEC [ofs+1]` while WMP 2 does the reverse: `DEC [ofs+0] / INC [ofs+1]`

## Thanks

- Thanks a lot to the people at the PC-9800 Series Central Discord for helping me to figure out various things, especially text and image formats.
