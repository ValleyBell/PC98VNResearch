# various game hacks

In this folder I'm collecting small hacks I did for various games. (not everything is ADV/VN)

**Note:** In most cases, file names and strings are terminated using a `00` byte. Keep in mind to append a `00` byte especially after file names.

- Escalation '95 \~Onee-sama tte Yonde Ii Desu ka?\~
  - jump to ending
    - in `start.mdr` (decrypt by XORing with 0FFh)
      - search for `=esop.mdr` (should be at the end of the file)
      - overwrite it with `=end.mdr` + a 00 byte
      - then re-encrypt the file
    - select "start from beginning" in the main menu
    - You can also do the search/replace process in the PC-98 emulator's RAM directly while in the main menu. In this case, no decryption is necessary.
  - Note: The game seems a bit buggy and corrupts the main save file after the staff roll finishes the 2nd time, making the game crash while loading the main menu.
- Mesuneko Hishoshitsu
  - jump to ending
    - in `start.mdr` (decrypt by XORing with 0FFh)
      - search for `=neko000.mdr` (should be at the end of the file)
      - overwrite it with `=last.mdr` + a 00 byte
      - then re-encrypt the file
    - select "start from beginning" in the main menu
    - You can also do the search/replace process in the PC-98 emulator's RAM directly while in the main menu. In this case, no decryption is necessary.
- Street Mahjong 2
  - [StreetMahjong2_Patches.7z](StreetMahjong2_Patches.7z) contains a partial disassembly + various tiny patches for the main executable
    - `JANTAKU+BOB.EXE` - always trigger "Bob" easter egg cutscene before a match
      - patch: search for `80 3E 22 38 02 75 49`, replace with `80 3E 22 38 02 90 90` (disassembly location `seg002:04F7`, label `loc_1A787`)
      - usually, the cutscene is triggered with a 1/10 chance before playing against the 3rd opponent
    - `JANTAKU+GOVER.EXE` - go to Game Over cutscene instead of starting a match (I couldn't figure out how to lose a match.)
      - patch: search for `83 C4 12 83 7E 06 00`, replace with `83 C4 12 E9 C6 19 00` (disassembly location `seg002:05C0`, before `loc_1A853`)
    - `JANTAKU+ENDING.EXE` - go to Ending instead of starting a match
      - patch: search for `83 C4 12 83 7E 06 00`, replace with `83 C4 12 E9 46 1C 00` (disassembly location `seg002:05C0`, before `loc_1A853`)
- Urban Soldier
  - `.BIN` files are scene scripts and can be decompressed using [kenji_dec](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/kenji_dec.c)
  - jump to various scenes after selecting a player
    - While in the main menu, open the PC-98 emulator's RAM and search for the 2nd occurrence of `A:\US01.BIN`
    - There should be `A:\US13.MF2` a bit above. (**not** `A:\SAVE8.DAT`)
    - change the file and `US01.BIN` one of the following names to access various screens directly:
      - `INIT.BIN` - Initialization
      - `US00.BIN` - Title Screen
      - `US01.BIN` - Map Screen (after player selection)
      - `US01B.BIN` - Match (broken graphics, change needs to be done while at Player Selection screen or the game will crash due to overwriting parts of the script)
      - `US02.BIN`/`US03.BIN`/`US04.BIN` - ?? (loads parts of the match, unuseable without loading data first, eventually redirects to CG scenes, assuming you have won)
      - `US05.BIN` - Continue Screen
      - `US06.BIN` - Staff Roll
