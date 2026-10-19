; Nostalgia 1907 main program (NOSMAIN.EXE) - Patch to support ASCII
; Patch developed by Valley Bell, finished 2026-10-14
;
; Assembling using NASM:
;	nasm -f bin -o NOSMAIN-ASC.EXE -l NOSMAIN-ASC.LST "NOSMAIN-ASC.asm"
;	This requires a decompressed NOSMAIN.DEC.EXE (46 512 bytes) to be in the same folder.

; Notes:
;  - The original script engine uses ASCII letters for control codes. (It does not print 1-byte ASCII codes.)
;    I replaced these with alternate code bytes, so that the letters can be used properly.
;  - New control code bytes:
;    - 01h (formerly "w"): don't wait after printing the line
;    - 02h (formerly ";"): continue dialogue with next command
;    - 0Ah: enforce new line

	use16
	cpu	186
CODE_BASE_OFS EQU 00040h
DATA_BASE_OFS EQU 0A690h

tb_baseX EQU 00h	; text box origin X, in pixels
tb_baseY EQU 02h 	; text box origin Y, in pixels
tb_sizeX EQU 04h 	; size X, in glyphs
tb_sizeY EQU 06h 	; size Y, in glyphs
tb_txSzX EQU 08h 	; text glyph size X? (always 18)
tb_txSzY EQU 0Ah 	; text glyph size Y? (always 18)
tb_txPosX EQU 0Ch	; ?? (usually 0)
tb_txPosY EQU 0Eh	; ?? (usually 0)
tb_field_10 EQU 10h	; base 10


	org	-DATA_BASE_OFS

	incbin "NOSMAIN.DEC.EXE", $, 0341h-($-$$-CODE_BASE_OFS)
IsSlowTextEnabled:

	incbin "NOSMAIN.DEC.EXE", $, 628Ch-($-$$-CODE_BASE_OFS)
j_DrawString:

	incbin "NOSMAIN.DEC.EXE", $, 6858h-($-$$-CODE_BASE_OFS)
sub_16858:

	; DrawString_Wait (6988h)
	incbin "NOSMAIN.DEC.EXE", $, 6988h-($-$$-CODE_BASE_OFS)
DrawString_Wait:
	incbin "NOSMAIN.DEC.EXE", $, 69D0h-($-$$-CODE_BASE_OFS)
	cmp	word [0502h], 0
	jz	short dstr_wait_long
	call	sub_16858
	test	al, 1
	jz	short dstr_wait_long
	
dstr_wait_short:
	mov	ax, 1
	jmp	short dstr_wait_common
dstr_wait_long:
	mov	ax, 4/2		; increase drawing speed, so that half-width characters show up in an acceptable time
dstr_wait_common:
	push	ax
	call	WaitFrames	; wait 1 or 4 frames
	;add	sp, byte 2
	mov	sp, bp
	pop	bp
	retn
	; free space: 9 bytes
	; possible more intelligent waiting:
	; - XOR [bp+var_2] with [cs:txtPixPosX]
	; - then apply AND ~1
	; - then result != 0, wait, else skip
	times 69F8h-($-$$-CODE_BASE_OFS) db 90h


	; DrawText_Name / DrawText_Tb2a (69F8h)
	; used for character names in the dialog box
	incbin "NOSMAIN.DEC.EXE", $, 6A0Ch-($-$$-CODE_BASE_OFS)
	mov	word [bp-0Eh], 7*2	; remaining width of the name: 7x full-width
	times 6A11h-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "NOSMAIN.DEC.EXE", $, 6A84h-($-$$-CODE_BASE_OFS)
dt_name_mainloop:
	
	incbin "NOSMAIN.DEC.EXE", $, 6A8Ah-($-$$-CODE_BASE_OFS)
	mov	ax, ds
	mov	es, ax
	mov	si, [bp+04h]	; arg_textData
	add	si, [bp-10h]	; dataOfs
	lea	di, [bp-0Ch]	; buffer
	call	CopyCharToBuffer
	mov	[bp-02h], cx	; bufLen
	jz	short dt_name_strend
	;jnz	short dt_name_drawchr
