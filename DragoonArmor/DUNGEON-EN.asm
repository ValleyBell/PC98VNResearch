; "Dragoon Armor For Adult" DUNGEON.EXE - English patch
; Decompilation and patch developed by Valley Bell.
; Translation by fuzion and BabaJeanmel.
;
; Assembling using NASM:
;	nasm -f bin -o "DUNGEON-EN.EXE" -l "DUNGEON-EN.LST" "DUNGEON-EN.asm"
;	This requires DUNGEON.DEC2.EXE (79 712 bytes) to be in the same folder.
;	This is the game's "DUNGEON.EXE" without protection and compression.

	use16
	cpu	186
DATA_BASE_OFS EQU 0070h
CODE_BASE_OFS EQU 0D3D0h

	org	-DATA_BASE_OFS

	incbin "DUNGEON.DEC2.EXE", $, 061Eh - ($-$$-DATA_BASE_OFS)
tListEquip:	; 061Eh
	DW	weaponList
	DW	armorList
	DW	shieldList
	DW	itemList
weaponList:	; 0626h
	DW	txtEqp00_0
	DW	txtEqp00_1
	DW	txtEqp00_2
	DW	txtEqp00_3
	DW	txtEqp00_4
	DW	txtEqp00_5
	DW	txtEqp00_6
	DW	txtEqp00_7
	DW	txtEqp00_8
	DW	txtEqp00_9
	DW	txtEqp00_10
txtEqp00_0:
	db	"Bare", 0
	dw	0		; price
	db	0, 1, 4, 0	; STR, RNG rolls, RNG damage range [1..N], base damage
txtEqp00_1:
	db	"Dagger", 0
	dw	10
	db	5, 1, 6, 0
txtEqp00_2:
	db	"Hammer", 0
	dw	20
	db	15, 1, 8, 2
txtEqp00_3:
	db	"Short Sword", 0
	dw	50
	db	20, 2, 6, 0
txtEqp00_4:
	db	"Long Sword", 0
	dw	100
	db	35, 3, 6, 6
txtEqp00_5:
	db	"Broad Sword", 0
	dw	500
	db	40, 3, 8, 8
txtEqp00_6:
	db	"Falchion", 0
	dw	600
	db	28h, 4, 6, 8
txtEqp00_7:
	db	"Bastard", 0
	dw	1500
	db	60, 6, 6, 10
txtEqp00_8:
	db	"Great Sword", 0
	dw	10000
	db	100, 10, 6, 10
txtEqp00_9:
	db	"Silver Bastard", 0
	dw	30000
	db	60, 10, 10, 20
txtEqp00_10:
	db	"Dragon Slayer", 0
	dw	60000
	db	40, 10, 20, 30
	;times 0703h-($-$$-DATA_BASE_OFS) db 00h

	;incbin "DUNGEON.DEC2.EXE", $, 0703h - ($-$$-DATA_BASE_OFS)
armorList:	; 0703h
	DW	txtEqp01_0
	DW	txtEqp01_1
	DW	txtEqp01_2
	DW	txtEqp01_3
	DW	txtEqp01_4
	DW	txtEqp01_5
	DW	txtEqp01_6
	DW	txtEqp01_7
	DW	txtEqp01_8
	DW	txtEqp01_9
	DW	txtEqp01_10
txtEqp01_0:
	db	"None", 0
	dw	0		; price
	db	0, 0, 0		; STR, DEX, DEF
txtEqp01_1:
	db	"Robe", 0
	dw	10
	db	2, 2, 2
txtEqp01_2:
	db	"Leather Armor", 0
	dw	30
	db	4, 1, 5
txtEqp01_3:
	db	"Ring Mail", 0
	dw	50
	db	12, 3, 10
txtEqp01_4:
	db	"Scale Mail", 0
	dw	100
	db	20, 5, 15
txtEqp01_5:
	db	"Half Plate", 0
	dw	500
	db	60, 7, 20
txtEqp01_6:
	db	"Chain Mail", 0
	dw	800
	db	70, 10, 30
txtEqp01_7:
	db	"Plate Mail", 0
	dw	1500
	db	120, 20, 40
txtEqp01_8:
	db	"Mithril Mail", 0
	dw	5000
	db	100, 20, 60
txtEqp01_9:
	db	"Silver Plate", 0
	dw	10000
	db	100, 15, 100
txtEqp01_10:
	db	"Dragon Armor", 0
	dw	50000
	db	60, 0, 150
	;times 07DDh-($-$$-DATA_BASE_OFS) db 00h

	;incbin "DUNGEON.DEC2.EXE", $, 07DDh - ($-$$-DATA_BASE_OFS)
shieldList:	; 07DDh
	DW	txtEqp02_0
	DW	txtEqp02_1
	DW	txtEqp02_2
	DW	txtEqp02_3
	DW	txtEqp02_4
	DW	txtEqp02_5
	DW	txtEqp02_6
	DW	txtEqp02_7
	DW	txtEqp02_8
txtEqp02_0:
	db	"None", 0
	dw	0		; price
	db	0, 0, 0		; STR, DEX, DEF
txtEqp02_1:
	db	"Cutter Shield", 0
	dw	10
	db	2, 0, 2
