; Dengeki Nurse AdvBIOS (ADVBIOS.OVL) - English Translation
; Patch developed by Valley Bell on 2026-06-28
; Translation by Geometrizer, edited by trentsignia
;
; Assembling using NASM:
;	nasm -f bin -o ADVBIOS.DEC2-EN.OVL -l ADVBIOS-EN.LST "ADVBIOS-EN.asm"
;	This requires ADVBIOS.DEC2.OVL (198 848 bytes) to be in the same folder.
;	"ADVBIOS.DEC2.OVL" is game's ADVBIOS.OVL file from disk A, with TC0-decryption and EXEPACK-compression removed.

	use16
	cpu	186
CODE_BASE_OFS EQU 00140h	; seg000
DATA_BASE_OFS EQU 302C0h	; seg008

	org	-DATA_BASE_OFS

	incbin "ADVBIOS.DEC2.OVL", $, 024Ch - ($-$$-CODE_BASE_OFS)
ShiftJIS2JIS:

	incbin "ADVBIOS.DEC2.OVL", $, 068Ah - ($-$$-CODE_BASE_OFS)
	mov	si, aAskQuit
	mov	bx, 2000h
	mov	cl, 0C5h
	call	DrawText	; replace inline code with equal function call
	jmp	short loc_106B1

	; --- parts of DrawText routine ---
rtchr_1byte:
	xor	ah, ah
	add	al, al		; bit 7 -> carry
	adc	ah, 29h		; ASCII (20..7F) -> page 09h, half-width katakana (A0..DF) -> page 0Ah
	shr	al, 1		; revert additon
	mov	ch, 1
	ret

rtchr_2byte:
	xchg	ah, al
	lodsb
	mov	dx, ax
	call	ShiftJIS2JIS	; call directly instead of "INT 0F1h, AH=2"
	mov	ax, dx
	mov	ch, 2
	ret
	; --- parts of DrawText routine END ---

	times 06B1h-($-$$-CODE_BASE_OFS) db 90h
loc_106B1:


	; sub_10BFC (0BFCh)
	incbin "ADVBIOS.DEC2.OVL", $, 0C18h - ($-$$-CODE_BASE_OFS)
	; Modify "make bold" routine so that the rightmost column is NOT duplicated.
	; The engine usually duplicates all pixel columns to the right, except for the last one.
	; That one is duplicated to the left. (because there is no space on the right)
	; However this causes the letters M W m w to be barely readable.
	; With this fix, the rightmost column is not bold, but the letters are way more readable.
	or	al, 00h


	; Int24 (1290h)
	;incbin "ADVBIOS.DEC2.OVL", $, 12AEh - ($-$$-CODE_BASE_OFS)
	;mov	di, 3	; enforce error message (for debugging, useful values: 0, 1, 0Ah, 0Bh, 0Ch)
	;nop
	
	incbin "ADVBIOS.DEC2.OVL", $, 12BAh - ($-$$-CODE_BASE_OFS)
	add	al, 'A'	; originally 60h
	mov	[aErrorRead_Drive], al
	
	incbin "ADVBIOS.DEC2.OVL", $, 12C1h - ($-$$-CODE_BASE_OFS)
	mov	si, [diskErrMsgList+di]
	
	incbin "ADVBIOS.DEC2.OVL", $, 12DAh - ($-$$-CODE_BASE_OFS)
	mov	si, aErrorReadDrv
	call	DrawText
	pop	si
	call	DrawText
	mov	si, aErrMsgEnd
	call	DrawText
	times 12EAh-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "ADVBIOS.DEC2.OVL", $, 1315h - ($-$$-CODE_BASE_OFS)
	; 1315h: beginning of old DrawText
	;incbin "ADVBIOS.DEC2.OVL", $, 132Eh - ($-$$-CODE_BASE_OFS)
	; 132Eh: old DrawText entry point

j_dtxt_special:
	jmp	near dtxt_special