dt_name_drawchr:
	push	cx	; save later use [not a function parameter]
	push	di		; function parameter + backup
	call	DrawString_Wait
	pop	di
	pop	cx
	sub	word [bp-0Eh], cx	; [bp-0Eh] = remWidth
	jg	short dt_name_mainloop	; exit early when going over the maximum name length

dt_name_strend:
	mov	byte [di], ' '	; We will draw spaces to fill up the name.
	mov	byte [di+1], 0	; (The original games does this as well, but uses full-width spaces 8140h instead.)
	mov	cx, [bp-0Eh]	; [bp-0Eh] = remWidth
	or	cx, cx
	jle	short dt_name_fin
dt_name_pad_loop:
	push	cx
	push	di		; function parameter + backup
	call	DrawString_Wait
	pop	di
	pop	cx
	dec	cx
	jnz	dt_name_pad_loop
	; fall through
dt_name_fin:
	mov	word [TextBoxes + 12h*2 + tb_txPosX], 7*2	; set X position after padding
	mov	word [0B10h], 1
	pop	si
	mov	sp, bp
	pop	bp
	retn

CopyCharToBuffer:
	push	di
	mov	cx, di
	mov	al, [si]
	or	al, al
	jz	short cctb_ret	; 00 terminator byte - stop immediately
	cld
	movsb	; copy 1st byte (DS:SI -> ES:DI)
	
	cmp	al, 80h
	jb	short cctb_ret
	cmp	al, 0EBh
	jnb	short cctb_ret
	movsb	; double-byte character: copy 2nd byte
	
cctb_ret:
	mov	[es:di], byte 00h	; write 00 terminator byte to buffer
	sub	cx, di
	neg	cx
	pop	di	; restore initial DI, so that the parent functions can reuse it
	retn

	times 6AF8h-1-($-$$-CODE_BASE_OFS) db 90h
	db	0, "Patch by Valley Bell", 0
	
	times 6B10h-($-$$-CODE_BASE_OFS) db 90h

	; DrawText_Dialog / DrawText_Tb2b (6B10h)
	; used for speech in the dialog box
	incbin "NOSMAIN.DEC.EXE", $, 6B53h-($-$$-CODE_BASE_OFS)
	mov	byte [bp-03h], 00h	; set "no wait" flag
dt_dlg_main_loop:	; loc_16B53
	cmp	byte [050Ch], 0	; check stopDialogDraw
	jnz	short j_dt_dlg_fin
	mov     ax, [bp-02h]	; bufLen
	add     [bp-0Eh], ax	; dataOfs
	push	ds
	mov	ax, ds
	mov	es, ax
	lea	di, [bp-0Ch]	; buffer
	mov	ax, [bp-0Eh]	; dataOfs
	lds	si, [bp+04h]	; arg_textData [Note: also sets DS!]
	add	si, ax
	call	CopyCharToBuffer
	pop	ds
	mov	[bp-02h], cx	; bufLen
	jnz	short dt_dlg_check_ctrl
j_dt_dlg_fin:
	jmp	near dt_dlg_fin

dt_dlg_check_ctrl:
	mov	al, [di]
	cmp	al, 0Ah
	jz	short dt_dlg_ctrl_newline
	cmp	al, 02h		; [CHANGED] was originally checking ';'
	jz	short dt_dlg_ctrl_continuation
	cmp	al, 01h		; [CHANGED] was originally checking 'w' and 'W'
	jz	short dt_dlg_ctrl_nowait
	jmp	short dt_dlg_linex_check

dt_dlg_ctrl_newline:
	mov	ax, [TextBoxes + 12h*2 + tb_sizeX]
	mov	[TextBoxes + 12h*2 + tb_txPosX], ax
	jmp	short dt_dlg_main_loop

dt_dlg_ctrl_continuation:
	mov	byte [0B10h], 1	; dialogHasName
	jmp	short dt_dlg_main_loop

dt_dlg_ctrl_nowait:
	mov	byte [bp-03h], 01h	; set "no wait" flag
	jmp	short dt_dlg_main_loop

	times 6BA7h+7-($-$$-CODE_BASE_OFS) db 90h
