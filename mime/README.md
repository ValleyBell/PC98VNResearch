# MIME / 舞夢

MIME is a dungeon crawler adventure by Studio Twin'kle.

## Folder contents

- `MIME.EXE` disassembly: [ASM file](MIME.asm) / [IDB database](MIME.idb) / [decompressed executable](MIME.EXE)
- `MIME_OP.EXE` disassembly: [ASM file](MIME_OP.asm) / [IDB database](MIME_OP.idb)
  - [MIME\_OP-SKIP.EXE](MIME_OP-SKIP.EXE) - a patch to the opening executable that makes it automatically skip the opening (for easier game testing)
- `STSSP.COM` disassembly: [ASM file](STSSP.asm) / [IDB database](STSSP.idb) ("Studio Twin'kle System Startup Program")
- [scenario format description](SceneFormat.txt)
- [scenario decompiler](ScenarioDecompile.py)
- [scenario compiler](ScenarioCompile.py)
- [scenario text dumping tool](ScenarioTsvDump.py) - takes multiple decompiled scenarios (`ASM` file), extracts all text and dumps it into a tab-separated (TSV) text table file  
  Scenario "talk" commands and selection menues have their text box size noted.
  "Print" commands have their screen target position noted where set.
- [scenario text reinsertion tool](ScenarioTsvReinsert.py) - takes a TSV text table file and reinserts the text into existing ASM files  
  For print and selection commands, the tool also writes the target position back.
- [text table line break tool](tsvLineBreak.py) - takes a TSV text table file and removes or reinserts line breaks for running text according to text box info  
  This is a special version for MIME text tables that takes the special indentation algorithm of the game into account.
- [text table merging tool](tsvMerge.py) - takes TSV files and transfers additional columns into the "base" TSV  
  (I needed this tool to transfer translated strings from older TSV dumps to newer ones based on modified ASM files.)
- [GTA image format documentation](GTAFormat.txt) and a tool to convert [between .GTA and .PI format](gta-tool.py)
- Python tool to convert the game's custom font data (extracted as `font.bin`) to an image: [font2img.py](font2img.py) (supports BMP/PNG/... through Pillow library)
- [item/monster list format description](MiscFormats.txt)
- [item/monster list name extraction/reinsertion tool](list-tsv.py)
  - The resulting file can be used with the [text table translation tool](../four-nine_system98/tsvTranslate.py) from the four-nine folder.
- a [patch to support ASCII text](MIME_OP-ASC.asm) in `MIME_OP.EXE`
  - It reads the text from `MIME_OP-Text.bin`. The "line end" marker consists of two forward slashes (bytes `2F 2F`).
  - A prepatched version is included as [MIME_OP-ASC.EXE](MIME_OP-ASC.EXE).
