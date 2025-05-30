; Assembling using NASM:
;	nasm -f bin -o VG-ASC.EXE -l VG-ASC.LST "VG-ASC.asm"
;	This requires VG.EXE (125 760 bytes) to be in the same folder.

; ** Information about the new text format **
;
; Old text format:
;   - 00 - text end
;   - lower-case ASCII 'n' -> new line
;   - ASCII letters 20..7E -> draw using a 8x8 font
;   - anything else -> draw full-width 16x16 character
;
; New text format:
;   - 00 - text end
;   - 01 - enable 8x8 font for ASCII
;   - 02 - enable 8x16 font for ASCII (default)
;   - CLR_CHR - clear text box (set to 03 by default)
;   - 'n' or 0Ah - newline (can be configured for NL_CHR variable)
;   - ASCII letters 20..7E - draw using 8x8 or 8x16 font (see above, default is 8x16)
;   - 8540h..869Eh - draw as 8x16 (half-width) character
;   - anything else -> draw full-width 16x16 character

%define SKIP_UNDRESSING	0	; skip the "undressing" scenes ("non-18+" patch)
%define SKIP_FIGHT	0	; 0 = no patch, 1 = win, 2 = lose, 3 = cancel fight (goes to 2P character selection)
%define JUMP_TO_END	0	; jump to ending scene after the first battle


;NL_CHR EQU 'n'
NL_CHR EQU `\n`
CLR_CHR EQU 03h

	use16
	cpu	186
SEG000_BASE_OFS EQU 2000h
SEG001_BASE_OFS EQU 7250h	; We assume "seg001", whose code begins at offset 7250h in the EXE file.
SEG019_BASE_OFS EQU 1BD60h
SEG026_BASE_OFS EQU 1C9D0h
SEG026_SPACE    EQU 100h	; additional space inserted *before* seg026 (must be a multiple of 10h)
SEG026_NEW_OFS  EQU SEG026_BASE_OFS+SEG026_SPACE

	org	-SEG001_BASE_OFS

seg001 EQU 0525h
seg012 EQU 159Ah
seg017 EQU 1970h
seg018 EQU 197Fh
seg026 EQU 1A9Dh

RelocDummy EQU 547Ch	; unused offset (segment 0525h, offset 022Ch)

	incbin "VG.EXE", 0, 0002h-($-$$)
	dw	(end-$$) & 1FFh		; number of bytes in last page
	dw	((end-$$) + 1FFh) / 200h	; total number of pages (full + partial)
	incbin "VG.EXE", $, 000Eh-($-$$)
	dw	(end-$$-SEG000_BASE_OFS)/10h + 8Dh	; set initial Stack Segment (register SS)

; === relocation table patches ===
; include relocation table and patch a few of the EXE relocation entries

	incbin "VG.EXE", $, 001Eh-($-$$)
	; patch data segment offsets
