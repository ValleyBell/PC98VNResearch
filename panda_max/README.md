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
- a [patch to support ASCII text](NSG_ASCII-patch.asm) for `NSG.EXE`
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [NSG\_ASC.EXE](NSG_ASC.EXE).
- `ENDING.EXE` disassembly: [ASM file](NS_ENDING.asm) / [IDB database](NS_ENDING.idb)

## Notes

- Scenario files (`.MDR`) use a simple `XOR 0FFh` scrambling algorithm that is applied to all bytes.  
  You can use [xordec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/xordec.c) to de-/reencrypt them: `xordec 0xFF "input.mdr" "output.bin"`
- When files begin with `"MAXPACK"+00h`, they are compressed. The compression can be used with all files, inside and outside of `PCK` archives.
  The compression is usual LZSS, but the nametable is initializated with various different patterns. (The initialization used is very common for Japanese developers.)
- The `EXDD` (Expanded Disk Driver) executable that is responsible for file loading.
  It handles decompression and `PCK` archives.
- Some of the `.COM` and `.EXE` files are encrypted. Those can be easily identified using the "PIYO" signature that the encryption tool adds.  
  These executables can be decrypted using [piyo\_dec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/piyo_dec.c).
