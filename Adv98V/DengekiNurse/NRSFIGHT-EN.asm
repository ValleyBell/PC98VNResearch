; Dengeki Nurse Battle Program (NRSFIGHT.CMD) - English Translation
; Patch developed by Valley Bell, finished on 2026-04-30
; Translation by Geometrizer, edited by trentsignia
;
; Assembling using NASM:
;	nasm -f bin -o NRSFIGHT-EN.CMD -l NRSFIGHT-EN.LST "NRSFIGHT-EN.asm"
;	This requires NRSFIGHT.CMD (35 088 bytes) to be in the same folder.

	use16
	cpu	186
CODE_BASE_OFS EQU 0400h
DATA_BASE_OFS EQU 50D0h	; 0400h+4CD0h

	org	-DATA_BASE_OFS

	; LoadD1CVC (1965h)
	incbin "NRSFIGHT.CMD", $, 1972h - ($-$$-CODE_BASE_OFS)
	mov	si, fnListD1CVC
	
	; LoadD1ENMF (1983h)
	incbin "NRSFIGHT.CMD", $, 1990h - ($-$$-CODE_BASE_OFS)
	mov	si, fnListD1Enm
	
	; LoadD1CVC6 (19A2h)
	incbin "NRSFIGHT.CMD", $, 19AAh - ($-$$-CODE_BASE_OFS)
	mov	dx, fnD1CVC6
	
	; sub_11BF5 (11B5h)
	incbin "NRSFIGHT.CMD", $, 1C03h - ($-$$-CODE_BASE_OFS)
	add	bx, word_1500A
	
	; ShowActionText (1C83h)
	incbin "NRSFIGHT.CMD", $, 1C94h - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_Actions
	incbin "NRSFIGHT.CMD", $, 1CA0h - ($-$$-CODE_BASE_OFS)
	mov	si, tListActions
	
	; ClearMessageBox (1CB4h)
	incbin "NRSFIGHT.CMD", $, 1CBBh - ($-$$-CODE_BASE_OFS)
	; clear 27 bytes per line (originally 26) to prevent
	; graphics glitches for lines that end with "m" or "w"
	; (e.g. Magenta's "Hoh, that really hurt! Now[LINE END]I'm pissed!")
	mov	dx, 27
	
	; ShowStat_HP (1CC5h)
	incbin "NRSFIGHT.CMD", $, 1CD9h - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_HP
	incbin "NRSFIGHT.CMD", $, 1CE7h - ($-$$-CODE_BASE_OFS)
	mov	si, txtHealth
	;incbin "NRSFIGHT.CMD", $, 1CEDh - ($-$$-CODE_BASE_OFS)
	;mov	si, aNumBuffer1	; 36B6h
	
	; ShowStat_Atk (1CFBh)
	incbin "NRSFIGHT.CMD", $, 1D0Fh - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_Atk
	incbin "NRSFIGHT.CMD", $, 1D1Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txtAttack
	;incbin "NRSFIGHT.CMD", $, 1D23h - ($-$$-CODE_BASE_OFS)
	;mov	si, aNumBuffer1	; 36B6h
	
	; ShowStat_Def (1D31h)
	incbin "NRSFIGHT.CMD", $, 1D45h - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_Def
	incbin "NRSFIGHT.CMD", $, 1D53h - ($-$$-CODE_BASE_OFS)
	mov	si, txtDefense
	;incbin "NRSFIGHT.CMD", $, 1D59h - ($-$$-CODE_BASE_OFS)
	;mov	si, aNumBuffer1	; 36B6h
	
	; ShowMessageText (1DAFh)
	incbin "NRSFIGHT.CMD", $, 1DBAh - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_Msg
	incbin "NRSFIGHT.CMD", $, 1DC0h - ($-$$-CODE_BASE_OFS)
	mov	si, tListMessages
	
	; ShowChat1Text (1DD0h)
	incbin "NRSFIGHT.CMD", $, 1DDBh - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_PlrChat
	incbin "NRSFIGHT.CMD", $, 1DE1h - ($-$$-CODE_BASE_OFS)
	mov	si, tListPlayer
	
	; ShowChat2Text (1DF1h)
	incbin "NRSFIGHT.CMD", $, 1DFCh - ($-$$-CODE_BASE_OFS)
	mov	si, tCoord_EnmChat
	incbin "NRSFIGHT.CMD", $, 1E02h - ($-$$-CODE_BASE_OFS)
	mov	si, tListEnemy
	
	; SetDirectionText (298Fh)
	incbin "NRSFIGHT.CMD", $, 299Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txtDirections
	;incbin "NRSFIGHT.CMD", $, 29A4h - ($-$$-CODE_BASE_OFS)
	;mov	si, aDirBuffer	; 36C4h
	incbin "NRSFIGHT.CMD", $, 29A2h - ($-$$-CODE_BASE_OFS)
	mov	si, [si]
	mov	al, 2
	call	SetSavedTxtPtr	; instead of copying into aDirBuffer, directly set the pointer to the new text
	popa
	retn
	times 29ABh-($-$$-CODE_BASE_OFS) db 90h

	; DrawInt_3DigSpc (29EBh)
	incbin "NRSFIGHT.CMD", $, 2A04h - ($-$$-CODE_BASE_OFS)
	mov	bx, 824Fh	; number type: full-width

	; DrawInt_NoPad (2A22h)
	incbin "NRSFIGHT.CMD", $, 2A22h - ($-$$-CODE_BASE_OFS)
; Modify the function to draw numbers as half-width ASCII.
; (The original code would draw full-width numbers.)
DrawInt_NoPad:
	pusha
	mov	cx, 4		; 3x half-width = 3 bytes + 1 byte terminator
loc_12A28:
	mov	[si], ch	; make text string empty
	inc	si
	loop	loc_12A28
	sub	si, byte 2
	
	mov	bx, 0030h	; number type: ASCII
	cmp	ax, 100
	jb	short loc_12A3D
	call	DrawDigit_FW	; draw last digit
loc_12A3D:
	dec	si
	cmp	ax, 10
	jb	short loc_12A48
	call	DrawDigit_FW	; draw 2nd-to-last digit
loc_12A48:
	dec	si
	call	DrawDigit_FW	; draw first digit
	popa
	retn
	times 2A50h-($-$$-CODE_BASE_OFS) db 90h

	incbin "NRSFIGHT.CMD", $, 2A50h - ($-$$-CODE_BASE_OFS)
DrawDigit_FW:
	push	dx
	call	Div10
	add	dx, bx
	js	short ddig_fw
ddig_hw:
	mov	[si], dl
	jmp	short ddig_fin
ddig_fw:
	xchg	dh, dl
	mov	[si], dx
	xchg	dh, dl
ddig_fin:
	mov	ax, cx
	pop	dx
	retn

	times 2A71h-($-$$-CODE_BASE_OFS) db 90h
Div10:

; --- inject custom text code ---
	; DrawText (2D26h)
	incbin "NRSFIGHT.CMD", $, 2DE7h - ($-$$-CODE_BASE_OFS)
	call	DrawSavedAndLineCheck	; originally: call DrawSavedText

	incbin "NRSFIGHT.CMD", $, 2E23h - ($-$$-CODE_BASE_OFS)
	; Original code:
	; xchg	dh, dl
	; call	WaitFrames
	; call	DoKeyboardThing
	; call	DrawTextChar
	; add	si, byte 2
	; add	di, byte 2
	
	; New code:
	call	CheckForLineBreak
	call	DoKeyboardThing
	push	di
	call	dtc_newdraw
	pop	ax
	call	dtc_16px_wait
dtc_draw_fin:
	times 2E34h-($-$$-CODE_BASE_OFS) db 90h

	incbin "NRSFIGHT.CMD", $, 2E71h - ($-$$-CODE_BASE_OFS)
DrawSavedText:
	incbin "NRSFIGHT.CMD", $, 2E8Fh - ($-$$-CODE_BASE_OFS)
DrawTextChar:
	incbin "NRSFIGHT.CMD", $, 2EA5h - ($-$$-CODE_BASE_OFS)
SetSavedTxtPtr:
	incbin "NRSFIGHT.CMD", $, 2EC2h - ($-$$-CODE_BASE_OFS)
DoKeyboardThing:
	incbin "NRSFIGHT.CMD", $, 47BCh - ($-$$-CODE_BASE_OFS)
GetChrData:
	incbin "NRSFIGHT.CMD", $, 47C8h - ($-$$-CODE_BASE_OFS)
biosGetCharData:
	
	incbin "NRSFIGHT.CMD", $, 47F7h - ($-$$-CODE_BASE_OFS)
GetBlock16:
	; inside GetBlock16:
	incbin "NRSFIGHT.CMD", $, 480Bh - ($-$$-CODE_BASE_OFS)
	jmp	gblk_8or16	; jump to custom code that handles half-width properly
	times 4812h-($-$$-CODE_BASE_OFS) db 90h

	incbin "NRSFIGHT.CMD", $, 4812h - ($-$$-CODE_BASE_OFS)
MakeBold_16x16:
	incbin "NRSFIGHT.CMD", $, 48CCh - ($-$$-CODE_BASE_OFS)
Draw16x16:
	incbin "NRSFIGHT.CMD", $, 4AFFh - ($-$$-CODE_BASE_OFS)
WaitFrames:


	incbin "NRSFIGHT.CMD", $, 4B36h - ($-$$-CODE_BASE_OFS)
	; The area 4B36..4CDF seems to be unused.

DrawSavedAndLineCheck:
	call	CheckForLineBreak
	jmp	DrawSavedText

dtc_newdraw:
	cmp	dl, 81h
	jb	short dtc_draw_1byte
	cmp	dl, 0A0h
	jb	short dtc_draw_shiftjis
	cmp	dl, 0E0h
	jb	short dtc_draw_1byte
	; fall through
dtc_draw_shiftjis:
	xchg	dh, dl
	call	DrawTextChar
	
	mov	dx, word [3CF4h]	; get character height + width as determined by BIOS call
	xor	ah, ah
	mov	al, dl
	add	si, ax		; increase text data pointer using character size
	mov	al, dh
	add	di, ax		; increase screen pointer using character width
	ret

dtc_draw_1byte:
	xor	dh, dh
	add	dl, dl		; bit 7 -> carry
	adc	dh, 29h		; ASCII (20..7F) -> page 09h, half-width Katakana (A0..DF) -> page 0Ah
	shr	dl, 1		; revert additon
	
DrawTextChar_1B:
	push	si
	push	ds
	
	mov	si, 39D2h
	; Note: The Adv98V function for ShiftJIS -> JIS does not handle with single-byte characters
	;       and just returns 0 for them.
	call	biosGetCharData
	call	GetBlock16
	call	MakeBold_16x16
	call	Draw16x16
	
	pop	ds
	pop	si
	
	inc	si
	inc	di
	ret

dtc_16px_wait:
	xor	ax, di
	and	ax, ~0001h	; mask out "8-pixel" steps, keeping only 16px and more
	jz	short dtc16w_nowait
	; Wait only when the screen position is different from before.
	; We take only 16-pixel steps into account, so that the drawing speed
	; of full-width and half-width characters is consistent.
	call	WaitFrames
dtc16w_nowait:
	ret

; These comments contain the unpatched part of GetBlock16.
;GetBlock_8or16:
;	pusha
;	push	ds
;	push	es
;	mov	di, ds
;	mov	es, di
;	mov	di, si
;	mov	si, seg001
;	mov	ds, si
;	mov	si, 3CF6h
;	mov	cx, 10h
gblk_8or16:
	mov	al, byte [3CF5h]	; get character width
	cmp	al, 2
	jae	gblk_16	; character size == 2 -> jump

gblk_8:
	xor	ah, ah
gblk_8_loop:
	lodsb	; AL = [SI]
	stosw	; [DI] = AX (i.e. 00AL)
	dec	cl
	jnz	gblk_8_loop
	pop	es
	pop	ds
	popa
	retn

gblk_16:
	cld
	rep movsw
	pop	es
	pop	ds
	popa
	retn

CheckForLineBreak:
	; General idea:
	; - check whether or not we are "@X27" -> no = return (line break code is only for the text box in the centre)
	; - keep track of the last character type ([20h, 8140h] = space, all else = letter)
	; - on transition from "space" to "letter":
	;   - estimate length of next word (control character 00..12 = immediate word end, 13h/14h = assume length 3 for number string)
	;   - if (YPos+WordSize) > 26 -> break line (code like dtxt0D_linebrk)
	;   - then continue drawing text as usual
	mov	ax, word [es:39F4h]	; get [es:dtxtPosX]
	cmp	ax, 27
	jnz	short cflb_ret	; only continue when printing to the text box in the centre
	
	mov	al, byte [es:36C7h]
	add	al, al		; shift previous "space" flag (bit 0) into bit 1
	
	cmp	dl, 20h		; check for ASCII space
	jz	short cflb_space
	cmp	dx, 4081h	; check for full-width space
	jz	short cflb_space
	cmp	dx, 4086h	; check for non-breaking space (in case we missed breaking there somehow)
	jz	short cflb_space
	jmp	short cflb_nospace
cflb_space:
	inc	al
cflb_nospace:
	and	al, 03h
	mov	byte [es:36C7h], al
	cmp	al, 02h	; transition "space" -> "letter"
	jnz	short cflb_ret
cflb_wordcheck:
	call	CalcWordWidth
	
	add	ax, di	; +(DI-BP) == add Y position relative to text box
	sub	ax, bp
	cmp	ax, 26	; current Y position + word size > 26?
	ja	short cflb_break	; yes - do line break
	or	ax, ax
	jnz	short cflb_ret
	; when the word is 0 characters long, revert the transition
	mov	al, byte [es:36C7h]
	shr	al, 1
	mov	byte [es:36C7h], al
	retn

cflb_break:
	add	bp, 80*16			; line base address += 80 [8-pixel blocks per line] * 16 [lines per character]
	add	word [es:39F6h], byte 16	; es:dtxtPosY += 16 lines (move to next line)
	mov	di, bp				; write to new position
	mov	word [es:39F2h], di		; set dtxtAddr
cflb_ret:
	retn

CalcWordWidth:
	push	cx
	push	si
	xor	cx, cx
cww_loop:
	mov	ax, [si]
	or	al, al
	jz	short cww_str_end	; terminator character
	cmp	al, 20h
	jz	short cww_word_end	; ASCII space -> word end
	cmp	ax, 4081h
	jz	short cww_word_end	; full-width space -> word end
	; Note: 8640h is treated as non-breaking space.
	cmp	al, 40h
	jz	short cww_word_end	; @ is a control code
	cmp	al, 10h
	jb	short cww_word_end	; quit on control characters
	cmp	al, 15h
	jb	short cww_str_ref	; 10..15 - string reference
	cmp	al, 81h
	jb	short cww_1byte
	cmp	al, 0A0h
	jb	short cww_shiftjis
	cmp	al, 0E0h
	jb	short cww_1byte
	; fall through
cww_shiftjis:
	add	si, byte 2
	xchg	ah, al
	cmp	ax, 8540h
	jb	short cww_width2
	cmp	ax, 869Fh
	jb	short cww_width1
	; fall through
cww_width2:
	add	cx, byte 2
	jmp	short cww_loop

cww_1byte:
	inc	si
cww_width1:
	inc	cx
	jmp	short cww_loop

cww_str_ref:
	inc	si
	
	xor	ah, ah
	sub	al, 10h
	shl	ax, 2
	push	ds
	push	si
	mov	si, 39FAh	; SavedTextPtrs
	add	si, ax
	lds	si, [si]	; DS:SI = *SavedTextPtrs[AL-10h]
	call	CalcWordWidth
	pop	si
	pop	ds
	pushf
	add	cx, ax
	popf
	jnc	short cww_end	; carry clear - sub-string parsing ended with "word end", so exit
	jmp	short cww_loop	; carry set - the sub-string ended with 00h, so we need to continue counting in the main text

cww_str_end:
	stc
	jmp	short cww_end
cww_word_end:
	clc
cww_end:
	mov	ax, cx
	pop	si
	pop	cx
	retn

%assign data_space CODE_BASE_OFS+4CD0h-($-$$)
%warning [Debug] Code segment: data_space bytes remaining
	times 4CD0h-($-$$-CODE_BASE_OFS) db 90h


	incbin "NRSFIGHT.CMD", $, 0124h - ($-$$-DATA_BASE_OFS)
fnListD1CVC:	; 0124h
	DW	fnD1CVC00
	DW	fnD1CVC01
	DW	fnD1CVC02
	DW	fnD1CVC03
	DW	fnD1CVC04
fnD1CVC00:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC1.GPC", 0
fnD1CVC01:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC2.GPC", 0
fnD1CVC02:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC3.GPC", 0
fnD1CVC03:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC4.GPC", 0
fnD1CVC04:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC5.GPC", 0

fnListD1Enm:	; 019Ch
	DW	fnD1Enm00
	DW	fnD1Enm00
	DW	fnD1Enm02
	DW	fnD1Enm03
	DW	fnD1Enm04
	DW	fnD1Enm05
	DW	fnD1Enm06
	DW	fnD1Enm07
	DW	fnD1Enm08
	DW	fnD1Enm09
	DW	fnD1Enm0A
	DW	fnD1Enm0B
	DW	fnD1Enm0C
	DW	fnD1Enm0D
	DW	fnD1Enm0E
	DW	fnD1Enm0F
fnD1Enm00:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF0B.GPC", 0
fnD1Enm02:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF1B.GPC", 0
fnD1Enm03:
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF2B.GPC", 0
fnD1Enm04:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF3B.GPC", 0
fnD1Enm05:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF4B.GPC", 0
fnD1Enm06:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF5B.GPC", 0
fnD1Enm07:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF6B.GPC", 0
fnD1Enm08:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF7B.GPC", 0
fnD1Enm09:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF8B.GPC", 0
fnD1Enm0A:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMF9B.GPC", 0
fnD1Enm0B:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMFAB.GPC", 0
fnD1Enm0C:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMFBB.GPC", 0
fnD1Enm0D:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMFCB.GPC", 0
fnD1Enm0E:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMFDB.GPC", 0
fnD1Enm0F:
	DB	"B:", 5Ch, "ACT_GPC", 5Ch, "D1ENMFEB.GPC", 0
fnD1CVC6:	; 0324h
	DB	"A:", 5Ch, "ACT_GPC", 5Ch, "D1CVC6.GPC", 0

word_1500A:
	DW	0, 0E00h, 1C00h, 2A00h, 3800h, 4600h, 5400h, 6200h, 7000h
	DW	0, 0E00h, 1C00h, 2A00h, 3800h, 4600h, 5400h, 6200h, 0

tCoord_Actions:	; 035Eh
	DW	tCrdAct_0
	DW	tCrdAct_1
	DW	tCrdAct_2
tCrdAct_0:
	DB	"@X27@Y264@C0@F1", 0
tCrdAct_1:
	DB	"@X27@Y280@C0@F1", 0
tCrdAct_2:
	DB	"@X27@Y296@C0@F1", 0

;	Text data begins here...

tListActions:	; 0394h
	DW	txtAction00
	DW	txtAction00
	DW	txtAction00
	DW	txtAction00
	DW	txtAction04
	DW	txtAction05
	DW	txtAction06
	DW	txtAction07
	DW	txtAction08
	DW	txtAction09
	DW	txtAction0A
	DW	txtAction0A
	DW	txtAction0A
	DW	txtAction0A
	DW	txtAction0E
	DW	txtAction0F
	DW	txtAction0F
	DW	txtAction11
	DW	txtAction12
	DW	txtAction13
	DW	txtAction14

;	Drug names

txtAction00:	; "メスカリンＤ"
	;DB	83h, 81h, 83h, 58h, 83h, 4Ah, 83h, 8Ah, 83h, 93h, 82h, 63h, 0
	DB	"Mescaline D", 0
txtAction04:	; "バリウムＺ"
	;DB	83h, 6Fh, 83h, 8Ah, 83h, 45h, 83h, 80h, 82h, 79h, 0
	DB	"Barium Z", 0
txtAction05:	; "マヒロホルム"
	;DB	83h, 7Dh, 83h, 71h, 83h, 8Dh, 83h, 7Ah, 83h, 8Bh, 83h, 80h, 0
	DB	"Mahiro Horumu Powder", 0
txtAction06:	; "ビタミンＮ"
	;DB	83h, 72h, 83h, 5Eh, 83h, 7Eh, 83h, 93h, 82h, 6Dh, 0
	DB	"Vitamin N", 0
txtAction07:	; "ビタミンＮ　ｓｕｐｅｒ"
	;DB	83h, 72h, 83h, 5Eh, 83h, 7Eh, 83h, 93h, 82h, 6Dh, 81h, 40h, 82h, 93h, 82h, 95h, 82h, 90h, 82h, 85h, 82h, 92h, 0
	DB	"Vitamin N ", 82h, 93h, 82h, 95h, 82h, 90h, 82h, 85h, 82h, 92h, 0
txtAction08:	; "プロテインＶ"
	;DB	83h, 76h, 83h, 8Dh, 83h, 65h, 83h, 43h, 83h, 93h, 82h, 75h, 0
	DB	"Protein V", 0
txtAction09:	; "キララ黄帝液"
	;DB	83h, 4Ch, 83h, 89h, 83h, 89h, 89h, 0A9h, 92h, 0E9h, 89h, 74h, 0
	DB	"Kirara Kotei Solution", 0

;	Special names

txtAction0A:	; "プラズマフラッシュ"
	;DB	83h, 76h, 83h, 89h, 83h, 59h, 83h, 7Dh, 83h, 74h, 83h, 89h, 83h, 62h, 83h, 56h, 83h, 85h, 0
	DB	"Plasma Flash", 0
txtAction0E:	; "電極２号"
	;DB	93h, 64h, 8Bh, 0C9h, 82h, 51h, 8Dh, 86h, 0
	DB	"Electrode #2", 0

;	Attack names

txtAction0F:	; "電撃パンチ"
	;DB	93h, 64h, 8Ch, 82h, 83h, 70h, 83h, 93h, 83h, 60h, 0
	DB	"Dengeki Punch", 0
txtAction11:	; "電撃メス手裏剣"
	;DB	93h, 64h, 8Ch, 82h, 83h, 81h, 83h, 58h, 8Eh, 0E8h, 97h, 0A0h, 8Ch, 95h, 0
	DB	"Dengeki Scalpel Shuriken", 0
txtAction12:	; "電撃キック"
	;DB	93h, 64h, 8Ch, 82h, 83h, 4Ch, 83h, 62h, 83h, 4Eh, 0
	DB	"Dengeki Kick", 0
txtAction13:	; "電撃レーザーメス"
	;DB	93h, 64h, 8Ch, 82h, 83h, 8Ch, 81h, 5Bh, 83h, 55h, 81h, 5Bh, 83h, 81h, 83h, 58h, 0
	DB	"Dengeki Laser Scalpel", 0
txtAction14:	; "電撃バズーカ"
	;DB	93h, 64h, 8Ch, 82h, 83h, 6Fh, 83h, 59h, 81h, 5Bh, 83h, 4Ah, 0
	DB	"Dengeki Bazooka", 0


tCoord_HP:	; 047Eh
	DW	tCrdHP_0
	DW	tCrdHP_1
tCrdHP_0:
	DB	"@X7@Y328@C0@F1", 0
tCrdHP_1:
	DB	"@X61@Y328@C0@F1", 0

tCoord_Atk:	; 04A1h
	DW	tCrdAtk_0
	DW	tCrdAtk_1
tCrdAtk_0:
	DB	"@X7@Y344@C0@F1", 0
tCrdAtk_1:
	DB	"@X61@Y344@C0@F1", 0

tCoord_Def:	; 04C4h
	DW	tCrdDef_0
	DW	tCrdDef_1
tCrdDef_0:
	DB	"@X7@Y360@C0@F1", 0
tCrdDef_1:
	DB	"@X61@Y360@C0@F1", 0

;	Status names
;	NOTE: The width of the text must be 3x full-width or 6x half-width to keep the alignment intact.

txtHealth:	; 04E7h "体力　"
	;DB	91h, 0CCh, 97h, 0CDh, 81h, 40h, 0
	DB	82h, 67h, 82h, 6Fh, 81h, 40h, 0
txtAttack:	; 04EEh "攻撃力"
	;DB	8Dh, 55h, 8Ch, 82h, 97h, 0CDh, 0
	DB	82h, 60h, 82h, 73h, 82h, 6Ah, 0
txtDefense:	; 04F5h "守備力"
	;DB	8Eh, 0E7h, 94h, 0F5h, 97h, 0CDh, 0
	DB	82h, 63h, 82h, 64h, 82h, 65h, 0

;	Cardinal directions (used in txtMsg35)

txtDirections:	; 04FCh
	DW	txtDirEast
	DW	txtDirWest
	DW	txtDirNorth
	DW	txtDirSouth
txtDirEast:
	;DB	93h, 8Ch, 0	; 東 East
	DB	"East", 0
txtDirWest:
	;DB	90h, 0BCh, 0	; 西 West
	DB	"West", 0
txtDirNorth:
	;DB	93h, 0ECh, 0	; 南 North
	DB	"North", 0
txtDirSouth:
	;DB	96h, 6Bh, 0	; 北 South
	DB	"South", 0
tCoord_Msg:	; 0504h
	DB	"@X27@Y264@C0@F1", 0


; Message box text begins here...

; Formatting rules:
; Box is 26 half-width characters wide
; "Dengeki Nurse" is 13 characters long
; The longest enemy name is "Sailor Nurse Momoko" at 19 characters long

; Control codes:
; 0Dh -> line break
; 10h -> Character 1
; 11h -> Character 2
; 12h -> Cardinal direction
; 13h -> Number 2
; 14h -> Number 1
; @Cx -> Color (0, Default (Black); 4, Dengeki Nurse (Red); 7, Enemy (Blue))

; Full-width reference
; 81h, 40h -> "　" Space
; 81h, 60h -> "" Wave dash
; 81h, 93h -> "" Percentage sign 

tListMessages:	; 0514h
	DW	txtMsg00
	DW	txtMsg00
	DW	txtMsg02
	DW	txtMsg03
	DW	txtMsg04
	DW	txtMsg05
	DW	txtMsg06
	DW	txtMsg07
	DW	txtMsg08
	DW	txtMsg09
	DW	txtMsg0A
	DW	txtMsg0B
	DW	txtMsg0C
	DW	txtMsg0D
	DW	txtMsg0E
	DW	txtMsg0F
	DW	txtMsg10
	DW	txtMsg11
	DW	txtMsg12
	DW	txtMsg13
	DW	txtMsg14
	DW	txtMsg15
	DW	txtMsg16
	DW	txtMsg17
	DW	txtMsg18
	DW	txtMsg19
	DW	txtMsg1A
	DW	txtMsg1B
	DW	txtMsg1C
	DW	txtMsg1D
	DW	txtMsg1E
	DW	txtMsg1F
	DW	txtMsg20
	DW	txtMsg21
	DW	txtMsg22
	DW	txtMsg23
	DW	txtMsg24
	DW	txtMsg25
	DW	txtMsg26
	DW	txtMsg27
	DW	txtMsg28
	DW	txtMsg29
	DW	txtMsg2A
	DW	txtMsg2B
	DW	txtMsg2C
	DW	txtMsg2D
	DW	txtMsg2E
	DW	txtMsg2F
	DW	txtMsg30
	DW	txtMsg31
	DW	txtMsg32
	DW	txtMsg33
	DW	txtMsg34
	DW	txtMsg35
	DW	txtMsg36
	DW	txtMsg37
	DW	txtMsg38
	DW	txtMsg39
	DW	txtMsg3A
	DW	txtMsg3B
	DW	txtMsg3C
	DW	txtMsg3D
	DW	txtMsg3E
	DW	txtMsg3F
	DW	txtMsg40
	DW	txtMsg41
	DW	txtMsg42
	DW	txtMsg43
	DW	txtMsg44

;	Wait message

txtMsg00:
	DB	0Dh, 81h, 40h, 81h, 40h, "Select a command!", 0


txtMsg02:
	DB	10h, " is no longer paralyzed!", 0
txtMsg03:	; Hundred-strike scoop (Golgo 31 special)
	DB	"The residue on the drugs have finally dried!", 0Dh, "@C4", "Okaaaay, I should be good now!", 0
txtMsg04:
	DB	10h, " has regained her composure!", 0Dh, 0Dh, "Ahhh, thank goodness!", 0
txtMsg05:
	DB	10h, " has been paralyzed!", 0
txtMsg06:	; Hundred-strike scoop (Golgo 31 special)
	DB	"The drugs have become a sticky mess!", 0Dh, "@C4", "Ewww, gross! I can't use this!", 0
txtMsg07:
	DB	10h, " can't concentrate!", 0

;	Electrode #2 recovery messages

txtMsg08:	; Last row: "　　 Ｙｅｓ　　Ｎｏ"
	DB	"Electrode #2 is in use.", 0Dh, "Do you want it recalled?", 0Dh, 0Dh, 81h, 40h, 81h, 40h, " ", 82h, 78h, 82h, 85h, 82h, 93h, 81h, 40h, 81h, 40h, 82h, 6Dh, 82h, 8Fh, 0
txtMsg09:
	DB	"@C4", "Thanks Electrode #2, I'll take it from here!", 0Dh, "@C0", "Dengeki Nurse has recalled Electrode #2.", 0

;	Win/lose messages

txtMsg0A:
	DB	"Dengeki Nurse defeated ", 11h, "!", 0Dh, "She's unstoppable, that Dengeki Nurse!", 0
txtMsg0B:
	DB	"Dengeki Nurse has been defeated.", 0Dh, "A lightning strike weeps in the distant sky...", 0

;	Dengeki Nurse attack messages

txtMsg0C:	; Successful hit
	DB	10h, " hits ", 11h, " and deals ", 14h, 86h, 40h, "damage!", 0
txtMsg0D:	; Ineffective hit
	DB	"Aw man! You didn't deal any actual damage!", 0Dh, 0Dh, "@C4", "What!? Why not??", 0
txtMsg0E:	; Dodged hit
	DB	10h, "'s attack was dodged!", 0Dh, "@C4", "Hey, that's cheap! Knock it off!", 0
txtMsg0F:	; Mescaline D
	DB	10h, " lowered ", 11h, "'s attack by ", 14h, "!", 0
txtMsg10:	; Barium Z
	DB	10h, " lowered ", 11h, "'s defense by ", 14h, "!", 0
txtMsg11:	; Mahiro Horumu Powder
	DB	10h, " paralyzed ", 11h, "!", 0
txtMsg12:	; Boss Immunity
	DB	10h, "'s drug has no effect!", 0Dh, 0Dh, "@C4", "That's weird...", 0

;	Dengeki Nurse drug/special messages

txtMsg13:	; Vitamin N
	DB	10h, " recovers ", 14h, 86h, 40h, "health!", 0
txtMsg14:	; Vitamin N super
	DB	10h, "'s health is fully restored!", 0
txtMsg15:	; Protein V
	DB	10h, "'s attack increased by ", 14h, "!", 0
txtMsg16:	; Kirara Kotei Solution
	DB	10h, "'s defense increased by ", 14h, "!", 0
txtMsg17:	; Electrode #2
	DB	10h, " secretly deploys Electrode #2!", 0Dh, 11h, " doesn't notice!", 0
txtMsg18:	; Power
	DB	"Plasma Charge is now at", 0Dh, 14h, 81h, 93h, "! You need ", 13h, 81h, 93h, " more before you can use Plasma Flash!", 0

;	Dengeki Nurse status messages

txtMsg19:
	DB	11h, " takes ", 14h, 86h, 40h, "damage!", 0
txtMsg1A:
	DB	11h, " didn't take any damage!", 0Dh, 0Dh, "@C4", "Hehe, having problems?", 0
txtMsg1B:
	DB	11h, " dodged the attack!", 0Dh, 0Dh, "@C4", "Yeah, as if!", 0
txtMsg1C:
	DB	11h, "'s attack reduced by ", 14h, "!", 0
txtMsg1D:
	DB	11h, "'s defense reduced by ", 14h, "!", 0
txtMsg1E:
	DB	11h, " has been paralyzed!", 0Dh, "Yikes, she can't attack!", 0
txtMsg1F:
	DB	11h, " can't concentrate!", 0Dh, "She is unable to Plasma Charge!", 0
txtMsg20:
	DB	11h, " can't use Plasma Flash!", 0Dh, "Oh shit! What are we going to do now?", 0
txtMsg21:
	DB	"Powerful EM waves are preventing Plasma Flash from being used!", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, "..............", 0
txtMsg22:
	DB	"The EM waves are fading!", 0Dh, "We can give the Plasma Flash a shot again!", 0Dh, "Great!!", 0

;	Electrode #2 status messages

txtMsg23:
	DB	11h, " takes ", 14h, 86h, 40h, "damage!", 0
txtMsg24:
	DB	"The attack had no effect on ", 11h, "!", 0Dh, "Great job, Electrode #2!", 0
txtMsg25:
	DB	"Pshhhhh...", 0Dh, "Electrode #2 makes a sad,", 0Dh, "deflating sound.", 0

;	Item usage (Both Dengeki Nurse and enemies)

txtMsg26:
	DB	10h, " uses Mescaline D!", 0
txtMsg27:
	DB	10h, " uses Barium Z!", 0
txtMsg28:
	DB	10h, " uses Mahiro Horumu Powder!", 0
txtMsg29:
	DB	10h, " uses Protein V!", 0
txtMsg2A:
	DB	10h, " uses Kirara Kotei Solution!", 0
txtMsg2B:
	DB	10h, " uses Vitamin N!", 0
txtMsg2C:
	DB	10h, " uses Vitamin N ", 82h, 93h, 82h, 95h, 82h, 90h, 82h, 85h, 82h, 92h, "!", 0

;	Enemy recovery messages

txtMsg2D:
	DB	10h, "'s health is fully restored!", 0
txtMsg2E:
	DB	10h, "'s attack increased by ", 14h, "!", 0
txtMsg2F:
	DB	10h, "'s defense increased by ", 14h, "!", 0
txtMsg30:
	DB	10h, " recovers ", 14h, " health!", 0


txtMsg31:
	DB	"Not enough Plasma Power!", 0Dh, "You need at least 50", 81h, 93h, " power to use Plasma Flash!", 0
txtMsg32:
	DB	"Your Plasma Power is at max! Use your electricity responsibly!", 0
txtMsg33:	; Electrode #2 unusable
	DB	"I'm sorry, Kirara honey, I can't fight no more... Nothin' I can do here, real sorry to leave ya...", 0

;	Black Cross Syringe Kamikaze Unit

;	Activation message
txtMsg34:
	DB	10h, " sends an emergency beacon to the sky!", 0
txtMsg35:
	DB	"The Black Cross Syringe Kamikaze Unit appears on the horizon, flying in from the ", 12h, "!", 0

;	Result 1
txtMsg36:
	DB	"Dah-dah-dahh! It's the plot twist of the century!", 0
txtMsg37:
	DB	"Dengeki Nurse's attack and defense have swapped with ", 10h, "'s!", 0

;	Result 2
txtMsg38:
	DB	10h, " got stabbed in the butt with", 0Dh, "Vitamin N ", 82h, 93h, 82h, 95h, 82h, 90h, 82h, 85h, 82h, 92h, "!", 0

;	Result 3
txtMsg39:
	DB	"Mahiro Horumu comes flying at ", 11h, "'s cute little butt!", 0

;	Result 4
txtMsg3A:
	DB	"A powerful EM wave is discharged!", 0Dh, "Dengeki Nurse loses 50", 81h, 93h, " of her Plasma Power!", 0

;	Result 5
txtMsg3B:
	DB	"Byoon byoon byooon!", 0Dh, "Dengeki Nurse was hit by", 0Dh, "Bacillus 50!", 0
txtMsg3C:
	DB	"50", 81h, 93h, " of ", 11h, "'s health was transferred to", 20h, 10h, "!", 0Dh, "@C4", "I-I can't believe it!", 0

;	Miss/Ineffective
txtMsg3D:
	DB	"KABOOOOM!", 0Dh, "The Kamikaze Squad plows into their target!", 0
txtMsg3E:
	DB	"But... They leave without doing anything!", 0

;	Other enemy-specific status effects

txtMsg3F:
	DB	"Powerful EM waves erupt!", 0Dh, "Dengeki Nurse's Plasma Power was pilfered!", 0
txtMsg40:	; Chodendo Nurse Special
	DB	"@C7", "Hmm, how weird, something must be broken...", 0Dh, "The plasma waves won't collect!", 0
txtMsg41:
	DB	"EM interference makes the Dengeki Shuriken fly off elsewhere!", 0

;	Critical hits

txtMsg42:	; Dengeki Nurse
	DB	0Dh, 81h, 40h, " A beautiful strike!", 0
txtMsg43:	; Enemy
	DB	0Dh, " A heartbreaking strike...", 0


txtMsg44:
	DB	"Plasma charge is now at", 0Dh, 14h, 81h, 93h, "... Plasma Flash is online!", 0


;	Dengeki Nurse dialog follows...

tCoord_PlrChat:	; 12C1h
	DB	"@X27@Y264@C4@F1", 0

tListPlayer:	; 12D1h
	DW	txtPlr00
	DW	txtPlr01
	DW	txtPlr02
	DW	txtPlr03
	DW	txtPlr04
	DW	txtPlr05
	DW	txtPlr06
	DW	txtPlr07
	DW	txtPlr08
	DW	txtPlr09
	DW	txtPlr0A
	DW	txtPlr0B
	DW	txtPlr0C
	DW	txtPlr0D
	DW	txtPlr0E
	DW	txtPlr0F
	DW	txtPlr10
	DW	txtPlr11
	DW	txtPlr12
	DW	txtPlr13
	DW	txtPlr14
	DW	txtPlr15
	DW	txtPlr16
	DW	txtPlr17
	DW	txtPlr18
	DW	txtPlr19
	DW	txtPlr1A
	DW	txtPlr1B
	DW	txtPlr1C
	DW	txtPlr1D
	DW	txtPlr1E
	DW	txtPlr1F
	DW	txtPlr20

;	Attack quotes

txtPlr00:
	DB	0Dh, 81h, 40h, "Let's do this!", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "Dengeki Puuunch!", 0
txtPlr01:
	DB	0Dh, 81h, 40h, "Eat this!", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "Dengeki Kickkk!", 0
txtPlr02:
	DB	0Dh, "Hyaaa!", 0Dh, " Dengeki Scalpel Shuriken!", 0
txtPlr03:
	DB	0Dh, "Try this on for size!", 0Dh, 81h, 40h, 81h, 40h, "Dengeki Laser Scalpel!", 0
txtPlr04:
	DB	0Dh, 81h, 40h, "Prepare yourself!", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "Dengeki Bazooka!", 0
txtPlr05:
	DB	0Dh, 81h, 40h, 81h, 40h, "PLASMA", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "FLAAAAAAAASH!", 0

;	Drug quotes

txtPlr06:	; Mescaline D
	DB	0Dh, "High attack leads to high BP, lemme bring that down!", 0
txtPlr07:	; Barium Z
	DB	0Dh, "You risk diabetes with a defense that high!", 0
txtPlr08:	; Mahiro Horumu Powder
	DB	0Dh, "Overworking is bad for your health! Take a break!", 0
txtPlr09:	; Vitamin N
	DB	"Hold on a minute...", 0Dh, "Slurp slurp slurp...", 0Dh, "Now I'm feeling energized!", 0
txtPlr0A:	; Vitamin N Super
	DB	"W-Wait, time out!", 0Dh, "Slurp slurp slurp...", 0Dh, "Okay, back in action!", 0
txtPlr0B:	; Electrode #2
	DB	0Dh, 81h, 40h, "Electrode #2, you", 0Dh, 81h, 40h, 81h, 40h, "take over for a bit!", 0
txtPlr0C:	; Charge
	DB	0Dh, "Plasma Power... Charge ON!", 0
txtPlr0D:	; Protein V
	DB	"Gulp gulp gulp...", 0Dh, "Ahhh...", 0Dh, "My body's heating up...", 0
txtPlr0E:	; Kirara Yellow Emperor Elixir
	DB	"Gulp gulp gulp...", 0Dh, "Ahhh... My muscles are", 0Dh, "getting stronger...", 0

;	Status effect quotes

txtPlr0F:	; Defeated
	DB	0Dh, "I can't... I can't fight anymore!", 0
txtPlr10:	; Attacked
	DB	0Dh, "Owie! What do you think you're doing?", 0
txtPlr11:	; Weird attacked
	DB	"Hey, knock it off! Why's your attack so weird?", 0
txtPlr12:	; Dodged attack
	DB	0Dh, "Hah! That kind of attack will never hit me!", 0
txtPlr13:	; Ineffective attack
	DB	0Dh, "Heh heh! I didn't feel a thing!", 0
txtPlr14:	; Ineffective weird attack
	DB	"There's no way such a weirdo attack would work on me!", 0
txtPlr15:	; Losing ATK
	DB	0Dh, "Nooo!", 0Dh, "My strength is draining!!!", 0
txtPlr16:	; Losing DEF
	DB	0Dh, "No way! My muscles are getting all squishy!", 0
txtPlr17:	; Paralyzed
	DB	0Dh, "Aaaahhhh!", 0Dh, "I can't move my body!", 0


txtPlr18:	; Golgo 31 Special
	DB	0Dh, "Stop it!", 0Dh, "That's absolutely filthy!", 0
txtPlr19:
	DB	0Dh, "Ahh... No... S-Stop, stop!", 0
txtPlr1A:
	DB	"Wh-what's happening?", 0Dh, "My plasma powers are fading...", 0
txtPlr1B:	; 
	DB	0Dh, "Whaaaa?", 0Dh, "How's that even allowed?", 0
txtPlr1C:	; "Plot Twist" Win
	DB	0Dh, "Lucky me!", 0Dh, "I came out ahead!", 0
txtPlr1D:
	DB	0Dh, "Huh... Did I get or lose something? Eh, whatever!", 0
txtPlr1E:
	DB	0Dh, "Whaaa!", 0Dh, "That's totally cheating!", 0
txtPlr1F: ; Losing Plasma Power
	DB	0Dh, "This sucks! I worked so hard to save it!", 0
txtPlr20:
	DB	0Dh, "It's sooooo stinky!!!", 0


;	Enemy dialog follows...

tCoord_EnmChat:	; 18FFh
	DB	"@X27@Y264@C7@F1", 0

tListEnemy:	; 190Fh
	DW	tLstEnemy00
	DW	tLstEnemy00
	DW	tLstEnemy02
	DW	tLstEnemy03
	DW	tLstEnemy04
	DW	tLstEnemy05
	DW	tLstEnemy06
	DW	tLstEnemy07
	DW	tLstEnemy08
	DW	tLstEnemy09
	DW	tLstEnemy10
	DW	tLstEnemy11
	DW	tLstEnemy12
	DW	tLstEnemy13
	DW	tLstEnemy14
	DW	tLstEnemy15

;	Doofy Nurse Tomoyo

tLstEnemy00:	; 192Fh
	DW	txtEnm00_0
	DW	txtEnm00_1
	DW	txtEnm00_2
	DW	txtEnm00_3
	DW	txtEnm00_4
	DW	txtEnm00_5
	DW	txtEnm00_6
	DW	txtEnm00_7
txtEnm00_0:	; Normal Attack
	DB	"Let's do this!", 0Dh, "Tomoyo Chop!", 0Dh, "@C0", "Chop chop chop!", 0
txtEnm00_1:	; Weird Attack
	DB	"Let's do this!", 0Dh, "Spurting Nosebleed Cotton Ball Blizzard!", 0
txtEnm00_2:	; Special Attack
	DB	"Hnnnnngh!!", 0Dh, "Brainbuster!!!", 0
txtEnm00_3:	; Hit
	DB	"Unnnngh!", 0Dh, "That hurts, y'know!", 0
txtEnm00_4:	; Miss
	DB	"Ha ha, you missed me! Serves you right, dingmat!", 0
txtEnm00_5:	; Ineffective
	DB	"Hm? A fly must've landed on me! Do you need more training?", 0
txtEnm00_6:	; Defeat
	DB	"Whaaaaa! No!! You idiot! I can't take this anymore!", 0

;	Goofy Nurse Ayako

tLstEnemy02:	; 1ADFh
	DW	txtEnm02_0
	DW	txtEnm02_1
	DW	txtEnm02_2
	DW	txtEnm02_3
	DW	txtEnm02_4
	DW	txtEnm02_5
	DW	txtEnm02_6
	DW	txtEnm00_7
txtEnm02_0:	; Normal Attack
	DB	"Deadly Ayapyon Buster!", 0Dh, "Try this, silly!", 0
txtEnm02_1:	; Weird Attack
	DB	"@C0", 10h, " jams a stethoscope against ", 11h, "'s butt!", 0Dh, "@C7", "Time for your examination!", 0
txtEnm02_2:	; Special Attack
	DB	"@C0", 10h, " does a mysterious dance!", 0Dh, "@C7", "Pii", 81h, 60h, "hyara, pii", 81h, 60h, "hyara, yes indeed!", 0
txtEnm02_3:	; Hit
	DB	"Kyaa! Don't do that!", 0
txtEnm02_4:	; Miss
	DB	"Oh, you missed me? How unfortunate!", 0
txtEnm02_5:	; Ineffective
	DB	"Kyapipipi, that didn't hurt at all! How lovely!", 0
txtEnm02_6:	; Defeat
	DB	"Aaaaah! I'm done for! Until we meet agaaaaain!", 0

;	Guillotine Nurse

tLstEnemy03:	; 1CC0h
	DW	txtEnm03_0
	DW	txtEnm03_1
	DW	txtEnm03_2
	DW	txtEnm03_3
	DW	txtEnm03_4
	DW	txtEnm03_5
	DW	txtEnm03_6
	DW	txtEnm00_7
txtEnm03_0:	; Normal Attack
	DB	"Ho ho ho! Take notes as I instruct you in my scalpel technique!", 0
txtEnm03_1:	; Weird Attack
	DB	"@C0", "Pew pew pew! Guillotine Nurse fires an X-Ray!", 0Dh, 0Dh, "@C7", "Oh my, what a tiny chest!", 0
txtEnm03_2:	; Special Attack
	DB	"Savor the terror of my custom guillotine!", 0Dh, "@C0", 81h, 40h, 81h, 40h, "Tok tok tok tok!", 0Dh, 81h, 40h, 81h, 40h, "Tok tok tok tok!!", 0
txtEnm03_3:	; Hit
	DB	"Tsk! For a little girl, you're pretty good...", 0
txtEnm03_4:	; Miss
	DB	"Hmph! Don't waste my time with lame attacks!", 0
txtEnm03_5:	; Ineffective
	DB	"You think that attack will damage me? How cute!", 0
txtEnm03_6:	; Defeat
	DB	"Aaaaagh! How can this be? For me to lose to some kid...", 0

;	Sailor Nurse Momoko

tLstEnemy04:	; 1ED6h
	DW	txtEnm04_0
	DW	txtEnm04_1
	DW	txtEnm04_2
	DW	txtEnm04_3
	DW	txtEnm04_4
	DW	txtEnm04_5
	DW	txtEnm04_6
	DW	txtEnm00_7
txtEnm04_0:	; Normal Attack
	DB	"Kyahaha! Momoko Punch!!!", 0Dh, "@C0", "Poke poke poke!", 0
txtEnm04_1:	; Weird Attack
	DB	"A pain only girls face! Secret Technique, Wax Strip!", 0Dh, "@C0", "Krk krk! Piak Piak!", 0
txtEnm04_2:	; Special Attack
	DB	"Finishing move! Butt Strike!", 0Dh, "@C0", "Byoon! Byoon! Byoooon!", 0
txtEnm04_3:	; Hit
	DB	"Kyaa! That hurts!", 0Dh, "Stop, stop, please!", 0
txtEnm04_4:	; Miss
	DB	"Kyaa! ...Wait, that didn't hurt?", 0Dh, "Did you miss?", 0
txtEnm04_5:	; Ineffective
	DB	"Kyaa! ...Wait, that didn't hurt?", 0Dh, "But it should've...", 0
txtEnm04_6:	; Defeat
	DB	"Kyaaaaaaa! Sob, sob...", 0Dh, "I told you, I didn't wanna do this...", 0

;	Sailor Nurse Asuka

tLstEnemy05:	; 20D2h
	DW	txtEnm05_0
	DW	txtEnm05_1
	DW	txtEnm05_2
	DW	txtEnm05_3
	DW	txtEnm05_4
	DW	txtEnm05_5
	DW	txtEnm05_6
	DW	txtEnm00_7
txtEnm05_0:	; Normal Attack
	DB	"Haaaaaa!", 0Dh, "Asuka Special, Artery-", 0Dh, "Rending Rupture Fist!", 0
txtEnm05_1:	; Weird Attack
	DB	"@C0", "Whoosh... BAM BAM BAM!", 0Dh, "@C7", "Taste the chilling fury of my Ice Pack Barrage!", 0
txtEnm05_2:	; Special Attack
	DB	"A souvenir for the afterlife!", 0Dh, "Asuka Super Special Yo-Yo Hell Spin!", 0
txtEnm05_3:	; Hit
	DB	"Pfah! Some nerve, pulling a stunt like that!", 0
txtEnm05_4:	; Miss
	DB	"Ho ho... I see through every one of your attacks!", 0
txtEnm05_5:	; Ineffective
	DB	"Heh heh...", 0Dh, "Was that an attack, or a mosquito bite?", 0
txtEnm05_6:	; Defeat
	DB	"Uuuuuuugh...", 0Dh, "I... I've lost...", 0Dh, "Dengeki Nurse... I won't forget your name...", 0

;	Golgo 31

tLstEnemy06:	; 2287h
	DW	txtEnm06_0
	DW	txtEnm06_1
	DW	txtEnm06_2
	DW	txtEnm06_3
	DW	txtEnm06_4
	DW	txtEnm06_5
	DW	txtEnm06_6
	DW	txtEnm06_7
txtEnm06_0:	; Normal Attack
	DB	"I don't like hitting women, but business is business...", 0Dh, "@C0", "Whack whack whack!", 0
txtEnm06_1:	; Weird Attack
	DB	"Ma'am, what a fine-looking butt you have there...", 0Dh, "@C0", "Grope grope grope!", 0
txtEnm06_2:	; Special Attack
	DB	"I no longer have a", 0Dh, 81h, 40h, "choice... Take this!", 0Dh, 81h, 40h, 81h, 40h, " Hundred-strike scoop!", 0
txtEnm06_3:	; Hit
	DB	"Ow! Ow! Owww!", 0Dh, "You better not push me any further!", 0
txtEnm06_4:	; Miss
	DB	"Heh... I'd stop if I were you. Roses suit women more than swords...", 0
txtEnm06_5:	; Ineffective
	DB	"What an adorable little nurse!", 0Dh, "Attacks like that wouldn't even hurt a bug!", 0
txtEnm06_6:	; Defeat
	DB	"H-How is this possible?", 0Dh, "Oh noo, oh noooo...", 0Dh, "This is good-byeeeeeeeeee!", 0
txtEnm06_7:	; Boss Immunity
	DB	"Didn't you know...? I'm already hooked on Mahiro Horumu! A tiny dose won't affect me!", 0

;	Janet

tLstEnemy07:	; 24BCh
	DW	txtEnm07_0
	DW	txtEnm07_1
	DW	txtEnm07_2
	DW	txtEnm07_3
	DW	txtEnm07_4
	DW	txtEnm07_5
	DW	txtEnm07_6
	DW	txtEnm00_7
txtEnm07_0:
	DB	"Here comes Janet!!!", 0Dh, "Iga Ninja Technique, Astro Meteor Bomber!", 0Dh, "ASTROOOOOOOO!", 0
txtEnm07_1:
	DB	"Try this on for size!", 0Dh, "Koga Ninja Technique, Laughing Lady Hell Jutsu!", 0Dh, "Tickle tickle tickle!", 0
txtEnm07_2:
	DB	"A high-tech engineering marvel, NASA's AI rock-", 0Dh, "thrower!", 0Dh, "Let's give it a test run!", 0
txtEnm07_3:
	DB	"Ah... This pain...", 0Dh, "It's pulling me into a dangerous world...", 0
txtEnm07_4:
	DB	"Hop hop hop, aw yeah!", 0Dh, "Check out this speed!", 0
txtEnm07_5:
	DB	"Oh, for real? That didn't faze me at all! I'm hella tough!", 0
txtEnm07_6:
	DB	"Urrrrgh! Seriously, forget this!", 0Dh, "I'm goin' back to America!", 0Dh, "Sob, sob...", 0

;	Colombia

tLstEnemy08:	; 26BEh
	DW	txtEnm08_0
	DW	txtEnm08_1
	DW	txtEnm08_2
	DW	txtEnm08_3
	DW	txtEnm08_4
	DW	txtEnm08_5
	DW	txtEnm08_6
	DW	txtEnm00_7
txtEnm08_0:
	DB	"Eat the demon blade that swallows the blood of knights!", 0
txtEnm08_1:
	DB	"@C0", "BAM! Squeak, squeak...", 0Dh, "@C7", "Defiant fool, lick the queen's boots!", 0
txtEnm08_2:
	DB	"@C0", "Creak creak creak... ", "@C7", "My shamisen strings tighten beautifully! Now let's impede your circulation...", 0
txtEnm08_3:
	DB	"Hmph, not bad at all...", 0Dh, "Any less, and you wouldn't be worth my torture!", 0
txtEnm08_4:
	DB	"Aw, ya missed...", 0Dh, "But you're young, your soul crushing is yet to come!", 0
txtEnm08_5:
	DB	"What a mindful and demure Yamato Nadeshiko, but your mercy is out-of-place here!", 0
txtEnm08_6:
	DB	"Tsk... Even as my foe, you have earned my praise. But the spirit of chivalry never dies...", 0

;	Magenta

tLstEnemy09:	; 28EFh
	DW	txtEnm09_0
	DW	txtEnm09_1
	DW	txtEnm09_2
	DW	txtEnm09_3
	DW	txtEnm09_4
	DW	txtEnm09_5
	DW	txtEnm09_6
	DW	txtEnm00_7
txtEnm09_0:
	DB	"Here I come, baby!", 0Dh, "Guided by the blue winds, CALIFORNIA CRAAAASH!", 0
txtEnm09_1:
	DB	"Hnnnngh! Yankee girl grit!", 0Dh, "Big-Bust Smother Hold!", 0
txtEnm09_2:
	DB	"@C0", "Shu-shu-shu!", 0Dh, "@C7", "Try a hairpin coated with rattlesnake venom!", 0
txtEnm09_3:
	DB	"Hoh, that really hurt! Now I'm pissed!", 0
txtEnm09_4:
	DB	"Fwip-fwip! Ain't I quick?", 0
txtEnm09_5:
	DB	"Hah, no way that'll hurt!", 0
txtEnm09_6:
	DB	"Gyaaaaa! This isn't... It wasn't supposed to end like this! Sniff, sniff...", 0

;	Johnny Nakamura

tLstEnemy10:	; 2AABh
	DW	txtEnm0A_0
	DW	txtEnm0A_1
	DW	txtEnm0A_2
	DW	txtEnm0A_3
	DW	txtEnm0A_4
	DW	txtEnm0A_5
	DW	txtEnm0A_6
	DW	txtEnm0A_7
txtEnm0A_0:
	DB	"My Muramasa craves blood!", 0Dh, "Eat my Flower Style Hidden School Deadly Sword Secret Technique... Duck Dance!", 0
txtEnm0A_1:
	DB	"Hooor-yah! Time for Sumo, Japan's national sport!", 0Dh, "Brace for my charging grapple!", 0
txtEnm0A_2:
	DB	"Ain't supposed to use this on girls, but what the hey! Mystic Art, Lavender Aroma!", 0
txtEnm0A_3:
	DB	"Gwah! Impudent girl, you fight well!", 0
txtEnm0A_4:
	DB	"@C0", "Bwawawan!", 0Dh, "@C7", "Heh heh.. Mystic Art, Altar Return!", 0
txtEnm0A_5:
	DB	"Bahaha! What a laughable technique, and laugh I will! Ha ha ha!", 0
txtEnm0A_6:
	DB	"Gwahhh! Gyaaaaaa!", 0Dh, "Owowowow... Such regret...", 0
txtEnm0A_7:	; Boss Immunity
	DB	"You fiend, how dare you emit such a strange light!", 0Dh, "With Muramasa, it will be deflected!", 0

;	Nurse The SENNA

tLstEnemy11:	; 2CFFh
	DW	txtEnm0B_0
	DW	txtEnm0B_1
	DW	txtEnm0B_2
	DW	txtEnm0B_3
	DW	txtEnm0B_4
	DW	txtEnm0B_5
	DW	txtEnm0B_6
	DW	txtEnm00_7
txtEnm0B_0:
	DB	"@C0", "VROOOOOOMM!", 0Dh, "@C7", 81h, 40h, " I'll show you how", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, "much better I am!", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "V-12 POWER BOMB!", 0
txtEnm0B_1:
	DB	"@C0", 10h, " rams her butt into ", 11h, "!", 0Dh, "@C7", "Tail To Nose Attack!", 0
txtEnm0B_2:
	DB	"Vrooooom! Full throttle! Supersonic Exhaust Heat!", 0
txtEnm0B_3:
	DB	"Hmph! Don't make that grin with your lucky hit!", 0
txtEnm0B_4:
	DB	"Silly girl, your slow attacks can't hit this supersonic nurse!", 0
txtEnm0B_5:
	DB	"I honed my technique in brutal races, your lame attacks won't work! Go back to the farm!", 0
txtEnm0B_6:
	DB	"Ahhh, it's not my fault...", 0Dh, "I blame the pit crew, I shouldn't have lost!", 0

;	Nurse THE MANSELL

tLstEnemy12:	; 2F29h
	DW	txtEnm0C_0
	DW	txtEnm0C_1
	DW	txtEnm0C_2
	DW	txtEnm0C_3
	DW	txtEnm0C_4
	DW	txtEnm0C_5
	DW	txtEnm0C_6
	DW	txtEnm00_7
txtEnm0C_0:
	DB	"@C0", "Brm Brm Brrrrmm!", 0Dh, "@C7", "Here comes a high-tech storm!", 0Dh, "Active Suspension Buster!", 0
txtEnm0C_1:
	DB	"A secret art of unknown nature!", 0Dh, "Parallel Injection!", 0
txtEnm0C_2:
	DB	"Hi-yah! My stamina is unbeatable!", 0Dh, "Q-Tire Hundred Shot!", 0
txtEnm0C_3:
	DB	"Gyagghhh! Sniff, I won't cry...", 0Dh, "My sadness means nothing on the circuit!", 0
txtEnm0C_4:
	DB	"Kyahaha, you can't hit me!", 0Dh, "I'mma spank your ass!", 0
txtEnm0C_5:
	DB	"Pain, pain, go away!", 0Dh, "Try again another day!", 0
txtEnm0C_6:
	DB	"Ahhh! I'm sorry...", 0Dh, "I'm raising the white flag!", 0

;	Chodendo Nurse

tLstEnemy13:	; 3115h
	DW	txtEnm0D_0
	DW	txtEnm0D_1
	DW	txtEnm0D_2
	DW	txtEnm0D_3
	DW	txtEnm0D_4
	DW	txtEnm0D_5
	DW	txtEnm0D_6
	DW	txtEnm0D_7
txtEnm0D_0:
	DB	"@C0", "Beep... Beep beep beep...", 0Dh, "@C7", "Roar and fly! Super-", 0Dh, "conducting Spin Ball!", 0
txtEnm0D_1:
	DB	"I know it's sudden, but time for a CT Scan!", 0Dh, "Bleep, bleep!", 0
txtEnm0D_2:
	DB	"@C0", 10h, " uses", 0Dh, 81h, 40h, 81h, 40h, "the Neuro-Fuzzy", 0Dh, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, "Plasma Controller!", 0
txtEnm0D_3:
	DB	"Tch!", 0Dh, "Looks like you've got some bite after all!", 0
txtEnm0D_4:
	DB	"Snort!", 0Dh, "Why bother with pointless attacks?", 0
txtEnm0D_5:
	DB	"Tsk tsk!", 0Dh, "The gall of thinking those pointless attacks work on me!", 0
txtEnm0D_6:
	DB	"No way! I can't believe I let my guard down...", 0Dh, "The magnetism is fading...", 0
txtEnm0D_7:
	DB	0Dh, "Get a load of this!", 0Dh, "Superconducting Psycho Barrier!", 0

;	Pepe
;	"WTF DO ELEPHANT SOUNDS SOUND LIKE???" - Geometrizer

tLstEnemy14:	; 3308h
	DW	txtEnm0E_0
	DW	txtEnm0E_1
	DW	txtEnm0E_2
	DW	txtEnm0E_3
	DW	txtEnm0E_4
	DW	txtEnm0E_5
	DW	txtEnm0E_6
	DW	txtEnm0E_7
txtEnm0E_0:
	DB	0Dh, "BRAAA!", 0Dh, "BRAA BRAA BRAAAA!", 0
txtEnm0E_1:
	DB	"Bwooooo! Pbbbrrrtttt...", 0Dh, "@C0", "Pepe released a revolting stinky gas!", 0
txtEnm0E_2:
	DB	"BRAAAAAAP!!!", 0Dh, "@C0", "My god! Pepe unleashed the Pepe Lariat!", 0
txtEnm0E_3:
	DB	0Dh, "Bwoooo....!", 0
txtEnm0E_4:
	DB	0Dh, "Bwoobwoobwooooon!", 0
txtEnm0E_5:
	DB	0Dh, "BWOOA-HA-HA-HAH!!!", 0
txtEnm0E_6:
	DB	0Dh, "Pao...", 0Dh, "Paopao... Buon...", 0

;	Black Nurse

tLstEnemy15:	; 342Eh
	DW	txtEnm0F_0
	DW	txtEnm0F_1
	DW	txtEnm0F_2
	DW	txtEnm0F_3
	DW	txtEnm0F_4
	DW	txtEnm0F_5
	DW	txtEnm0F_6
	DW	txtEnm0E_7
txtEnm0F_0:
	DB	"Traitor!", 0Dh, "Face the consequences of your betrayal!", 0Dh, "Black Blaster!", 0
txtEnm0F_1:
	DB	"I'll twist that beautiful body of yours into a hideous thing!", 0Dh, "Black Nipple!", 0
txtEnm0F_2:
	DB	"@C0", "Bzzt Bzzzt Bzzzzzt!", 0Dh, "@C7", "Time for you to behave!", 0Dh, "Black Turbine!", 0
txtEnm0F_3:
	DB	"Hmph! You've grown since our last meeting...", 0Dh, "But your defeat is inevitable!", 0
txtEnm0F_4:
	DB	"Heh heh heh! You're no match for me.", 0Dh, "I can telegraph your every attack!", 0
txtEnm0F_5:
	DB	"Heh heh heh! Useless attacks!", 0Dh, "Accept your traitorous defeat!", 0
txtEnm0F_6:
	DB	"Uwawawawawa!!! Impossible, this can't be...", 0Dh, "For ME to lose? Black Cross Society, forever...!", 0
txtEnm0E_7:
	DB	"Fool! As if that would work on ME!", 0


txtEnm00_7:	; "メッセージ未作成" [unused]
	DB	"Message not yet created", 0


%assign data_space DATA_BASE_OFS+36B6h-($-$$)
%warning [Debug] Data segment: data_space bytes remaining
	times 36B6h-($-$$-DATA_BASE_OFS) db 0FFh
	incbin "NRSFIGHT.CMD", $
