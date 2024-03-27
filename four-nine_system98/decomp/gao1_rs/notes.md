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
