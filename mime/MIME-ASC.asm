; Assembling using NASM:
;	nasm -f bin -o MIME_ASC.EXE -l MIME_ASC.LST "MIME-ASC.asm"
;	This requires a decompressed MIME.EXE (106.576 bytes) to be in the same folder.
;
;	A detailed description of how EXE files work can be found at: https://wiki.osdev.org/MZ

	use16
SEG_BASE_OFS EQU 5160h	; We assume "seg007", whose code begins at offset 5160h in the EXE file.

	org	-SEG_BASE_OFS

RelocDummy EQU 0DCDEh	; unused offset (segment 4C7h, offset 906Eh)

PrintSeg EQU 0327h
ShiftJIS2JIS EQU 06AFh
PrintFontChar EQU 06D8h

ScriptMainLoop EQU 70C0h
scr_fin_2b EQU 72C9h
WaitFrames EQU 8E59h


; include EXE header
	incbin "MIME.EXE", 0, 004Eh

; === relocation table patches ===
; include relocation table and patch a few of the EXE relocation entries

	incbin "MIME.EXE", $, 016Eh-($-$$)
	dw	RelocDummy, 000h	; originally: scr00_PrintTalk: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr00_PrintTalk: call PrintSeg:PrintFontChar

	incbin "MIME.EXE", $, 01CAh-($-$$)
	; patch Print_NoData calls
	dw	reloc_01+3, 4C7h
	dw	reloc_02+3, 4C7h
	dw	reloc_03+3, 4C7h
%rep (22Ah-($-$$))/4
	dw	RelocDummy, 000h
%endrep
	; patch PrintSaveGameName calls
	incbin "MIME.EXE", $, 022Ah-($-$$)
%rep (2AEh-($-$$))/4
	dw	RelocDummy, 000h
%endrep
	; patch Print_Cancel calls
	incbin "MIME.EXE", $, 02AEh-($-$$)
%rep (2FEh-($-$$))/4
	dw	RelocDummy, 000h
%endrep
	; patch ShowMenuTexts calls
	incbin "MIME.EXE", $, 02FEh-($-$$)
	dw	RelocDummy, 000h
	dw	RelocDummy, 000h
	dw	reloc_pme+3, 4C7h

	; patch code that executes scripts
	incbin "MIME.EXE", $, 03C2h-($-$$)
	dw	RelocDummy, 000h	; originally: scr30_PrintSJIS: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr30_PrintSJIS: call PrintSeg:PrintFontChar
	incbin "MIME.EXE", $, 03FAh-($-$$)
	dw	RelocDummy, 000h	; originally: scr3B_PrintVarStr: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr3B_PrintVarStr: call PrintSeg:PrintFontChar
	incbin "MIME.EXE", $, 047Ah-($-$$)
	dw	RelocDummy, 000h	; originally: scr5D_PrintSJIS: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr5D_PrintSJIS: call PrintSeg:PrintFontChar
	incbin "MIME.EXE", $, 0486h-($-$$)
	dw	RelocDummy, 000h	; originally: scr5E_PrintVarStr: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr5E_PrintVarStr: call PrintSeg:PrintFontChar

	incbin "MIME.EXE", $, 04E2h-($-$$)


; === main code patches ===

	incbin "MIME.EXE", $, 6E02h - ($-$$-SEG_BASE_OFS)
saveNamePattern:
	db	"**/** **:**  Lv**", 0, 0, 0	; shorten "Level" text to just "Lv " (save 3 characters)

; --- patch scenario script commands, part 1 ---
	incbin "MIME.EXE", $, 70DFh - ($-$$-SEG_BASE_OFS)
	mov	bh, 32		; patch from 16 full-width to 32 half-width characters per line
	incbin "MIME.EXE", $, 70E8h - ($-$$-SEG_BASE_OFS)
; patching scr00_PrintTalk
loc_1BD58:
	mov	[es:41C4h], di
	or	dl, dl
	jz	short loc_1BD64
	add	di, byte 2
loc_1BD64:
	xor	bl, bl

loc_1BD66:
	test	word [cs:016Eh], 1
	jz	short loc_1BD88
	
	push	di
	mov	di, 020Bh	; 020Bh = ScriptMemory
	add	di, [cs:0170h]
	mov	ax, [cs:di]
	pop	di
	or	ax, ax		; bytes 00 00 -> return to "original" string
	jz	short loc_1BD88
	
	push	ax
	call	scr00_print_chr
	add	[cs:0170h], cx
	jmp	short scr00_chr_check

loc_1BD88:
	mov	ax, [si]
	cmp	ax, 5C5Ch	; '\\'
	jz	short scr00_ret
	cmp	ax, 2323h	; '##'
	jz	short scr00_print_name
	
	push	ax
	call	scr00_print_chr
	add	si, cx
