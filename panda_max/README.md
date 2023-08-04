# PANDA HOUSE MAX Adventure Scenario Driver

## Folder contents

- [list of games using the engine](game-list.md)
- [an archive with all known game executables](executables.7z)
- [archive unpacking and repacking tool](pck_packer.py) for `.PCK` files
- a [PCK file format specification](PCK-Format.txt), also contains notes on the "MAXPACK" file header used by compressed files
- `EXDD.COM` disassembly ([IDB file](es95_98__EXDD.DEC.idb)), based on the version from Escalation'95)

## Notes

- Scenario files (`.MDR`) use a simple `XOR 0FFh` scrambling algorithm that is applied to all bytes.  
  You can use [xordec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/xordec.c) to de-/reencrypt them: `xordec 0xFF "input.mdr" "output.bin"`
- When files begin with `"MAXPACK"+00h`, they are compressed. The compression can be used with all files, inside and outside of `PCK` archives.
  The compression is usual LZSS, but the nametable is initializated with various different patterns. (The initialization used is very common for Japanese developers.)
- The `EXDD` (Expanded Disk Driver) executable that is responsible for file loading.
  It handles decompression and `PCK` archives.
