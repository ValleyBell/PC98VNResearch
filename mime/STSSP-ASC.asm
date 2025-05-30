; Assembling using NASM:
;	nasm -f bin -o STSSP-ASC.COM -l STSSP-ASC.LST "STSSP-ASC.asm"
;	This requires STSSP.COM (5 064 bytes) to be in the same folder.

	use16
	cpu	186
BASE_OFS EQU 100h	; COM load offset

	org	BASE_OFS

WaitForVSync EQU 0A5Ch
DrawTextBox EQU 0B84h
textDrawPtr EQU 0E92h
drawColX EQU 0E94h
drawRowY EQU 0E96h
drawWidth EQU 0E98h
drawHeight EQU 0E9Ah
txtColorMain EQU 0E9Ch
txtColorShdw EQU 0E9Dh
txtFontCache EQU 0E9Eh

	incbin "STSSP.COM", $, 0109h - ($-$$+BASE_OFS)
	mov	sp, end+0FEh
	mov	bx, end+110h

	incbin "STSSP.COM", $, 02B6h - ($-$$+BASE_OFS)
; The text is centered to X=320.
SoundFM_X EQU 304	; originally 288
SoundMIDI_X EQU 288	; originally 272
loc_102B6:
	; The box is 32 pixels larger (in both, width and height) than then "inner size". (16 pixels border on each side)
	; Centering algorithm: startX = 640 - (innerWidth + 32) / 2
	mov	word [drawColX], 208/8		; start pixel X (originally 216)
	mov	word [drawRowY], 96/16		; start pixel Y
	mov	word [drawWidth], 192/16	; inner width (originally 176)
	mov	word [drawHeight], 48/16	; inner height
	call	DrawTextBox	; draw text box for Sound Source Selection
	
	; original properties: text length 11*16 = 176 px, startX = (640-176)/2 = 232
	; new properties: text length 24*8 = 192 px
	mov	word [drawColX], 224/8	; originally 232
	mov	word [drawRowY], 106
	mov	byte [txtColorMain], 4
	mov	byte [txtColorShdw], 8
	mov	si, aSoundMode
	call	DrawText	; "Select Sound Mode"
	
	mov	word [drawColX], SoundFM_X/8
	mov	word [drawRowY], 130
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aSound_FM
	call	DrawText	; "FM sound source"
	
	mov	word [drawColX], SoundMIDI_X/8
	mov	word [drawRowY], 148
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aSound_MIDI
	call	DrawText	; "MIDI sound source"

	incbin "STSSP.COM", $, 03B3h - ($-$$+BASE_OFS)
loc_103B3:
	mov	word [drawColX], SoundFM_X/8
	mov	word [drawRowY], 130
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aSound_FM
	call	DrawText	; "FM sound source"
	
	mov	word [drawColX], SoundMIDI_X/8
	mov	word [drawRowY], 148
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aSound_MIDI
	call	DrawText	; "MIDI sound source"

	incbin "STSSP.COM", $, 0416h - ($-$$+BASE_OFS)
loc_10416:
	mov	word [drawColX], SoundFM_X/8
	mov	word [drawRowY], 130
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aSound_FM
	call	DrawText	; "FM sound source"
	
	mov	word [drawColX], SoundMIDI_X/8
	mov	word [drawRowY], 148
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aSound_MIDI
	call	DrawText	; "MIDI sound source"

	incbin "STSSP.COM", $, 0491h - ($-$$+BASE_OFS)