txtEqp02_2:
	db	"Wood Shield", 0
	dw	50
	db	5, 1, 5
txtEqp02_3:
	db	"Small Shield", 0
	dw	100
	db	10, 3, 10
txtEqp02_4:
	db	"Round Shield", 0
	dw	200
	db	20, 6, 15
txtEqp02_5:
	db	"Large Shield", 0
	dw	500
	db	30, 10, 20
txtEqp02_6:
	db	"Wall Shield", 0
	dw	1000
	db	50, 30, 30
txtEqp02_7:
	db	"Silver Shield", 0
	dw	5000
	db	20, 5, 50
txtEqp02_8:
	db	"D.Scale Shield", 0
	dw	30000
	db	10, 0, 50
	;times 0895h-($-$$-DATA_BASE_OFS) db 00h

	;incbin "DUNGEON.DEC2.EXE", $, 0895h - ($-$$-DATA_BASE_OFS)
itemList:	; 0895h
	DW	txtEqp03_0
	DW	txtEqp03_1
	DW	txtEqp03_2
	DW	txtEqp03_3
	DW	txtEqp03_4
	DW	txtEqp03_5
	DW	txtEqp03_6
	DW	txtEqp03_7
	DW	txtEqp03_8
	DW	txtEqp03_9
	DW	txtEqp03_10
txtEqp03_0:
	db	"None", 0
	dw	0		; price
	db	0		; ?
txtEqp03_1:
	db	"Crystal", 0
	dw	0
	db	0
txtEqp03_2:
	db	"Sword Hilt", 0
	dw	0
	db	0
txtEqp03_3:
	db	"Ribbon", 0
	dw	0
	db	0
txtEqp03_4:
	db	"Still Sword", 0
	dw	0
	db	10
txtEqp03_5:
	db	"H-Book Vol.1", 0
	dw	10000
	db	1
txtEqp03_6:
	db	"H-Book Vol.2", 0
	dw	15000
	db	1
txtEqp03_7:
	db	"H-Book Vol.3", 0
	dw	20000
	db	1
txtEqp03_8:
	db	22h, "Ring of STR", 22h, "}", 0
	dw	3000
	db	0
txtEqp03_9:
	db	22h, "Ring of DEF", 22h, "}", 0
	dw	5000
	db	0
txtEqp03_10:
	db	"Key", 0
	dw	0
	db	0
	times 0947h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 0947h - ($-$$-DATA_BASE_OFS)
tList0947:	; 0947h
	DW	t0947_00
	DW	t0947_01
	DW	t0947_02
	DW	t0947_03
	DW	t0947_04
t0947_00:
	db	" Critical hit!", 0Ah
t0947_01:
	db	" Critical hit!", 0Ah
t0947_02:
	db	" Defeated!", 0Ah
t0947_03:
	db	" Damage suffered.", 0Ah
t0947_04:
	db	" Damage dealt.", 0Ah
	times 09B7h-($-$$-DATA_BASE_OFS) db 00h
itemNameBuffer:	; 09B7h

	incbin "DUNGEON.DEC2.EXE", $, 0A07h - ($-$$-DATA_BASE_OFS)
txt_0A07:
	db	04h, 1Ah, 0Ah
txt_0A0A:
	db	07h, " obtained.", 0Dh, 13h, 0Ah
	times 0A18h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 0C8Eh - ($-$$-DATA_BASE_OFS)
txt_0C8E:	; "Monster x# appears" colour setup
	db	07h, 13h
	times 0C90h-($-$$-DATA_BASE_OFS) db 00h

txt_0C90:	; monster name buffer
	db	0
	times 0CA6h-($-$$-DATA_BASE_OFS) db 00h

; Monster "x# appears" text
txt_0CA6:	; "　が　##　匹　います．", 12h, 0Ah
	;db	81h, 40h, 82h, 0AAh, 81h, 40h
	db	" x"
MstAppear_Number:
	dw	0000h	; replaced with Shift-JIS number character
	;db	81h, 40h, 95h, 43h, 81h, 40h, 82h, 0A2h, 82h, 0DCh, 82h, 0B7h, 81h, 44h, 12h, 0Ah
	db	" appeared.", 12h, 0Ah
	times 0CBEh-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 1021h - ($-$$-DATA_BASE_OFS)
txt_1021:
	db	06h, "The door is locked.", 0Ah
txt_1039:
	db	07h, "Go upstairs? [", 85h, 78h, " or N]", 0Ah
txt_1065:
	db	07h, "Go downstairs? [", 85h, 78h, " or N]", 0Ah
txt_1091:	; [unused] わーーーー
	db	07h, 82h, 0EDh, 81h, 5Bh, 81h, 5Bh, 81h, 5Bh, 81h, 5Bh, 0Dh, 0Ah
	incbin "DUNGEON.DEC2.EXE", $, 109Eh - ($-$$-DATA_BASE_OFS)
txt_109E:
	db	07h, 13h, "What will you do?", 0Ah
txt_10B1:
	db	07h, 13h, "Which spell should Fin cast?", 0Ah
	times 10DAh-($-$$-DATA_BASE_OFS) db 00h
	incbin "DUNGEON.DEC2.EXE", $, 10DEh - ($-$$-DATA_BASE_OFS)
