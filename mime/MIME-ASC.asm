; Assembling using NASM:
;	nasm -f bin -o MIME-ASC.EXE -l MIME-ASC.LST "MIME-ASC.asm"
;	This requires a decompressed MIME.EXE (106.576 bytes) to be in the same folder.
;
;	A detailed description of how EXE files work can be found at: https://wiki.osdev.org/MZ

	use16
SEG_BASE_OFS EQU 5160h	; We assume "seg007", whose code begins at offset 5160h in the EXE file.

	org	-SEG_BASE_OFS

RelocDummy EQU 0DCDEh	; unused offset (segment 4C7h, offset 906Eh)

; code segment GfxSeg (seg002)
GfxSeg EQU 0310h
WaitForVSync EQU 0159h

; code segment PrintSeg (seg003)
PrintSeg EQU 0327h
ShiftJIS2JIS EQU 06AFh
PrintFontChar EQU 06D8h

; image copy segment
BlitSeg EQU 03D5h
ImageCopy1 EQU 0668h

; code segment (seg007)
MainCodeSeg EQU 4C7h
tempVars EQU 016Eh
ScriptMemory EQU 020Bh
NameChg_CharTbl EQU 6E16h
ScriptMainLoop EQU 70C0h
scr_fin_2b EQU 72C9h
WaitFrames EQU 8E59h

; data segment (dseg)
DataSeg EQU 0DCEh
plrName_ScrOfs EQU 0662h
textDrawPtr EQU 41C4h


; include EXE header
	incbin "MIME.EXE", 0, 004Eh

; === relocation table patches ===
; include relocation table and patch a few of the EXE relocation entries

	incbin "MIME.EXE", $, 0166h-($-$$)
	dw	RelocDummy, 000h	; originally: scr00_TalkDungeon: mov ax, seg DataSeg
	dw	reloc_ptwait+3, MainCodeSeg	; originally: scr00_TalkDungeon: call GfxSeg:WaitForVSync
	dw	RelocDummy, 000h	; originally: scr00_TalkDungeon: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr00_TalkDungeon: call PrintSeg:PrintFontChar
	incbin "MIME.EXE", $, 017Eh-($-$$)
	dw	RelocDummy, 000h	; originally: scr02_TalkFullScr: mov ax, seg DataSeg
	dw	RelocDummy, 000h	; originally: scr02_TalkFullScr: call GfxSeg:WaitForVSync
	dw	RelocDummy, 000h	; originally: scr02_TalkFullScr: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr02_TalkFullScr: call PrintSeg:PrintFontChar

	incbin "MIME.EXE", $, 01CAh-($-$$)
	; patch Print_NoData calls
	dw	reloc_01+3, MainCodeSeg
	dw	reloc_02+3, MainCodeSeg
	dw	reloc_03+3, MainCodeSeg
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
	dw	reloc_pme+3, MainCodeSeg

	; patch code that executes scripts
	incbin "MIME.EXE", $, 03C2h-($-$$)
	dw	RelocDummy, 000h	; originally: scr30_PrintSJIS: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr30_PrintSJIS: call PrintSeg:PrintFontChar
	incbin "MIME.EXE", $, 03CEh-($-$$)
	dw	RelocDummy, 000h	; originally: scr33_PlrName_AddChr: mov ax, seg DataSeg
	dw	RelocDummy, 000h	; originally: scr33_PlrName_AddChr: call PrintSeg:ShiftJIS2JIS
	dw	RelocDummy, 000h	; originally: scr33_PlrName_AddChr: call PrintSeg:PrintFontChar
	dw	reloc_scr34+3, MainCodeSeg	; originally: scr34_PlrName_DelChr: call BlitSeg:ImageCopy1
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
	db	"**/** **:** Lvl**", 0, 0	; shorten "Level" text to just "Lvl" (save 3 characters)