DispAna_X EQU 296	; originally 240
DispLCD_X EQU 296	; originally 256
loc_10491:
	mov	word [drawColX], 200/8		; start pixel X (originally 184)
	mov	word [drawRowY], 192/16		; start pixel Y
	mov	word [drawWidth], 208/16	; inner width (originally 240)
	mov	word [drawHeight], 48/16	; inner height
	call	DrawTextBox	; draw text box for Display Mode Selection
	
	; original properties: text length 15*16 = 240 px, startX = (640-240)/2 = 200
	; new properties: text length 26*8 = 208 px
	mov	word [drawColX], 216/8	; originally 200
	mov	word [drawRowY], 202
	mov	byte [txtColorMain], 4
	mov	byte [txtColorShdw], 8
	mov	si, aDispMode
	call	DrawText	; "Select Display Mode"
	
	mov	word [drawColX], DispAna_X/8
	mov	word [drawRowY], 226
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aDisp_Analog
	call	DrawText	; "Analog Display"
	
	mov	word [drawColX], DispLCD_X/8
	mov	word [drawRowY], 244
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aDisp_LCD
	call	DrawText	; "LCD display"

	incbin "STSSP.COM", $, 0595h - ($-$$+BASE_OFS)
loc_10595:
	mov	word [drawColX], DispAna_X/8
	mov	word [drawRowY], 226
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aDisp_Analog
	call	DrawText	; "Analog Display"
	
	mov	word [drawColX], DispLCD_X/8
	mov	word [drawRowY], 244
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aDisp_LCD
	call	DrawText	; "LCD display"

	incbin "STSSP.COM", $, 05FEh - ($-$$+BASE_OFS)
loc_105FE:
	mov	word [drawColX], DispAna_X/8
	mov	word [drawRowY], 226
	mov	byte [txtColorMain], 3
	mov	byte [txtColorShdw], 0
	mov	si, aDisp_Analog
	call	DrawText	; "Analog Display"
	
	mov	word [drawColX], DispLCD_X/8
	mov	word [drawRowY], 244
	mov	byte [txtColorMain], 1
	mov	byte [txtColorShdw], 8
	mov	si, aDisp_LCD
	call	DrawText	; "LCD display"

	incbin "STSSP.COM", $, 0688h - ($-$$+BASE_OFS)
	mov	word [drawColX], 152/8		; start pixel X (originally 192)
	mov	word [drawRowY], 288/16		; start pixel Y
	mov	word [drawWidth], 304/16	; inner width (originally 224)
	mov	word [drawHeight], 16/16	; inner height
	call	DrawTextBox	; draw text box for "MIDI Init" message
	
	; original properties: text length 14*16 = 224 px, startX = (640-224)/2 = 208
	; new properties: text length 38*8 = 304 px
	mov	word [drawColX], 168/8	; originally 208
	mov	word [drawRowY], 303
	mov	byte [txtColorMain], 10
	mov	byte [txtColorShdw], 9
	mov	si, aMidiInit
	call	DrawText	; "MIDI Initialization in progress"

	incbin "STSSP.COM", $, 07FBh - ($-$$+BASE_OFS)
	mov	dx, QuitText_HDD
	incbin "STSSP.COM", $, 082Ah - ($-$$+BASE_OFS)
	mov	dx, QuitText_Floppy
	incbin "STSSP.COM", $, 0886h - ($-$$+BASE_OFS)
	mov	dx, a5731m
	incbin "STSSP.COM", $, 08A5h - ($-$$+BASE_OFS)
	mov	dx, Err_NotFound
	incbin "STSSP.COM", $, 08AEh - ($-$$+BASE_OFS)
	mov	dx, Err_WriteEnv
	incbin "STSSP.COM", $, 08B7h - ($-$$+BASE_OFS)
	mov	dx, Err_CantOperate
	incbin "STSSP.COM", $, 08BEh - ($-$$+BASE_OFS)
	mov	dx, aExclamation
	incbin "STSSP.COM", $, 08F0h - ($-$$+BASE_OFS)
	mov	dx, Err_PleaseReset

	incbin "STSSP.COM", $, 0A6Bh - ($-$$+BASE_OFS)
DrawText:
	push	ax
	push	ds
	mov	ax, cs
	mov	ds, ax
	mov	bx, [drawColX]
	mov	cx, [drawRowY]
	imul	dx, cx, byte 50h
	add	dx, bx
	mov	[textDrawPtr], dx
	call	WaitForVSync
	mov	al, 0Bh
	out	68h, al
	