txt_10DE:
	db	"Dodged!", 0Dh, 0Ah
txt_10F4:
	db	"Evaded!", 0Dh, 0Ah
txt_1108:
	db	"Failed!", 0Dh, 0Ah
txt_111C:	; [unused] ランディスは攻撃した
	db	07h, 13h, "Randis attacks!", 0Dh, 0Ah
txt_1133:
	db	07h, 13h, "Randis defends!", 0Dh, 0Ah
txt_1149:
	db	07h, 13h, "Randis runs away! ", 0Ah
txt_1162:
	db	"Managed to escape!", 0Dh, 0Ah
txt_116E:
	db	07h, 13h, 0Ah
txt_1171:
	db	" attacks! ", 0Ah
txt_1178:
	db	07h, " damage. ", 0Dh, 0Ah
txt_1199:
	db	07h, " damage! ", 0Dh, 0Ah
txt_11A8:
	db	" defeated.", 0Dh, 0Ah
txt_11B4:
	db	1Ah, 02h, "Randis is dead.", 07h, 0Dh, 0Ah
txt_11CB:
	db	12h, 07h, "Randis attacked again!", 0Dh, 0Ah
txt_11EB:
	db	03h, 1Ah, "Level up!", " ", 07h, "Level ", 0Ah
txt_11FE:
	db	07h, " reached!", 12h, 0Dh, 0Ah
txt_1214:
	db	"HP Max is now ", 0Ah
txt_1223:
	db	"!", 0Dh, 12h, 0Ah
txt_1232:
	db	1Ah, 0Ah
txt_1234:
	db	12h, 0Ah
txt_1236:
	db	1Ah, 07h, "Fin casts ", 0Ah
txt_1243:
	db	07h, "!", 0Dh, 0Ah
txt_1254:
	db	1Ah, 05h, "Fin, please use ", 0Ah
txt_1261:
	db	05h, "!", 0Dh, 07h, 0Ah
txt_1273:
	db	12h, 07h, 0Ah
txt_1276:
	db	12h, 06h, "I don't want to, it's too much trouble.", 0Dh
	db	12h, 05h, "Ugh, no way!", 0Dh, 07h, 1Ah, 0Ah
txt_12B1:
	db	04h, "Heal", 0Ah
txt_12BD:
	db	04h, "Guard", 0Ah
txt_12C9:
	db	04h, "Blast", 0Ah
txt_12D5:
	db	12h, 0Ah
txt_12D7:
	db	07h, " HP recovered!", 0Dh, 07h, 1Ah, 0Ah
txt_12EC:
	db	" took a breath! ", 0Ah
txt_12FF:
	db	05h, "Nice, dragon scales resisted the fire!", 07h, 0Dh, 0Ah
txt_132B:
	db	07h, " glares at you. ", 0Ah
txt_133B:
	db	12h, 05h, "Aaaargh! ", 02h, "Ping ", 0Dh
	db	12h, 06h, "Pull yourself together, you can't turn to stone here!", 07h, 0Dh, 0Ah
txt_13B2:
	db	02h, 12h, "Randis' strength is being drained!", 07h, 0Dh, 0Ah
txt_13D5:
	db	1Ah, 05h, "Aaaaaah! ", 02h, "Crash!"
	db	12h, 06h, "Enemy hit! ", 0Ah
txt_13FF:
	db	06h, " damage dealt! Keep it up!", 0Dh, 07h, 1Ah, 0Ah
txt_1421:
	db	1Ah, 02h, "Slash!"
	db	12h, 06h, "Nice! ", 0Ah
txt_1444:
	db	06h, " damage dealt!", 0Dh, 07h, 1Ah, 0Ah
txt_1453:
	db	1Ah, 07h, "Aaaaaah! ", 05h, "Uh? I missed...", 0Dh, 07h, 1Ah, 0Ah
txt_1486:
	db	12h, 06h, "But it has no effect...", 0Dh, 07h, 1Ah, 0Ah
txt_14AA:
	db	07h, " casts ", 04h, 0Ah
txt_14AF:
	db	07h, "! ", 0Dh, 0Ah
txt_14C0:
	db	"Cure", 0Ah
txt_14C9:
	db	"Fire Ball", 0Ah
txt_14DA:
	db	"Healing EX", 0Ah
txt_14ED:
	db	"Fire Arrow", 0Ah
txt_1500:
	db	"Full Healing", 0Ah
txt_1513:
	db	"Fire Storm", 0Ah
txt_1526:
	db	07h, " damage!", 0Dh, 0Ah
txt_153D:
	db	05h, " Ouch!", 0Dh
	db	12h, 06h, "Are you OK?... Fou warned you about this.", 0Dh
	db	05h, 12h, "Easy for you to say, you can fly!", 0Dh, 1Ah, 07h, 0Ah
txt_15C2:
	db	05h, " Ouch...", 0Dh
	db	12h, 06h, "Hey, are you really going to fall into the same trap over and over?", 0Dh
	db	12h, 05h, "If you noticed the trap, just tell me!", 0Dh
	db	12h, 06h, "Act like a man, and take responsability for your actions!", 0Dh, 1Ah, 0Ah