; patch NameChg_CharTbl with ASCII characters
	incbin "MIME.EXE", $, 6F76h - ($-$$-SEG_BASE_OFS)
	dw	'0', '1', '2', '3', '4'
	incbin "MIME.EXE", $, 6F98h - ($-$$-SEG_BASE_OFS)
	dw	'5', '6', '7', '8', '9'
	incbin "MIME.EXE", $, 6FAEh - ($-$$-SEG_BASE_OFS)
	dw	'A', 'B', 'C', 'D', 'E', 'F', 'G', 8140h, 'H', 'I', 'J', 'K', 'L', 'M', 'N'
	incbin "MIME.EXE", $, 6FD0h - ($-$$-SEG_BASE_OFS)
	dw	'O', 'P', 'Q', 'R', 'S', 'T', 'U', 8140h, 'V', 'W', 'X', 'Y', 'Z'
	incbin "MIME.EXE", $, 6FF2h - ($-$$-SEG_BASE_OFS)
	dw	'a', 'b', 'c', 'd', 'e', 'f', 'g', 8140h, 'h', 'i', 'j', 'k', 'l', 'm', 'n'
	incbin "MIME.EXE", $, 7014h - ($-$$-SEG_BASE_OFS)
	dw	'o', 'p', 'q', 'r', 's', 't', 'u', 8140h, 'v', 'w', 'x', 'y', 'z', 8145h, '.'

; --- patch scenario script commands, part 1 ---
	incbin "MIME.EXE", $, 70D0h - ($-$$-SEG_BASE_OFS)
scr00_TalkDungeon:
	mov	di, 5AB8h	; start writing at (192, 122)
	mov	word [cs:ptLineStep], 5F0h	; 19 lines
	mov	bh, 16*2	; 32 half-width characters per line
	mov	word [cs:ptBrktFunc], pt_brkt_dungeon
	jmp	PrintTalk

ptLineStep EQU tempVars+00h
ptBrktFunc EQU tempVars+02h
ptPtrMem EQU tempVars+04h
pt_end EQU scr_fin_2b

PrintTalk:
	mov	ax, ds
	mov	es, ax		; es = DataSeg
reloc_ptwait:
	call	GfxSeg:WaitForVSync
	xor	dl, dl		; reset flags
	jmp	short pt_line_start

pt_newline:
	add	si, byte 1
pt_nextline:
	add	di, [cs:ptLineStep]
	;jmp	short pt_line_start

pt_line_start:
	mov	[textDrawPtr], di	; NOTE: We assume that "ds" = dataSeg
	xor	bl, bl	; initialize/reset line character counter
pt_loop:
	mov	ax, [es:si]
	cmp	ax, 5C5Ch	; '\\'
	jz	pt_end
	or	al, al		; check for null terminator
	jz	short pt_name_end
	cmp	al, 0Ah		; [not in original game] check for newline character
	jz	short pt_newline
	cmp	ax, 2323h	; '##'
	jz	short pt_name
	
pt_draw:
	call	GetCharType
	add	bl, cl		; advance line character counter
	cmp	bl, bh		; attempting to write beyond line size?
	jg	short pt_nextline	; yes - next line, then try again (signed compare for indent handling)
	
	push	word [cs:ScriptMemory+0Ch]
	call	WaitFrames
	add	sp, byte 2
	
	push	ax
	call	PrintChar
	add	si, cx	; advance text pointer
	pop	ax
	
	cmp	ax, 7A81h	; Shift-JIS closing bracket (817A)
	;jz	short pt_close_brkt
	jnz	short pt_loop
pt_close_brkt:
	jmp	[cs:ptBrktFunc]

pt_name:
	test	dl, 01h
	jnz	pt_draw			; "name mode" already active -> just draw the ## directly
	
	add	si, byte 2
	mov	[cs:ptPtrMem], si	; save actual text pointer
	mov	ax, cs
	mov	es, ax			; ScriptMemory is in the CodeSegment
	mov	si, ScriptMemory+00h	; read name from script memory
	or	dl, 01h			; enable "name mode"
	jmp	short pt_loop

pt_name_end:
	add	si, byte 1
	test	dl, 01h
	jz	short pt_loop		; ignore when not in "name mode"
	
	mov	ax, ds
	mov	es, ax
	mov	si, [cs:ptPtrMem]	; restore actual "text" pointer
	and	dl, ~01h		; disable "name mode"
	jmp	short pt_loop

	times 7174h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 8 bytes

	incbin "MIME.EXE", $, 71DFh - ($-$$-SEG_BASE_OFS)
scr02_TalkFullScr:
	mov	di, 6723h	; start writing at (24, 330)
	mov	word [cs:ptLineStep], 5A0h	; 18 lines
	mov	bh, 37*2	; 74 half-width characters per line
	mov	word [cs:ptBrktFunc], pt_brkt_fullscr
	jmp	PrintTalk