loc_10A89:
	call	ParseTextChar
	jz	short loc_10A95
	call	DrawTextChar
	jmp	short loc_10A89
	
loc_10A95:
	mov	al, 0Ah
	out	68h, al
	pop	ds
	pop	ax
	ret

DrawTextChar:
	pusha
	push	ds
	push	es
	
	push	ax
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	
	mov	al, 0C0h
	out	7Ch, al
	pop	ax
	
	mov	cx, 500h-2	; default to full-width (2 bytes on screen)
	;or	ah, ah			; page 0 doesn't work with the current code anyway
	;jz	short dtc_ls_halfwidth	; JIS page 0 -> half-width
	cmp	ah, 9
	jb	short dtc_set_line_step
	cmp	ah, 12
	jnb	short dtc_set_line_step
	;jmp	short dtc_ls_halfwidth	; JIS page 9..11 -> jump to half-width code
dtc_ls_halfwidth:
	inc	cx		; set to half-width (1 byte on screen)
dtc_set_line_step:
	mov	[cs:dtcLineStep], cx
	
dtc_getchar:
	out	0A1h, al	; character code, low byte
	mov	al, ah
	out	0A3h, al	; character code, high byte (page)
	
	mov	dx, txtFontCache
	mov	di, dx
	xor	cl, cl
loc_10AD3:
	mov	al, cl
	or	al, 20h		; L/R bit = "right"
	out	0A5h, al	; write Name Line Counter, font pattern "right"
	in	al, 0A9h	; read Name Character Pattern Data
	mov	ah, al
	mov	al, cl		; L/R bit = "left"
	out	0A5h, al	; write Name Line Counter, font pattern "left"
	in	al, 0A9h	; read Name Character Pattern Data
	stosw	; I can do this due to setting "ES = CS" above
	inc	cl
	cmp	cl, 10h
	jb	short loc_10AD3
	
	mov	ax, 0A800h
	mov	es, ax
	mov	di, [textDrawPtr]
	; from here on, this is mostly the original code (with minor optimizations)
dtc_draw:
	mov	ah, [txtColorShdw]
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	
	push	di
	add	di, byte 50h
	mov	si, dx
	xor	cl, cl
loc_10B15:
	lodsw
	mov	bx, ax
	shr	bx, 1
	or	ax, bx
	xchg	al, ah
	mov	[es:di], ax
	add	di, byte 50h
	inc	cl
	cmp	cl, 10h
	jb	short loc_10B15
	
	mov	ah, [txtColorMain]
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	shr	ah, 1
	sbb	al, al
	out	7Eh, al
	pop	di
	
	mov	si, dx
	xor	cl, cl
loc_10B52:
	lodsw
	mov	bx, ax
	shl	bx, 1
	not	bx
	and	ax, bx
	not	bx
	or	ax, bx
	xchg	al, ah
	mov	[es:di], ax
	add	di, byte 50h
	inc	cl
	cmp	cl, 10h
	jb	short loc_10B52
	
	xor	al, al
	out	7Ch, al
dtcLineStep EQU $+2	; hooray for self-modifying code
	sub	di, 4FEh	; This line is important for proper alignment of the characters.
	mov	[textDrawPtr], di
	pop	es
	pop	ds
	popa
	retn

	times 0B84h-($-$$+BASE_OFS) db	90h

	incbin "STSSP.COM", $, 129Dh - ($-$$+BASE_OFS)
	db	"MIME"
	incbin "STSSP.COM", $, 12D9h - ($-$$+BASE_OFS)