txt_165D:
	db	05h, " Ouch!", 0Dh
	db	12h, 06h, "Are you OK?... Honestly, Fou warned you about this.", 0Dh
	db	12h, 05h, "...I never imagined there would be pitfalls straight from the third floor...", 0Dh, 1Ah, 0Ah
txt_16F5:
	db	06h, "Phew... Good work. Where's the treasure chest?", 0Dh
	db	12h, 05h, "Ah, I'll open it now... It opened!", 0Dh
	db	1Ah, 06h, "...What was inside?", 0Dh
	db	12h, 05h, "A crystal...", 0Dh
	db	1Ah, 06h, "Perhaps one of the sword blades...", 0Dh
	db	12h, 05h, "Probably. It fit perfectly into the recess in the hilt.", 0Dh
	db	1Ah, 06h, "Come on, there's no time to waste. Let's continue exploring.", 0Dh, 1Ah, 07h, 0Ah
txt_17F8:
	db	05h, "Whoa, Fin! Wait a minute. If I put on the fifth one...", 0Dh
	db	12h, 06h, "Eh? That sword...", 0Dh
	db	1Ah, 05h, "This is the legendary Sword of Light..."
	db	12h, 07h, "Snap!", 0Dh
	db	12h, 06h, "Randis, what's wrong? Are you spacing out?...", 0Dh
	db	12h, 05h, "Quiet! Someone's talking to me directly into my head!", 0Dh
	db	1Ah, 07h, "Hero who holds the Still Sword, I have something to tell you...", 0Dh
	db	1Ah, 07h, "This sword can't be used with a murderous intent. It must be wielded to savelives, not take them.", 0Dh
	db	1Ah, 07h, "Wield the iron sword to cut through the dark, and the sword of light to", 0Dh
	db	12h, 05h, "restore light from it...", 0Dh
	db	1Ah, 07h, "If you swear to carve these words into your heart... I will recognize you asa champion of light... Can you swear that?", 0Dh
	db	12h, 05h, "I swear it!", 0Dh
	db	1Ah, 07h, "Very well. Then, until that time comes... I will fall into a short slumber. If you call upon me, I will rise again.", 0Dh
	db	1Ah, 05h, "...", 0Dh
	db	1Ah, 05h, "I can't hear anything anymore...", 0Dh
	db	12h, 06h, "What was the voice saying?", 0Dh
	db	1Ah, 05h, "That I can't wield the sword to take lives. It was as if the sword", 0Dh
	db	12h, 05h, "was speaking to me...", 0Dh
	db	1Ah, 06h, "Ah? The blade's gone...", 0Dh, 1Ah, 0Ah
	times 1BCDh-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 230Eh - ($-$$-DATA_BASE_OFS)
txt_230E:
	db	0
	times 230Fh-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 2524h - ($-$$-DATA_BASE_OFS)
txt_2524:
	db	"Dungeon Put & Move Routine", 0Dh, 0Ah, "DUNGEON", 0Dh, 0Ah, "$"
txt_254A:	; "ＥＸＥＣに失敗しました。", 0Dh, 0Ah, "$"
	db	82h, 64h, 82h, 77h, 82h, 64h, 82h, 62h, 82h, 0C9h, 8Eh, 0B8h, 94h, 73h, 82h, 0B5h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh, 81h, 42h, 0Dh, 0Ah, "$"
txt_2565:	; "メモリ－が変更できません。", 0Dh, 0Ah, "$"
	db	83h, 81h, 83h, 82h, 83h, 8Ah, 81h, 7Ch, 82h, 0AAh, 95h, 0CFh, 8Dh, 58h, 82h, 0C5h, 82h, 0ABh, 82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 81h, 42h, 0Dh, 0Ah, "$"
txt_2582:	; "メモリーが確保できません。", 0Dh, 0Ah, "$"
	db	83h, 81h, 83h, 82h, 83h, 8Ah, 81h, 5Bh, 82h, 0AAh, 8Ah, 6Dh, 95h, 0DBh, 82h, 0C5h, 82h, 0ABh, 82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 81h, 42h, 0Dh, 0Ah, "$"
txt_259F:	; "メモリーの解放に失敗しました。", 0Dh, 0Ah, "$"
	db	83h, 81h, 83h, 82h, 83h, 8Ah, 81h, 5Bh, 82h, 0CCh, 89h, 0F0h, 95h, 0FAh, 82h, 0C9h, 8Eh, 0B8h, 94h, 73h, 82h, 0B5h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh, 81h, 42h, 0Dh, 0Ah, "$"
txt_25C0:	; "ファイルがオープンできません。", 0Dh, 0Ah, "$"
	db	83h, 74h, 83h, 40h, 83h, 43h, 83h, 8Bh, 82h, 0AAh, 83h, 49h, 81h, 5Bh, 83h, 76h, 83h, 93h, 82h, 0C5h, 82h, 0ABh, 82h, 0DCh, 82h, 0B9h, 82h, 0F1h, 81h, 42h, 0Dh, 0Ah, "$"
