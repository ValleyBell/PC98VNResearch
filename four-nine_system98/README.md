# Four･Nine System-98 ADV/Visual Novel engine

Research on the System-98 engine, using the version used by "Gao Gao! 4th: Canaan ~Yakusoku no Chi~".

## Folder contents

- [list of games using the engine](game-list.md)
- [an archive with all known game executables](executables.7z)
- [unpacking tool](Unpack.py) for `DISK_#.LIB/CAT` files
- decompression tool for the game's LZSS-packed data: [cleaned up version](Decompress.py), [original disassembly translation](Decompress.py.bak)
- [scenario descrambler](ScenarioDec.py)
- [image format documentation](ImageFormat.txt) and a tool to convert [images files to the .PI format](Graphics2Pi.py)
- [tool to De-/Interlace Canaan's intro images](PrologueImgInterleave.py)
- SYS98.COM disassembly ([IDB file](SYS98.idb), [ASM file](SYS98.asm))
- a few Windows `.bat` scripts to quickly decode data from the game "Canaan".

## Notes

- The engine's image format is the [Pi image format](https://mooncore.eu/bunny/txt/pi-pic.htm), but with stripped header.
- Scenario files use a simple `XOR 01h` scrambling algorithm that is applied to all "payload" bytes, which begin at offset 100h.
- A variant of LZSS is used to compress the data.
- Archive files, when used, consist of a pair of `.CAT` and `.LIB` files.
  - `.CAT` (catalogue) contains the file list
  - `.LIB` (library) contains the actual file data