dt_dlg_linex_check:
	mov	ax, [TextBoxes + 12h*2 + tb_txPosX]
	add	ax, cx
	cmp	ax, [TextBoxes + 12h*2 + tb_sizeX]
	jle	short dt_dlg_drawchr
	; automatic line break when the character-to-draw would exceed the line size
	times 6BB9h-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "NOSMAIN.DEC.EXE", $, 6BE0h-($-$$-CODE_BASE_OFS)
	mov	word [TextBoxes + 12h*2 + tb_txPosX], 15	; adjust indent X position (text box data) [x=8 full-width -> x=15 half-width]
	incbin "NOSMAIN.DEC.EXE", $, 6BF7h-($-$$-CODE_BASE_OFS)
	call	dt_dlg_mul_with_pos				; adjust indent X position calculation (sizeX*8 -> sizeX*tb_txPosX)
	times 6BFBh-($-$$-CODE_BASE_OFS) db 90h
	incbin "NOSMAIN.DEC.EXE", $, 6C19h-($-$$-CODE_BASE_OFS)
	mov	word [TextBoxes + 12h*2 + tb_txPosX], 15	; adjust indent X position (text box data) [x=8 full-width -> x=15 half-width]
	incbin "NOSMAIN.DEC.EXE", $, 6C22h-($-$$-CODE_BASE_OFS)
	call	dt_dlg_mul_with_pos				; adjust indent X position calculation (sizeX*8 -> sizeX*tb_txPosX)
	times 6C26h-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "NOSMAIN.DEC.EXE", $, 6C38h-($-$$-CODE_BASE_OFS)
dt_dlg_drawchr:
	lea	di, [bp-0Ch]	; buffer
	push	di		; function parameter
	call	DrawString_Wait
	add	sp, byte 2
	mov	cx, [bp-02h]	; bufLen
	add	[TextBoxes + 12h*2 + tb_txPosX], cx
	jmp	dt_dlg_main_loop

dt_dlg_fin:
	cmp	byte [0B10h], 0	; dialogHasName
	jnz	short loc_16C87
	
	cmp	byte [bp-03h], 00h	; check "no wait" flag
	jnz	short loc_16C81
	
	call	IsSlowTextEnabled
	or	ax, ax
	jnz	short loc_16C81
	
	push	word 2		; text box ID
	call	WaitForInput
	add	sp, byte 2
	
loc_16C81:
	mov	word [0F18h], 0	; dlgTextYPos
loc_16C87:
	pop	si
	mov	sp, bp
	pop	bp
	retn

dt_dlg_mul_with_pos:	; function size: 7 bytes
	mov	cx, [TextBoxes + 12h*2 + tb_txPosX]
	mul	cx
	retn

get_tbox_glyph_width:	; function size: 5 bytes
	mov	ax, [si+TextBoxes+tb_txSzX]	; read glyph size from text box (instead of hardcoded 18)
	retn

	times 6C8Ch-($-$$-CODE_BASE_OFS) db 90h



	; DrawText_Tb1a (6C8Ch)
	incbin "NOSMAIN.DEC.EXE", $, 6CD2h-($-$$-CODE_BASE_OFS)
dt_tb1a_main_loop:
	incbin "NOSMAIN.DEC.EXE", $, 6CD8h-($-$$-CODE_BASE_OFS)
	mov	ax, ds
	mov	es, ax
	mov	si, [bp+04h]	; arg_textData
	add	si, [bp-16h]	; dataOfs
	lea	di, [bp-0Ch]	; buffer
	call	CopyCharToBuffer
	mov	[bp-02h], cx	; bufLen
	jnz	short dt_tb1a_check_ctrl
	jmp	near dt_tb1a_fin

dt_tb1a_check_ctrl:
	mov	al, [di]
	cmp	al, 0Ah
	jz	short dt_tb1a_nextline
	jmp	short dt_tb1a_linex_check
	

	times 6D1Ch-11-($-$$-CODE_BASE_OFS) db 90h
dt_tb1a_linex_check:
	mov	ax, [bp-14h]	; relPosX; Note: can't compare against [TextBoxes + 12h*1 + tb_txPosX], because it is not properly reset on line breaks
	add	ax, cx
	cmp	ax, [TextBoxes + 12h*1 + tb_sizeX]
	jle	short dt_tb1a_drawchr
	; automatic line break when the character-to-draw would exceed the line size
	times 6D1Ch-($-$$-CODE_BASE_OFS) db 90h