txt_25E1:	; "データを読み込み中にエラーが発生しました。", 0Dh, 0Ah, "$"
	db	83h, 66h, 81h, 5Bh, 83h, 5Eh, 82h, 0F0h, 93h, 0C7h, 82h, 0DDh, 8Dh, 9Eh, 82h, 0DDh, 92h, 86h, 82h, 0C9h, 83h, 47h, 83h, 89h, 81h, 5Bh, 82h, 0AAh, 94h, 0ADh, 90h, 0B6h, 82h, 0B5h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh, 81h, 42h, 0Dh, 0Ah, "$"
txt_260E:	; "ＥＲＲＯＲ　"
	db	82h, 64h, 82h, 71h, 82h, 71h, 82h, 6Eh, 82h, 71h, 81h, 40h, 0
	times 261Bh-($-$$-DATA_BASE_OFS) db 00h
	incbin "DUNGEON.DEC2.EXE", $, 261Fh - ($-$$-DATA_BASE_OFS)
txt_261F:	; "拡張エラ－コ－ド　"
	db	8Ah, 67h, 92h, 0A3h, 83h, 47h, 83h, 89h, 81h, 7Ch, 83h, 52h, 81h, 7Ch, 83h, 68h, 81h, 40h, 0
	times 2632h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 7166h - ($-$$-DATA_BASE_OFS)
txt_7166:	; "Ｃ　Ａ　Ｍ　Ｐ" (unused)
	db	82h, 62h, 81h, 40h, 82h, 60h, 81h, 40h, 82h, 6Ch, 81h, 40h, 82h, 6Fh, 0Ah
txt_7175:	; "た　た　か　う", 1Ch, "　ま　も　る　", 1Ch, "　に　げ　る　"
	db	"    Attack    ", 1Ch
	db	"    Defend    ", 1Ch
	db	"   Run Away   ", 0Ah
txt_71A2:	; "か　い　ふ　く", 1Ch, "ぼ　う　ぎ　ょ", 1Ch, "こ　う　げ　き"
	db	"     Heal     ", 1Ch
	db	"    Guard     ", 1Ch
	db	"    Blast     ", 0Ah
txt_71CF:	; "あ　い　て　む", 1Ch, "　ま　ほ　う　", 1Ch, "で　ぃ　す　く" (unused)
	db	"     Item     ", 1Ch
	db	"    Magic     ", 1Ch
	db	"     Disk     ", 0Ah
	times 71FCh-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 71FCh - ($-$$-DATA_BASE_OFS)
txt_71FC:	; "コマンド　１　", 1Ch, "コマンド　２　", 1Ch, "コマンド　３　", 1Ch, "コマンド　４　", 1Ch, "コマンド　５　", 1Ch, "0コマンド　６　", 1Ch, "コマンド　７　", 1Ch, "コマンド　８　", 1Ch, "コマンド　９　", 1Ch, "コマンド　１０", 0Ah
	db	83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 50h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 51h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 52h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 53h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 54h, 81h, 40h, 1Ch, "0", 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 55h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 56h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 57h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 58h, 81h, 40h, 1Ch, 83h, 52h, 83h, 7Dh, 83h, 93h, 83h, 68h, 81h, 40h, 82h, 50h, 82h, 4Fh, 0Ah
	times 7293h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 0D1A2h - ($-$$-DATA_BASE_OFS)
txt_D1A2:
	db	1Bh, "[000;000H$"
	times 0D1ADh-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 0D244h - ($-$$-DATA_BASE_OFS)
txt_D244:	; "ファイルの読み込みに失敗しました。", 0Dh, 0Ah, "$"
	db	83h, 74h, 83h, 40h, 83h, 43h, 83h, 8Bh, 82h, 0CCh, 93h, 0C7h, 82h, 0DDh, 8Dh, 9Eh, 82h, 0DDh, 82h, 0C9h, 8Eh, 0B8h, 94h, 73h, 82h, 0B5h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh, 81h, 42h, 0Dh, 0Ah, "$"
txt_D269:	; "ふらぐをえでぃっとするもーど$"
	db	82h, 0D3h, 82h, 0E7h, 82h, 0AEh, 82h, 0F0h, 82h, 0A6h, 82h, 0C5h, 82h, 0A1h, 82h, 0C1h, 82h, 0C6h, 82h, 0B7h, 82h, 0E9h, 82h, 0E0h, 81h, 5Bh, 82h, 0C7h, "$"
	times 0D286h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 0D297h - ($-$$-DATA_BASE_OFS)
txt_D297:	; "れじすたのえでぃっとむぉーど$"
	db	82h, 0EAh, 82h, 0B6h, 82h, 0B7h, 82h, 0BDh, 82h, 0CCh, 82h, 0A6h, 82h, 0C5h, 82h, 0A1h, 82h, 0C1h, 82h, 0C6h, 82h, 0DEh, 82h, 0A7h, 81h, 5Bh, 82h, 0C7h, "$"
txt_D2B4:
	db	"edit reg *:     $"
	times 0D2C5h-($-$$-DATA_BASE_OFS) db 00h
	incbin "DUNGEON.DEC2.EXE", $, 0D2D4h - ($-$$-DATA_BASE_OFS)