scr00_chr_check:
	add	bl, cl
	
	pop	cx
	cmp	bl, bh
	jae	short loc_1BDD5
	cmp	cx, 7A81h	; Shift-JIS closing bracket
	jnz	short loc_1BD66
	
	mov	dl, 1		; enforce line break
	jmp	short loc_1BDDD
loc_1BDD5:
	or	dl, dl
	jz	short loc_1BDDD
	sub	bh, 2
	xor	dl, dl
loc_1BDDD:
	add	di, 5F0h
	jmp	loc_1BD58

scr00_print_name:
	add	si, byte 2
	or	word [cs:016Eh], byte 1
	mov	word [cs:0170h], 0
	jmp	short loc_1BD66

scr00_ret:
	add	si, byte 2
	jmp	ScriptMainLoop

scr00_print_chr:
	push	word [cs:020Bh+0Ch]
	call	WaitFrames
	add	sp, byte 2
	jmp	PrintChar

	times 7174h-($-$$-SEG_BASE_OFS) db 90h

; TODO: patch scr02 (and figure out what it does)


; --- patch save game code ---
	incbin "MIME.EXE", $, 7567h - ($-$$-SEG_BASE_OFS)
Print_NoData:
	; original string: 8140 8140 8140 8366 815B 835E 82CD 82A0 82E8 82DC 82B9 82F1
	mov	di, txtNoData
	jmp	PrintStr_DI

txtNoData:
	db	"       No data available.", 0, 0
	times 7600h-($-$$-SEG_BASE_OFS) db 00h

; *** custom text drawing routines ***
; I'm inserting them here, because size-optimizing the function freed lots of space.
PrintChar:
	or	al, al
	jns	short pchr_asc
	;js	pchr_sjis

pchr_sjis:
	push	ax	; reads value from stack
reloc_01:
	call	PrintSeg:ShiftJIS2JIS
	push	ax
reloc_02:
	call	PrintSeg:PrintFontChar
	add	sp, byte 4
	mov	cx, 2
	ret

pchr_asc:
	xor	ah, ah
	push	ax
reloc_03:
	call	PrintSeg:PrintFontChar
	add	sp, byte 2
	mov	cx, 1
	ret

; for scr30_PrintSJIS and scr5D_PrintSJIS
; prints text stored at offset <ds:si> until two backslashes (5C5C) occour
PrintStr_SI:
	push	cx
pstr_si_loop:
	mov	ax, [si]
	cmp	ax, 5C5Ch	; return on '\\'
	jz	short pstr_si_ret
	
	call	PrintChar
	add	si, cx
	jmp	short pstr_si_loop

pstr_si_ret:
	add	si, byte 2
	pop	cx
	ret

; for scr3B_PrintVarStr and scr5E_PrintVarStr
; prints text stored at offset <cs:di> until two backslashes (5C5C) OR two 00s occour
PrintStr_DI:	; can be terminated by 00s instead of backslash
	push	cx
pstr_di_loop:
	mov	ax, [cs:di]
	or	ax, ax
	jz	short pstr_di_ret	; return on 0000h
	cmp	ax, 5C5Ch
	jz	short pstr_di_ret	; return on '\\'
	
	call	PrintChar
	add	di, cx
	jmp	short pstr_di_loop

pstr_di_ret:
	add	di, byte 2
	pop	cx
	ret
; *** custom text drawing routines END ***
	times 7664h-($-$$-SEG_BASE_OFS) db 00h

	incbin "MIME.EXE", $, 769Dh - ($-$$-SEG_BASE_OFS)
PrintSaveGameName:
	mov	ax, [cs:6DF6h]	; get save game "floor ID"
	cmp	ax, (txtLabNamesEnd-txtLabNames)/2
	jb	short psgn_show_lab
	mov	ax, (txtLabNamesEnd-txtLabNames)/2
psgn_show_lab:
	add	ax, ax
	mov	di, txtLabNames
	add	di, ax
	mov	di, [cs:di]	; get labyrinth name from table
	call	PrintStr_DI
	
	mov	di, saveNamePattern
	jmp	PrintStr_DI

txtLabNames:
	dw	txtLabC	;  0
	dw	txtLabD	;  1
	dw	txtLabD	;  2
	dw	txtLabD	;  3
	dw	txtLabE	;  4
	dw	txtLabF	;  5
	dw	txtLabG	;  6
	dw	txtLabH	;  7
	dw	txtLabI	;  8
	dw	txtLabJ	;  9
	dw	txtLabK	; 10
	dw	txtLabL	; 11
	dw	txtLabB	; 12
	dw	txtLabA	; 13+
txtLabNamesEnd:

		; each text must be 14 characters long, for proper alignment