DrawText:	; 0a64:1a66
	call	ReadTextChar
	test	ch, ch
	jz	short j_dtxt_special
	
	xchg	ah, al
	sub	al, 20h
	mov	[es:bx+di], cl
	stosw
	cmp	ch, 2
	jnz	short DrawText
	or	al, 80h
	mov	[es:bx+di], cl
	stosw
	jmp	short DrawText

	times 1334h-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "ADVBIOS.DEC2.OVL", $, 155Ah - ($-$$-CODE_BASE_OFS)
	add	al, [bp+12h]
	add	al, 'A'	; originally 60h
	mov	[aPutDisk_Drive], al	; write drive ID
	mov	al, [bp+0Eh]
	add	al, 'A'	; originally 60h
	mov	[aPutDisk_Disk], al	; write disk ID
	times 156Ah-($-$$-CODE_BASE_OFS) db 90h
	
	; ShowDiskChgMsg (163Ch)
	incbin "ADVBIOS.DEC2.OVL", $, 1646h - ($-$$-CODE_BASE_OFS)
	mov	di, 65Ch+4
	mov	si, aTopLine
	call	DrawText
	add	di, byte 38h+16
	mov	si, aPutDiskInDrive
	call	DrawText
	add	di, byte 38h+16
	mov	si, aBottomLine
	call	DrawText
	times 1661h-($-$$-CODE_BASE_OFS) db 90h

	; CheckConfidentNote (1A4Eh)
	; verifies "Notice Regarding Confidentiality"
	; In Dengeki Nurse, the code is unused, so we can just overwrite it with custom text render code.
	incbin "ADVBIOS.DEC2.OVL", $, 1A4Eh - ($-$$-CODE_BASE_OFS)
ReadTextChar:
	lodsb
	cmp	al, 20h			; control code
	jb	short rtchr_cntrl
	cmp	al, 81h
	jb	short j_rtchr_1byte	; 00..80 - ASCII
	cmp	al, 0A0h
	jb	short j_rtchr_2byte	; 81..9F - Shift-JIS, 1st byte
	cmp	al, 0E0h
	jb	short j_rtchr_1byte	; A0..DF - half-width katakana
	cmp	al, 0FDh
	jb	short j_rtchr_2byte	; E0..FC - Shift-JIS, 1st byte
					; FD..FF - half-width
j_rtchr_1byte:
	jmp	near rtchr_1byte

j_rtchr_2byte:
	jmp	near rtchr_2byte

rtchr_cntrl:
	xor	ah, ah
	xor	ch, ch
dtxt_ret:
	ret


dtxt_special:
	test	al, al
	jz	short dtxt_ret
	cmp	al, 0Dh
	;jz	short dtxt_linefill
	jnz	short dtxt_nolinefill

dtxt_linefill:
	mov	ax, di	; take target address
	mov	dl, 160
	div	dl	; text RAM target address [AX] / 160 [DL] -> AL = quotient (Y coordinate), AH = remainder (X coordinate * 2)
	shr	ah, 1
	mov	dl, 80
	sub	dl, ah	; DL = remaining characters (words) until reaching end of the line (80 - X coord)
	xor	ax, ax	; character 0 draws nothing (equivalent to a space)
dtxt_lfloop:
	mov	[es:bx+di], cl	; set flags
	stosw		; put text character
	dec	dl
	jnz	short dtxt_lfloop	; loop until end of the line
	; fall through

dtxt_nolinefill:
	jmp	near DrawText


	times 1A92h-($-$$-CODE_BASE_OFS) db 90h


	incbin "ADVBIOS.DEC2.OVL", $, 0132h - ($-$$-DATA_BASE_OFS)
aAskQuit:	; 0132h
	; This message appears if you are running from the hard disk and press the STOP key.
	; "　　　　　　　　　《　　終了してもよろしいですか（ｙ／ｎ）？　　》　　　　　　　"
;	db	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h
;	db	81h, 40h, 81h, 40h, 81h, 40h, 81h, 73h, 81h, 40h, 81h, 40h
;	db	8Fh, 49h, 97h,0B9h, 82h,0B5h, 82h,0C4h, 82h,0E0h, 82h,0E6h
;	db	82h,0EBh, 82h,0B5h, 82h,0A2h, 82h,0C5h, 82h,0B7h, 82h,0A9h
;	db	81h, 69h, 82h, 99h, 81h, 5Eh, 82h, 8Eh, 81h, 6Ah, 81h, 48h
;	db	81h, 40h, 81h, 40h, 81h, 74h, 81h, 40h, 81h, 40h, 81h, 40h
;	db	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h

	db	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h
	db	81h, 40h, 81h, 40h, 81h, 40h, 81h, 40h, " "
	db	81h, 73h, " Shall we end the game here?"
	db	81h, 69h, 82h, 99h, 81h, 5Eh, 82h, 8Eh, 81h, 6Ah, 81h, 74h	; "（ｙ／ｎ）》"
	db	0Dh, 0



	incbin "ADVBIOS.DEC2.OVL", $, 0200h - ($-$$-DATA_BASE_OFS)
