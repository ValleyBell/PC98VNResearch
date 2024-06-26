# Various notes

## Game bugs

- `SNR\RS1Q12.LSP`:
  - After selecting "Look", the "cancel" key will trigger the selected menu action instead of going back.
  - The source of the issue is in `loc_0232`, which lacks the evaluation of the pressed key.
- `SNR\RS3Q05.LSP`:
  - The code incorrectly jumps to offset 0x0B12 at a few spots, which is the file path "BGM\\RSM02.LSP".
  - This happens in `loc_028E`, `loc_04C0`, `loc_04D4` and `loc_04E8`. I assume that the correct destination offset of the jumps is 0x0146.
- `SNR\RS3Q30.LSP`:
  - In the park, the "Listen" dialogue is bugged and lacks a terminating 00 byte at the end of `str_171C`.
    This causes the following narrator dialog to be displayed in the character talk box as well.

## Translation notes

- Text boxes in H scenes work in a slightly special way that causes difficulties with the tool for inserting line breaks:  
  It prints the selected commands to the "talk" box first, e.g. `【Look】−【Around】`.
  Then it starts printing the actual text from the second line on.  
  This causes trouble with the line break insertion tool, because the first time only 3 lines can be printed before reaching the end of the box.
  But after clearing the box, 4 lines can be printed.
- The music room has the select line sizes hardcoded into the script file `WAKU^2`. They are part of the structure `sel_2329`.

## Save game notes

- variable 353 (offset 0x2C2): chapter ID
  - values: 1..9
- variable 354 (offset 0x2C4): scene ID
  - values 0..99: "normal" scenes (for scene files `RS?S##.LSP`, this is the `##`)
  - values 1000..1999: H scenes
    - The "100" and "10" digits specify the H scene.
    - The "1" digit specifies the sub-scene.
    - For scene files `RSHnnnFx.LSP`, the `nnn` are the 100 and 10 digits and the `x` is the 1 digit.