txt_D2D4:	; "わーど配列のえでぃっともぉど$"
	db	82h, 0EDh, 81h, 5Bh, 82h, 0C7h, 94h, 7Ah, 97h, 0F1h, 82h, 0CCh, 82h, 0A6h, 82h, 0C5h, 82h, 0A1h, 82h, 0C1h, 82h, 0C6h, 82h, 0E0h, 82h, 0A7h, 82h, 0C7h, "$"
txt_D2F1:
	db	"edit reg *[    ]:     $"
	times 0D308h-($-$$-DATA_BASE_OFS) db 00h

	incbin "DUNGEON.DEC2.EXE", $, 00E2h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1039

	incbin "DUNGEON.DEC2.EXE", $, 0167h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1065

	incbin "DUNGEON.DEC2.EXE", $, 01EDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1526

	incbin "DUNGEON.DEC2.EXE", $, 0204h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_153D

	incbin "DUNGEON.DEC2.EXE", $, 023Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1526

	incbin "DUNGEON.DEC2.EXE", $, 0255h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_165D

	incbin "DUNGEON.DEC2.EXE", $, 0283h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1526

	incbin "DUNGEON.DEC2.EXE", $, 029Ah - ($-$$-CODE_BASE_OFS)
	mov	si, txt_15C2

	incbin "DUNGEON.DEC2.EXE", $, 02E7h - ($-$$-CODE_BASE_OFS)
	mov	si, txtEqp00_9

	incbin "DUNGEON.DEC2.EXE", $, 02EFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A07

	incbin "DUNGEON.DEC2.EXE", $, 02F6h - ($-$$-CODE_BASE_OFS)
	mov	si, itemNameBuffer

	incbin "DUNGEON.DEC2.EXE", $, 02FDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A0A

	incbin "DUNGEON.DEC2.EXE", $, 0316h - ($-$$-CODE_BASE_OFS)
	mov	si, txtEqp01_9

	incbin "DUNGEON.DEC2.EXE", $, 031Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A07

	incbin "DUNGEON.DEC2.EXE", $, 0325h - ($-$$-CODE_BASE_OFS)
	mov	si, itemNameBuffer

	incbin "DUNGEON.DEC2.EXE", $, 032Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A0A

	incbin "DUNGEON.DEC2.EXE", $, 0345h - ($-$$-CODE_BASE_OFS)
	mov	si, txtEqp02_7

	incbin "DUNGEON.DEC2.EXE", $, 034Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A07

	incbin "DUNGEON.DEC2.EXE", $, 0354h - ($-$$-CODE_BASE_OFS)
	mov	si, itemNameBuffer

	incbin "DUNGEON.DEC2.EXE", $, 035Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0A0A

	incbin "DUNGEON.DEC2.EXE", $, 03F2h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_16F5

	incbin "DUNGEON.DEC2.EXE", $, 0418h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_17F8

	; CopyItemName (0430h)
	incbin "DUNGEON.DEC2.EXE", $, 0430h - ($-$$-CODE_BASE_OFS)
	mov	di, itemNameBuffer
	incbin "DUNGEON.DEC2.EXE", $, 0434h - ($-$$-CODE_BASE_OFS)
	lodsb	; read a single byte (instead of 2 bytes) to fix ASCII names
	incbin "DUNGEON.DEC2.EXE", $, 0439h - ($-$$-CODE_BASE_OFS)
	stosb	; write a single byte (instead of 2 bytes) to fix ASCII names

	incbin "DUNGEON.DEC2.EXE", $, 0F09h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C8E

	incbin "DUNGEON.DEC2.EXE", $, 0F13h - ($-$$-CODE_BASE_OFS)
	add	ax, 854Fh	; originally 824Fh (full-width), now half-width
	xchg	al, ah
	mov	word [MstAppear_Number], ax
	db	33h, 0C0h	; xor	ax, ax (NASM encoding is 31 C0)
	incbin "DUNGEON.DEC2.EXE", $, 0F1Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0CA6

	incbin "DUNGEON.DEC2.EXE", $, 0FF1h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_7175

	incbin "DUNGEON.DEC2.EXE", $, 0FFAh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_109E

	incbin "DUNGEON.DEC2.EXE", $, 1009h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_71A2

	incbin "DUNGEON.DEC2.EXE", $, 1012h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_10B1

	incbin "DUNGEON.DEC2.EXE", $, 1185h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_13D5

	incbin "DUNGEON.DEC2.EXE", $, 11AFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1232

	incbin "DUNGEON.DEC2.EXE", $, 121Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1234

	incbin "DUNGEON.DEC2.EXE", $, 1225h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 122Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11A8

	incbin "DUNGEON.DEC2.EXE", $, 1263h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11CB

	incbin "DUNGEON.DEC2.EXE", $, 1279h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1232

	incbin "DUNGEON.DEC2.EXE", $, 1291h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1178

	incbin "DUNGEON.DEC2.EXE", $, 129Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1234

	incbin "DUNGEON.DEC2.EXE", $, 12A3h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 12AAh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11A8

	incbin "DUNGEON.DEC2.EXE", $, 12BFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1232

	incbin "DUNGEON.DEC2.EXE", $, 1301h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11B4

	incbin "DUNGEON.DEC2.EXE", $, 1316h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1133

	incbin "DUNGEON.DEC2.EXE", $, 1330h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1149

	incbin "DUNGEON.DEC2.EXE", $, 136Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1162

	incbin "DUNGEON.DEC2.EXE", $, 1379h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1108

	incbin "DUNGEON.DEC2.EXE", $, 1382h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1276

	incbin "DUNGEON.DEC2.EXE", $, 138Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_10DE

	incbin "DUNGEON.DEC2.EXE", $, 1396h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1453

	incbin "DUNGEON.DEC2.EXE", $, 13A0h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1486

	incbin "DUNGEON.DEC2.EXE", $, 13AAh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_10F4

	incbin "DUNGEON.DEC2.EXE", $, 13B4h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1108

	incbin "DUNGEON.DEC2.EXE", $, 13E8h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1236

	incbin "DUNGEON.DEC2.EXE", $, 13EFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12B1

	incbin "DUNGEON.DEC2.EXE", $, 13F6h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1243

	incbin "DUNGEON.DEC2.EXE", $, 13FDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1273

	incbin "DUNGEON.DEC2.EXE", $, 1456h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12D5

	incbin "DUNGEON.DEC2.EXE", $, 146Ah - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12D7

	incbin "DUNGEON.DEC2.EXE", $, 148Fh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1254

	incbin "DUNGEON.DEC2.EXE", $, 1496h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12B1

	incbin "DUNGEON.DEC2.EXE", $, 149Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1261

	incbin "DUNGEON.DEC2.EXE", $, 14A7h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1254

	incbin "DUNGEON.DEC2.EXE", $, 14AEh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12BD

	incbin "DUNGEON.DEC2.EXE", $, 14B5h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1261

	incbin "DUNGEON.DEC2.EXE", $, 14BDh - ($-$$-CODE_BASE_OFS)
loc_1E81D:
	incbin "DUNGEON.DEC2.EXE", $, 14BFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1254

	incbin "DUNGEON.DEC2.EXE", $, 14C6h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12C9

	incbin "DUNGEON.DEC2.EXE", $, 14CDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1261

	incbin "DUNGEON.DEC2.EXE", $, 14DFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1236

	incbin "DUNGEON.DEC2.EXE", $, 14E6h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12BD

	incbin "DUNGEON.DEC2.EXE", $, 14EDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1243

	incbin "DUNGEON.DEC2.EXE", $, 14F4h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1273

	incbin "DUNGEON.DEC2.EXE", $, 151Ah - ($-$$-CODE_BASE_OFS)
	jmp	near loc_1E81D	; [BUGFIX] fix missing "Fin, please use Blast!" message

	incbin "DUNGEON.DEC2.EXE", $, 151Fh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1236

	incbin "DUNGEON.DEC2.EXE", $, 1526h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12C9

	incbin "DUNGEON.DEC2.EXE", $, 152Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1243

	incbin "DUNGEON.DEC2.EXE", $, 1534h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1273

	incbin "DUNGEON.DEC2.EXE", $, 156Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1178

	incbin "DUNGEON.DEC2.EXE", $, 1573h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1232

	incbin "DUNGEON.DEC2.EXE", $, 15DFh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 15E6h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 15EDh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1171

	incbin "DUNGEON.DEC2.EXE", $, 1666h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C8E

	incbin "DUNGEON.DEC2.EXE", $, 166Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12EC

	incbin "DUNGEON.DEC2.EXE", $, 16B0h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1199

	incbin "DUNGEON.DEC2.EXE", $, 16D1h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_12FF

	incbin "DUNGEON.DEC2.EXE", $, 170Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C8E

	incbin "DUNGEON.DEC2.EXE", $, 1712h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_132B

	incbin "DUNGEON.DEC2.EXE", $, 1720h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_133B

	incbin "DUNGEON.DEC2.EXE", $, 1763h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_13B2

	incbin "DUNGEON.DEC2.EXE", $, 1882h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 1889h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 1890h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 1897h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14C0

	incbin "DUNGEON.DEC2.EXE", $, 189Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 1912h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 1919h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 1920h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 1927h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14C9

	incbin "DUNGEON.DEC2.EXE", $, 192Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 1942h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1199

	incbin "DUNGEON.DEC2.EXE", $, 1987h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 198Eh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 1995h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 199Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14DA

	incbin "DUNGEON.DEC2.EXE", $, 19A3h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 19E2h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 19E9h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 19F0h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 19F7h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14ED

	incbin "DUNGEON.DEC2.EXE", $, 19FEh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 1A24h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 1A2Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 1A32h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 1A39h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1500

	incbin "DUNGEON.DEC2.EXE", $, 1A40h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 1A7Fh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_116E

	incbin "DUNGEON.DEC2.EXE", $, 1A86h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_0C90

	incbin "DUNGEON.DEC2.EXE", $, 1A8Dh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AA

	incbin "DUNGEON.DEC2.EXE", $, 1A94h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1513

	incbin "DUNGEON.DEC2.EXE", $, 1A9Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_14AF

	incbin "DUNGEON.DEC2.EXE", $, 1B24h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_13FF

	incbin "DUNGEON.DEC2.EXE", $, 1B3Bh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1421

	incbin "DUNGEON.DEC2.EXE", $, 1B58h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1444

	incbin "DUNGEON.DEC2.EXE", $, 1BD8h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1199

	; GetWeaponProps (1BE4h)
	incbin "DUNGEON.DEC2.EXE", $, 1BECh - ($-$$-CODE_BASE_OFS)
	add	bx, weaponList
	mov	si, [bx]
	mov	di, 1C38h	; weaponName ; [BUGFIX] was originally "mov di, [1C38h]"
	nop
loc_1EF56:
	lodsb	; read a single byte (instead of 2 bytes) to fix ASCII names
	and	al, al
	jz	short loc_1EF5E
	stosb	; write a single byte (instead of 2 bytes) to fix ASCII names
	jmp	short loc_1EF56
loc_1EF5E:
	nop	; original code: DEC SI, because LODSW went too far by 1
	nop	; original code: DEC DI (doesn't make sense to me here)
	mov	byte [di], 0Ah	; write 0Ah string terminator to end of item name
	add	si, byte 3
	times 1C06h-($-$$-CODE_BASE_OFS) db 90h

	incbin "DUNGEON.DEC2.EXE", $, 1D99h - ($-$$-CODE_BASE_OFS)
	; overwrite unused code (1D90h..1D9Eh)
SkipItemName:
loc_1F499:
	lodsb			; read item name until a 00 is found
	and	al, al
	jnz	short loc_1F499
	; return with SI right after the found 00 byte
	retn
	times 1D9Fh-($-$$-CODE_BASE_OFS) db 90h

	incbin "DUNGEON.DEC2.EXE", $, 1FECh - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11EB

	incbin "DUNGEON.DEC2.EXE", $, 2006h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_11FE

	incbin "DUNGEON.DEC2.EXE", $, 2025h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1214

	incbin "DUNGEON.DEC2.EXE", $, 2037h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1223

	incbin "DUNGEON.DEC2.EXE", $, 208Ch - ($-$$-CODE_BASE_OFS)
	mov	di, armorList

	incbin "DUNGEON.DEC2.EXE", $, 20A2h - ($-$$-CODE_BASE_OFS)
	mov	di, shieldList

	incbin "DUNGEON.DEC2.EXE", $, 20D3h - ($-$$-CODE_BASE_OFS)
	mov	di, weaponList

	; GetItemProps (2132h)
	incbin "DUNGEON.DEC2.EXE", $, 2139h - ($-$$-CODE_BASE_OFS)
	call	SkipItemName
	inc	si		; skip 1st byte of item price
	inc	si		; skip 2nd byte of item price
	mov	bl, [si]
	mov	cx, [si+1]
	retn
	times 2145h-($-$$-CODE_BASE_OFS) db 90h

	incbin "DUNGEON.DEC2.EXE", $, 2251h - ($-$$-CODE_BASE_OFS)
	mov	si, txt_1021

	incbin "DUNGEON.DEC2.EXE", $, 2A39h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_2524

	incbin "DUNGEON.DEC2.EXE", $, 2A55h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2A5Fh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_2565

	incbin "DUNGEON.DEC2.EXE", $, 2A76h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2A80h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_254A

	incbin "DUNGEON.DEC2.EXE", $, 2A97h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2A9Eh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_25C0

	incbin "DUNGEON.DEC2.EXE", $, 2AA8h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_230E

	incbin "DUNGEON.DEC2.EXE", $, 2ABFh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2AC6h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_25E1

	incbin "DUNGEON.DEC2.EXE", $, 2AD0h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_230E

	incbin "DUNGEON.DEC2.EXE", $, 2AE7h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2AF1h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_2582

	incbin "DUNGEON.DEC2.EXE", $, 2B08h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_260E

	incbin "DUNGEON.DEC2.EXE", $, 2B12h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_259F

	incbin "DUNGEON.DEC2.EXE", $, 2B4Ch - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_261F

	incbin "DUNGEON.DEC2.EXE", $, 311Ch - ($-$$-CODE_BASE_OFS)
	mov	si, txt_71FC

	incbin "DUNGEON.DEC2.EXE", $, 3FF0h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D244

	incbin "DUNGEON.DEC2.EXE", $, 4034h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D244

	incbin "DUNGEON.DEC2.EXE", $, 4590h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 4597h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D269

	incbin "DUNGEON.DEC2.EXE", $, 47B5h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 47BCh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D297

	incbin "DUNGEON.DEC2.EXE", $, 4889h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 48EFh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 48F6h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D2B4

	incbin "DUNGEON.DEC2.EXE", $, 49BCh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 49C3h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D2B4

	incbin "DUNGEON.DEC2.EXE", $, 4AA1h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 4AA8h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D2D4

	incbin "DUNGEON.DEC2.EXE", $, 4B7Fh - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 4C11h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D1A2

	incbin "DUNGEON.DEC2.EXE", $, 4C18h - ($-$$-CODE_BASE_OFS)
	mov	dx, txt_D2F1

	incbin "DUNGEON.DEC2.EXE", $