pt_brkt_dungeon:
	mov	ax, [si]
	cmp	ax, 7581h	; check for Shift-JIS 8175
	;jz	short ptbd_indent	; yes - do additional 2-char indent for all following lines
	jnz	pt_nextline
	
ptbd_indent:
	add	di, [cs:ptLineStep]	; move to next line
	mov	[textDrawPtr], di	; set text pointer *without* indent
	
	add	di, byte 2	; then add indent for all following lines
	mov	bl, -2		; set initial line position relative to indented text
	add	bh, bl		; and then reduce the line width
	jmp	pt_loop

pt_brkt_fullscr:
	mov	ax, 7*2
	cmp	bl, al		; X position < 7 full-width characters?
	jl	ptbfs_indent	; (signed compare for indent handling)
	mov	al, bl		; yes - enforce indent of at least 14 characters
ptbfs_indent:
	add	di, ax		; move draw pointer to indent position
	sub	bh, al		; and then reduce the line width
	jmp	pt_line_start	; stay on the same line

	times 72A1h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 128 bytes


; --- patch save game code ---
	incbin "MIME.EXE", $, 7567h - ($-$$-SEG_BASE_OFS)
Print_NoData:
	; original string: 8140 8140 8140 8366 815B 835E 82CD 82A0 82E8 82DC 82B9 82F1
	mov	di, txtNoData
	jmp	PrintStr_DI

txtNoData:
	db	"            No data.", 0, 0
	align	10h, db 00h
	db	"ASCII patch by Valley Bell", 0
	times 75C0h-($-$$-SEG_BASE_OFS) db 00h

; *** custom text drawing routines ***
; I'm inserting them here, because size-optimizing the function freed lots of space.
PrintChar:
	call	GetCharType
	jnc	short pchr_asc
	;jc	pchr_sjis

pchr_sjis:
	push	ax	; reads value from stack
reloc_01:
	call	PrintSeg:ShiftJIS2JIS
	push	ax
reloc_02:
	call	PrintSeg:PrintFontChar
	add	sp, byte 4
	ret

pchr_asc:
	xor	ah, ah
	push	ax
reloc_03:
	call	PrintSeg:PrintFontChar
	add	sp, byte 2
	ret

GetCharType:
	cmp	al, 81h
	jb	short gct_halfwidth	; 00..80 -> ASCII
	cmp	al, 0A0h
	jb	short gct_fullwidth	; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short gct_halfwidth	; A0..DF -> half-width Katakana
	cmp	al, 0FDh
	jb	short gct_fullwidth	; E0xx .. FCxx -> Shift-JIS
	;jnb	short gct_halfwidth	; FD..FF -> half-width

gct_halfwidth:
	xor	ah, ah
	mov	cx, 1
	clc	; clear carry
	ret

gct_fullwidth:
	mov	cx, 2
	stc	; set carry
	ret

; for scr30_PrintSJIS and scr5D_PrintSJIS
; prints text stored at offset <ds:si> until two backslashes (5C5C) occour
PrintStr_SI:
	; Note: Unlike most of the existing code, we assume that register DS = DataSeg.
	;       We can do that without risk, because the script data (read using [SI]) is *also* stored in DataSeg.
	mov	di, [textDrawPtr]
	
	push	cx
pstr_si_loop:
	mov	ax, [si]
	cmp	ax, 5C5Ch	; return on '\\'
	jz	short pstr_si_ret
	cmp	al, 0Ah
	jz	short pstr_si_newline
	
	call	PrintChar
	add	si, cx
	jmp	short pstr_si_loop

pstr_si_newline:
	add	di, 20*80	; 20 lines * 80 bytes per line (Note: This is the line spacing during battles.)
	mov	[textDrawPtr], di
	add	si, byte 1
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
	or	al, al
	jz	short pstr_di_ret	; return on 00h (originally returns on 0000h, but this should be enough)
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
	times 7664h-($-$$-SEG_BASE_OFS) db 00h	; remaining space: 37 bytes

	incbin "MIME.EXE", $, 769Dh - ($-$$-SEG_BASE_OFS)
PrintSaveGameName:
	mov	ax, [cs:6DF6h]	; get save game "floor ID"
	cmp	ax, (txtMazeNamesEnd-txtMazeNames)/2
	jb	short psgn_show_maze
	mov	ax, (txtMazeNamesEnd-txtMazeNames)/2-1
