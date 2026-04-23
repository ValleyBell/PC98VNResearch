# PANDA HOUSE MAX Adventure Scenario Driver

## Folder contents

- [list of games using the engine](game-list.md)
- [an archive with all known game executables](executables.7z)
- [archive unpacking and repacking tool](pck_packer.py) for `.PCK` files
- a [PCK file format specification](PCK-Format.txt), also contains notes on the "MAXPACK" file header used by compressed files
- `EXDD.COM` disassembly ([IDB file](es95_98__EXDD.DEC.idb)), based on the version from Escalation'95)

## Night Slave

Night Slave is not an adventure game, but it uses many of the PANDA HOUSE formats.
I did a fair amount of research on it in order to help BabaJeanmel with a proper Japanese to English translation of the game.

- [MDR de-/encoding tool](ns-mdr-tool.py) (does *not* work with other games' MDR files)
- [MDR format description](NightSlave-MDR.txt)
- [CMF text dumping/insertion tool](ns-cmf-text-tool.py)
- partial [CMF format description](NightSlave-CMF.txt)
- `NSG.EXE` disassembly: [ASM file](NSG.DEC2.asm) / [IDB database](NSG.DEC2.idb) / [decrypted/decompressed executable](NSG.DEC2.EXE)
- a [patch to support ASCII text](NSG_ASC.asm) for `NSG.EXE`
  - Additional features:
    - proper handling of half-width Shift-JIS (85xx/86xx)
    - support for line breaks using byte `0Dh`
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [NSG\_ASC.EXE](NSG_ASC.EXE).
  - If you use this patch, you can (and should!) use the `-M` parameter when encoding CMF and MDR files.
    - `ns-cmf-text-tool.py -M e "input.txt" "input.cmf" "output.cmf"`
    - `ns-mdr-tool.py -M e "input.txt" "output.mdr"`
    - You can use `\r` in the text files for explicit line breaks.
- `ENDING.EXE` disassembly: [ASM file](NS_ENDING.asm) / [IDB database](NS_ENDING.idb)

## Heart Heat Girls

Fuzion from the "PC-9800 Series Central" Discord did some research on this game and wrote useful tools for it.

- [hhg-mdr.py](hhg-mdr.py) - a tool to decode/encode MDR script files used by "Heart Heat Girls" (probably works with other games that use the MAX engine as well)
  - Note: This needs `maxpack.py` in the same folder for de- and recompression.
- [maxpack.py](maxpack.py) - decompress and recompress the MAXPACK format

## Notes

These notes are about the PANDA HOUSE games in general and are not specific to any of the games listed above.

- Scenario files (`.MDR`) use a simple `XOR 0FFh` scrambling algorithm that is applied to all bytes. (Note: Night Slave MDR files are stored unencrypted.)  
  You can use [xordec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/xordec.c) to de-/reencrypt them: `xordec 0xFF "input.mdr" "output.bin"`
- When files begin with `"MAXPACK"+00h`, they are compressed. The compression can be used with all files, inside and outside of `PCK` archives.
  The compression is usual LZSS, but the nametable is initializated with various different patterns. (The initialization used is very common for Japanese developers.)
- The `EXDD` (Expanded Disk Driver) executable that is responsible for file loading.
  It handles MAXPACK decompression and `PCK` archives.
- Some of the `.COM` and `.EXE` files are encrypted. Those can be easily identified using the "PIYO" signature that the encryption tool adds.  
  These executables can be decrypted using [piyo\_dec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/piyo_dec.c).
