# Patches for scenario scripts

This folder contains various patches for the scenario scripts.
These are based on MIME's v2 update and need to applied to decompiled scripts. (i.e. `.ASM` files)

Most of these were featured in the English translation of Mime. The patches have to be applied to the original Japanese script though.

## Bug fixes

- [fixes_event-trigger.diff](fixes_event-trigger.diff) - fix broken event trigger in the character building maze @2,6 (west-north path)
- [fixes_item-creation.diff](fixes_item-creation.diff) - item creation fixes/improvements at the Magic Tablet:
  - fixed: item 124 Crimson Sword (1x Shadow + 2x Fire + 2x Destruction + 1x Evil)
    - The monster group of "3x Alien Worker + 1x Alien Dweller" on B1F talks about this item, but the creation code is missing.
  - added: item 238 Iga Hood (1x Wind + 2x Protection + 3x Shadow)
- [fixes_sidequests.diff](fixes_sidequests.diff) - sidequest fixes
  - "broken boy doll" sidequest: fix missing trigger for quest completion in 4F
- [fixes_spells.diff](fixes_spells.diff) - various fixes to spells
  - fixes to healing spells so that their MP consumption and HP restoration matches the online manual:
    - Sanpa Shikou \[battle\] (single target -> whole party)
    - Insui Shourai \[camp mode\] (restore 50 HP instead of 100 HP)
    - Shuuha Shijin \[camp mode\] (use 10 MP instead of 100 MP)
    - Sanpa Shikou \[camp mode\] (allow to be used)
  - In camp mode, healing spells now restore the expected amount of HP to Tear instead of healing her completely.
- [fixes_story-12F.diff](fixes_story-12F.diff) - fixes related to story counter 120
  - trigger unused dialogues in Noah's Bar and the Divination Room when entering 12F the first time
  - fix Suzu's wrong dialogue for this point of the story

## Improvements / Translation patches

- [CG_MODE-mod.ASM](CG_MODE-mod.ASM) - an improved implementation of `CG_MODE.DAT`
  - The original script would just go to the next image on any pressed key.
  - The new script allows the user to go forward/backward or return to the main menu immediately.
  - New controls:
    - cursor right / return: next image
    - cursor left / space: previous image
    - ESC: exit to main menu
  - As a bonus, you don't need to press an additional key after selecting "CG Viewer".
- [improvement_eagle-knight.diff](improvement_eagle-knight.diff) - change Eagle's title from "Squire" to "Knight"
  - Apparently Eagle was supposed to be promoted from squire to knight at some point in the story. (by changing register 298 from 0 to 1)
    However with the current story it is not clear when this is supposed to happen.
  - This patch places the promotion at the point where Tear is cured.
- [improvement_7Fboss-textspeed.diff](improvement_7Fboss-textspeed.diff) - slow down the speed of the text in the cutscene before the 7F boss 
  - The original game shows each text line for only 2 seconds (58 frames), making it nearly impossible to read in time.
  - The patch increases the display of the lines to 2 to 5 seconds, depending on the amount of text.
  - In order to keep the screen transition into the battle synchronized with the music, the music gets restarted in the middle of the cutscene.
- [translate_battle.diff](translate_battle.diff) - translate hardcoded names for Tear, Henzou and Eldelyca in battle scripts to English
- [translate_namechange.diff](translate_namechange.diff) - properly support half-width characters during the name entry screen
  - **Note:** This script patch works only with the ASCII-patched MIME executable, as it relies on special modifications of some script commands added by the ASCII patch.
- [translate_staff.diff](translate_staff.diff) - add "Translation/Hacking" screen to the staff roll
