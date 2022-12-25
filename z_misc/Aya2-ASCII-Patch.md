# Hatchake Ayayo-san 2 - ASCII patch

## Notes

The game's drawing works in an interesting way:

- When ASCII characters are encountered, they are converted to Shift-JIS codes in the range of 8540h..859Fh.
  On the PC-98, these Shift-JIS codes contain mirrors of the half-width ASCII characters.
- The functions that read ASCII/Shift-JIS do the remapping above and then set register DX to 0 (half-width) or 1 (full-width).
- The main function reponsible for processing the text is at seg000:1286. (Offset 12C6 in the EXE file.)
- After the ASCII → JIS remapping, the contents of the DX register are discarded by the code that inserts automatic line breaks.
- "Printing text" works by writing 2-byte words (format as used by I/O registers A1h/A3h) to memory region A000h:0000h, as well as format codes (also 2-byte words) to A200h:0000h.
- For JIS codes (JIS rows 01+), it will write 2 words (left+right half of the character) and add 2 to the text cursor position. (→ full-width)
- For ASCII codes (JIS row 00), it will write 1 word add increment the text cursor position by 1. (→ half-width)
- However, at the point where the text buffer is written, the ASCII codes were already remapped, so half-width support effectively goes unused.

My first attempt at adding ASCII support was to remove the ASCII → JIS remapping. The bytes written to A000h:0000h looked correct, but no text would display.

Thus I had another attempt where I keep the remapping, but save the "full-width" flag. This ended up working well and the patch also is simpler.

*Note:* Addresses reference the program's "code" segment. This begins at offset 0x40 in the decompressed `AYA2.EXE` file. (The original EXE is compressed using EXEPACK.)

## Original code

```asm
;addr.  byte code   ASM code
12DC    75 1E       jnz     short print_shiftjis    ; multibyte-charcter - jump
12DE    3C 20       cmp     al, 20h
12E0    77 0F       ja      short loc_112F1 ; 21h..7Fh
12E2    74 05       jz      short loc_112E9 ; 20h (space) - jump
    [...]

loc_112E9:
12E9    B8 40 86    mov     ax, 8640h       ; 20h = space -> 8460h = Shift-JIS "non-breaking space"
12EC    33 D2       xor     dx, dx          ; DX = 0 -> half-width
12EE    EB 0C       jmp     short print_shiftjis
12F0    90          nop

loc_112F1:
12F1    05 1F 85    add     ax, 851Fh       ; 21h..5Fh ASCII -> 8540h..857Eh (mirror of ASCII characters)
12F4    3D 7F 85    cmp     ax, 857Fh
12F7    72 01       jb      short loc_112FA
12F9    40          inc     ax              ; 60h..7Fh ASCII -> 8580h..859Fh
12FA    33 D2       xor     dx, dx          ; DX = 0 -> half-width

print_shiftjis:
12FC    2D 40 81    sub     ax, 8140h       ; input: AX = Shift-JIS character
    [...]
137E    0A ED       or      ch, ch          ; test high byte of JIS code -> non-zero == JIS (full-width), zero == ASCII (half-width)
```

## Patch to support half-width ASCII characters

```asm
;addr.  byte code   ASM code
12DC    75 1D       jnz     short print_shiftjis    ; [patch] jump to "pushf"
12DE    3C 20       cmp     al, 20h
12E0    77 0E       ja      short loc_112F1         ; [patch] jump to moved function
    [...]
12EE    EB 0B       jmp     short print_shiftjis    ; [patch] jump to "pushf"

loc_112F1:
12F0    05 1F 85    add     ax, 851Fh       ; [patch] function moved 1 byte ahead
12F3    3D 7F 85    cmp     ax, 857Fh
12F6    72 01       jb      short loc_112FA
12F8    40          inc     ax
12F9    33 D2       xor     dx, dx          ; [patch] move end

print_shiftjis:
12FB    9C          pushf                   ; [patch] save flags (incl. "zero / non-zero" condition flag)
12FC    2D 40 81    sub     ax, 8140h       ; input: AX = Shift-JIS character
    [...]
137E    90          nop
137F    9D          popf                    ; [patch] restore flags, "non-zero" flag = full-width character