psgn_show_maze:
	add	ax, ax
	mov	di, txtMazeNames
	add	di, ax
	mov	di, [cs:di]	; get maze name from table
	call	PrintStr_DI
	
	mov	di, saveNamePattern
	jmp	PrintStr_DI

txtMazeNames:
	dw	txtMazeC	;  0
	dw	txtMazeD	;  1
	dw	txtMazeD	;  2
	dw	txtMazeD	;  3
	dw	txtMazeE	;  4
	dw	txtMazeF	;  5
	dw	txtMazeG	;  6
	dw	txtMazeH	;  7
	dw	txtMazeI	;  8
	dw	txtMazeJ	;  9
	dw	txtMazeK	; 10
	dw	txtMazeL	; 11
	dw	txtMazeB	; 12
	dw	txtMazeA	; 13+
txtMazeNamesEnd:

		; each text must be 13 characters long, for proper alignment
txtMazeA:	db	"   Holy Maze ", 0, 0
txtMazeB:	db	"   Null Maze ", 0, 0
txtMazeC:	db	"Phantom Maze ", 0, 0
txtMazeD:	db	"   Tree Maze ", 0, 0
txtMazeE:	db	"    Fun Maze ", 0, 0
txtMazeF:	db	"   Tear Maze ", 0, 0
txtMazeG:	db	"    Ash Maze ", 0, 0
txtMazeH:	db	"  Curse Maze ", 0, 0
txtMazeI:	db	"    Sea Maze ", 0, 0
txtMazeJ:	db	"  Flame Maze ", 0, 0
txtMazeK:	db	"  Earth Maze ", 0, 0
txtMazeL:	db	"   Wind Maze ", 0, 0
	times 787Ch-($-$$-SEG_BASE_OFS) db 00h	; remaining space: 240 bytes

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

pndel_var_width:
	mov	dx, bx		; save end address
	mov	bx, ScriptMemory
	cmp	dx, bx
	jbe	near pn_fail	; end address <= start address -> we have nothing to delete
pndel_vw_loop:
	mov	ax, [cs:bx]
	call	GetCharType
	add	bx, cx		; advance character-by-character
	cmp	bx, dx
	jb	short pndel_vw_loop
	sub	bx, cx		; go back by one
	sub	di, cx		; adjust draw pointer
	mov	cx, bx		; keep BX (destination for "clear" operation)
	sub	cx, ScriptMemory	; CX = new name length (without last character)
	mov	[cs:ScriptMemory+0Eh], cl	; save new name length (low byte only, so that flags are kept)
	mov	word [cs:ScriptMemory+6Eh], 1	; save "success" state in variable 55
	jmp	near pndel_delete		; size: 48 bytes

	times 7A94h-($-$$-SEG_BASE_OFS) db 00h	; remaining space: 135 bytes

; --- patch menu selection text ---
	incbin "MIME.EXE", $, 7AD0h - ($-$$-SEG_BASE_OFS)
	mov	dh, 32		; patch from 16x full-width to 32x half-width

	incbin "MIME.EXE", $, 7ADFh - ($-$$-SEG_BASE_OFS)
	push	cx		; save CX, as it is used for counting the menu entries
	push	bx		; save BX, which gets textDrawPtr
	push	di		; save DI - should be unused, but let's be safe
	mov	di, textDrawPtr
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
	push	word [cs:ScriptMemory+12h]
	pop	word [es:di+2]
	push	word [cs:ScriptMemory+14h]
	pop	word [es:di+4]
	push	ax
reloc_pme:
	call	PrintSeg:PrintFontChar	; draw selected text (also advances textDrawPtr)
	add	sp, byte 2
	pop	word [es:di+4]
	pop	word [es:di+2]
	sub	word [es:di], byte 28h
	jmp	short PrintMenuEntry

	times 7B3Ch-6-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 9 bytes
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
scr_printsi:
	call	PrintStr_SI
	jmp	ScriptMainLoop

pndel_var_modes:
	test	dh, 40h
	jnz	near pndel_calc_len	; special "length calculation" function
	jmp	near pndel_var_width	; new "variable width" mode
						; size: 10 bytes (3+4+4)

pn_fail:
	mov	word [cs:ScriptMemory+6Eh], 0	; save "failed" state in variable 55
	jmp	ScriptMainLoop			; size: 10 bytes

	times 827Bh-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 7 bytes

	incbin "MIME.EXE", $, 82C5h - ($-$$-SEG_BASE_OFS)