%rep (004Eh-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep

	; patch relocation table in modified functions
	incbin "VG.EXE", $, 09BAh-($-$$)
	dw	RelocDummy, 000h	; originally: DoEnd1_Jun: seg001:SetTextPosition (0000h:38A4h)
	incbin "VG.EXE", $, 0FB6h-($-$$)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg018:j_DrawTextChar (0525h:0B06h)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg018:j_DrawTextChar (0525h:0ADEh)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg012:MaybeWaitKey (0525h:0A9Dh)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg012:MaybeWaitKey (0525h:0A78h)
	incbin "VG.EXE", $, 1006h-($-$$)
	dw	ltes_reloc6+3, seg001	; originally: LoadText_ES: seg018:j_DrawTextChar (0525h:0C70h)
	dw	ltes_reloc5+3, seg001	; originally: LoadText_ES: seg018:j_DrawTextChar (0525h:0C4Ah)
	dw	ltes_reloc4+3, seg001	; originally: LoadText_ES: seg018:j_DrawTextChar (0525h:0C25h)
	dw	ltes_reloc3+3, seg001	; originally: LoadText_ES: seg018:j_DrawTextChar (0525h:0BFDh)
	dw	ltes_reloc2+3, seg001	; originally: LoadText_ES: seg012:MaybeWaitKey (0525h:0BC6h)
	dw	ltes_reloc1+3, seg001	; originally: LoadText_ES: seg012:MaybeWaitKey (0525h:0BC1h)
	incbin "VG.EXE", $, 101Eh-($-$$)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg018:j_DrawTextChar (0525h:0B51h)
	dw	RelocDummy, 000h	; originally: LoadText_DS: seg018:j_DrawTextChar (0525h:0B2Bh)

	; patch more data segment offsets
	incbin "VG.EXE", $, 1172h-($-$$)
%rep (1302h-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep
	incbin "VG.EXE", $, 139Ah-($-$$)
%rep (1522h-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep
	incbin "VG.EXE", $, 159Ah-($-$$)
%rep (1722h-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep
	incbin "VG.EXE", $, 17AEh-($-$$)
%rep (193Eh-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep
	incbin "VG.EXE", $, 19DAh-($-$$)
%rep (1B6Ah-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep
	incbin "VG.EXE", $, 1C02h-($-$$)
%rep (1D8Ah-($-$$))/4
	incbin "VG.EXE", $, 02h
	dw	seg026+(SEG026_SPACE/10h)
%endrep


MaybeWaitKey EQU 0009h
j_DrawTextChar EQU 04F8h
ClearTextBox EQU 0A4Ch

textColor EQU 2020h
textPosX EQU 2022h
textPosY EQU 2024h
textBox_XEnd EQU 2026h
textBox_YEnd EQU 2028h
textBox_XStart EQU 202Ah
textBox_YStart EQU 202Ch

; --- patch all the text pointers ---
	incbin "VG.EXE", $, 08EAh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0316 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 08F9h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_031D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0908h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0325 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0917h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_032B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 093Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0334 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 09BDh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_033D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 09CAh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0347 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0F5Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0351 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0F81h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_035A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0FAFh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0363 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 14C9h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_036B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 14EEh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0375 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 151Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_037F - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 19D3h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0388 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1A68h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0390 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1A86h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0397 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1AABh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03A0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1AD6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03A9 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1AECh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03B4 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1B45h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03B7 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1B86h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03BE - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1F0Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03C4 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1F32h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03CA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 1F60h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03D0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2503h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03D5 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2512h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03DC - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2536h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03E2 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 25A1h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03EA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 25C6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03F3 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 29BFh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_03FC - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 29CEh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0403 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2A76h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_040A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2AA7h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_040D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2AECh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0410 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2B1Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0413 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2B53h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0416 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2CA0h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_041B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2D4Fh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0422 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2D6Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0459 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2D7Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0490 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2D9Ch - ($-$$-SEG000_BASE_OFS)
DoUndress_Yuka_ResumeMusic:	; seg000:2D9C
	incbin "VG.EXE", $, 2DCCh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_04CE - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2E7Bh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_04D5 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2E98h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0523 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2EA8h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0558 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2EF8h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0590 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2FA7h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0597 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2FC4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_05D6 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2FD4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_05FB - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 2FE4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0642 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3034h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_068D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 30E3h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0694 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3100h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_06C2 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3110h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0701 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3160h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0740 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 320Fh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0747 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 322Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0771 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 323Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_07AC - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 328Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_07DE - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 333Bh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_07E6 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3358h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_082E - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3368h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0879 - ($$+SEG026_NEW_OFS)

%if SKIP_UNDRESSING
	; skip undressing scene
	incbin "VG.EXE", $, 3424h - ($-$$-SEG000_BASE_OFS)
	push	word [2646h]	; push Player 1 score
	push	cs
	call	near UndressResumeMusic
	add	sp, byte 2
	jmp	short undress_skip
	
UndressResumeMusic:
	; NOTE: There is a part of code inside the "undressing scene" code that restarts the battle music.
	; I don't want to deal with the segment relocation stuff too much, so I will just recreate the
	; initial stack layout here and then jump into the part of the function that restarts the music.
	push	bp
	mov	bp, sp
	push	si
	jmp	near DoUndress_Yuka_ResumeMusic
	
	incbin "VG.EXE", $, 3486h - ($-$$-SEG000_BASE_OFS)
undress_skip:
%endif

	incbin "VG.EXE", $, 34A0h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_08C1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 34AFh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_08CA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 35C8h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_08D1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 35F6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0901 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3657h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_090D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3667h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0927 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3677h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0953 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 368Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_096B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 369Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0987 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 36ACh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_09BD - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 36E4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_09FF - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 37B0h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0A06 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 37DEh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0A4C - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3865h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0A58 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3875h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0A8E - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 388Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0AC8 - ($$+SEG026_NEW_OFS)
	
	; dummy out "call SetTextPosition(0, 1)"
	incbin "VG.EXE", $, 38A1h - ($-$$-SEG000_BASE_OFS)
	times 38A6h-($-$$-SEG000_BASE_OFS) db	90h
	
	incbin "VG.EXE", $, 38A9h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0B14 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 38B5h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0B5A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 38CAh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0B9A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 38F6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0BE6 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 39C2h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0BED - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 39F0h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0C39 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3A77h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0C45 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3A87h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0C83 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3A97h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0CB5 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3AACh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0CFB - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3AC1h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0D27 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3AD1h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0D53 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3AFCh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0D97 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3BC8h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0D9E - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3BF6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0DE4 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3C7Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0DF0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3C8Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0E24 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3C9Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0E68 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3CB2h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0EB0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3CC7h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0EDA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3CD7h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0F16 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3D18h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0F5E - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3D33h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0F65 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3E22h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0F6A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3E50h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0F98 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3EADh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0FA4 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3EBDh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_0FE0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3F29h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1026 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3F35h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1062 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3F4Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_108A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3F5Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_10A0 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3F6Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_10DE - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 3FA4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_10EA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4070h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_10F1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 409Eh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_112B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4130h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1139 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4140h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1155 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4150h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_118F - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4165h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_11B1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 417Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_11E9 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 418Fh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1207 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 41A4h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1251 - ($$+SEG026_NEW_OFS)

%if SKIP_FIGHT
	; skip actual fight
	incbin "VG.EXE", $, 4231h - ($-$$-SEG000_BASE_OFS)
	; Note: The call to sub_1230 (located at 422Eh) is required to set up the drawing window for the "battle won" scene.
	jmp	short loc_4236	; jmp + NOP, so I don't need to care about the relocation table
	times 4236h-($-$$-SEG000_BASE_OFS) db	00h
loc_4236:
	mov	ax, [2646h]
	mov	[bp-0Ch], ax	; required to make mid-battle cutscene work
	
%if SKIP_FIGHT == 1
	inc	word [2646h]	; increase Player 1 score
	jmp	near fight_RoundEnd
%elif SKIP_FIGHT == 2
	inc	word [2648h]	; increase Player 2 score
	jmp	near fight_RoundEnd
%else
	mov	word [bp-02h], 0	; some "break" condition
	jmp	near fight_End
%endif
	incbin "VG.EXE", $, 44C8h - ($-$$-SEG000_BASE_OFS)
fight_RoundEnd:
	incbin "VG.EXE", $, 450Dh - ($-$$-SEG000_BASE_OFS)
fight_End:
%endif

	incbin "VG.EXE", $, 4706h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_129B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 470Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12A2 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 477Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12A7 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 477Eh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12AE - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4784h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12B3 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4788h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12BA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 478Eh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12BF - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4792h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12C6 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4798h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12CB - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 479Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12D2 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4813h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12D7 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4817h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12D8 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 48B1h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12E5 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 48B5h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12E6 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4994h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12F3 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 49BEh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_12FB - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 49E9h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1306 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4A11h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1318 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4A3Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1323 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4A5Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1332 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4A84h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1339 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4AAFh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1342 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4AD7h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1354 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B02h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_135F - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B08h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1370 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B32h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_137A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B5Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_138A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B85h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13AA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4B8Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13C4 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4BB6h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13CD - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4BE1h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13DF - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C09h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13EA - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C10h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_13FC - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C3Ah - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1405 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C65h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_141B - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C8Dh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_142F - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4C94h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1444 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4CBEh - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_144D - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4CE9h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1469 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4D11h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_147F - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4D3Ch - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_1493 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4D67h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_14B1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 4D92h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_14BC - ($$+SEG026_NEW_OFS)

; old patch - skips all rounds, but causes issues with the "battle won" screens
;%if SKIP_FIGHT
;	; skip actual fight, and just set "fight won" return code
;	incbin "VG.EXE", $, 4F0Bh - ($-$$-SEG000_BASE_OFS)
;	mov	ax, SKIP_FIGHT-1
;	times 4F0Fh-($-$$-SEG000_BASE_OFS) db	90h
;%endif

%if JUMP_TO_END
	; modify "fight ID" check to jump to the ending after the first fight
	incbin "VG.EXE", $, 4F6Ch - ($-$$-SEG000_BASE_OFS)
	cmp	word [001Ah], byte 1
	times 4F71h-($-$$-SEG000_BASE_OFS) db	90h
%endif

	incbin "VG.EXE", $, 5162h - ($-$$-SEG000_BASE_OFS)
	mov	ax, str_14CF - ($$+SEG026_NEW_OFS)

; --- patch the text drawing routine ---
	incbin "VG.EXE", $, 0A8Ah - ($-$$-SEG001_BASE_OFS)
LoadText_DS:
	push	bp
	push	es		; save ES, just for safety
	mov	bp, sp
	
	mov	ax, ds
	sub	ax, SEG026_SPACE/10h	; decrease data segment so that we can use the extra inserted space
	push	ax	; replaces "push ds"
	
	mov	ax, word [bp+08h]
	add	ax, SEG026_SPACE	; modify pointer according to the moved segment register
	push	ax	; replaces "push word [bp+08h]"
	
	push	cs		; (value is unused, but also pushed by j_LoadText_ES)
	call	LoadText_ES
	mov	sp, bp
	pop	es
	pop	bp
	retf

lt_var_tpos_scrx EQU -05h
lt_var_tpos_scry EQU -03h

LoadText_ES:
	push	bp
	mov	bp, sp
	sub	sp, byte 5
	push	di
	push	si
	
	mov	byte [bp-01h], 01h	; enable ASCII -> JIS mirror conversion by default
	les	si, [bp+06h]
	jmp	near ltxt_chrcheck

ltxt_loop:				; CODE XREF: LoadText_ES+105j
ltes_reloc1:
	call	seg012:MaybeWaitKey
ltes_reloc2:
	call	seg012:MaybeWaitKey
	
	; --- new code: read 1-byte or 2-byte character code ---
ltxt_parse:
	mov	al, [es:si]	; read Shift-JIS 1st byte
	inc	si		; advance text pointer by 1
	cmp	al, 81h
	jb	short ltp_halfwidth	; 00..80 -> ASCII
	cmp	al, 0A0h
	jb	short ltp_fullwidth	; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short ltp_halfwidth	; A0..DF -> half-width Katakana
	cmp	al, 0FDh
	jb	short ltp_fullwidth	; E0xx .. FCxx -> Shift-JIS
ltp_halfwidth:
	xor	ah, ah
	cmp	al, 01h		; special code 01: disable ASCII -> JIS mirror conversion
	jz	short ltp_aconv_off
	cmp	al, 02h		; special code 02: enable ASCII -> JIS mirror conversion
	jz	short ltp_aconv_on
	
	test	byte [bp-01h], 01h
	jz	short ltp_fin	; conversion disabled - continue processing
	
	; convert ASCII to Shift-JIS mirror
	call	ASCII2ShiftJIS
	mov	di, ax
	jmp	short lttw_halfwidth

ltp_aconv_off:
	and	byte [bp-01h], ~01h
	jmp	near ltxt_chrcheck

ltp_aconv_on:
	or	byte [bp-01h], 01h
	jmp	near ltxt_chrcheck

j_ltxt_space:
	jmp	near ltxt_space

ltp_fullwidth:
	mov	ah, al
	mov	al, [es:si]	; read Shift-JIS 2nd byte
	inc	si		; advance text pointer by 1
	;jmp	short ltp_fin
ltp_fin:
	mov	di, ax
	
	; --- new code: set X position increment
ltxt_textwidth:
	mov	cx, 2		; default to full-width
	or	ah, ah
	jz	short lttw_halfwidth	; 1-byte character -> half-width
	cmp	ax, 8540h
	jb	short lttw_fullwidth	; 8140..84FC = full-width
	cmp	ax, 869Fh
	jb	short lttw_halfwidth	; 8540..869E = half-width
	;jae	short lttw_fullwidth	; 869F..9FFC -> full-width
lttw_halfwidth:
	mov	cx, 1		; set to half-width (1 byte on screen)
lttw_fullwidth:
	mov	[cs:ltxt_movex], cl
	
	; For spaces, we will just skip the text box size checks - and we can skip drawing, too.
	cmp	ax, 0020h
	jz	short j_ltxt_space	; ASCII space
	cmp	ax, 8140h
	jz	short j_ltxt_space	; full-width space
	cmp	ax, 8640h
	jz	short j_ltxt_space	; half-width space
	
	; do line wrapping checks
	; Note: The original code does this after drawing. I moved it here so that
	;       newline handling works better.
	mov	ax, [textBox_XEnd]
	sub	ax, [textBox_XStart]	; AX = text box width
	sub	ax, cx		; subtract text character width
	inc	ax		; We want to wrap when exceeding the text box, so add +1.
	cmp	ax, [textPosX]
	jg	short ltxt_noxwrap	; Note: The original code checks "jge" (break on <), but "jg" (break on <=) looks nicer.
	
	; X coordinate exceeds text box - start new line
	mov	word [textPosX], 0
	inc	word [textPosY]
ltxt_noxwrap:
	
	mov	ax, [textBox_YEnd]
	sub	ax, [textBox_YStart]
	cmp	ax, [textPosY]
	jge	short ltxt_noywrap
	
	; Y coordinate exceeds text box - clear text box
	push	cs
	call	near ClearTextBox
ltxt_noywrap:
	
	; text position -> screen position
	mov	ax, [textBox_XStart]
	add	ax, [textPosX]
	mov	cl, 3
	shl	ax, cl
	mov	[bp+lt_var_tpos_scrx], ax
	
	mov	ax, [textBox_YStart]
	add	ax, [textPosY]
	mov	cl, 4
	shl	ax, cl
	mov	[bp+lt_var_tpos_scry], ax
	
	push	di
	sub	ax, ax
	push	ax
	mov	ax, [bp+lt_var_tpos_scry]
	inc	ax
	push	ax
	mov	ax, [bp+lt_var_tpos_scrx]
	inc	ax
	push	ax
ltes_reloc3:
	call	seg018:j_DrawTextChar	; Note: Trashes AX/BX/CX/DX
	add	sp, byte 8
	
	push	di
	sub	ax, ax
	push	ax
	mov	ax, [bp+lt_var_tpos_scry]
	inc	ax
	push	ax
	mov	ax, [bp+lt_var_tpos_scrx]
	add	ax, word 2
	push	ax
ltes_reloc4:
	call	seg018:j_DrawTextChar
	add	sp, byte 8
	
	push	di
	dw	36FFh, textColor	; push textColor
	push	word [bp+lt_var_tpos_scry]
	push	word [bp+lt_var_tpos_scrx]
ltes_reloc5:
	call	seg018:j_DrawTextChar
	add	sp, byte 8
	
	push	di
	dw	36FFh, textColor	; push textColor
	push	word [bp+lt_var_tpos_scry]
	mov	ax, [bp+lt_var_tpos_scrx]
	inc	ax
	push	ax
ltes_reloc6:
	call	seg018:j_DrawTextChar
	add	sp, byte 8
	
ltxt_space:
ltxt_movex EQU $+4	; hooray for self-modifying code
	add	word [textPosX], byte 2
	
ltxt_chrcheck:
	cmp	byte [es:si], 0
	jz	short loc_15F12	; text end
	cmp	byte [es:si], NL_CHR
	jz	short loc_15F06	; handle newline
	cmp	byte [es:si], CLR_CHR
	jz	short ltxt_tbclr	; clear textbox
	jmp	near ltxt_loop

loc_15F06:				; CODE XREF: LoadText_ES+103j
	inc	si		; advance text pointer by 1
	mov	word [textPosX], 0
	inc	word [textPosY]
	jmp	short ltxt_chrcheck

ltxt_tbclr:
	inc	si		; advance text pointer by 1
	push	cs
	call	near ClearTextBox
	jmp	short ltxt_chrcheck

loc_15F12:				; CODE XREF: LoadText_ES+FDj
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf

ASCII2ShiftJIS:
	cmp	al, 20h
	jb	short a2sj_ret		; 00..1F - just keep ASCII code
	jz	short a2sj_space	; 20 - space, convert to 8640
	cmp	al, 80h
	jae	short as2j_kana		; A1..FE - half-width Katakana, convert to 859F..85FC
	; fall through
as2j_latin:				; 21..7E - Latin letter, convert to 8541..859E
	cmp	al, 7Fh-1Fh		; set carry so that we can skip 857F below
	cmc				; "carry = al<7Fh" -> "carry = al>=7Fh"
	adc	ax, 851Fh		; 21..5F -> 8540..857E, 60..7E -> 8580..859E
a2sj_ret:
	ret

a2sj_space:
	mov	ax, 8640h
	ret
as2j_kana:
	add	ax, 84FEh
	ret

	times 0CCEh-($-$$-SEG001_BASE_OFS) db	90h

	incbin "VG.EXE", $, 0CFEh - ($-$$-SEG001_BASE_OFS)
	call	near LoadText_ES

; --- patch a few remainign the text pointers ---
	incbin "VG.EXE", $, 0238h - ($-$$-SEG019_BASE_OFS)
	mov	di, str_1F55+1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 023Fh - ($-$$-SEG019_BASE_OFS)
	mov	di, str_1F58+1 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0247h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1EFC - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 025Bh - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F55 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 026Fh - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F15 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0285h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F2A - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 0299h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F55 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 02ADh - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F33 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 02C1h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F58 - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 02D5h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F3E - ($$+SEG026_NEW_OFS)
	incbin "VG.EXE", $, 02E9h - ($-$$-SEG019_BASE_OFS)
	mov	ax, str_1F5B - ($$+SEG026_NEW_OFS)

	incbin "VG.EXE", $, 1C852h - ($-$$)
	mov	ax, seg026+(SEG026_SPACE/10h)

	incbin "VG.EXE", $, 000Ch - ($-$$-SEG026_BASE_OFS)
; --- text patches ---
	; Here we insert new space *before* the actual data segment.
	; The "Text" function was patched so that it can properly address this space.
str_1339:	; "ＶＧ選手"
	db	01h, "Character ", 02h, " A: "
	db	82h, 75h, 82h, 66h, 91h, 49h, 8Eh, 0E8h, 00h
str_137A:	; "ＶＧせんしゅのn"
	db	01h, "Character ", 02h, " B: "
	db	82h, 75h, 82h, 66h, 82h, 0B9h, 82h, 0F1h, 82h, 0B5h, 82h, 0E3h, 82h, 0CCh, NL_CHR, 00h
str_13CD:	; "『増田　千穂』、n"
;	db	01h, "Character ", 02h, " C: "
;	db	81h, 77h, 91h, 9Dh, 93h, 63h, 81h, 40h, 90h, 0E7h, 95h, 0E4h, 81h, 78h, 81h, 41h, NL_CHR, 00h
	;db	"This is a test text.nWith NewliNes.nANd more.", 0
	db	85h, 73h, 85h, 88h, 85h, 89h, 85h, 93h, 86h, 40h	; "This "
	db	"is a test text.", NL_CHR
	db	"With Newlines.", NL_CHR
	db	01h, "ANd a tiny FONT - 1234 ABCD abcd XYZ xyz.", NL_CHR, 0

%assign data_space SEG026_NEW_OFS+000Ch-($-$$)
%warning Extra text segment: data_space bytes remaining
	times 000Ch-($-$$-SEG026_NEW_OFS) db	0AAh

; --- include actual data segment ---
	incbin "VG.EXE", $-SEG026_SPACE, 0316h - ($-$$-SEG026_NEW_OFS)
str_0316:
	db	"b:vg02", 00h
str_031D:
	db	"b:vgefe", 00h
str_0325:
	db	"a:sel", 00h
str_032B:
	db	"a:selchr", 00h
str_0334:
	db	"a:selchr", 00h
str_033D:
	db	"a:selkao4", 00h
str_0347:
	db	"a:selkao6", 00h
str_0351:
	db	"a:titlec", 00h
str_035A:
	db	"a:titlec", 00h
str_0363:
	db	"a:title", 00h
str_036B:
	db	"a:configc", 00h
str_0375:
	db	"a:configc", 00h
str_037F:
	db	"a:config", 00h
str_0388:
	db	"b:vgorg", 00h
str_0390:
	db	"b:vg13", 00h
str_0397:
	db	"a:contic", 00h
str_03A0:
	db	"a:contic", 00h
str_03A9:
	db	"a:continue", 00h
str_03B4:
	db	"k2", 00h
str_03B7:
	db	"k1.gem", 00h
str_03BE:
	db	"a:cnt", 00h
str_03C4:
	db	"a:vsc", 00h
str_03CA:
	db	"a:vsc", 00h
str_03D0:
	db	"a:vs", 00h
str_03D5:
	db	"a:vg14", 00h
str_03DC:
	db	"a:sys", 00h
str_03E2:
	db	"a:vgefe", 00h
str_03EA:
	db	"a:syschr", 00h
str_03F3:
	db	"a:syschr", 00h
str_03FC:
	db	"a:vg14", 00h
str_0403:
	db	"a:vg12", 00h
str_040A:
	db	"k1", 00h
str_040D:
	db	"k2", 00h
str_0410:
	db	"k1", 00h
str_0413:
	db	"k2", 00h
str_0416:
	db	".txt", 00h
str_041B:
	db	"b:vg10", 00h
str_0422:	; "「か…覚悟は決めてたけど…やっぱり…恥ずかしいよぉ」nn"
	db	81h, 75h, 82h, 0A9h, 81h, 63h, 8Ah, 6Fh, 8Ch, 0E5h, 82h, 0CDh, 8Ch, 88h, 82h, 0DFh, 82h, 0C4h, 82h, 0BDh, 82h, 0AFh, 82h, 0C7h, 81h, 63h, 82h, 0E2h, 82h, 0C1h, 82h, 0CFh, 82h, 0E8h, 81h, 63h, 92h, 70h, 82h, 0B8h, 82h, 0A9h, 82h, 0B5h, 82h, 0A2h, 82h, 0E6h, 82h, 0A7h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0459:	; "「あ…ふぁ…いや…んくっ、変に…ボク…変に…あっ…」nn"
	db	81h, 75h, 82h, 0A0h, 81h, 63h, 82h, 0D3h, 82h, 9Fh, 81h, 63h, 82h, 0A2h, 82h, 0E2h, 81h, 63h, 82h, 0F1h, 82h, 0ADh, 82h, 0C1h, 81h, 41h, 95h, 0CFh, 82h, 0C9h, 81h, 63h, 83h, 7Bh, 83h, 4Eh, 81h, 63h, 95h, 0CFh, 82h, 0C9h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0490:	; "「あぁっ、やだ、…きちゃうよぉ…あっあぁっ……ああぁっ！…」n"
	db	81h, 75h, 82h, 0A0h, 82h, 9Fh, 82h, 0C1h, 81h, 41h, 82h, 0E2h, 82h, 0BEh, 81h, 41h, 81h, 63h, 82h, 0ABh, 82h, 0BFh, 82h, 0E1h, 82h, 0A4h, 82h, 0E6h, 82h, 0A7h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 82h, 0A0h, 82h, 9Fh, 82h, 0C1h, 81h, 63h, 81h, 63h, 82h, 0A0h, 82h, 0A0h, 82h, 9Fh, 82h, 0C1h, 81h, 49h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_04CE:
	db	"b:vg11", 00h
str_04D5:	; "「こらぁっ…こんなの聞いてないぞぉ…服脱ぐだけだって…言ったじゃねぇかぁ…」n"
	db	81h, 75h, 82h, 0B1h, 82h, 0E7h, 82h, 9Fh, 82h, 0C1h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 82h, 0CCh, 95h, 0B7h, 82h, 0A2h, 82h, 0C4h, 82h, 0C8h, 82h, 0A2h, 82h, 0BCh, 82h, 0A7h, 81h, 63h, 95h, 9Eh, 92h, 45h, 82h, 0AEh, 82h, 0BEh, 82h, 0AFh, 82h, 0BEh, 82h, 0C1h, 82h, 0C4h, 81h, 63h, 8Ch, 0BEh, 82h, 0C1h, 82h, 0BDh, 82h, 0B6h, 82h, 0E1h, 82h, 0CBh, 82h, 0A5h, 82h, 0A9h, 82h, 9Fh, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_0523:	; "「いやぁ…あっ、あ…熱い…熱いぃ…んぁ…はあぁっ」nn"
	db	81h, 75h, 82h, 0A2h, 82h, 0E2h, 82h, 9Fh, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 41h, 82h, 0A0h, 81h, 63h, 94h, 4Dh, 82h, 0A2h, 81h, 63h, 94h, 4Dh, 82h, 0A2h, 82h, 0A1h, 81h, 63h, 82h, 0F1h, 82h, 9Fh, 81h, 63h, 82h, 0CDh, 82h, 0A0h, 82h, 9Fh, 82h, 0C1h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0558:	; "「…やだ…見ない…で…お願…ぃあっ…あっ、んあぁっ！」n"
	db	81h, 75h, 81h, 63h, 82h, 0E2h, 82h, 0BEh, 81h, 63h, 8Ch, 0A9h, 82h, 0C8h, 82h, 0A2h, 81h, 63h, 82h, 0C5h, 81h, 63h, 82h, 0A8h, 8Ah, 0E8h, 81h, 63h, 82h, 0A1h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 41h, 82h, 0F1h, 82h, 0A0h, 82h, 9Fh, 82h, 0C1h, 81h, 49h, 81h, 76h, NL_CHR, 00h
str_0590:
	db	"b:vg10", 00h
str_0597:	; "「…おねがいやから、いじめんといて…。こんなん…いややぁ…」nn"
	db	81h, 75h, 81h, 63h, 82h, 0A8h, 82h, 0CBh, 82h, 0AAh, 82h, 0A2h, 82h, 0E2h, 82h, 0A9h, 82h, 0E7h, 81h, 41h, 82h, 0A2h, 82h, 0B6h, 82h, 0DFh, 82h, 0F1h, 82h, 0C6h, 82h, 0A2h, 82h, 0C4h, 81h, 63h, 81h, 42h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 82h, 0F1h, 81h, 63h, 82h, 0A2h, 82h, 0E2h, 82h, 0E2h, 82h, 9Fh, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_05D6:	; "「……ふ…ぅあっ…あっ…ぁはっ…」nn"
	db	81h, 75h, 81h, 63h, 81h, 63h, 82h, 0D3h, 81h, 63h, 82h, 0A3h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 9Fh, 82h, 0CDh, 82h, 0C1h, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_05FB:	; "「……だめぇ…ぁふ…まなみちゃん…へんなん…いや…あっ…ゃああっ！」nn"
	db	81h, 75h, 81h, 63h, 81h, 63h, 82h, 0BEh, 82h, 0DFh, 82h, 0A5h, 81h, 63h, 82h, 9Fh, 82h, 0D3h, 81h, 63h, 82h, 0DCh, 82h, 0C8h, 82h, 0DDh, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 81h, 63h, 82h, 0D6h, 82h, 0F1h, 82h, 0C8h, 82h, 0F1h, 81h, 63h, 82h, 0A2h, 82h, 0E2h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0E1h, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 49h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0642:	; "「……んんぁっ…ん…はあっ…あっ…ああっ………にゃぁああああっ！…………」"
	db	81h, 75h, 81h, 63h, 81h, 63h, 82h, 0F1h, 82h, 0F1h, 82h, 9Fh, 82h, 0C1h, 81h, 63h, 82h, 0F1h, 81h, 63h, 82h, 0CDh, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 81h, 63h, 81h, 63h, 82h, 0C9h, 82h, 0E1h, 82h, 9Fh, 82h, 0A0h, 82h, 0A0h, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 49h, 81h, 63h, 81h, 63h, 81h, 63h, 81h, 63h, 81h, 76h, 00h
str_068D:
	db	"b:vg11", 00h
str_0694:	; "「…こんな格好させて…何を考えているの…？」n"
	db	81h, 75h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 8Ah, 69h, 8Dh, 44h, 82h, 0B3h, 82h, 0B9h, 82h, 0C4h, 81h, 63h, 89h, 0BDh, 82h, 0F0h, 8Dh, 6Ch, 82h, 0A6h, 82h, 0C4h, 82h, 0A2h, 82h, 0E9h, 82h, 0CCh, 81h, 63h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_06C2:	; "「痛…や…やめて…こんな…どうして…溢れて…んぅっ…あぁ…」nn"
	db	81h, 75h, 92h, 0C9h, 81h, 63h, 82h, 0E2h, 81h, 63h, 82h, 0E2h, 82h, 0DFh, 82h, 0C4h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 81h, 63h, 82h, 0C7h, 82h, 0A4h, 82h, 0B5h, 82h, 0C4h, 81h, 63h, 88h, 0ECh, 82h, 0EAh, 82h, 0C4h, 81h, 63h, 82h, 0F1h, 82h, 0A3h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 9Fh, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0701:	; "「…ああっ…締めつけて…くるぅっ…あっ…ああっ……はああ…っ」"
	db	81h, 75h, 81h, 63h, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 92h, 0F7h, 82h, 0DFh, 82h, 0C2h, 82h, 0AFh, 82h, 0C4h, 81h, 63h, 82h, 0ADh, 82h, 0E9h, 82h, 0A3h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 81h, 63h, 82h, 0CDh, 82h, 0A0h, 82h, 0A0h, 81h, 63h, 82h, 0C1h, 81h, 76h, 00h
str_0740:
	db	"b:vg10", 00h
str_0747:	; "「…こんなのって…ひどいわ…恥ずかしい」n"
	db	81h, 75h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 82h, 0CCh, 82h, 0C1h, 82h, 0C4h, 81h, 63h, 82h, 0D0h, 82h, 0C7h, 82h, 0A2h, 82h, 0EDh, 81h, 63h, 92h, 70h, 82h, 0B8h, 82h, 0A9h, 82h, 0B5h, 82h, 0A2h, 81h, 76h, NL_CHR, 00h
str_0771:	; "「…きゃ…つめたぁい…なに…これ…？…ぬるぬるしてる…」nn"
	db	81h, 75h, 81h, 63h, 82h, 0ABh, 82h, 0E1h, 81h, 63h, 82h, 0C2h, 82h, 0DFh, 82h, 0BDh, 82h, 9Fh, 82h, 0A2h, 81h, 63h, 82h, 0C8h, 82h, 0C9h, 81h, 63h, 82h, 0B1h, 82h, 0EAh, 81h, 63h, 81h, 48h, 81h, 63h, 82h, 0CAh, 82h, 0E9h, 82h, 0CAh, 82h, 0E9h, 82h, 0B5h, 82h, 0C4h, 82h, 0E9h, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_07AC:	; "「…やめて…気持ち…あ…下着も…汚れ…ちゃう…」n"
	db	81h, 75h, 81h, 63h, 82h, 0E2h, 82h, 0DFh, 82h, 0C4h, 81h, 63h, 8Bh, 43h, 8Eh, 9Dh, 82h, 0BFh, 81h, 63h, 82h, 0A0h, 81h, 63h, 89h, 0BAh, 92h, 85h, 82h, 0E0h, 81h, 63h, 89h, 98h, 82h, 0EAh, 81h, 63h, 82h, 0BFh, 82h, 0E1h, 82h, 0A4h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_07DE:
	db	"d:vg11x", 00h
str_07E6:	; "「…痛っ！こんな事して、ただで済むと思っている訳じゃないでしょうね…」n"
	db	81h, 75h, 81h, 63h, 92h, 0C9h, 82h, 0C1h, 81h, 49h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 8Eh, 96h, 82h, 0B5h, 82h, 0C4h, 81h, 41h, 82h, 0BDh, 82h, 0BEh, 82h, 0C5h, 8Dh, 0CFh, 82h, 0DEh, 82h, 0C6h, 8Eh, 76h, 82h, 0C1h, 82h, 0C4h, 82h, 0A2h, 82h, 0E9h, 96h, 0F3h, 82h, 0B6h, 82h, 0E1h, 82h, 0C8h, 82h, 0A2h, 82h, 0C5h, 82h, 0B5h, 82h, 0E5h, 82h, 0A4h, 82h, 0CBh, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_082E:	; "「…そ、そんなっ…こんな…格好…で…あっ……お嫁に行けなくなっちゃう…」nn"
	db	81h, 75h, 81h, 63h, 82h, 0BBh, 81h, 41h, 82h, 0BBh, 82h, 0F1h, 82h, 0C8h, 82h, 0C1h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 81h, 63h, 8Ah, 69h, 8Dh, 44h, 81h, 63h, 82h, 0C5h, 81h, 63h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 81h, 63h, 82h, 0A8h, 89h, 0C5h, 82h, 0C9h, 8Dh, 73h, 82h, 0AFh, 82h, 0C8h, 82h, 0ADh, 82h, 0C8h, 82h, 0C1h, 82h, 0BFh, 82h, 0E1h, 82h, 0A4h, 81h, 63h, 81h, 76h, NL_CHR, NL_CHR, 00h
str_0879:	; "「…や…だ…やめて…見ないでぇっ……こんな…いやぁ…うっ…ぁああっ…」n"
	db	81h, 75h, 81h, 63h, 82h, 0E2h, 81h, 63h, 82h, 0BEh, 81h, 63h, 82h, 0E2h, 82h, 0DFh, 82h, 0C4h, 81h, 63h, 8Ch, 0A9h, 82h, 0C8h, 82h, 0A2h, 82h, 0C5h, 82h, 0A5h, 82h, 0C1h, 81h, 63h, 81h, 63h, 82h, 0B1h, 82h, 0F1h, 82h, 0C8h, 81h, 63h, 82h, 0A2h, 82h, 0E2h, 82h, 9Fh, 81h, 63h, 82h, 0A4h, 82h, 0C1h, 81h, 63h, 82h, 9Fh, 82h, 0A0h, 82h, 0A0h, 82h, 0C1h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_08C1:
	db	"d:vgefex", 00h
str_08CA:
	db	"d:vg15", 00h
str_08D1:	; "「これで…日本一、か。…えへへ…やったねっ！」n"
	db	81h, 75h, 82h, 0B1h, 82h, 0EAh, 82h, 0C5h, 81h, 63h, 93h, 0FAh, 96h, 7Bh, 88h, 0EAh, 81h, 41h, 82h, 0A9h, 81h, 42h, 81h, 63h, 82h, 0A6h, 82h, 0D6h, 82h, 0D6h, 81h, 63h, 82h, 0E2h, 82h, 0C1h, 82h, 0BDh, 82h, 0CBh, 82h, 0C1h, 81h, 49h, 81h, 76h, NL_CHR, 00h
str_0901:	; "－数年後－n"
	db	81h, 7Ch, 90h, 94h, 94h, 4Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_090D:	; "「なに！？今の音は！？」n"
	db	81h, 75h, 82h, 0C8h, 82h, 0C9h, 81h, 49h, 81h, 48h, 8Dh, 0A1h, 82h, 0CCh, 89h, 0B9h, 82h, 0CDh, 81h, 49h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_0927:	; "「優香が、また『鬼吼弾』撃ったんだってぇ」n"
	db	81h, 75h, 97h, 44h, 8Dh, 81h, 82h, 0AAh, 81h, 41h, 82h, 0DCh, 82h, 0BDh, 81h, 77h, 8Bh, 53h, 99h, 0E1h, 92h, 65h, 81h, 78h, 8Ch, 82h, 82h, 0C1h, 82h, 0BDh, 82h, 0F1h, 82h, 0BEh, 82h, 0C1h, 82h, 0C4h, 82h, 0A5h, 81h, 76h, NL_CHR, 00h
str_0953:	; "「…えーっ？またぁ？」n"
	db	81h, 75h, 81h, 63h, 82h, 0A6h, 81h, 5Bh, 82h, 0C1h, 81h, 48h, 82h, 0DCh, 82h, 0BDh, 82h, 9Fh, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_096B:	; "「…また…やっちゃった…」n"
	db	81h, 75h, 81h, 63h, 82h, 0DCh, 82h, 0BDh, 81h, 63h, 82h, 0E2h, 82h, 0C1h, 82h, 0BFh, 82h, 0E1h, 82h, 0C1h, 82h, 0BDh, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_0987:	; "武内　優香。かねてからの希望通り、婦人警官となった。n"
	db	95h, 90h, 93h, 0E0h, 81h, 40h, 97h, 44h, 8Dh, 81h, 81h, 42h, 82h, 0A9h, 82h, 0CBh, 82h, 0C4h, 82h, 0A9h, 82h, 0E7h, 82h, 0CCh, 8Ah, 0F3h, 96h, 5Dh, 92h, 0CAh, 82h, 0E8h, 81h, 41h, 95h, 77h, 90h, 6Ch, 8Ch, 78h, 8Ah, 0AFh, 82h, 0C6h, 82h, 0C8h, 82h, 0C1h, 82h, 0BDh, 81h, 42h, NL_CHR, 00h
str_09BD:	; "…が、『市民に愛される婦人警官』には、まだまだ遠いようである…。n"
	db	81h, 63h, 82h, 0AAh, 81h, 41h, 81h, 77h, 8Eh, 73h, 96h, 0AFh, 82h, 0C9h, 88h, 0A4h, 82h, 0B3h, 82h, 0EAh, 82h, 0E9h, 95h, 77h, 90h, 6Ch, 8Ch, 78h, 8Ah, 0AFh, 81h, 78h, 82h, 0C9h, 82h, 0CDh, 81h, 41h, 82h, 0DCh, 82h, 0BEh, 82h, 0DCh, 82h, 0BEh, 89h, 93h, 82h, 0A2h, 82h, 0E6h, 82h, 0A4h, 82h, 0C5h, 82h, 0A0h, 82h, 0E9h, 81h, 63h, 81h, 42h, NL_CHR, 00h
str_09FF:
	db	"d:vg18", 00h
str_0A06:	; "「…まいったな、オレに勝てるのは宇宙人ぐらいしかいねえのか？ハハハ」n"
	db	81h, 75h, 81h, 63h, 82h, 0DCh, 82h, 0A2h, 82h, 0C1h, 82h, 0BDh, 82h, 0C8h, 81h, 41h, 83h, 49h, 83h, 8Ch, 82h, 0C9h, 8Fh, 9Fh, 82h, 0C4h, 82h, 0E9h, 82h, 0CCh, 82h, 0CDh, 89h, 46h, 92h, 88h, 90h, 6Ch, 82h, 0AEh, 82h, 0E7h, 82h, 0A2h, 82h, 0B5h, 82h, 0A9h, 82h, 0A2h, 82h, 0CBh, 82h, 0A6h, 82h, 0CCh, 82h, 0A9h, 81h, 48h, 83h, 6Eh, 83h, 6Eh, 83h, 6Eh, 81h, 76h, NL_CHR, 00h
str_0A4C:	; "－数年後－n"
	db	81h, 7Ch, 90h, 94h, 94h, 4Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_0A58:	; "…Ｊ国初のスペースシャトル『黎明』、打ち上げに成功。n"
	db	81h, 63h, 82h, 69h, 8Dh, 91h, 8Fh, 89h, 82h, 0CCh, 83h, 58h, 83h, 79h, 81h, 5Bh, 83h, 58h, 83h, 56h, 83h, 83h, 83h, 67h, 83h, 8Bh, 81h, 77h, 0EAh, 74h, 96h, 0BEh, 81h, 78h, 81h, 41h, 91h, 0C5h, 82h, 0BFh, 8Fh, 0E3h, 82h, 0B0h, 82h, 0C9h, 90h, 0ACh, 8Ch, 0F7h, 81h, 42h, NL_CHR, 00h
str_0A8E:	; "１９＊＊年＊＊月＊＊日、新大阪国際空港に無事、帰還した。n"
	db	82h, 50h, 82h, 58h, 81h, 96h, 81h, 96h, 94h, 4Eh, 81h, 96h, 81h, 96h, 8Ch, 8Eh, 81h, 96h, 81h, 96h, 93h, 0FAh, 81h, 41h, 90h, 56h, 91h, 0E5h, 8Dh, 0E3h, 8Dh, 91h, 8Dh, 0DBh, 8Bh, 0F3h, 8Dh, 60h, 82h, 0C9h, 96h, 0B3h, 8Eh, 96h, 81h, 41h, 8Bh, 41h, 8Ah, 0D2h, 82h, 0B5h, 82h, 0BDh, 81h, 42h, NL_CHR, 00h
str_0AC8:	; "「…潤は凄いよ。男７人で動かせない機材を１人で簡単に持ち上げちまったんだ」n"
	db	81h, 75h, 81h, 63h, 8Fh, 81h, 82h, 0CDh, 90h, 0A6h, 82h, 0A2h, 82h, 0E6h, 81h, 42h, 92h, 6Ah, 82h, 56h, 90h, 6Ch, 82h, 0C5h, 93h, 0AEh, 82h, 0A9h, 82h, 0B9h, 82h, 0C8h, 82h, 0A2h, 8Bh, 40h, 8Dh, 0DEh, 82h, 0F0h, 82h, 50h, 90h, 6Ch, 82h, 0C5h, 8Ah, 0C8h, 92h, 50h, 82h, 0C9h, 8Eh, 9Dh, 82h, 0BFh, 8Fh, 0E3h, 82h, 0B0h, 82h, 0BFh, 82h, 0DCh, 82h, 0C1h, 82h, 0BDh, 82h, 0F1h, 82h, 0BEh, 81h, 76h, NL_CHR, 00h
str_0B14:	; "同乗し再突入時に発生した事故に際し、トラブルシューターとして活躍したn"
	db	93h, 0AFh, 8Fh, 0E6h, 82h, 0B5h, 8Dh, 0C4h, 93h, 0CBh, 93h, 0FCh, 8Eh, 9Eh, 82h, 0C9h, 94h, 0ADh, 90h, 0B6h, 82h, 0B5h, 82h, 0BDh, 8Eh, 96h, 8Ch, 0CCh, 82h, 0C9h, 8Dh, 0DBh, 82h, 0B5h, 81h, 41h, 83h, 67h, 83h, 89h, 83h, 75h, 83h, 8Bh, 83h, 56h, 83h, 85h, 81h, 5Bh, 83h, 5Eh, 81h, 5Bh, 82h, 0C6h, 82h, 0B5h, 82h, 0C4h, 8Ah, 88h, 96h, 0F4h, 82h, 0B5h, 82h, 0BDh, NL_CHR, 00h
str_0B5A:	; "『久保田　潤』には、その功績に対し国民栄誉章が贈与される予定。n"
	db	81h, 77h, 8Bh, 76h, 95h, 0DBh, 93h, 63h, 81h, 40h, 8Fh, 81h, 81h, 78h, 82h, 0C9h, 82h, 0CDh, 81h, 41h, 82h, 0BBh, 82h, 0CCh, 8Ch, 0F7h, 90h, 0D1h, 82h, 0C9h, 91h, 0CEh, 82h, 0B5h, 8Dh, 91h, 96h, 0AFh, 89h, 68h, 97h, 5Fh, 8Fh, 0CDh, 82h, 0AAh, 91h, 0A1h, 97h, 5Eh, 82h, 0B3h, 82h, 0EAh, 82h, 0E9h, 97h, 5Ch, 92h, 0E8h, 81h, 42h, NL_CHR, 00h
str_0B9A:	; "「…フフッ。宇宙は大きかったよ。このオレが小さい存在に思えるぐらいに、ね」n"
	db	81h, 75h, 81h, 63h, 83h, 74h, 83h, 74h, 83h, 62h, 81h, 42h, 89h, 46h, 92h, 88h, 82h, 0CDh, 91h, 0E5h, 82h, 0ABh, 82h, 0A9h, 82h, 0C1h, 82h, 0BDh, 82h, 0E6h, 81h, 42h, 82h, 0B1h, 82h, 0CCh, 83h, 49h, 83h, 8Ch, 82h, 0AAh, 8Fh, 0ACh, 82h, 0B3h, 82h, 0A2h, 91h, 0B6h, 8Dh, 0DDh, 82h, 0C9h, 8Eh, 76h, 82h, 0A6h, 82h, 0E9h, 82h, 0AEh, 82h, 0E7h, 82h, 0A2h, 82h, 0C9h, 81h, 41h, 82h, 0CBh, 81h, 76h, NL_CHR, 00h
str_0BE6:
	db	"d:vg17", 00h
str_0BED:	; "「わあい！まなみちゃん、おかねもちやぁ☆ほしいもん、いーっぱいかうねん！」n"
	db	81h, 75h, 82h, 0EDh, 82h, 0A0h, 82h, 0A2h, 81h, 49h, 82h, 0DCh, 82h, 0C8h, 82h, 0DDh, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 81h, 41h, 82h, 0A8h, 82h, 0A9h, 82h, 0CBh, 82h, 0E0h, 82h, 0BFh, 82h, 0E2h, 82h, 9Fh, 81h, 99h, 82h, 0D9h, 82h, 0B5h, 82h, 0A2h, 82h, 0E0h, 82h, 0F1h, 81h, 41h, 82h, 0A2h, 81h, 5Bh, 82h, 0C1h, 82h, 0CFh, 82h, 0A2h, 82h, 0A9h, 82h, 0A4h, 82h, 0CBh, 82h, 0F1h, 81h, 49h, 81h, 76h, NL_CHR, 00h
str_0C39:	; "－数年後－n"
	db	81h, 7Ch, 90h, 94h, 94h, 4Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_0C45:	; "「楠先生っ！どこにかくれてるのっ！早くでていらっしゃいっ！」n"
	db	81h, 75h, 93h, 0EDh, 90h, 0E6h, 90h, 0B6h, 82h, 0C1h, 81h, 49h, 82h, 0C7h, 82h, 0B1h, 82h, 0C9h, 82h, 0A9h, 82h, 0ADh, 82h, 0EAh, 82h, 0C4h, 82h, 0E9h, 82h, 0CCh, 82h, 0C1h, 81h, 49h, 91h, 81h, 82h, 0ADh, 82h, 0C5h, 82h, 0C4h, 82h, 0A2h, 82h, 0E7h, 82h, 0C1h, 82h, 0B5h, 82h, 0E1h, 82h, 0A2h, 82h, 0C1h, 81h, 49h, 81h, 76h, NL_CHR, 00h
str_0C83:	; "「…せんせえ、よんでるけど…いかんでええのん？」n"
	db	81h, 75h, 81h, 63h, 82h, 0B9h, 82h, 0F1h, 82h, 0B9h, 82h, 0A6h, 81h, 41h, 82h, 0E6h, 82h, 0F1h, 82h, 0C5h, 82h, 0E9h, 82h, 0AFh, 82h, 0C7h, 81h, 63h, 82h, 0A2h, 82h, 0A9h, 82h, 0F1h, 82h, 0C5h, 82h, 0A6h, 82h, 0A6h, 82h, 0CCh, 82h, 0F1h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_0CB5:	; "「いったらおこられるもん…まなみちゃん、ガラスわってしもおたから…」n"
	db	81h, 75h, 82h, 0A2h, 82h, 0C1h, 82h, 0BDh, 82h, 0E7h, 82h, 0A8h, 82h, 0B1h, 82h, 0E7h, 82h, 0EAh, 82h, 0E9h, 82h, 0E0h, 82h, 0F1h, 81h, 63h, 82h, 0DCh, 82h, 0C8h, 82h, 0DDh, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 81h, 41h, 83h, 4Bh, 83h, 89h, 83h, 58h, 82h, 0EDh, 82h, 0C1h, 82h, 0C4h, 82h, 0B5h, 82h, 0E0h, 82h, 0A8h, 82h, 0BDh, 82h, 0A9h, 82h, 0E7h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_0CFB:	; "「せんせえ…ちゃんとあやまらなあかんよ？」n"
	db	81h, 75h, 82h, 0B9h, 82h, 0F1h, 82h, 0B9h, 82h, 0A6h, 81h, 63h, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 82h, 0C6h, 82h, 0A0h, 82h, 0E2h, 82h, 0DCh, 82h, 0E7h, 82h, 0C8h, 82h, 0A0h, 82h, 0A9h, 82h, 0F1h, 82h, 0E6h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_0D27:	; "楠　真奈美。…なんの因果か幼稚園の先生に。n"
	db	93h, 0EDh, 81h, 40h, 90h, 5Eh, 93h, 0DEh, 94h, 0FCh, 81h, 42h, 81h, 63h, 82h, 0C8h, 82h, 0F1h, 82h, 0CCh, 88h, 0F6h, 89h, 0CAh, 82h, 0A9h, 97h, 63h, 92h, 74h, 89h, 80h, 82h, 0CCh, 90h, 0E6h, 90h, 0B6h, 82h, 0C9h, 81h, 42h, NL_CHR, 00h
str_0D53:	; "教育しているのかされてるのかは判らないが…とにかく、頑張れ（笑）。n"
	db	8Bh, 0B3h, 88h, 0E7h, 82h, 0B5h, 82h, 0C4h, 82h, 0A2h, 82h, 0E9h, 82h, 0CCh, 82h, 0A9h, 82h, 0B3h, 82h, 0EAh, 82h, 0C4h, 82h, 0E9h, 82h, 0CCh, 82h, 0A9h, 82h, 0CDh, 94h, 0BBh, 82h, 0E7h, 82h, 0C8h, 82h, 0A2h, 82h, 0AAh, 81h, 63h, 82h, 0C6h, 82h, 0C9h, 82h, 0A9h, 82h, 0ADh, 81h, 41h, 8Ah, 0E6h, 92h, 0A3h, 82h, 0EAh, 81h, 69h, 8Fh, 0CEh, 81h, 6Ah, 81h, 42h, NL_CHR, 00h
str_0D97:
	db	"d:vg16", 00h
str_0D9E:	; "「…この国にはもう未練はない。わたしより強い人間がいない国にはね…」n"
	db	81h, 75h, 81h, 63h, 82h, 0B1h, 82h, 0CCh, 8Dh, 91h, 82h, 0C9h, 82h, 0CDh, 82h, 0E0h, 82h, 0A4h, 96h, 0A2h, 97h, 0FBh, 82h, 0CDh, 82h, 0C8h, 82h, 0A2h, 81h, 42h, 82h, 0EDh, 82h, 0BDh, 82h, 0B5h, 82h, 0E6h, 82h, 0E8h, 8Bh, 0ADh, 82h, 0A2h, 90h, 6Ch, 8Ah, 0D4h, 82h, 0AAh, 82h, 0A2h, 82h, 0C8h, 82h, 0A2h, 8Dh, 91h, 82h, 0C9h, 82h, 0CDh, 82h, 0CBh, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_0DE4:	; "－数年後－n"
	db	81h, 7Ch, 90h, 94h, 94h, 4Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_0DF0:	; "「おもしろかったね、『ビハインド・ザ・ニンジャ』」n"
	db	81h, 75h, 82h, 0A8h, 82h, 0E0h, 82h, 0B5h, 82h, 0EBh, 82h, 0A9h, 82h, 0C1h, 82h, 0BDh, 82h, 0CBh, 81h, 41h, 81h, 77h, 83h, 72h, 83h, 6Eh, 83h, 43h, 83h, 93h, 83h, 68h, 81h, 45h, 83h, 55h, 81h, 45h, 83h, 6Ah, 83h, 93h, 83h, 57h, 83h, 83h, 81h, 78h, 81h, 76h, NL_CHR, 00h
str_0E24:	; "「主演のチホ・マスダ…カッコいいよなぁ。アクションもバッチリだし」n"
	db	81h, 75h, 8Eh, 0E5h, 89h, 89h, 82h, 0CCh, 83h, 60h, 83h, 7Ah, 81h, 45h, 83h, 7Dh, 83h, 58h, 83h, 5Fh, 81h, 63h, 83h, 4Ah, 83h, 62h, 83h, 52h, 82h, 0A2h, 82h, 0A2h, 82h, 0E6h, 82h, 0C8h, 82h, 9Fh, 81h, 42h, 83h, 41h, 83h, 4Eh, 83h, 56h, 83h, 87h, 83h, 93h, 82h, 0E0h, 83h, 6Fh, 83h, 62h, 83h, 60h, 83h, 8Ah, 82h, 0BEh, 82h, 0B5h, 81h, 76h, NL_CHR, 00h
str_0E68:	; "「…知ってるかい？彼女、Ｊ国最強、本物のニンジャ・レディなんだってよ」n"
	db	81h, 75h, 81h, 63h, 92h, 6Dh, 82h, 0C1h, 82h, 0C4h, 82h, 0E9h, 82h, 0A9h, 82h, 0A2h, 81h, 48h, 94h, 0DEh, 8Fh, 97h, 81h, 41h, 82h, 69h, 8Dh, 91h, 8Dh, 0C5h, 8Bh, 0ADh, 81h, 41h, 96h, 7Bh, 95h, 0A8h, 82h, 0CCh, 83h, 6Ah, 83h, 93h, 83h, 57h, 83h, 83h, 81h, 45h, 83h, 8Ch, 83h, 66h, 83h, 42h, 82h, 0C8h, 82h, 0F1h, 82h, 0BEh, 82h, 0C1h, 82h, 0C4h, 82h, 0E6h, 81h, 76h, NL_CHR, 00h
str_0EB0:	; "「…チホ・マスダ、推参！…なぁんて、ね」n"
	db	81h, 75h, 81h, 63h, 83h, 60h, 83h, 7Ah, 81h, 45h, 83h, 7Dh, 83h, 58h, 83h, 5Fh, 81h, 41h, 90h, 84h, 8Eh, 51h, 81h, 49h, 81h, 63h, 82h, 0C8h, 82h, 9Fh, 82h, 0F1h, 82h, 0C4h, 81h, 41h, 82h, 0CBh, 81h, 76h, NL_CHR, 00h
str_0EDA:	; "増田千穂。…単身Ａ国に渡り、某所にて映画界に鮮烈デビュー。n"
	db	91h, 9Dh, 93h, 63h, 90h, 0E7h, 95h, 0E4h, 81h, 42h, 81h, 63h, 92h, 50h, 90h, 67h, 82h, 60h, 8Dh, 91h, 82h, 0C9h, 93h, 6Eh, 82h, 0E8h, 81h, 41h, 96h, 5Eh, 8Fh, 8Ah, 82h, 0C9h, 82h, 0C4h, 89h, 66h, 89h, 0E6h, 8Ah, 45h, 82h, 0C9h, 91h, 4Eh, 97h, 0F3h, 83h, 66h, 83h, 72h, 83h, 85h, 81h, 5Bh, 81h, 42h, NL_CHR, 00h
str_0F16:	; "Ｓ・コスギを越えるニンジャスターとして、新ニンジャブームの火種となる。n"
	db	82h, 72h, 81h, 45h, 83h, 52h, 83h, 58h, 83h, 4Dh, 82h, 0F0h, 89h, 7Ah, 82h, 0A6h, 82h, 0E9h, 83h, 6Ah, 83h, 93h, 83h, 57h, 83h, 83h, 83h, 58h, 83h, 5Eh, 81h, 5Bh, 82h, 0C6h, 82h, 0B5h, 82h, 0C4h, 81h, 41h, 90h, 56h, 83h, 6Ah, 83h, 93h, 83h, 57h, 83h, 83h, 83h, 75h, 81h, 5Bh, 83h, 80h, 82h, 0CCh, 89h, 0CEh, 8Eh, 0EDh, 82h, 0C6h, 82h, 0C8h, 82h, 0E9h, 81h, 42h, NL_CHR, 00h
str_0F5E:
	db	"d:vg19", 00h
str_0F65:
	db	".gem", 00h
str_0F6A:	; "「どうやら終了ですね。…風が…気持ちいいわ」n"
	db	81h, 75h, 82h, 0C7h, 82h, 0A4h, 82h, 0E2h, 82h, 0E7h, 8Fh, 49h, 97h, 0B9h, 82h, 0C5h, 82h, 0B7h, 82h, 0CBh, 81h, 42h, 81h, 63h, 95h, 97h, 82h, 0AAh, 81h, 63h, 8Bh, 43h, 8Eh, 9Dh, 82h, 0BFh, 82h, 0A2h, 82h, 0A2h, 82h, 0EDh, 81h, 76h, NL_CHR, 00h
str_0F98:	; "－数年後－n"
	db	81h, 7Ch, 90h, 94h, 94h, 4Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_0FA4:	; "「…発表します。１９＊＊年度、ミス・ユニバース日本代表…」n"
	db	81h, 75h, 81h, 63h, 94h, 0ADh, 95h, 5Ch, 82h, 0B5h, 82h, 0DCh, 82h, 0B7h, 81h, 42h, 82h, 50h, 82h, 58h, 81h, 96h, 81h, 96h, 94h, 4Eh, 93h, 78h, 81h, 41h, 83h, 7Eh, 83h, 58h, 81h, 45h, 83h, 86h, 83h, 6Ah, 83h, 6Fh, 81h, 5Bh, 83h, 58h, 93h, 0FAh, 96h, 7Bh, 91h, 0E3h, 95h, 5Ch, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_0FE0:	; "「…エントリーナンバー４１。…神奈川県『梁瀬　かおり』さんです！！」n"
	db	81h, 75h, 81h, 63h, 83h, 47h, 83h, 93h, 83h, 67h, 83h, 8Ah, 81h, 5Bh, 83h, 69h, 83h, 93h, 83h, 6Fh, 81h, 5Bh, 82h, 53h, 82h, 50h, 81h, 42h, 81h, 63h, 90h, 5Fh, 93h, 0DEh, 90h, 0ECh, 8Ch, 0A7h, 81h, 77h, 97h, 0C0h, 90h, 0A3h, 81h, 40h, 82h, 0A9h, 82h, 0A8h, 82h, 0E8h, 81h, 78h, 82h, 0B3h, 82h, 0F1h, 82h, 0C5h, 82h, 0B7h, 81h, 49h, 81h, 49h, 81h, 76h, NL_CHR, 00h
str_1026:	; "梁瀬　かおり。弱冠２２才で国立Ｔ大学名誉教授に就任したのちn"
	db	97h, 0C0h, 90h, 0A3h, 81h, 40h, 82h, 0A9h, 82h, 0A8h, 82h, 0E8h, 81h, 42h, 8Eh, 0E3h, 8Ah, 0A5h, 82h, 51h, 82h, 51h, 8Dh, 0CBh, 82h, 0C5h, 8Dh, 91h, 97h, 0A7h, 82h, 73h, 91h, 0E5h, 8Ah, 77h, 96h, 0BCh, 97h, 5Fh, 8Bh, 0B3h, 8Eh, 0F6h, 82h, 0C9h, 8Fh, 41h, 94h, 43h, 82h, 0B5h, 82h, 0BDh, 82h, 0CCh, 82h, 0BFh, NL_CHR, 00h
str_1062:	; "ミス・ユニバース日本代表に選出される。n"
	db	83h, 7Eh, 83h, 58h, 81h, 45h, 83h, 86h, 83h, 6Ah, 83h, 6Fh, 81h, 5Bh, 83h, 58h, 93h, 0FAh, 96h, 7Bh, 91h, 0E3h, 95h, 5Ch, 82h, 0C9h, 91h, 49h, 8Fh, 6Fh, 82h, 0B3h, 82h, 0EAh, 82h, 0E9h, 81h, 42h, NL_CHR, 00h
str_108A:	; "「今のお気持ちは？」n"
	db	81h, 75h, 8Dh, 0A1h, 82h, 0CCh, 82h, 0A8h, 8Bh, 43h, 8Eh, 9Dh, 82h, 0BFh, 82h, 0CDh, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_10A0:	; "「…よくわからないんですけど…これって名誉な事なんですの？」n"
	db	81h, 75h, 81h, 63h, 82h, 0E6h, 82h, 0ADh, 82h, 0EDh, 82h, 0A9h, 82h, 0E7h, 82h, 0C8h, 82h, 0A2h, 82h, 0F1h, 82h, 0C5h, 82h, 0B7h, 82h, 0AFh, 82h, 0C7h, 81h, 63h, 82h, 0B1h, 82h, 0EAh, 82h, 0C1h, 82h, 0C4h, 96h, 0BCh, 97h, 5Fh, 82h, 0C8h, 8Eh, 96h, 82h, 0C8h, 82h, 0F1h, 82h, 0C5h, 82h, 0B7h, 82h, 0CCh, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_10DE:	; "「…は？」n"
	db	81h, 75h, 81h, 63h, 82h, 0CDh, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_10EA:
	db	"d:vg20", 00h
str_10F1:	; "「フッ…あと何回勝てば闘わずに済むようになるのかしら？」n"
	db	81h, 75h, 83h, 74h, 83h, 62h, 81h, 63h, 82h, 0A0h, 82h, 0C6h, 89h, 0BDh, 89h, 0F1h, 8Fh, 9Fh, 82h, 0C4h, 82h, 0CEh, 93h, 0ACh, 82h, 0EDh, 82h, 0B8h, 82h, 0C9h, 8Dh, 0CFh, 82h, 0DEh, 82h, 0E6h, 82h, 0A4h, 82h, 0C9h, 82h, 0C8h, 82h, 0E9h, 82h, 0CCh, 82h, 0A9h, 82h, 0B5h, 82h, 0E7h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_112B:	; "－数カ月後－n"
	db	81h, 7Ch, 90h, 94h, 83h, 4Ah, 8Ch, 8Eh, 8Ch, 0E3h, 81h, 7Ch, NL_CHR, 00h
str_1139:	; "「…あのレイミが、ねぇ…」n"
	db	81h, 75h, 81h, 63h, 82h, 0A0h, 82h, 0CCh, 83h, 8Ch, 83h, 43h, 83h, 7Eh, 82h, 0AAh, 81h, 41h, 82h, 0CBh, 82h, 0A5h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_1155:	; "「判らないものですね、あのレイミが一目惚れするなんて…」n"
	db	81h, 75h, 94h, 0BBh, 82h, 0E7h, 82h, 0C8h, 82h, 0A2h, 82h, 0E0h, 82h, 0CCh, 82h, 0C5h, 82h, 0B7h, 82h, 0CBh, 81h, 41h, 82h, 0A0h, 82h, 0CCh, 83h, 8Ch, 83h, 43h, 83h, 7Eh, 82h, 0AAh, 88h, 0EAh, 96h, 0DAh, 8Dh, 9Bh, 82h, 0EAh, 82h, 0B7h, 82h, 0E9h, 82h, 0C8h, 82h, 0F1h, 82h, 0C4h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_118F:	; "「しかも相手は『あれ』だろ…？」n"
	db	81h, 75h, 82h, 0B5h, 82h, 0A9h, 82h, 0E0h, 91h, 8Ah, 8Eh, 0E8h, 82h, 0CDh, 81h, 77h, 82h, 0A0h, 82h, 0EAh, 81h, 78h, 82h, 0BEh, 82h, 0EBh, 81h, 63h, 81h, 48h, 81h, 76h, NL_CHR, 00h
str_11B1:	; "「そうそう。そふとはうすのぷらぐらまーさんやねんて☆」n"
	db	81h, 75h, 82h, 0BBh, 82h, 0A4h, 82h, 0BBh, 82h, 0A4h, 81h, 42h, 82h, 0BBh, 82h, 0D3h, 82h, 0C6h, 82h, 0CDh, 82h, 0A4h, 82h, 0B7h, 82h, 0CCh, 82h, 0D5h, 82h, 0E7h, 82h, 0AEh, 82h, 0E7h, 82h, 0DCh, 81h, 5Bh, 82h, 0B3h, 82h, 0F1h, 82h, 0E2h, 82h, 0CBh, 82h, 0F1h, 82h, 0C4h, 81h, 99h, 81h, 76h, NL_CHR, 00h
str_11E9:	; "「…あのレイミが結婚ねぇ…」n"
	db	81h, 75h, 81h, 63h, 82h, 0A0h, 82h, 0CCh, 83h, 8Ch, 83h, 43h, 83h, 7Eh, 82h, 0AAh, 8Ch, 8Bh, 8Dh, 0A5h, 82h, 0CBh, 82h, 0A5h, 81h, 63h, 81h, 76h, NL_CHR, 00h
str_1207:	; "…レイミ・謝華。ＶＧ終了２カ月後、電撃結婚。末永く幸せに暮らしたという。n"
	db	81h, 63h, 83h, 8Ch, 83h, 43h, 83h, 7Eh, 81h, 45h, 8Eh, 0D3h, 89h, 0D8h, 81h, 42h, 82h, 75h, 82h, 66h, 8Fh, 49h, 97h, 0B9h, 82h, 51h, 83h, 4Ah, 8Ch, 8Eh, 8Ch, 0E3h, 81h, 41h, 93h, 64h, 8Ch, 82h, 8Ch, 8Bh, 8Dh, 0A5h, 81h, 42h, 96h, 96h, 89h, 69h, 82h, 0ADh, 8Dh, 4Bh, 82h, 0B9h, 82h, 0C9h, 95h, 0E9h, 82h, 0E7h, 82h, 0B5h, 82h, 0BDh, 82h, 0C6h, 82h, 0A2h, 82h, 0A4h, 81h, 42h, NL_CHR, 00h
str_1251:	; "「フフフ…シ・ア・ワ・セ。だって、愛する彼を養ってあげられるんですもの」n"
	db	81h, 75h, 83h, 74h, 83h, 74h, 83h, 74h, 81h, 63h, 83h, 56h, 81h, 45h, 83h, 41h, 81h, 45h, 83h, 8Fh, 81h, 45h, 83h, 5Ah, 81h, 42h, 82h, 0BEh, 82h, 0C1h, 82h, 0C4h, 81h, 41h, 88h, 0A4h, 82h, 0B7h, 82h, 0E9h, 94h, 0DEh, 82h, 0F0h, 97h, 7Bh, 82h, 0C1h, 82h, 0C4h, 82h, 0A0h, 82h, 0B0h, 82h, 0E7h, 82h, 0EAh, 82h, 0E9h, 82h, 0F1h, 82h, 0C5h, 82h, 0B7h, 82h, 0E0h, 82h, 0CCh, 81h, 76h, NL_CHR, 00h
str_129B:
	db	"d:vg01", 00h
str_12A2:
	db	".hgs", 00h
str_12A7:
	db	"d:vg01", 00h
str_12AE:
	db	".hcm", 00h
str_12B3:
	db	"d:vg01", 00h
str_12BA:
	db	".hmt", 00h
str_12BF:
	db	"d:vg01", 00h
str_12C6:
	db	".hfm", 00h
str_12CB:
	db	"d:vg01", 00h
str_12D2:
	db	".hf2", 00h
str_12D7:
	db	00h
str_12D8:
	db	"d:stroll.exe", 00h
str_12E5:
	db	00h
str_12E6:
	db	"a:dandan.exe", 00h
str_12F3:
	db	"a:tyuka", 00h
str_12FB:	; "ＶＧ選手、"
	db	82h, 75h, 82h, 66h, 91h, 49h, 8Eh, 0E8h, 81h, 41h, 00h
str_1306:	; "『武内　優香』。n"
	db	81h, 77h, 95h, 90h, 93h, 0E0h, 81h, 40h, 97h, 44h, 8Dh, 81h, 81h, 78h, 81h, 42h, NL_CHR, 00h
str_1318:	; "ボクの挑戦"
	db	83h, 7Bh, 83h, 4Eh, 82h, 0CCh, 92h, 0A7h, 90h, 0EDh, 00h
str_1323:	; "受けてもらうよ"
	db	8Eh, 0F3h, 82h, 0AFh, 82h, 0C4h, 82h, 0E0h, 82h, 0E7h, 82h, 0A4h, 82h, 0E6h, 00h
str_1332:
	db	"a:tjun", 00h
	; Character Intro A
;str_1339:	; "ＶＧ選手"
;	db	82h, 75h, 82h, 66h, 91h, 49h, 8Eh, 0E8h, 00h
str_1342:	; "『久保田　潤』。n"
	db	81h, 77h, 8Bh, 76h, 95h, 0DBh, 93h, 63h, 81h, 40h, 8Fh, 81h, 81h, 78h, 81h, 42h, NL_CHR, 00h
str_1354:	; "　あんた、"
	db	81h, 40h, 82h, 0A0h, 82h, 0F1h, 82h, 0BDh, 81h, 41h, 00h
str_135F:	; "強いんだろうな？"
	db	8Bh, 0ADh, 82h, 0A2h, 82h, 0F1h, 82h, 0BEh, 82h, 0EBh, 82h, 0A4h, 82h, 0C8h, 81h, 48h, 00h
str_1370:
	db	"a:tmanami", 00h
	;  Character Intro B
;str_137A:	; "ＶＧせんしゅのn"
;	db	82h, 75h, 82h, 66h, 82h, 0B9h, 82h, 0F1h, 82h, 0B5h, 82h, 0E3h, 82h, 0CCh, NL_CHR, 00h
str_138A:	; "『くすのき　まなみちゃん』ですn"
	db	81h, 77h, 82h, 0ADh, 82h, 0B7h, 82h, 0CCh, 82h, 0ABh, 81h, 40h, 82h, 0DCh, 82h, 0C8h, 82h, 0DDh, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 81h, 78h, 82h, 0C5h, 82h, 0B7h, NL_CHR, 00h
str_13AA:	; "☆おねえちゃん、あそぼ！n"
	db	81h, 99h, 82h, 0A8h, 82h, 0CBh, 82h, 0A6h, 82h, 0BFh, 82h, 0E1h, 82h, 0F1h, 81h, 41h, 82h, 0A0h, 82h, 0BBh, 82h, 0DAh, 81h, 49h, NL_CHR, 00h
str_13C4:
	db	"a:tchiho", 00h
	; Character Intro C
;str_13CD:	; "『増田　千穂』、n"
;	db	81h, 77h, 91h, 9Dh, 93h, 63h, 81h, 40h, 90h, 0E7h, 95h, 0E4h, 81h, 78h, 81h, 41h, NL_CHR, 00h
str_13DF:	; "ＶＧ選手。"
	db	82h, 75h, 82h, 66h, 91h, 49h, 8Eh, 0E8h, 81h, 42h, 00h
str_13EA:	; "さあ、始めようかn"
	db	82h, 0B3h, 82h, 0A0h, 81h, 41h, 8Eh, 6Eh, 82h, 0DFh, 82h, 0E6h, 82h, 0A4h, 82h, 0A9h, NL_CHR, 00h
str_13FC:
	db	"a:tkaori", 00h
str_1405:	; "前年度ＶＧ準優勝選手n"
	db	91h, 4Fh, 94h, 4Eh, 93h, 78h, 82h, 75h, 82h, 66h, 8Fh, 80h, 97h, 44h, 8Fh, 9Fh, 91h, 49h, 8Eh, 0E8h, NL_CHR, 00h
str_141B:	; "『梁瀬　かおり』。n"
	db	81h, 77h, 97h, 0C0h, 90h, 0A3h, 81h, 40h, 82h, 0A9h, 82h, 0A8h, 82h, 0E8h, 81h, 78h, 81h, 42h, NL_CHR, 00h
str_142F:	; "挑戦をお受けしますわ"
	db	92h, 0A7h, 90h, 0EDh, 82h, 0F0h, 82h, 0A8h, 8Eh, 0F3h, 82h, 0AFh, 82h, 0B5h, 82h, 0DCh, 82h, 0B7h, 82h, 0EDh, 00h
str_1444:
	db	"a:treimi", 00h
str_144D:	; "『謝華コンツェルン』会長、n"
	db	81h, 77h, 8Eh, 0D3h, 89h, 0D8h, 83h, 52h, 83h, 93h, 83h, 63h, 83h, 46h, 83h, 8Bh, 83h, 93h, 81h, 78h, 89h, 0EFh, 92h, 0B7h, 81h, 41h, NL_CHR, 00h
str_1469:	; "そして無敗ＶＧ優勝者n"
	db	82h, 0BBh, 82h, 0B5h, 82h, 0C4h, 96h, 0B3h, 94h, 73h, 82h, 75h, 82h, 66h, 97h, 44h, 8Fh, 9Fh, 8Eh, 0D2h, NL_CHR, 00h
str_147F:	; "『レイミ・謝華』よn"
	db	81h, 77h, 83h, 8Ch, 83h, 43h, 83h, 7Eh, 81h, 45h, 8Eh, 0D3h, 89h, 0D8h, 81h, 78h, 82h, 0E6h, NL_CHR, 00h
str_1493:	; "不運な挑戦者はあなたかしら？n"
	db	95h, 73h, 89h, 5Eh, 82h, 0C8h, 92h, 0A7h, 90h, 0EDh, 8Eh, 0D2h, 82h, 0CDh, 82h, 0A0h, 82h, 0C8h, 82h, 0BDh, 82h, 0A9h, 82h, 0B5h, 82h, 0E7h, 81h, 48h, NL_CHR, 00h
str_14B1:	; "・・・さ、"
	db	81h, 45h, 81h, 45h, 81h, 45h, 82h, 0B3h, 81h, 41h, 00h
str_14BC:	; "かかってらっしゃい"
	db	82h, 0A9h, 82h, 0A9h, 82h, 0C1h, 82h, 0C4h, 82h, 0E7h, 82h, 0C1h, 82h, 0B5h, 82h, 0E1h, 82h, 0A2h, 00h
str_14CF:
	db	"b:nr3", 00h
%assign data_space SEG026_NEW_OFS+14D6h-($-$$)
%warning Original text segment: data_space bytes remaining
	times 14D6h-($-$$-SEG026_NEW_OFS) db	0

	incbin "VG.EXE", $-SEG026_SPACE, 1EFCh - ($-$$-SEG026_NEW_OFS)
str_1EFC:	; "好きなドライブにディスク"
	db	8Dh, 44h, 82h, 0ABh, 82h, 0C8h, 83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, 82h, 0C9h, 83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, 00h
str_1F15:	; "を入れてくださいね。"
	db	82h, 0F0h, 93h, 0FCh, 82h, 0EAh, 82h, 0C4h, 82h, 0ADh, 82h, 0BEh, 82h, 0B3h, 82h, 0A2h, 82h, 0CBh, 81h, 42h, 00h
str_1F2A:	; "ドライブ"
	db	83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, 00h
str_1F33:	; "でディスク"
	db	82h, 0C5h, 83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, 00h
str_1F3E:	; "にエラーが発生しました"
	db	82h, 0C9h, 83h, 47h, 83h, 89h, 81h, 5Bh, 82h, 0AAh, 94h, 0ADh, 90h, 0B6h, 82h, 0B5h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh, 00h
str_1F55:	; "Ａ"
	db	82h, 60h, 00h
str_1F58:	; "Ａ"
	db	82h, 60h, 00h
str_1F5B:	; "用意ができたら何かキーを押してくださいね。"
	db	97h, 70h, 88h, 0D3h, 82h, 0AAh, 82h, 0C5h, 82h, 0ABh, 82h, 0BDh, 82h, 0E7h, 89h, 0BDh, 82h, 0A9h, 83h, 4Ch, 81h, 5Bh, 82h, 0F0h, 89h, 9Fh, 82h, 0B5h, 82h, 0C4h, 82h, 0ADh, 82h, 0BEh, 82h, 0B3h, 82h, 0A2h, 82h, 0CBh, 81h, 42h, 00h
%assign data_space SEG026_NEW_OFS+1F86h-($-$$)
%warning Debug message segment: data_space bytes remaining
	times 1F86h-($-$$-SEG026_NEW_OFS) db	0

	incbin "VG.EXE", $-SEG026_SPACE
end:
