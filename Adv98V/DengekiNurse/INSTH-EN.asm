; Dengeki Nurse Install Program (INSTH.EXE) - English Translation
; Patch developed by Valley Bell on 2026-06-17
; Translation by trentsignia
;
; Assembling using NASM:
;	nasm -f bin -o INSTH.DEC2-EN.EXE -l INSTH-EN.LST "INSTH-EN.asm"
;	This requires INSTH.DEC2.EXE (75 248 bytes) to be in the same folder.
;	"INSTH.DEC2.EXE" is game's INSTH.EXE file from disk A, with TC0-decryption and EXEPACK-compression removed.

	use16
	cpu	186
CODE_BASE_OFS EQU 00040h
DATA_BASE_OFS EQU 11E60h

	org	-DATA_BASE_OFS

	incbin "INSTH.DEC2.EXE", $, 003Dh - ($-$$-CODE_BASE_OFS)
	mov	ax, aInstallNote
	
	incbin "INSTH.DEC2.EXE", $, 0047h - ($-$$-CODE_BASE_OFS)
	mov	ax, aPressAnyKey
	
	incbin "INSTH.DEC2.EXE", $, 0068h - ($-$$-CODE_BASE_OFS)
	mov	ax, aDriveRoot
	
	incbin "INSTH.DEC2.EXE", $, 010Eh - ($-$$-CODE_BASE_OFS)
	mov	ax, aExitProgram
	
	incbin "INSTH.DEC2.EXE", $, 0126h - ($-$$-CODE_BASE_OFS)
	mov	ax, aErrorNum
	
	incbin "INSTH.DEC2.EXE", $, 01B1h - ($-$$-CODE_BASE_OFS)
	mov	ax, aBadDrive
	
	incbin "INSTH.DEC2.EXE", $, 1992h - ($-$$-CODE_BASE_OFS)
	mov	ax, aGameTitle
	
	incbin "INSTH.DEC2.EXE", $, 19A6h - ($-$$-CODE_BASE_OFS)
	mov	si, [bx+instructStrList]
	
	incbin "INSTH.DEC2.EXE", $, 19DAh - ($-$$-CODE_BASE_OFS)
	mov	si, [bx+syntaxStrList]
	
	incbin "INSTH.DEC2.EXE", $, 1BEAh - ($-$$-CODE_BASE_OFS)
	push	si		; swap the two arguments - JP text is "drive A:, disk #B"
	push	word [bp-12h]	; but EN text is "disk #B into drive A:"
	mov	ax, aInsertDisk
	times 1BF1h-($-$$-CODE_BASE_OFS) db 90h
	
	incbin "INSTH.DEC2.EXE", $, 1C7Bh - ($-$$-CODE_BASE_OFS)
	mov	ax, aCouldNotCopy
	
	incbin "INSTH.DEC2.EXE", $, 1E54h - ($-$$-CODE_BASE_OFS)
	mov	ax, aNoStartFile
	

	incbin "INSTH.DEC2.EXE", $, 006Eh - ($-$$-DATA_BASE_OFS)
aInstallNote:	; 006Eh
	; >>> ドライブ %c: から %c: へ インストールします。
	;db	">>> ", 83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, " %c: "
	;db	82h, 0A9h, 82h, 0E7h, " %c: ", 82h, 0D6h, " "
	;db	83h, 43h, 83h, 93h, 83h, 58h, 83h, 67h, 81h, 5Bh
	;db	83h, 8Bh, 82h, 0B5h, 82h, 0DCh, 82h, 0B7h, 81h, 42h, 0Ah, 0
	db	">>> The contents of Drive %c: will now be installed to Drive %c:.", 0Ah, 0
	;times 00A1h-($-$$-DATA_BASE_OFS) db 0AAh

	;incbin "INSTH.DEC2.EXE", $, 00A1h - ($-$$-DATA_BASE_OFS)
aPressAnyKey:	; 00A1h
	; >>> よろしければ何かキーを押してください。
	;db	">>> ", 82h, 0E6h, 82h, 0EBh, 82h, 0B5h
	;db	82h, 0AFh, 82h, 0EAh, 82h, 0CEh, 89h, 0BDh, 82h, 0A9h
	;db	83h, 4Ch, 81h, 5Bh, 82h, 0F0h, 89h, 9Fh, 82h, 0B5h
	;db	82h, 0C4h, 82h, 0ADh, 82h, 0BEh, 82h, 0B3h, 82h, 0A2h
	;db	81h, 42h, 0Ah, 0
	db	">>> Press any key to continue.", 0Ah, 0
	;times 00CDh-($-$$-DATA_BASE_OFS) db 0AAh

	;incbin "INSTH.DEC2.EXE", $, 00CDh - ($-$$-DATA_BASE_OFS)
; [moved down] aDriveRoot:	; 00CDh
;	db	"%c:\", 0
	times 00D2h-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $, 00DBh - ($-$$-DATA_BASE_OFS)
aExitProgram:	; 00DBh
	; >>> 終了しました。
	;db	0Ah, ">>> ", 8Fh, 49h, 97h, 0B9h, 82h, 0B5h, 82h, 0DCh
	;db	82h, 0B5h, 82h, 0BDh, 81h, 42h, 0Ah, 0
	db	0Ah, ">>> Exiting program...", 0Ah, 0
	;times 00F0h-($-$$-DATA_BASE_OFS) db 0AAh

	;incbin "INSTH.DEC2.EXE", $, 00F0h - ($-$$-DATA_BASE_OFS)
; [moved down] aGameTitle:	; 00F0h
;	; 電撃ナース
;	;db	" ", 93h, 64h, 8Ch, 82h, 83h, 69h, 81h, 5Bh, 83h, 58h, " ", 0
;	db	" Dengeki Nurse ", 0

aDriveRoot:	; (moved from 00CDh)
	db	"%c:\", 0
	times 00FEh-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $, 0128h - ($-$$-DATA_BASE_OFS)
aErrorNum:	; 0128h
	; エラー: %s.
	;db	0Ah, 83h, 47h, 83h, 89h, 81h, 5Bh, ": %s.", 0
	db	0Ah, "Error: %s.", 0
	times 0135h-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $, 013Ah - ($-$$-DATA_BASE_OFS)
aBadDrive:	; 013Ah
	; ドライブの指定が違います。
	;db	83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, 82h, 0CCh, 8Eh, 77h, 92h, 0E8h
	;db	82h, 0AAh, 88h, 0E1h, 82h, 0A2h, 82h, 0DCh, 82h, 0B7h, 81h, 42h, 0
	db	"Incorrect drive specified.", 0
	times 0155h-($-$$-DATA_BASE_OFS) db 0AAh


	incbin "INSTH.DEC2.EXE", $, 0470h - ($-$$-DATA_BASE_OFS)
aInsthAdv98V:	; 0470h
	; InstH: Adv98V ハードディスク インストール プログラム  Version 1.01
	;db	"InstH: Adv98V "
	;db	83h, 6Eh, 81h, 5Bh, 83h, 68h, 83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, ' '
	;db	83h, 43h, 83h, 93h, 83h, 58h, 83h, 67h, 81h, 5Bh, 83h, 8Bh, ' '
	;db	83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h
	;db	"  Version 1.01", 0Ah, 0
	db	"InstH: Adv98V Hard Disk Install Program, Version 1.01", 0Ah, 0

aCopyrightTune:	; 04B4h
	db	"Copyright(C) Tuneup. 1991,92.", 0Dh, 0
aCopyrightIdes:	; 04D3h
	; Copyright(C) (有)アイデス 1991,92.
	;db	"Copyright(C) (", 97h, 4Ch, ")", 83h, 41h, 83h, 43h, 83h, 66h, 83h, 58h, " 1991,92.", 0Ah, 0
	db	"Copyright(C) IDES Co., Ltd. 1991,92.", 0Ah, 0
;asc_22317:	; 04F7h
;	db	0Ah, 0
aProgramName:	; 04F9h
	; プログラム名: " %s "
	;db	83h, 76h, 83h, 8Dh, 83h, 4Fh, 83h, 89h, 83h, 80h, 96h, 0BCh, ': " %s "', 0Ah, 0
	db	'Program Name: "%s"', 0Ah, 0
aGameTitle:	; (moved from 00F0h)
	db	"Dengeki Nurse", 0
	times 050Fh-($-$$-DATA_BASE_OFS) db 0AAh
asc_22317:
asc_2232F:	; 050Fh
	db	0Ah, 0


	times 0511h-($-$$-DATA_BASE_OFS) db 0AAh
	incbin "INSTH.DEC2.EXE", $, 0512h - ($-$$-DATA_BASE_OFS)
instructStrList:	; 0512h
	dw	aInsthAdv98V
	dw	aCopyrightTune
	dw	aCopyrightIdes
	dw	asc_22317
	dw	aProgramName
	dw	asc_2232F
	dw	0


aSyntax:	; 0520h
	; 使用法: insth s: d:
	;db	8Eh, 67h, 97h, 70h, 96h, 40h, ": insth s: d:", 0Ah, 0
	db	"Syntax: insth s: d:", 0Ah, 0
aStxFloppyDrive:	; 0535h
	; s: = フロッピーディスクのドライブ番号
	;db	9, "s: = ", 83h, 74h, 83h, 8Dh, 83h, 62h
	;db	83h, 73h, 81h, 5Bh, 83h, 66h, 83h, 42h, 83h, 58h
	;db	83h, 4Eh, 82h, 0CCh, 83h, 68h, 83h, 89h, 83h, 43h
	;db	83h, 75h, 94h, 0D4h, 8Dh, 86h, 0Ah, 0
	db	9, "s: = Floppy Disk Drive Letter", 0Ah, 0
aStxHardDisk:	; 055Dh
	; d: = ハードディスクのドライブ番号
	;db	9, "d: = ", 83h, 6Eh, 81h, 5Bh, 83h, 68h
	;db	83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, 82h, 0CCh
	;db	83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, 94h, 0D4h
	;db	8Dh, 86h, 0Ah, 0
	db	9, "d: = Hard Disk Drive Letter", 0Ah, 0
; [moved down] aExample:	; 0581h
;	; 例）
;	;db	"  ", 97h, 0E1h, 81h, 6Ah, 0Ah, 0
;	db	"  Example:", 0Ah, 0
	times 0589h-($-$$-DATA_BASE_OFS) db 0AAh
aInsthBA:	; 0589h
	db	9, "insth b: a:", 0Ah, 0
aInsthDB:	; 0597h
	db	9, "insth d: b:", 0Ah, 0

	times 05A5h-($-$$-DATA_BASE_OFS) db 0AAh
	incbin "INSTH.DEC2.EXE", $, 05A6h - ($-$$-DATA_BASE_OFS)
syntaxStrList:	; 05A6h
	dw	aSyntax
	dw	aStxFloppyDrive
	dw	aStxHardDisk
	dw	aExample
	dw	aInsthBA
	dw	aInsthDB
	dw	0


	incbin "INSTH.DEC2.EXE", $, 05BCh - ($-$$-DATA_BASE_OFS)
aInsertDisk:	; 05BCh
	; >>> ドライブ %c: に ディスク #%c をセットしてください。
	;db	">>> ", 83h, 68h, 83h, 89h, 83h, 43h, 83h, 75h, " %c: "
	;db	82h, 0C9h, " ", 83h, 66h, 83h, 42h, 83h, 58h, 83h, 4Eh, " #%c "
	;db	82h, 0F0h, 83h, 5Ah, 83h, 62h, 83h, 67h, 82h, 0B5h, 82h, 0C4h
	;db	82h, 0ADh, 82h, 0BEh, 82h, 0B3h, 82h, 0A2h, 81h, 42h, 7, 0Ah, 0
	db	">>> Please insert Disk #%c into Drive %c:.", 7, 0Ah, 0
aExample:	; (moved from 0581h)
	db	"  Example:", 0Ah, 0
	times 05F6h-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $, 0620h - ($-$$-DATA_BASE_OFS)
aCouldNotCopy:	; 0620h
	; ファイルがコピーできません
	;db	83h, 74h, 83h, 40h, 83h, 43h, 83h, 8Bh, 82h, 0AAh, 83h, 52h, 83h, 73h
	;db	81h, 5Bh, 82h, 0C5h, 82h, 0ABh, 82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 0
	db	"Files could not be copied.", 0
	times 063Bh-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $, 065Eh - ($-$$-DATA_BASE_OFS)
aNoStartFile:	; 065Eh
	; スタート用ファイルが作成できません
	;db	83h, 58h, 83h, 5Eh, 81h, 5Bh, 83h, 67h, 97h, 70h, 83h, 74h
	;db	83h, 40h, 83h, 43h, 83h, 8Bh, 82h, 0AAh, 8Dh, 0ECh, 90h, 0ACh
	;db	82h, 0C5h, 82h, 0ABh, 82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 0
	db	"Start file could not be created.", 0

	times 0681h-($-$$-DATA_BASE_OFS) db 0AAh

	incbin "INSTH.DEC2.EXE", $