dt_tb1a_nextline:

	incbin "NOSMAIN.DEC.EXE", $, 6D7Dh-($-$$-CODE_BASE_OFS)
dt_tb1a_drawchr:
	lea	di, [bp-0Ch]	; buffer
	push	di		; function parameter
	call	DrawString_Wait
	add	sp, byte 2
	mov	cx, [bp-02h]	; bufLen
	add	[bp-14h], cx	; relPosX
	add	[TextBoxes + 12h*1 + tb_txPosX], cx
	jmp	dt_tb1a_main_loop
	
	times 6D9Ah-($-$$-CODE_BASE_OFS) db 90h
	incbin "NOSMAIN.DEC.EXE", $, 6D9Ah-($-$$-CODE_BASE_OFS)
dt_tb1a_fin:
	mov	bx, 12h		; set text box offset
	jmp	near dt_tbna_retlines	; Note: works, because relPosY is at the same stack offset [bp-12h] as in DrawText_TbNa
	times 6DB6h-($-$$-CODE_BASE_OFS) db 90h


	; DrawTBoxBorder (6DB6h)
	incbin "NOSMAIN.DEC.EXE", $, 6E11h-($-$$-CODE_BASE_OFS)
	call	get_tbox_glyph_width	; replaces the hardcoded glyph size X of 18
	times 6E14h-($-$$-CODE_BASE_OFS) db 90h
	incbin "NOSMAIN.DEC.EXE", $, 6E5Bh-($-$$-CODE_BASE_OFS)
	call	get_tbox_glyph_width	; replaces the hardcoded glyph size X of 18
	times 6E5Eh-($-$$-CODE_BASE_OFS) db 90h

	; CopyTextBuffer2 (6F09h)
	;incbin "NOSMAIN.DEC.EXE", $, 6F23h-($-$$-CODE_BASE_OFS)
	; This needs to stay as-is, or the selection text will break.


	; Note: Both TBoxBuf_* functions need to be patched the same way,
	;       or text drawn by DrawText_TbNa will be corrupt.
	; TBoxBuf_Scr2Buf (6F52h)
	incbin "NOSMAIN.DEC.EXE", $, 6F86h-($-$$-CODE_BASE_OFS)
	mov	ax, [si+TextBoxes+tb_txSzX]	; read glyph size from text box (instead of hardcoded 18)
	imul	word [si+TextBoxes+tb_sizeX]
	cwd	; DX = sign(AX)
	times 6F92h-($-$$-CODE_BASE_OFS) db 90h

	; TBoxBuf_Buf2Scr (6FCDh)
	incbin "NOSMAIN.DEC.EXE", $, 7001h-($-$$-CODE_BASE_OFS)
	mov	ax, [si+TextBoxes+tb_txSzX]	; read glyph size from text box (instead of hardcoded 18)
	imul	word [si+TextBoxes+tb_sizeX]
	cwd	; DX = sign(AX)
	times 700Dh-($-$$-CODE_BASE_OFS) db 90h

	; DrawTextF_Opts (7209h)
	incbin "NOSMAIN.DEC.EXE", $, 7243h-($-$$-CODE_BASE_OFS)
	mov	ax, [bp+04h]	; get X position in characters
	add	ax, ax		; count(full-width) -> count(half-width)
	times 7249h-($-$$-CODE_BASE_OFS) db 90h


	; DrawText_TbNa (7263h)
	; used for location names + selection text
	incbin "NOSMAIN.DEC.EXE", $, 72BCh-($-$$-CODE_BASE_OFS)
	mov	ax, ds
	mov	es, ax
	mov	si, [bp+04h]	; arg_textData
	add	si, [bp-16h]	; dataOfs
	lea	di, [bp-0Ch]	; buffer
	call	CopyCharToBuffer
	mov	[bp-02h], cx	; bufLen
	jnz	short dt_tbna_drawchr
	jmp	near dt_tbna_fin
