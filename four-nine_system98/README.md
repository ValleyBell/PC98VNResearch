# Four･Nine System-98 ADV/Visual Novel engine

Research on the System-98 engine, using the version used by "Gao Gao! 4th: Canaan ~Yakusoku no Chi~".

## Folder contents

- [list of games using the engine](game-list.md)
- [an archive with all known game executables](executables.7z)
- [archive unpacking tool](Unpack.py) for `DISK_#.LIB/CAT` files
- decompression tool for the game's LZSS-packed data: [cleaned up version](Decompress.py), [original disassembly translation](Decompress.py.bak)
- [scenario descrambler](ScenarioDecode.py)
- [scenario decompiler](ScenarioDecompile.py)
- [image format documentation](ImageFormat.txt) and a tool to convert [images files to the .PI format](Graphics2Pi.py)
- [tool to De-/Interlace Canaan's intro images](PrologueImgInterlace.py)
- `SYS98.COM` disassembly ([IDB file](SYS98.idb), [ASM file](SYS98.asm))
- Python tool to convert a four･nine font file (`.FNT`) to an image: [font2img.py](font2img.py) (supports BMP/PNG/... through Pillow library)
- Gaogao 4 font:
  - an [image conversion of GAO4.FNT](GAO4_FNT.PNG)
  - a [JIS to Unicode mapping](Gao4-Font.txt), for use with the scenario decompiler

## Extras

- Windows `.bat` scripts to quickly decode data from the game "Canaan".
- a [patch to support ASCII text](Sys98_ANK-patch.asm) for `SYS98.EXE` v3.10
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [SYS98ANK.EXE](SYS98ANK.EXE).
- an English patch for Canaan's options menu (requires the ASCII patch above)
  - [WAKUWAKU-EN.SCN](ExampleFiles/WAKUWAKU-EN.SCN) (unscrambled / readable version)
  - [WAKUWAKU-EN.S](ExampleFiles/WAKUWAKU-EN.S) (scrambled), can be inserted into the game by storing it as `WAKUWAKU.S` into the game's main folder. (No repacking is required.)
- NEC PC-9801 JIS ↔ Unicode mapping:
  - [Python Pickle file](NEC-C-6226-lut.pkl), generated from HarJIT's `NEC-C-6226-visual3.txt` (see [z\_misc folder](z_misc/README.md))
  - Shift JIS/JIS ↔ Unicode [Python converter module](nec_jis_conv.py) (used by the scenario decompiler)

## Notes

- The engine's image format is the [Pi image format](https://mooncore.eu/bunny/txt/pi-pic.htm), but with stripped header.
- Scenario files use a simple `XOR 01h` scrambling algorithm that is applied to all "payload" bytes, which begin at offset 100h.
- A variant of LZSS is used to compress the data inside archives.
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

## Thanks

- Thanks a lot to the people at the PC-9800 Series Central Discord for helping me to figure out various things, especially text and image formats.