- a [patch to support ASCII text](MIME-ASC.asm) in `MIME.EXE` almost everywhere
  - The game originally comes with very limited ASCII support for drawing certain texts like "HP" and "MP" using special script commands.  
    This patch adds ASCII support to almost all functions that supported only 2-byte Shift-JIS codes before.
  - The patch is in ASM format and can be assembled+applied using [NASM](https://www.nasm.us/).
  - A prepatched version is included as [MIME-ASC.EXE](MIME-ASC.EXE).
  - I think this is the most complicated patch I made so far.
  - The patch also translates the "save game" screen into English. It is the only ingame text that is stored in the EXE file instead of the script files.
- a [patch to support ASCII text](STSSP-ASC.asm) in `STSSP-ASC.COM`
  - This also translates all messages to English. Thanks to saintttimmy for the translations.
- `_patch-build.bat` is a script that compiles the MIME patch using NASM and then uses the [NDC tool](https://euee.web.fc2.com/tool/nd.html#ndc) to insert it into an HDI image
- `data` folder: various script files that were patched with English texts
  - `.DEC` files are decompressed so that they can be hex-edited
  - `.DAT` files are compressed, for insertion into the game
  - `_insert.bat` - script to insert the `.DAT` files back into the HDI image of the game (requires NDC)
- tool to [dump the game's maps as images](map-dump.py) (supports BMP/PNG/... through Pillow library)
  - The tool features various options, like including the border, showing only uncovered areas or showing secret passages.
  - Example call: `python map-dump.py -m Z1000.DAT -t "STMED+overlay.png" -o map.png -b -e -s`
- general [game documentation](game-docs/README.md)
- [fixed files](fixed-files/README.md) (save games, graphics, game scripts)

## Notes

- Scenario files (with `.DAT` extension) are LZSS compressed.
  The nametable is initializated with various different patterns, as with many other Japanese games on the PC-98. (see `LZSS_Decompress` function in the disassembly)
- LZSS-compressed files can be decompressed using [lzss-tool](https://github.com/ValleyBell/ExtractorsDecoders/blob/master/lzss-tool.c) with parameters `-a c4,o4 -n p`
- Save games (`Z100#.DAT`) are uncompressed.
- Most strings in scenario files are terminated using the backslash/Yen character, byte 0x5C.  
  ASCII strings are terminated with a single `5C` byte.
  Shift-JIS strings end with `5C 5C`, because each character is assumed to be 2 bytes.
- The game's text rendering routine remaps certain codes to custom font glyphs.  
  Among those are the JIS mirrors of capital ASCII letters (Shift-JIS codes 85 61..85 7A), making actual ASCII the only way of using capital letters.  
  The table can be found under the label `CustomFontData` in the disassembly. The first word in each line indicates the access code of the font ROM that is redirected.  
  `210Dh` (16-bit word) → ROM access code `0D 21` → JIS `2D21` → Shift-JIS `8740`

## Game engine trivia

- Just the fact that MIME includes limited ASCII support is great, because the existing code handles the half-width ASCII characters nicely.
  This made it a lot easier to add global ASCII support.
- The few hardcoded texts that MIME has in the EXE file are printed in a very verbose way:
  They unrolled the loop of printing every character. (Just look at `Print_NoData` and `Print_Cancel` in the disassembly.)  
  Those two functions were very easy to size-optimize, giving me lots of free space for inserting my custom text handling code.

## Game bugs / unimplemented features

- The map data is broken in the v2 update of MIME, allowing the player to leave the map on 1F at 1,15 and on 3F at 14,15.
- There are minor graphical issues:
  - `STMED.GTA`: There is a missing white pixel on the uppermost line in some of the background map tiles.
  - The text box for full-screen text breaks the dithering pattern on the border of the right edge.  
    This is caused by the text box drawing code copying the box pattern to Y=323..339 instead of Y=328..344. (Y=328..344 is used on the left side.)
- Various healing spells don't work properly and don't work as specified in the manual.
  - battle mode:
    - Sanpa Shikou: heals only 1 party member instead of the whole party
  - camp mode:
    - Tear's healing spells: Tear always gets fully healed. Everyone else would heal by the specified amount of HP.
    - Insui Shourai: restores 100 HP instead of 50 HP
    - Shuuha Shijin: uses 100 MP instead of 10 MP, restores 500 HP instead of 100 HP
    - Sanpa Shikou: unuseable
    - In camp mode, all healing spells affect all party members due to the lack of the character selection.
- Side quests:
  - The side quest with the broken boy doll is broken in the original game. Taking the boy doll only advances the dialogue (`A607_.DAT`), but won't give you the "Broken Doll Boy" item that you need for completing the quest. (expected by `A405_.DAT`)
    - Maybe the developers were split over how to handle this: The characters discuss about the limited inventory space, but will take the doll in any case.
  - Apparently it was planned that you could save Amnell from the vines. Changing save game register 281 from 0 to 1 reveals the additional dialogue, but there is no event to set it.
    - It's really a shame that the sidequest is unfinished, as various locations have additional dialogues for it: Old Tree, Flower Field, Flower Queen, Tirolian's Den, Vine Cross, Three Dwarfs, Pierrot's Room
    - The "Vine Cross" screen (`A118_.DAT`) doesn't react properly to r281=1. It requires r104=75 to show a different text (at this point r104 is 76) and the image is wrong.
- Eagle's occupation can be changed from "squire" to "knight" by changing register 298 from 0 to 1 in a save game. However there is no ingame event that sets this value.
- The image files for the map graphics contain images for showing "far away treasure chest" (2 different distances) and "opened treasure chest". The images unfortunately went unused due to how map events work.  
  Technical background: Treasure chests are part of the game scripts instead of the map data. This makes it impossible to show them from afar. Showing them open should be possible, but is unimplemented.
- There are graphics files that show an unused slot machine for the casino. (`SU_A_.GTA` and `SU_B_.GTA`)
- When you enter floor 12F the first time, the story counter is supposed to be set to 120 and trigger a new set of dialogues for Noah's Bar and the Lady of the Black Snake.
  However the next time the story counter is when after talking to all 3 people to 12F and then it is set to 125, triggering a new set of dialogues.  
  Thus, a bunch of dialogues go unused by normal means. They can be viewed using Debug Mode by setting the Story Flags to 120.  
  Additional notes:
  - The condition for Suzu's dialogue for story counter 120 was not programmed in. This results in her telling you about Sakura's death despite her still being in the bar.
    The script contains a copy of Suzu's "story counter 70" dialogue for this situation, but it is unused.
  - Setting the story counter to 120 for all locations breaks the state of some of the sidequests that are available after the 7F boss. Maybe this is why they ended up not setting the counter upon reaching 12F.
- Talking to the 3 star people on 12F advances the story counter to 125, but this will reset the state of some of the sidequests, e.g. the one for healing White Lily.
