# List of compressions used by PC-98 games

| Game or engine | Developer | Compression | Notes |
|:----------|:----------|:----------|:----------|
| Dragon Half | Microcabin | LZSS | used inside some archive files<br/>nametable initalized with 00s, non-standard reference word nibble order<br/>`lzss-tool -n 0x00 -R 0x00` |
| Foresight Dolly | Right Stuff | LZSS | used by `.SLD` files and inside `.BND` archives<br/>nametable initalized with 00s<br/>`lzss-tool -a o4 -n 0x00` |
| Lenam: Sword of Legend | Hertz | LZSS | used by `.MSG`/`.MSK`/various files without extension<br/>nametable initalized with spaces (TODO: verify)<br/>`lzss-tool -a c4 -n 0x20` |
| MAX Adventure Scenario Driver | Melody | LZSS | also applies to Night Slave, used for files with "MAXPACK" header<br/>nametable initialized with patterns<br/>`lzss-tool -a "sMAXPACK,b00,o2,c4,o4" -n p` |
| Merry Go Round | Mischief | LZSS | used by `.OVL` files<br/>nametable initalized with 00s<br/>`lzss-tool -a o2 -n 0x00` |
| MIME | Studio Twin'kle | LZSS | used by most `.DAT` files<br/>nametable initialized with patterns<br/>`lzss-tool -a c4,o4 -n p` |
| Revery: Izanai no Masuishō | Right Stuff | custom | used by `.COD` files and inside `.BND` archives<br/>custom LZ-style compression that stores all control bytes in one data block and then data+reference words in a separate block |
| Shinmei KENJI engine | various | LZSS | used by `.##1`/`.##2` files, some `.##2` may or may not be archives, not all of them are compressed<br/>nametable initialized with patterns<br/>`lzss-tool -a c4,o4 -n p` |
| System-98 | Four･Nine | LZSS | used by `.CAT`/`.LIB` files, `.CAT` files with "Cat1" signature even compress the archive TOC<br/>non-standard nametable start offset (0x001), non-standard reference word nibble order, nametable initalized with 00s but stream don't use preinitialized data<br/>`lzss-tool -a o4 -n n -C 0 -R 0x03 -O 0x001 -E 1` |
| Twilight | Studio Twin'kle | custom | used inside `.DAT` files<br/>custom compression that uses various binary trees |
| various | Forest | LZSS | used inside `.FA1` archives<br/>non-standard LZSS with 16-bit control words |
| various | Wolf Team | LZSS | used on all platforms, file header values are Little/Big Endian depending on the platform<br/>nametable initialized with patterns<br/>`lzss-tool -a c4L,o4L -n p` or `lzss-tool -a c4B,o4B -n p` |
| Waku Waku Mahjong Panic! | Four･Nine | LZSS | used by various files, can be identified by "eLZ0" signature<br/>details see System-98<br/>`lzss-tool -a "seLZ0,o4" -n n -C 0 -R 0x03 -O 0x001 -E 1` |
| Xak III | Microcabin | LZSS | used by `.BPL`/`.CMP`/`.GSP`/`.RCP` files<br/>nametable initalized with 00s, non-standard reference word nibble order<br/>`lzss-tool -n 0x00 -R 0x00` |