QuitText_Floppy:
	db	1Bh, "[7;36m"
	db	"Thank you for playing. Please remove the disk before you turn off your machine."
	db	1Bh, "[m", 0Dh, 0Ah, '$'
	times 133Bh-($-$$+BASE_OFS) db	00h

	incbin "STSSP.COM", $, 1349h - ($-$$+BASE_OFS)
	dw	Err_WriteEnv
	dw	Err_CantOperate

	incbin "STSSP.COM", $, 1392h - ($-$$+BASE_OFS)
	; --- DOS strings ---
QuitText_HDD:
	db	1Bh, "[7;36m"
	db	"Thank you for playing."
	db	1Bh, "[m", 0Dh, 0Ah, '$'
Err_WriteEnv:
	db	"Unable to write STSSP.ENV$"	; Note: followed by aExclamation
Err_NotFound:
	db	" not found$"	; for "FILE.BIN not found" errors, note: followed by aExclamation
Err_PleaseReset:
	db	0Dh, 0Ah
	db	"Cannot recover. Please reboot."
	db	0Dh, 0Ah, "$"

	db	"ASCII patch by Valley Bell.", 0

; I don't want to move these, because they are all scattered around the code.
	times 141Ah-($-$$+BASE_OFS) db	00h
;a0m1h5h:
;	db	1Bh, "[0m"
;	db	1Bh, "[>1h"
;	db	1Bh, "[>5h"
;	db	1Bh, "*", "$"
;aNewLine:
;	db	0Dh, 0Ah, "$"
;a1l5l:
;	db	1Bh, "[>1l"
;	db	1Bh, "[>5l", "$"

	; --- menu strings ---
	incbin "STSSP.COM", $, 1439h - ($-$$+BASE_OFS)
a5731m:
	db	1Bh, "[5;7;31m", "$"
aExclamation:
	db	"!", 1Bh, "[m"
	db	0Dh, 0Ah, "$"
aSoundMode:
	db	81h, 0A1h, 81h, 40h, "Select Sound Mode", 20h, 81h, 0A1h, 0	; new size: 24
aSound_FM:
	db	82h, 65h, 82h, 6Ch, 0	; FM sound source
aSound_MIDI:
	db	82h, 6Ch, 82h, 68h, 82h, 63h, 82h, 68h, 0	; MIDI sound source
aDispMode:
	db	81h, 0A1h, 81h, 40h, "Select Display Mode", 20h, 81h, 0A1h, 0
aDisp_Analog:
	db	"Analog", 0
aDisp_LCD:
	db	82h, 6Bh, 82h, 62h, 82h, 63h, 0
aMidiInit:
	db	81h, 0A1h, 81h, 40h, "MIDI initialization in progress", 20h, 81h, 0A1h, 0
Err_CantOperate:
	db	"Unsupported environment.$"

ParseTextChar:
	lodsb
	or	al, al
	jz	short ptc_end	; 00 terminator - end
	
	cmp	al, 81h
	jb	short ptc_halfwidth	; 00..80 -> ASCII
	cmp	al, 0A0h
	jb	short ptc_fullwidth	; 81xx .. 9Fxx -> Shift-JIS
	cmp	al, 0E0h
	jb	short ptc_halfwidth	; A0..DF -> half-width Katakana
	cmp	al, 0FDh
	jb	short ptc_fullwidth	; E0xx .. FCxx -> Shift-JIS
ptc_halfwidth:
	xor	ah, ah
	add	al, al		; extract bit 7
	adc	ah, 9		; AL 00h..7Fh -> AH = 09h, AL 80h..0FFh -> AH = 0Ah
	shr	al, 1
ptc_end:
	ret

ptc_fullwidth:
	xchg	ah, al
	lodsb			; read 2nd byte
	
	; do Shift-JIS -> ROM access code conversion
	add	ah, ah
	sub	al, 1Fh
	js	short ptc_sjis_noadd
	cmp	al, 61h
	adc	al, -22h
ptc_sjis_noadd:
	add	ax, 1FA1h
	and	ax, 7F7Fh
	sub	ah, 20h
	ret

end:
