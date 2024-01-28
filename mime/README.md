# MIME / 舞夢

MIME is a dungeon crawler adventure by Studio Twin'kle.

## Folder contents

- `MIME.EXE` disassembly: [ASM file](MIME.asm) / [IDB database](MIME.idb) / [decompressed executable](MIME.EXE)
- `MIME_OP.EXE` disassembly: [ASM file](MIME_OP.asm) / [IDB database](MIME_OP.idb)
- a [patch to support ASCII text](MIME-ASC.asm) in `MIME.EXE` almost everywhere
  - The game comes with very limited ASCII support for drawing certain texts like "HP" and "MP" using special script commands.  
    This patch adds ASCII support to almost all functions that originally supported only 2-byte Shift-JIS codes.
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [MIME-ASC.EXE](MIME-ASC.EXE).
  - I think this is the most complicated patch I made so far.
  - The patch also translates the "save game" screen into English. It is the only ingame text that is stored in the EXE file instead of the script files.
- `_patch-build.bat` is a script that compiles the MIME patch using NASM and then uses the [NDC tool](https://euee.web.fc2.com/tool/nd.html#ndc) to insert it into an HDI image
- `data` folder: various script files that were patched with English texts
  - `.DEC` files are decompressed so that they can be hex-edited
  - `.DAT` files are compressed, for insertion into the game
  - `_insert.bat` - script to insert the `.DAT` files back into the HDI image of the game (requires NDC)

## Notes

- Scenario files (with `.DAT` extension) are LZSS compressed.
  The nametable is initializated with various different patterns, as with many other Japanese games on the PC-98. (see `LZSS_Decompress` function in the disassembly)
- LZSS-compressed files can be decompressed using [wolfteam\_dec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/wolfteam_dec.c)
- Save games (`Z100#.DAT`) are uncompressed.
- Most strings in scenario files are terminated using the backslash/Yen character, byte 0x5C.  
  ASCII strings are terminated with a single `5C` byte.
  Shift-JIS strings end with `5C 5C`, because each character is assumed to be 2 bytes.
- The game's text rendering routine remaps certain codes to custom font glyphs.  
  Among those are the JIS mirrors of capital ASCII letters (Shift-JIS codes 85 61..85 7A), making actual ASCII the only way of using capital letters.  
  The table can be found under the label `CustomFontData` in the disassembly. The first word in each line indicates the access code of the font ROM that is redirected.

## Game engine trivia

- Just the fact that MIME includes limited ASCII support is great, because the existing code handles the half-width ASCII characters nicely.
  This made it a lot easier to add global ASCII support.
- The few hardcoded texts that MIME has in the EXE file are printed in a very verbose way:
  They unrolled the loop of printing every character. (Just look at `Print_NoData` and `Print_Cancel` in the disassembly.)  
  Those two functions were very easy to size-optimize, giving me lots of free space for inserting my custom text handling code.