diskErrMsgList:	; 0200h
	dw	aDiskWriteProt	; 0
	dw	aDriveNotReady	; 1
	dw	aDriveNotReady	; 2
	dw	aDiskError	; 3
	dw	aDiskError	; 4
	dw	aDiskError	; 5
	dw	aDiskError	; 6
	dw	aDiskError	; 7
	dw	aDiskError	; 8
	dw	aDiskError	; 9
	dw	aDataWriteFail	; 0Ah
	dw	aDataReadFail	; 0Bh
	dw	aDiskError	; 0Ch
	times 021Ah-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "ADVBIOS.DEC2.OVL", $, 024Eh - ($-$$-DATA_BASE_OFS)
	; Total line length: 52 half-width characters / 26 full-width characters
;aTopLine:	; 024Eh
;	; "┌────────────────────────┐"
;	db	86h, 0AEh, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0B2h, 0
;
;aPutDiskInDrive:	; 0283h
;	; "│　　ドライブＡに、ディスク＃Ａを入れてねッ！　　│"
;	db	86h, 0A4h, 81h, 40h, 81h, 40h, 83h, 68h
;	db	83h, 89h, 83h, 43h, 83h, 75h, 82h
;aPutDisk_Drive:	; aPutDiskInDrive+0Fh
;	db	60h	; replaced with 60h (full-width "A") .. 61h (full-width "B")
;	db	82h, 0C9h, 81h, 41h, 83h, 66h, 83h, 42h
;	db	83h, 58h, 83h, 4Eh, 81h, 94h, 82h
;aPutDisk_Disk:	; aPutDiskInDrive+1Fh
;	db	60h	; replaced with 60h (full-width "A") .. 65h (full-width "F")
;	db	82h, 0F0h, 93h, 0FCh, 82h, 0EAh, 82h, 0C4h
;	db	82h, 0CBh, 83h, 62h, 81h, 49h, 81h, 40h
;	db	81h, 40h, 86h, 0A4h, 0
;
;aBottomLine:	; 02B8h
;	; "└────────────────────────┘"
;	db	86h, 0B6h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
;	db	86h, 0A2h, 86h, 0BAh, 0


	; new Total line length: 44 half-width characters / 22 full-width characters
aTopLine:	; 024Eh
	; "┌────────────────────┐"
	db	86h, 0AEh, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0B2h, 0

	times 0283h-($-$$-DATA_BASE_OFS) db 0AAh
aPutDiskInDrive:	; 0283h
	db	86h, 0A4h, 81h, 40h, " ", "Please stick Disk "
aPutDisk_Disk:
	db	"A into Drive "
aPutDisk_Drive:
	db	"A!", 81h, 40h, 81h, 40h, 86h, 0A4h, 0

	times 02B8h-($-$$-DATA_BASE_OFS) db 0AAh
aBottomLine:	; 02B8h
	; "└────────────────────┘"
	db	86h, 0B6h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0A2h
	db	86h, 0A2h, 86h, 0A2h, 86h, 0A2h, 86h, 0BAh, 0

	times 02EDh-($-$$-DATA_BASE_OFS) db 0AAh
	nop


; !! Important !!
; The program prints always prints:
;  - aErrorReadDrv
;  - one of aDiskWriteProt/aDriveNotReady/.../aDiskError
;  - aErrMsgEnd
; The width of the combined text must be 80 half-width characters.
; This also means, that the error description text for all variants must be of the same length.
; ... originally. I introduced an additional "0Dh" control code that just fills the rest of the line. :)
aErrorReadDrv:	; 02EEh
	; "　《　ドライブＡでエラー発生！　"
	; << Error reading Drive A!