txtLabA:	db	"    Holy Lab. ", 0, 0
txtLabB:	db	" Nothing Lab. ", 0, 0
txtLabC:	db	"Illusion Lab. ", 0, 0
txtLabD:	db	"    Tree Lab. ", 0, 0
txtLabE:	db	"     Fun Lab. ", 0, 0
txtLabF:	db	"   Tears Lab. ", 0, 0
txtLabG:	db	"     Ash Lab. ", 0, 0
txtLabH:	db	"  Cursed Lab. ", 0, 0
txtLabI:	db	"   Ocean Lab. ", 0, 0
txtLabJ:	db	"   Flame Lab. ", 0, 0
txtLabK:	db	"   Earth Lab. ", 0, 0
txtLabL:	db	"    Wind Lab. ", 0, 0
	times 787Ch-($-$$-SEG_BASE_OFS) db 00h

	; adjust offsets of changed (hardcoded) "saveNamePattern" text
	incbin "MIME.EXE", $, 7963h - ($-$$-SEG_BASE_OFS)
	mov	byte [cs:saveNamePattern+0Fh], al
	jmp	short loc_1C5DF
loc_1C5D9:
	mov	byte [cs:saveNamePattern+0Fh], ' '
loc_1C5DF:
	add	dl, '0'
	mov	byte [cs:saveNamePattern+10h], dl

	incbin "MIME.EXE", $, 79C1h - ($-$$-SEG_BASE_OFS)
Print_Cancel:
	; original string: 8140 8140 8140 8140 8140 8140 8EE6 82E8 8FC1 82B5
	mov	di, txtCancel
	jmp	PrintStr_DI

txtCancel:
	db	"             Cancel ", 0, 0
	times 7A94h-($-$$-SEG_BASE_OFS) db 00h

; --- patch menu selection text ---
	incbin "MIME.EXE", $, 7AD0h - ($-$$-SEG_BASE_OFS)
	mov	dh, 32		; patch from 16x full-width to 32x half-width

	incbin "MIME.EXE", $, 7ADFh - ($-$$-SEG_BASE_OFS)
	push	cx		; save CX, as it is used for counting the menu entries
	push	bx		; save BX, which gets textDrawPtr
	push	di		; save DI - should be unused, but let's be safe
	mov	di, 41C4h
PrintMenuEntry:
	mov	ax, [si]
	cmp	ax, 5C5Ch
	jz	short pme_ret
	
	mov	bx, [es:di]	; save original textDrawPtr value
	call	PrintChar	; draw unselected text (white)
	add	si, cx
	add	dl, cl		; add character width to "menu width counter"
	
	add	bx, byte 28h	; move pointer into "selected text" area
	mov	[es:di], bx	; restore textDrawPtr from BX, so that we advance the text draw pointer only once below
	push	word [es:di+2]
	push	word [es:di+4]
	push	word [cs:020Bh+12h]
	pop	word [es:di+2]
	push	word [cs:020Bh+14h]
	pop	word [es:di+4]
	push	ax
reloc_pme:
	call	PrintSeg:PrintFontChar	; draw selected text (also advances textDrawPtr)
	add	sp, byte 2
	pop	word [es:di+4]
	pop	word [es:di+2]
	sub	word [es:di], byte 28h
	jmp	short PrintMenuEntry

	times 7B3Ch-6-($-$$-SEG_BASE_OFS) db 90h
pme_ret:
	add	si, byte 2	; skip 5C5C
	pop	di
	pop	bx
	pop	cx
	; We must be at 7B3Ch here.

	incbin "MIME.EXE", $, 7B63h - ($-$$-SEG_BASE_OFS)
	shl	dx, 3		; patch from <<4 (*16) to <<3 (*8)


; --- patch scenario script commands, part 2 ---
	incbin "MIME.EXE", $, 825Ah - ($-$$-SEG_BASE_OFS)
; patching scr30_PrintSJIS
	call	PrintStr_SI
	jmp	ScriptMainLoop
	times 827Bh-($-$$-SEG_BASE_OFS) db 90h

	incbin "MIME.EXE", $, 84BEh - ($-$$-SEG_BASE_OFS)
; patching scr3B_PrintVarStr
	call	PrintStr_DI
	jmp	scr_fin_2b
	times 84E8h-($-$$-SEG_BASE_OFS) db 90h

	incbin "MIME.EXE", $, 8BCBh - ($-$$-SEG_BASE_OFS)
; patching scr5D_PrintSJIS
	call	PrintStr_SI
	jmp	ScriptMainLoop
	times 8BECh-($-$$-SEG_BASE_OFS) db 90h

	incbin "MIME.EXE", $, 8C07h - ($-$$-SEG_BASE_OFS)
; patching scr5E_PrintVarStr
	; NOTE: used during fight (highlighted text)
	call	PrintStr_DI
	jmp	scr_fin_2b
	times 8C31h-($-$$-SEG_BASE_OFS) db 90h


	;incbin "MIME.EXE", $, 8F7Bh - ($-$$-SEG_BASE_OFS)
	; The code at 8F7Bh seems to be unused.
	;times 9062h-($-$$-SEG_BASE_OFS) db 90h

	incbin "MIME.EXE", $