scr33_PlrName_AddChr:
	mov	di, [cs:ScriptMemory+22h]	; get table cursor X position
	mov	ax, [cs:ScriptMemory+24h]	; get table cursor Y position
	mov	dx, 17
	mul	dx
	add	di, ax		; index = Y * 17 + X
	add	di, di		; index -> offset into 2-byte array
	add	di, NameChg_CharTbl
	mov	ax, [cs:di]	; look up character from "name change character table"
	call	PlrName_Setup
	mov	[textDrawPtr], di	; set screen offset
	jnc	short pnadd_fixed_width
pnadd_var_width:
	; new "variable width" mode
	mov	dl, cl		; save original name length
	call	GetCharType	; get size
	add	dl, cl		; increase name length by CX
	cmp	dl, 8
	ja	near pn_fail
	mov	[cs:ScriptMemory+0Eh], dl	; save new name length (low byte only, so that flags are kept)
	mov	word [cs:ScriptMemory+6Eh], 1	; save "success" state in variable 55
	; fall through
pnadd_fixed_width:
	; "fixed 2-byte width" mode (fallback for original game scripts)
	mov	[cs:bx], ax	; write character to script memory
	call	PrintChar
	jmp	ScriptMainLoop

	times 8310h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 6 bytes
	incbin "MIME.EXE", $, 8310h - ($-$$-SEG_BASE_OFS)
scr34_PlrName_DelChr:
	call	PlrName_Setup
	jc	near pndel_var_modes	; register 7, bit 15 enables "new" modes
pndel_delete:
	mov	word [cs:bx], 0	; set the variable to 0 to clear the character
	
	push	2
	push	di
	push	10h
	push	10h
	push	di
reloc_scr34:
	call	BlitSeg:ImageCopy1
	add	sp, byte 0Ah
	jmp	ScriptMainLoop			; size: 27 bytes (since pndel_delete)

	times 8338h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 6 bytes

	incbin "MIME.EXE", $, 84BEh - ($-$$-SEG_BASE_OFS)
; patching scr3B_PrintVarStr
scr_printdi:
	call	PrintStr_DI
	jmp	scr_fin_2b

PlrName_Setup:
	mov	cx, [cs:ScriptMemory+0Eh]	; get register 7
	add	cx, cx
	pushf	; save carry flag (for switching between 2-byte and multi-byte mode)
	jnc	short pns_sjis
	; bit 15 was set - multi-byte mode
	rcr	cx, 1	; rotate back
	mov	dh, ch	; copy to DH for later evaluation
	xor	ch, ch	; clear high byte so that we can use CX properly
pns_sjis:
	mov	bx, ScriptMemory
	add	bx, cx
	mov	di, plrName_ScrOfs
	add	di, cx
	popf
	ret					; size: 28 bytes

	times 84E8h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 8 bytes

	incbin "MIME.EXE", $, 8BCBh - ($-$$-SEG_BASE_OFS)
; patching scr5D_PrintSJIS
	;call	PrintStr_SI
	;jmp	ScriptMainLoop
	jmp	scr_printsi

pndel_calc_len:
	mov	ax, cs
	mov	es, ax
	mov	bx, ScriptMemory
	mov	di, bx	; start searching at variable 0
	mov	cx, 8+1	; search for at most 8 bytes (+1 to make up for overshoot in success)
	xor	al, al	; search for 0-byte
	cld		; search forward
	repne scasb	; run string search
	sub	di, bx	; caluclate offset
	add	di, 8000h-1	; set bit 15 and subtract 1 (because "repne" always overshoots by 1)
	mov	[cs:bx+0Eh], di	; save length
	jmp	ScriptMainLoop			; size: 30 bytes

	times 8BECh-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 0 bytes

	incbin "MIME.EXE", $, 8C07h - ($-$$-SEG_BASE_OFS)
; patching scr5E_PrintVarStr
	; NOTE: used during fight (highlighted text)
	;call	PrintStr_DI
	;jmp	scr_fin_2b
	jmp	scr_printdi

	times 8C31h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 39 bytes


	;incbin "MIME.EXE", $, 8F7Bh - ($-$$-SEG_BASE_OFS)
	; The code at 8F7Bh seems to be unused.
	;times 9062h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 231 bytes

	incbin "MIME.EXE", $