;	db	81h, 40h, 81h, 73h, 81h, 40h, 83h, 68h
;	db	83h, 89h, 83h, 43h, 83h, 75h, 82h
;aErrorRead_Drive:	; aErrorReadDrv+0Fh
;	db	60h
;	db	82h, 0C5h, 83h, 47h, 83h, 89h, 81h, 5Bh
;	db	94h, 0ADh, 90h, 0B6h, 81h, 49h, 81h, 40h, 0
	db	81h, 40h, 81h, 73h, " Error reading Drive "
aErrorRead_Drive:	; aErrorReadDrv+0Fh
	db	'A! ', 0

aDiskWriteProt:	; 030Fh
	; "ディスクが書き込み禁止になってるみたいだよ"
	; Looks like the disk's write-protected!
;	db	83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, 82h, 0AAh, 8Fh, 91h
;	db	82h, 0ABh, 8Dh, 9Eh, 82h, 0DDh, 8Bh, 0D6h, 8Eh, 7Eh, 82h, 0C9h
;	db	82h, 0C8h, 82h, 0C1h, 82h, 0C4h, 82h, 0E9h, 82h, 0DDh, 82h, 0BDh
;	db	82h, 0A2h, 82h, 0BEh, 82h, 0E6h, 0
	db	"Looks like the disk's write-protected!", 0
aDriveNotReady:	; 033Ah
	; "ドライブの準備ができていませんよ～～ッ！！"
;	db	83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, 82h, 0CCh, 8Fh, 80h
;	db	94h, 0F5h, 82h, 0AAh, 82h, 0C5h, 82h, 0ABh, 82h, 0C4h, 82h, 0A2h
;	db	82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 82h, 0E6h, 81h, 60h, 81h, 60h
;	db	83h, 62h, 81h, 49h, 81h, 49h, 0
	db	"Wait up, it isn't ready yet!", 0
aDataWriteFail:	; 0365h
	; "クスン‥‥データの書き込みに失敗しちゃった"
;	db	83h, 4Eh, 83h, 58h, 83h, 93h, 81h, 64h, 81h, 64h, 83h, 66h
;	db	81h, 5Bh, 83h, 5Eh, 82h, 0CCh, 8Fh, 91h, 82h, 0ABh, 8Dh, 9Eh
;	db	82h, 0DDh, 82h, 0C9h, 8Eh, 0B8h, 94h, 73h, 82h, 0B5h, 82h, 0BFh
;	db	82h, 0E1h, 82h, 0C1h, 82h, 0BDh, 0
	db	"Sniff sniff, I couldn't write any data!", 0
aDataReadFail:	; 0390h
	; "クスン‥‥データの読み込みに失敗しちゃった"
;	db	83h, 4Eh, 83h, 58h, 83h, 93h, 81h, 64h, 81h, 64h, 83h, 66h
;	db	81h, 5Bh, 83h, 5Eh, 82h, 0CCh, 93h, 0C7h, 82h, 0DDh, 8Dh, 9Eh
;	db	82h, 0DDh, 82h, 0C9h, 8Eh, 0B8h, 94h, 73h, 82h, 0B5h, 82h, 0BFh
;	db	82h, 0E1h, 82h, 0C1h, 82h, 0BDh, 0
	db	"Sniff sniff, I couldn't read any data!", 0
aDiskError:	; 03BBh
	; "何か変だよ？　ディスクをよ～く確認してねッ"
;	db	89h, 0BDh, 82h, 0A9h, 95h, 0CFh, 82h, 0BEh, 82h, 0E6h, 81h, 48h
;	db	81h, 40h, 83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, 82h, 0F0h
;	db	82h, 0E6h, 81h, 60h, 82h, 0ADh, 8Ah, 6Dh, 94h, 46h, 82h, 0B5h
;	db	82h, 0C4h, 82h, 0CBh, 83h, 62h, 0
	db	"Something's up... Check the disk, will ya?", 0
aErrMsgEnd:		; 03E6h
	; "　》　"
;	db	81h, 40h, 81h, 74h, 81h, 40h, 0 ; DATA XREF: seg000:12E4o
	db	" ", 81h, 74h, 0Dh, 0 ; DATA XREF: seg000:12E4o
	times 03EDh-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "ADVBIOS.DEC2.OVL", $