dt_tbna_drawchr:
	mov	ax, 12h
	imul	word [bp+06h]	; bp+06h = arg_tBoxID
	mov	si, ax
	
	mov	al, [di]
	cmp	al, 0Ah		; [NEW] check for newline character '\n'
	jz	short dt_tbna_nextline
	
	push	si	; save for later
	push	di		; function parameter
	call	j_DrawString
	add	sp, byte 2
	pop	si
	
	; add string size to X position values
	mov	cx, [bp-02h]	; get string length
	add	word [bp-14h], cx	; bp-14h = relPosX
	add	word [si+TextBoxes+tb_txPosX], cx
	add	word [bp-18h], cx	; bp-18h = var_18
	jmp	short dt_tbna_linex_check
	
	times 72FCh-1-($-$$-CODE_BASE_OFS) db 90h
	db	0, "Proudly made with human intelligence", 0
	
	times 7324h-($-$$-CODE_BASE_OFS) db 90h
dt_tbna_linex_check:
	mov	ax, [bp-14h]
	cmp	ax, [si+TextBoxes+tb_sizeX]	; relPosX < text box size X?
	jb	short loc_1737E		; yes - skip
	; else do a line break
dt_tbna_nextline:
	
	incbin "NOSMAIN.DEC.EXE", $, 737Eh-($-$$-CODE_BASE_OFS)
loc_1737E:
	incbin "NOSMAIN.DEC.EXE", $, 7381h-($-$$-CODE_BASE_OFS)
dt_tbna_fin:
	
	incbin "NOSMAIN.DEC.EXE", $, 73ECh-($-$$-CODE_BASE_OFS)
dt_tbna_retlines:
	
	incbin "NOSMAIN.DEC.EXE", $, 73F2h-($-$$-CODE_BASE_OFS)
	; The original code would count characters [bp-18h] and calculate the number of lines based on that.
	; In the patched code, we just return the line counter directly.
	times 73FEh-($-$$-CODE_BASE_OFS) db 90h
	mov	ax, [bp-12h]	; relPosY
	times 7401h-($-$$-CODE_BASE_OFS) db 90h


	; ScrollTextOutUp (746Fh)
	incbin "NOSMAIN.DEC.EXE", $, 74A3h-($-$$-CODE_BASE_OFS)
	call	get_tbox_glyph_width

	; sub_17556 (7556h)
	incbin "NOSMAIN.DEC.EXE", $, 7599h-($-$$-CODE_BASE_OFS)
	call	get_tbox_glyph_width

	; sub_17857 (7857h)
	incbin "NOSMAIN.DEC.EXE", $, 788Bh-($-$$-CODE_BASE_OFS)
	call	get_tbox_glyph_width

	; sub_17C04 (7C04h)
	incbin "NOSMAIN.DEC.EXE", $, 7C4Dh-($-$$-CODE_BASE_OFS)
	mov	cx, 108/2	; patch text buffer size factor
	times 7C50h-($-$$-CODE_BASE_OFS) db 90h

	incbin "NOSMAIN.DEC.EXE", $, 7CD8h-($-$$-CODE_BASE_OFS)
WaitFrames:

	incbin "NOSMAIN.DEC.EXE", $, 7E48h-($-$$-CODE_BASE_OFS)
WaitForInput:

	incbin "NOSMAIN.DEC.EXE", $, 0B12h-($-$$-DATA_BASE_OFS)
TextBoxes:
	;	 baseX/Y 	sizeX/Y 	glyphX/Y 	posX/Y	??
	dw	 33,  12,	20*2,  2,	18/2, 18,	0, 0,	0	; text box 0 (location name)
	dw	498,  25,	 7*2,  7,	18/2, 18,	0, 0,	0	; text box 1 (selections)
	dw	 80, 262,	28*2,  6,	18/2, 18,	0, 0,	0	; text box 2 (dialogues)
	dw	536, 180,	 5*2,  4,	18/2, 18,	0, 0,	0	; text box 3
	dw	536, 156,	 6*2,  2,	18/2, 18,	0, 0,	0	; text box 4
	dw	502, 184,	 7*2,  3,	18/2, 18,	0, 0,	0	; text box 5
	dw	  0,   0,	35*2, 22,	18/2, 18,	0, 0,	0	; text box 6 (customizable)

	;incbin "NOSMAIN.DEC.EXE", $, 8F7Bh - ($-$$-SEG_BASE_OFS)
	; The code at 8F7Bh seems to be unused.
	;times 9062h-($-$$-SEG_BASE_OFS) db 90h	; remaining space: 231 bytes

	incbin "NOSMAIN.DEC.EXE", $
