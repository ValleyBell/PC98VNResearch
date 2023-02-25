	JP	loc_010A

file_0104:
	DB	1, "ss.s", 0

loc_010A:
	CALL	loc_0F8A
	CALL	loc_120A
	PALFADE	0, 4
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_0180	; 0
	DW	loc_013C	; 1
	DW	loc_0152	; 2
	DW	loc_0168	; 3

loc_013C:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_017A

loc_0152:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_017A

loc_0168:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_017A:
	SUBI	i679, 1
loc_0180:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_01E8	; 0
	DW	loc_01A4	; 1
	DW	loc_01BA	; 2
	DW	loc_01D0	; 3

loc_01A4:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_01E2

loc_01BA:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_01E2

loc_01D0:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_01E2:
	SUBI	i679, 1
loc_01E8:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_0250	; 0
	DW	loc_020C	; 1
	DW	loc_0222	; 2
	DW	loc_0238	; 3

loc_020C:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_024A

loc_0222:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_024A

loc_0238:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_024A:
	SUBI	i679, 1
loc_0250:
	IMGLOAD	0, 0, 0, 0, file_1C3D, 0	; waku06b.g
	PALBW	0, 3
loc_0264:
	CMPI	i174, 1
	JEQ	loc_0290
	TBOPEN	8, 13, 8, 13, 6, 4
	PRINT	8, str_030A
	CMD6A	224, 144, 225, 207
	JP	loc_02AE

loc_0290:
	TBOPEN	8, 13, 8, 13, 8, 4
	PRINT	8, str_0359
	CMD6A	224, 144, 225, 239
loc_02AE:
	CMD3F	i272, i280
	MENUSEL	i48, i49, data_02CC, loc_03CE
loc_02BE:
	CMD42	1
	CMD43	i272, i280
	JP	loc_02BE

data_02CC:
	DW	1, 224, 144, 400, 160
	DW	2, 224, 160, 400, 176
	DW	3, 224, 176, 400, 192
	DW	4, 224, 192, 400, 208
	DW	5, 224, 208, 400, 224
	DW	6, 224, 224, 400, 240
	DW	0
str_030A:
	DB	"      Start Intro"     , 0x0D	; "    最初から始める"
	DB	" Waku Waku Four・Nine"  , 0x0D	; "わくわくフォア・ナイン"
	DB	"   Change Sound Mode"  , 0x0D	; "      音源の変更"
	DB	"       Quit Game"      , 0	; "   ゲームを終了する"
str_0359:
	;	"1234567890123456789012" ; width: 11 full-width characters
	DB	"      Start Intro"     , 0x0D	; "    最初から始める"
	DB	"   Start Main Story"   , 0x0D	; "    本編から始める"
	DB	"       Load Game"      , 0x0D	; "    途中から始める"
	DB	" Waku Waku Four・Nine"  , 0x0D	; "わくわくフォア・ナイン"
	DB	"   Change Sound Mode"  , 0x0D	; "      音源の変更"
	DB	"       Quit Game"      , 0	; "   ゲームを終了する"

loc_03CE:
	JTBL	i49
	DW	loc_03E2	; 0
	DW	loc_03DA	; 1
	DW	loc_03E2	; 2
	DW	loc_03DA	; 3

loc_03DA:
	TBCLOSE	8
	JP	loc_0264

loc_03E2:
	SUBI	i48, 1
	CMPI	i174, 1
	JEQ	loc_03FE
	JTBL	i48
	DW	loc_0748	; 0
	DW	loc_0AE0	; 1
	DW	loc_040E	; 2
	DW	loc_0AFA	; 3

loc_03FE:
	JTBL	i48
	DW	loc_0748	; 0
	DW	loc_0734	; 1
	DW	loc_0904	; 2
	DW	loc_0AE0	; 3
	DW	loc_040E	; 4
	DW	loc_0AFA	; 5

loc_040E:
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0662
	MOVR	i625, i145
	MOVR	i626, i146
	MOVR	i627, i147
	MOVR	i628, i148
	MOVR	i629, i149
	MOVR	i630, i150
	MOVR	i631, i151
	MOVR	i632, i152
	MOVR	i633, i153
	MOVR	i634, i154
	MOVR	i635, i155
	MOVR	i636, i156
	MOVR	i637, i157
	MOVR	i638, i158
	MOVR	i639, i159
	MOVR	i640, i160
	MOVR	i641, i161
	MOVR	i642, i162
	MOVR	i643, i163
	MOVR	i644, i164
	MOVR	i645, i165
	MOVR	i646, i166
	MOVR	i647, i167
	MOVR	i648, i168
	MOVR	i649, i169
	MOVR	i650, i170
	MOVR	i651, i171
	MOVR	i652, i172
	MOVR	i653, i173
	MOVR	i654, i174
	MOVR	i655, i175
	REGFLD	0, file_05D2	; config.dat
	CMPI	i3, 3376
	JEQ	loc_050E
	CMPI	i3, 3377
	JEQ	loc_0518
	CMPI	i3, 3378
	JEQ	loc_0522
	CMPI	i3, 3379
	JEQ	loc_052C
loc_050E:
	PRINT	8, str_0676
	JP	loc_0532

loc_0518:
	PRINT	8, str_0687
	JP	loc_0532

loc_0522:
	PRINT	8, str_069C
	JP	loc_0532

loc_052C:
	PRINT	8, str_06B1
loc_0532:
	TBOPEN	10, 15, 19, 10, 6, 4
	PRINT	10, str_0562
	CMD6A	256, 320, 383, 383
	MENUSEL	i998, i999, data_05A8, loc_05DE
loc_055A:
	CMD42	1
	JP	loc_055A

str_0562:
	DB	0x03, 0x0F, "    No sound    ", 0x0D
	DB	"   Mono ＦＭ音源", 0x0D
	DB	" Stereo ＦＭ音源", 0x0D
	DB	"ＭＩＤＩＧＳ音源", 0
data_05A8:
	DW	1, 256, 320, 384, 336
	DW	2, 256, 336, 384, 352
	DW	3, 256, 352, 384, 368
	DW	4, 256, 368, 384, 384
	DW	0
file_05D2:
	DB	1, "config.dat", 0

loc_05DE:
	JTBL	i999
	DW	loc_05F6	; 0
	DW	loc_05EA	; 1
	DW	loc_05F6	; 2
	DW	loc_05EA	; 3

loc_05EA:
	TBCLOSE	10
	TBCLOSE	8
	JP	loc_0658

loc_05F6:
	SUBI	i998, 1
	TBCLOSE	10
	JTBL	i998
	DW	loc_060C	; 0
	DW	loc_061C	; 1
	DW	loc_062C	; 2
	DW	loc_063C	; 3

loc_060C:
	MOVI	i3, 3376
	PRINT	8, str_06F8
	JP	loc_0648

loc_061C:
	MOVI	i3, 3377
	PRINT	8, str_0704
	JP	loc_0648

loc_062C:
	MOVI	i3, 3378
	PRINT	8, str_0714
	JP	loc_0648

loc_063C:
	MOVI	i3, 3379
	PRINT	8, str_0724
loc_0648:
	REGFSAV	0, file_05D2	; config.dat
	PRINT	8, str_06C6
	TBCLOSE	8
loc_0658:
	MOVI	i9, 9
	DOSRETR	i9

str_0662:
	DB	"音源を選んで下さい", 0x0D, 0
str_0676:
	DB	"今は音源無しです", 0
str_0687:
	DB	"今はノーマルＦＭです", 0
str_069C:
	DB	"今はステレオＦＭです", 0
str_06B1:
	DB	"今はＧＳＭＩＤＩです", 0
str_06C6:
	DB	"変更しました", 0x0D
	DB	"新設定でシステムを", 0x0D
	DB	"起動し直します。", 1, 0
str_06F8:
	DB	0x0D, "音源無しに", 0
str_0704:
	DB	0x0D, "ノーマルＦＭに", 0
str_0714:
	DB	0x0D, "ステレオＦＭに", 0
str_0724:
	DB	0x0D, "ＧＳＭＩＤＩに", 0

loc_0734:
	TBCLOSE	8
	MOVI	i190, 0
	MOVI	i187, 1
	LDSCENE	file_0B26	; CS01_01.s

loc_0748:
	TBCLOSE	8
	JP	loc_08DE

loc_0750:	; unused
	IMGLOAD	0, 0, 0, 2, file_08D4, 0	; E020tx.g
	MOVI	i48, 12
	MOVI	i49, 288
	MOVI	i50, 3
	MOVI	i51, 304
	MOVI	i52, 2
	MOVI	i53, 0
	MOVI	i54, 0
	MOVI	i55, 1
	MOVI	i56, 44
	MOVI	i57, 1
	MOVI	i58, 77
	MOVI	i59, 0
	MOVI	i60, 62
	MOVI	i62, 74
	MOVI	i63, 0
	MOVI	i912, 0
	MOVI	i192, 0
	MOVI	i193, 2
	MOVI	i194, 1
	MOVI	i195, 0
	GFX3A	i53, i48, i53, i50, i51, i52, i62, i63
	LOOPSTI	0
	MOVI	i112, 1
	MOVI	i912, 0
	JP	loc_080A

loc_07FC:	; unused
	WAIT	i193
	MOVI	i113, 1
loc_0806:
	LOOPGTR	i912
loc_080A:
	SUBR	i112, i912
	MOVR	i113, i112
	ADDR	i193, i113
	MOVI	i0, 10
	DIVR	i193, i0
	ADDR	i192, i193
	MOVR	i193, i0
	ADDR	i194, i192
	ADDR	i195, i193
	MOVI	i0, 10
	DIVR	i195, i0
	ADDR	i194, i195
	MOVR	i195, i0
	ADDR	i54, i194
	CMPI	i54, 44
	JGE	loc_087E
	MOVI	i55, 44
	SUBR	i55, i54
	MOVR	i61, i54
	JP	loc_088A

loc_087E:
	MOVI	i55, 44
	MOVI	i61, 0
loc_088A:
	GFX3A	i52, i62, i54, i57, i55, i52, i58, i59
	GFX64	i52, i60, i61, i57, i55, i52, i58, i59
	GFX3A	i52, i58, i59, i57, i55, i53, i48, i54
	LOOPGTR	i112
	CMPR	i54, i49
	JLT	loc_0806
	CMD1E	i0
	DOSEXIT

file_08D4:
	DB	1, "E020tx.g", 0

loc_08DE:
	MOVI	i174, 1
	REGFSAV	0, file_1E58	; cansav.sys
	MOVI	i190, 0
	MOVI	i187, 0
	LDSCENE	file_08FA	; prolog.s

file_08FA:
	DB	1, "prolog.s", 0

loc_0904:
	TBOPEN	9, 15, 11, 14, 9, 4
	PRINT	9, str_1DC8
	CMD6A	256, 192, 256, 303
	MENUSEL	i48, i49, data_093A, loc_0982
	CMD43	i273, i281
	CMD42	1
	JP	loc_1675

data_093A:
	DW	1, 256, 192, 448, 208
	DW	2, 256, 208, 448, 224
	DW	3, 256, 224, 448, 240
	DW	4, 256, 240, 448, 256
	DW	5, 256, 256, 448, 272
	DW	6, 256, 272, 448, 288
	DW	7, 256, 288, 448, 304
	DW	0

loc_0982:
	JTBL	i49
	DW	loc_099A	; 0
	DW	loc_098E	; 1
	DW	loc_099A	; 2
	DW	loc_098E	; 3

loc_098E:
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_0264

loc_099A:
	SUBI	i48, 1
	TBCLOSE	9
	TBCLOSE	8
	JTBL	i48
	DW	loc_09BA	; 0
	DW	loc_09E4	; 1
	DW	loc_0A0E	; 2
	DW	loc_0A38	; 3
	DW	loc_0A62	; 4
	DW	loc_0A8C	; 5
	DW	loc_0AB6	; 6

loc_09BA:
	FILETM	i17, s2, file_1E01	; cansav.da1
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E01	; cansav.da1
	CALL	loc_1F8A
	JP	loc_0ADC

loc_09E4:
	FILETM	i17, s2, file_1E0D	; cansav.da2
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E0D	; cansav.da2
	CALL	loc_1F8A
	JP	loc_0ADC

loc_0A0E:
	FILETM	i17, s2, file_1E19	; cansav.da3
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E19	; cansav.da3
	CALL	loc_1F8A
	JP	loc_0ADC

loc_0A38:
	FILETM	i17, s2, file_1E25	; cansav.da4
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E25	; cansav.da4
	CALL	loc_1F8A
	JP	loc_0ADC

loc_0A62:
	FILETM	i17, s2, file_1E31	; cansav.da5
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E31	; cansav.da5
	CALL	loc_1F8A
	JP	loc_0ADC

loc_0A8C:
	FILETM	i17, s2, file_1E3D	; cansav.da6
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E3D	; cansav.da6
	CALL	loc_1F8A
	JP	loc_0ADC

loc_0AB6:
	FILETM	i17, s2, file_1E49	; cansav.da7
	CMPI	i17, 0
	JEQ	loc_0264
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E49	; cansav.da7
	CALL	loc_1F8A
loc_0ADC:
	JP	loc_1A67

loc_0AE0:
	TBCLOSE	8
	MOVI	i190, 0
	LDSCENE	file_0AEE	; WakuWaku.s

file_0AEE:
	DB	1, "WakuWaku.s", 0

loc_0AFA:
	TBCLOSE	8
	CALL	loc_0F8A
	CALL	loc_120A
	PALFADE	0, 3
	CMD5E	0, 0, 0, 80, 400
	CMD5E	1, 0, 0, 80, 400
	DOSEXIT

file_0B26:
	DB	1, "CS01_01.s", 0

loc_0B31:
	MOVI	i672, 0
	CALL	loc_1218
	IMGLOAD	2, 64, 1, 2, file_0B99, 0	; BG00.g
	MOVI	i578, 10
	MOVI	i577, 10
	MOVI	i576, 10
	MOVI	i581, 10
	MOVI	i580, 10
	MOVI	i579, 10
	MOVI	i584, 10
	MOVI	i583, 10
	MOVI	i582, 10
	MOVI	i599, 10
	MOVI	i598, 10
	MOVI	i597, 10
	CALL	loc_1232
	JP	loc_0BA1

file_0B99:
	DB	1, "BG00.g", 0

loc_0BA1:
	CALL	loc_0E32
	CMD2F	2, 68, 304, 12, 96, 1, 12, 264
	IMGLOAD	12, 264, 0, 1, file_0BE5, 1	; Kait00.g
	CALL	loc_123C
	CMD2F	1, 12, 264, 12, 96, 0, 12, 264
	PRINT	9, str_0CDD
	JP	loc_0BEF

file_0BE5:
	DB	1, "Kait00.g", 0

loc_0BEF:
	CALL	loc_13A3
	IMGLOAD	2, 16, 0, 1, file_0C09, 1	; CA013C.g
	CALL	loc_13BB
	JP	loc_0C13

file_0C09:
	DB	1, "CA013C.g", 0

loc_0C13:
	CALL	loc_0E80
	PRINT	9, str_0D98
	CALL	loc_13A3
	IMGLOAD	2, 16, 0, 1, file_0C37, 1	; CA018B.g
	CALL	loc_13BB
	JP	loc_0C41

file_0C37:
	DB	1, "CA018B.g", 0

loc_0C41:
	CALL	loc_0E32
	CMD2F	2, 68, 304, 12, 96, 1, 12, 264
	IMGLOAD	12, 264, 0, 1, file_0C85, 1	; Kait00.g
	CALL	loc_123C
	CMD2F	1, 12, 264, 12, 96, 0, 12, 264
	PRINT	9, str_0CDD
	JP	loc_0C8F

file_0C85:
	DB	1, "Kait00.g", 0

loc_0C8F:
	CALL	loc_127E
	CALL	loc_0E80
	PRINT	9, str_0D98
	DOSEXIT

loc_0C9F:	; unused
	TBOPEN	8, 5, 16, 7, 7, 1
	CMD1E	i0
	TBOPEN	9, 12, 16, 22, 7, 2
	IMGLOAD	12, 264, 1, 0, file_0E20, 1	; ka01.g
	PRINT	9, str_0CDD
	TBCLOSE	9
	TBCLOSE	8
	DOSEXIT

str_0CDD:
	DB	"（弟だけじゃない。父さんも・・・母さん", 0x0D
	DB	"も・・・・・・皆、皆・・・・・・）", 1
	DB	"とりあえず、テストでかいてみ", 0x0D
	DB	"とりあえず、テストでかいてみ", 0x0D
	DB	"とりあえず、テストでかいてみ", 0x0D
	DB	"るけどうまくいくのかなぁ", 1, 0
str_0D98:
	DB	"てすとその２なんだけど、うまくいくかな？  だいたいどこまで", 0x0D
	DB	"入るんだかわかんないんだから色々やってみるしかないってことなんじゃ", 0x0D
	DB	"ないかな", 1, 0
file_0E20:
	DB	1, "ka01.g", 0
file_0E28:	; unused
	DB	1, "CanSub.s", 0

loc_0E32:
	CALL	loc_11BE
	CALL	loc_11DE
	CMPI	i560, 1
	JNE	loc_0E46
	RET

loc_0E46:
	CALL	loc_1162
	TBOPEN	8, 5, 16, 7, 7, 1
	TBOPEN	9, 12, 16, 22, 7, 2
	CMD2F	0, 12, 264, 12, 96, 2, 68, 304
	MOVI	i560, 1
	RET

loc_0E80:
	CALL	loc_11BE
	CALL	loc_11F2
	CMPI	i561, 1
	JNE	loc_0E94
	RET

loc_0E94:
	CALL	loc_1162
	TBOPEN	9, 2, 19, 37, 6, 0
	MOVI	i561, 1
	RET

loc_0EAE:	; unused
	CALL	loc_1120
	CALL	loc_0FDA
	CMPI	i563, 1
	JNE	loc_0EC2
	RET

loc_0EC2:
	TBOPEN	9, 7, 18, 33, 7, 2
	MOVI	i563, 1
	RET

loc_0ED8:	; unused
	CALL	loc_1120
	CALL	loc_0F8A
	RET

	DB	0x01, 0x00, 0x10, 0x00, 0xD0, 0x00, 0x80, 0x00
	DB	0xE0, 0x00, 0x02, 0x00, 0x10, 0x00, 0xE0, 0x00
	DB	0x80, 0x00, 0xF0, 0x00, 0x03, 0x00, 0x10, 0x00
	DB	0xF0, 0x00, 0x80, 0x00, 0x00, 0x01, 0x04, 0x00
	DB	0x10, 0x00, 0x00, 0x01, 0x80, 0x00, 0x10, 0x01
	DB	0x00, 0x00, 0x01, 0x00, 0x20, 0x00, 0xF0, 0x00
	DB	0x90, 0x00, 0x00, 0x01, 0x02, 0x00, 0x20, 0x00
	DB	0x00, 0x01, 0x90, 0x00, 0x10, 0x01, 0x03, 0x00
	DB	0x20, 0x00, 0x10, 0x01, 0x90, 0x00, 0x20, 0x01
	DB	0x04, 0x00, 0x20, 0x00, 0x20, 0x01, 0x90, 0x00
	DB	0x30, 0x01, 0x00, 0x00, 0x01, 0x00, 0x20, 0x00
	DB	0x00, 0x01, 0x90, 0x00, 0x10, 0x01, 0x02, 0x00
	DB	0x20, 0x00, 0x10, 0x01, 0x90, 0x00, 0x20, 0x01
	DB	0x03, 0x00, 0x20, 0x00, 0x20, 0x01, 0x90, 0x00
	DB	0x30, 0x01, 0x04, 0x00, 0x20, 0x00, 0x30, 0x01
	DB	0x90, 0x00, 0x40, 0x01, 0x00, 0x00, 0x01, 0x00
	DB	0x20, 0x00, 0x10, 0x01, 0x90, 0x00, 0x20, 0x01
	DB	0x02, 0x00, 0x20, 0x00, 0x20, 0x01, 0x90, 0x00
	DB	0x30, 0x01, 0x03, 0x00, 0x20, 0x00, 0x30, 0x01
	DB	0x90, 0x00, 0x40, 0x01, 0x04, 0x00, 0x20, 0x00
	DB	0x40, 0x01, 0x90, 0x00, 0x50, 0x01, 0x00, 0x00

loc_0F8A:
	CALL	loc_0F98
	CALL	loc_0FB2
	CALL	loc_0FDA
	RET

loc_0F98:
	CMPI	i565, 0
	JEQ	loc_0FB0
	TBCLOSE	8
	TBCLOSE	9
	MOVI	i565, 0
loc_0FB0:
	RET

loc_0FB2:
	CMPI	i563, 0
	JEQ	loc_0FD8
	TBCLOSE	9
	MOVI	i563, 0
	CMD2F	2, 36, 280, 16, 128, 0, 0, 280
loc_0FD8:
	RET

loc_0FDA:
	JTBL	i564
	DW	loc_0FF2	; 0
	DW	loc_0FE8	; 1
	DW	loc_0FE4	; 2

loc_0FE4:
	TBCLOSE	9
loc_0FE8:
	TBCLOSE	8
	MOVI	i564, 0
loc_0FF2:
	RET

loc_0FF4:
	CALL	loc_14E3
	MOVI	i48, 1
	MOVI	i49, 0
	MOVI	i50, 0
	MOVI	i51, 80
	MOVI	i52, 2
	MOVI	i53, 0
	MOVI	i56, 398
	MOVI	i57, 0
	LOOPSTI	0
loc_102C:
	LOOPJPR	i57, loc_102C
	ADDI	i57, 1
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	loc_10B0
	ADDI	i50, 4
	SUBI	i56, 4
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	loc_10B0
	ADDI	i50, 4
	SUBI	i56, 4
	JP	loc_102C

loc_10B0:
	MOVI	i0, 1
	PA4GET	i0
	TBOPEN	8, 0, 18, 7, 7, 1
	CMD2F	0, 0, 280, 16, 128, 2, 0, 280
	TBCLOSE	8
	TBOPEN	9, 6, 18, 33, 7, 3
	CMD2F	0, 0, 280, 16, 128, 2, 18, 280
	TBCLOSE	9
	CMD2F	0, 0, 280, 16, 128, 2, 36, 280
	MOVI	i0, 0
	PA4GET	i0
	RET

loc_1120:
	CMPI	i190, 1
	JEQ	loc_1156
	CALL	loc_120A
	IMGLOAD	0, 0, 0, 1, file_11B4, 0	; winf.lsp
	GFX36
	MOVI	i190, 1
	IMGLOAD	0, 0, 0, 1, file_1158, 0	; BlackF.g
	CALL	loc_0FF4
loc_1156:
	RET

file_1158:
	DB	1, "BlackF.g", 0

loc_1162:
	CMPI	i190, 0
	JEQ	loc_11A8
	CALL	loc_0F8A
	MOVI	i190, 0
	IMGLOAD	0, 0, 0, 1, file_11AA, 0	; win3.lsp
	GFX36
	CALL	loc_0F8A
	CALL	loc_120A
	PALFADE	0, 1
	IMGLOAD	0, 0, 0, 0, file_1C3D, 0	; waku06b.g
	PALBW	0, 3
loc_11A8:
	RET

file_11AA:
	DB	1, "win3.lsp", 0
file_11B4:
	DB	1, "winf.lsp", 0

loc_11BE:
	JTBL	i562
	DW	loc_11DC	; 0
	DW	loc_11D2	; 1
	DW	loc_11CE	; 2
	DW	loc_11CA	; 3

loc_11CA:
	TBCLOSE	10
loc_11CE:
	TBCLOSE	9
loc_11D2:
	TBCLOSE	8
	MOVI	i562, 0
loc_11DC:
	RET

loc_11DE:
	JTBL	i561
	DW	loc_11F0	; 0
	DW	loc_11E6	; 1

loc_11E6:
	TBCLOSE	9
	MOVI	i561, 0
loc_11F0:
	RET

loc_11F2:
	JTBL	i560
	DW	loc_1208	; 0
	DW	loc_11FA	; 1

loc_11FA:
	TBCLOSE	9
	TBCLOSE	8
	MOVI	i560, 0
loc_1208:
	RET

loc_120A:
	CALL	loc_11DE
	CALL	loc_11BE
	CALL	loc_11F2
	RET

loc_1218:
	CALL	loc_1162
	CALL	loc_120A
	CMPI	i672, 0
	JEQ	loc_122C
	RET

loc_122C:
	CALL	loc_127E
	RET

loc_1232:
	CALL	loc_14E3
	CALL	loc_1323
	RET

loc_123C:
	MOVI	i0, 0
	PCOLSET	i0, i578, i577, i576
	MOVI	i0, 2
	PCOLSET	i0, i581, i580, i579
	MOVI	i0, 3
	PCOLSET	i0, i584, i583, i582
	MOVI	i0, 7
	PCOLSET	i0, i599, i598, i597
	RET

loc_127E:
	CALL	loc_120A
	IMGLOAD	2, 16, 0, 1, file_12A8, 0	; Black.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	CALL	loc_1323
	RET

file_12A8:
	DB	1, "Black.lsp", 0
file_12B3:
	DB	1, "BlackE.lsp", 0

loc_12BF:	; unused
	CALL	loc_1162
	CALL	loc_120A
	CMPI	i672, 0
	JEQ	loc_12F3
	IMGLOAD	2, 16, 0, 1, file_12B3, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

loc_12F3:
	CALL	loc_127E
	IMGLOAD	2, 16, 0, 1, file_12B3, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

loc_1319:	; unused
	CALL	loc_14E3
	CALL	loc_1323
	RET

loc_1323:
	MOVI	i48, 2
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 1
	MOVI	i52, 320
	MOVI	i53, 0
	MOVI	i54, 61
	MOVI	i55, 1
	LOOPSTI	0
loc_1357:
	LOOPJPR	i55, loc_1357
	CMPI	i54, 1
	JEQ	loc_13A1
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i54, i50, i51, i52, i53, i54, i50
	ADDI	i49, 2
	SUBI	i54, 2
	ADDI	i55, 1
	JP	loc_1357

loc_13A1:
	RET

loc_13A3:
	CALL	loc_120A
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	RET

loc_13BB:
	MOVI	i64, 0
	CALL	loc_13DB
	CALL	loc_123C
	RET

loc_13CB:	; unused
	MOVI	i64, 1
	CALL	loc_13DB
	CALL	loc_123C
	RET

loc_13DB:
	MOVI	i48, 1
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 60
	MOVI	i52, 1
	MOVI	i53, 0
	MOVI	i54, 319
	MOVI	i55, 1
	LOOPSTI	0
loc_140F:
	LOOPJPR	i55, loc_140F
	CMPI	i54, 15
	JEQ	loc_1457
	CALL	loc_1459
	CMPI	i54, 15
	JEQ	loc_1457
	CALL	loc_1459
	CMPI	i54, 15
	JEQ	loc_1457
	CALL	loc_1459
	CMPI	i54, 15
	JEQ	loc_1457
	CALL	loc_1459
	ADDI	i55, 1
	JP	loc_140F

loc_1457:
	RET

loc_1459:
	CMPI	i64, 1
	JEQ	loc_1495
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

loc_1495:
	GFX64	i48, i49, i50, i51, i52, i53, i49, i50
	GFX64	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

loc_14C7:	; unused
	CALL	loc_120A
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	CALL	loc_13DB
	RET

loc_14E3:
	MOVI	i0, 0
	PCOLSET	i0, i578, i577, i576
	MOVI	i0, 1
	PCOLSET	i0, i587, i586, i585
	MOVI	i0, 2
	PCOLSET	i0, i581, i580, i579
	MOVI	i0, 3
	PCOLSET	i0, i584, i583, i582
	MOVI	i0, 4
	PCOLSET	i0, i590, i589, i588
	MOVI	i0, 5
	PCOLSET	i0, i593, i592, i591
	MOVI	i0, 6
	PCOLSET	i0, i596, i595, i594
	MOVI	i0, 7
	PCOLSET	i0, i599, i598, i597
	MOVI	i0, 8
	PCOLSET	i0, i602, i601, i600
	MOVI	i0, 9
	PCOLSET	i0, i605, i604, i603
	MOVI	i0, 10
	PCOLSET	i0, i608, i607, i606
	MOVI	i0, 11
	PCOLSET	i0, i611, i610, i609
	MOVI	i0, 12
	PCOLSET	i0, i614, i613, i612
	MOVI	i0, 13
	PCOLSET	i0, i617, i616, i615
	MOVI	i0, 14
	PCOLSET	i0, i620, i619, i618
	MOVI	i0, 15
	PCOLSET	i0, i623, i622, i621
	RET

loc_15E5:
	TBOPEN	8, 31, 12, 9, 6, 3
	PRINT	8, str_1E64
	CMD6A	512, 208, 513, 271
	CMD3F	i544, i552
	MENUSEL	i48, i49, data_1C60, loc_1621
loc_1613:
	CMD42	1
	CMD43	i544, i552
	JP	loc_1613

loc_1621:
	JTBL	i49
	DW	loc_1635	; 0
	DW	loc_162D	; 1
	DW	loc_1635	; 2
	DW	loc_162D	; 3

loc_162D:
	TBCLOSE	8
	JP	loc_0B31

loc_1635:
	SUBI	i48, 1
	JTBL	i48
	DW	loc_1647	; 0
	DW	loc_1895	; 1
	DW	loc_1BEF	; 2
	DW	loc_1C48	; 3

loc_1647:
	CMD3F	i545, i553
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, str_1DC8
	MENUSEL	i48, i49, data_16BB, loc_1683
loc_1675:
	CMD43	i545, i553
	CMD42	1
	JP	loc_1675

loc_1683:
	JTBL	i49
	DW	loc_169B	; 0
	DW	loc_168F	; 1
	DW	loc_169B	; 2
	DW	loc_168F	; 3

loc_168F:
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_15E5

loc_169B:
	SUBI	i48, 1
	TBCLOSE	9
	TBCLOSE	8
	JTBL	i48
	DW	loc_1703	; 0
	DW	loc_173B	; 1
	DW	loc_1773	; 2
	DW	loc_17AB	; 3
	DW	loc_17E3	; 4
	DW	loc_181B	; 5
	DW	loc_1853	; 6
data_16BB:
	DW	1, 336, 176, 528, 192
	DW	2, 336, 192, 528, 208
	DW	3, 336, 208, 528, 224
	DW	4, 336, 224, 528, 240
	DW	5, 336, 240, 528, 256
	DW	6, 336, 256, 528, 272
	DW	7, 336, 272, 528, 288
	DW	0

loc_1703:
	REGFSAV	0, file_1E01	; cansav.da1
	STRCLR	s3
	STRCPYI	s3, str_1DD7
	FILETM	i17, s2, file_1E01	; cansav.da1
	STRCAT	s3, s2
	STRCPYI	s3, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EA9
	PRINT	9, str_1E97
	JP	loc_1887

loc_173B:
	REGFSAV	0, file_1E0D	; cansav.da2
	STRCLR	s4
	STRCPYI	s4, str_1DDD
	FILETM	i17, s2, file_1E0D	; cansav.da2
	STRCAT	s4, s2
	STRCPYI	s4, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EB6
	PRINT	9, str_1E97
	JP	loc_1887

loc_1773:
	REGFSAV	0, file_1E19	; cansav.da3
	STRCLR	s5
	STRCPYI	s5, str_1DE3
	FILETM	i17, s2, file_1E19	; cansav.da3
	STRCAT	s5, s2
	STRCPYI	s5, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EC3
	PRINT	9, str_1E97
	JP	loc_1887

loc_17AB:
	REGFSAV	0, file_1E25	; cansav.da4
	STRCLR	s6
	STRCPYI	s6, str_1DE9
	FILETM	i17, s2, file_1E25	; cansav.da4
	STRCAT	s6, s2
	STRCPYI	s6, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1ED0
	PRINT	9, str_1E97
	JP	loc_1887

loc_17E3:
	REGFSAV	0, file_1E31	; cansav.da5
	STRCLR	s7
	STRCPYI	s7, str_1DEF
	FILETM	i17, s2, file_1E31	; cansav.da5
	STRCAT	s7, s2
	STRCPYI	s7, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EDD
	PRINT	9, str_1E97
	JP	loc_1887

loc_181B:
	REGFSAV	0, file_1E3D	; cansav.da6
	STRCLR	s8
	STRCPYI	s8, str_1DF5
	FILETM	i17, s2, file_1E3D	; cansav.da6
	STRCAT	s8, s2
	STRCPYI	s8, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EEA
	PRINT	9, str_1E97
	JP	loc_1887

loc_1853:
	REGFSAV	0, file_1E49	; cansav.da7
	STRCLR	s9
	STRCPYI	s9, str_1DFB
	FILETM	i17, s2, file_1E49	; cansav.da7
	STRCAT	s9, s2
	STRCPYI	s9, str_1E55
	CALL	loc_0E80
	PRINT	9, str_1EF7
	PRINT	9, str_1E97
loc_1887:
	TBCLOSE	9
	MOVI	i561, 0
	JP	loc_15E5

loc_1895:
	CMD3F	i274, i554
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, str_1DC8
	MENUSEL	i16, i17, data_16BB, loc_18D7
	MOVI	i34, 50
loc_18C9:
	CMD42	1
	CMD43	i274, i554
	JP	loc_18C9

loc_18D7:
	JTBL	i17
	DW	loc_18EF	; 0
	DW	loc_18E3	; 1
	DW	loc_18EF	; 2
	DW	loc_18E3	; 3

loc_18E3:
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_15E5

loc_18EF:
	SUBI	i16, 1
	MOVR	i34, i32
	JTBL	i16
	DW	loc_190D	; 0
	DW	loc_193F	; 1
	DW	loc_1971	; 2
	DW	loc_19A3	; 3
	DW	loc_19D5	; 4
	DW	loc_1A07	; 5
	DW	loc_1A39	; 6

loc_190D:
	FILETM	i17, s2, file_1E01	; cansav.da1
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E01	; cansav.da1
	CALL	loc_1F8A
	JP	loc_1A67

loc_193F:
	FILETM	i17, s2, file_1E0D	; cansav.da2
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E0D	; cansav.da2
	CALL	loc_1F8A
	JP	loc_1A67

loc_1971:
	FILETM	i17, s2, file_1E19	; cansav.da3
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E19	; cansav.da3
	CALL	loc_1F8A
	JP	loc_1A67

loc_19A3:
	FILETM	i17, s2, file_1E25	; cansav.da4
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E25	; cansav.da4
	CALL	loc_1F8A
	JP	loc_1A67

loc_19D5:
	FILETM	i17, s2, file_1E31	; cansav.da5
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E31	; cansav.da5
	CALL	loc_1F8A
	JP	loc_1A67

loc_1A07:
	FILETM	i17, s2, file_1E3D	; cansav.da6
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E3D	; cansav.da6
	CALL	loc_1F8A
	JP	loc_1A67

loc_1A39:
	FILETM	i17, s2, file_1E49	; cansav.da7
	CMPI	i17, 0
	JEQ	loc_18C9
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_1E58	; cansav.sys
	CALL	loc_1F04
	REGFLD	0, file_1E49	; cansav.da7
	CALL	loc_1F8A
loc_1A67:
	BGMFADE
	MOVI	i575, 255
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_1AD7	; 0
	DW	loc_1A93	; 1
	DW	loc_1AA9	; 2
	DW	loc_1ABF	; 3

loc_1A93:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_1AD1

loc_1AA9:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_1AD1

loc_1ABF:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_1AD1:
	SUBI	i679, 1
loc_1AD7:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_1B3F	; 0
	DW	loc_1AFB	; 1
	DW	loc_1B11	; 2
	DW	loc_1B27	; 3

loc_1AFB:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_1B39

loc_1B11:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_1B39

loc_1B27:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_1B39:
	SUBI	i679, 1
loc_1B3F:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_1BA7	; 0
	DW	loc_1B63	; 1
	DW	loc_1B79	; 2
	DW	loc_1B8F	; 3

loc_1B63:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_1BA1

loc_1B79:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_1BA1

loc_1B8F:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_1BA1:
	SUBI	i679, 1
loc_1BA7:
	CMPI	i190, 1
	JNE	loc_1BC3
	CALL	loc_127E
	MOVI	i190, 0
	CALL	loc_1120
	JP	loc_1BE3

loc_1BC3:
	IMGLOAD	65, 128, 0, 0, file_1BD9, 0	; PTY000.g
	CALL	loc_123C
	JP	loc_1BE3

file_1BD9:
	DB	1, "PTY000.g", 0

loc_1BE3:
	BGMFADE
	MOVI	i575, 255
	LDSCENE	file_0104	; ss.s

loc_1BEF:
	TBCLOSE	8
	CALL	loc_127E
	REGCLR	i48, i95
	REGCLR	i112, i136
	REGCLR	i272, i287
	BGMFADE
	MOVI	i575, 255
	IMGLOAD	65, 128, 0, 0, file_1C27, 0	; PTY000.g
	CALL	loc_123C
	JP	loc_1C31

file_1C27:
	DB	1, "PTY000.g", 0

loc_1C31:
	LDSCENE	file_1C35	; open.s

file_1C35:
	DB	1, "open.s", 0
file_1C3D:
	DB	1, "waku06b.g", 0

loc_1C48:
	TBCLOSE	8
	IMGLOAD	0, 0, 0, 1, file_1158, 0	; BlackF.g
	CALL	loc_0FF4
	DOSEXIT

data_1C60:
	DW	1, 512, 208, 624, 224
	DW	2, 512, 224, 624, 240
	DW	3, 512, 240, 624, 256
	DW	4, 512, 256, 624, 272
	DW	5, 512, 272, 624, 288
	DW	6, 512, 288, 624, 304
	DW	0, 1, 480, 240, 592
	DW	256, 2, 480, 256, 592
	DW	272, 3, 480, 272, 592
	DW	288, 4, 480, 288, 592
	DW	304, 5, 480, 304, 592
	DW	320, 6, 480, 320, 592
	DW	336, 7, 480, 336, 592
	DW	352, 8, 480, 352, 592
	DW	368, 0, 1, 480, 256
	DW	592, 272, 2, 480, 272
	DW	592, 288, 3, 480, 288
	DW	592, 304, 4, 480, 304
	DW	592, 320, 5, 480, 320
	DW	592, 336, 6, 480, 336
	DW	592, 352, 7, 480, 352
	DW	592, 368, 0, 1, 480
	DW	272, 592, 288, 2, 480
	DW	288, 592, 304, 3, 480
	DW	304, 592, 320, 4, 480
	DW	320, 592, 336, 5, 480
	DW	336, 592, 352, 6, 480
	DW	352, 592, 368, 7, 480
	DW	368, 592, 384, 8, 480
	DW	384, 592, 400, 0, 1
	DW	480, 288, 592, 304, 2
	DW	480, 304, 592, 320, 3
	DW	480, 320, 592, 336, 4
	DW	480, 336, 592, 352, 5
	DW	480, 352, 592, 368, 6
	DW	480, 368, 592, 384, 0
str_1DC8:
	DB	0x04, 0x03, 0x04, 0x04, 0x04, 0x05, 0x04, 0x06, 0x04, 0x07, 0x04, 0x08, 0x04, 0x09, 0
str_1DD7:
	DB	"１： ", 0
str_1DDD:
	DB	"２： ", 0
str_1DE3:
	DB	"３： ", 0
str_1DE9:
	DB	"４： ", 0
str_1DEF:
	DB	"５： ", 0
str_1DF5:
	DB	"６： ", 0
str_1DFB:
	DB	"７： ", 0
file_1E01:
	DB	1, "cansav.da1", 0
file_1E0D:
	DB	1, "cansav.da2", 0
file_1E19:
	DB	1, "cansav.da3", 0
file_1E25:
	DB	1, "cansav.da4", 0
file_1E31:
	DB	1, "cansav.da5", 0
file_1E3D:
	DB	1, "cansav.da6", 0
file_1E49:
	DB	1, "cansav.da7", 0
str_1E55:
	DB	" ", 0x0D, 0
file_1E58:
	DB	1, "cansav.sys", 0
str_1E64:
	DB	"    セーブ", 0x0D
	DB	"    ロード", 0x0D
	DB	"トップメニュー", 0x0D
	DB	" ＤＯＳに戻る", 0
str_1E97:
	DB	"セーブしました。", 1, 0
str_1EA9:
	DB	"ファイル１に", 0
str_1EB6:
	DB	"ファイル２に", 0
str_1EC3:
	DB	"ファイル３に", 0
str_1ED0:
	DB	"ファイル４に", 0
str_1EDD:
	DB	"ファイル５に", 0
str_1EEA:
	DB	"ファイル６に", 0
str_1EF7:
	DB	"ファイル７に", 0

loc_1F04:
	MOVR	i625, i145
	MOVR	i626, i146
	MOVR	i627, i147
	MOVR	i628, i148
	MOVR	i629, i149
	MOVR	i630, i150
	MOVR	i631, i151
	MOVR	i632, i152
	MOVR	i633, i153
	MOVR	i634, i154
	MOVR	i635, i155
	MOVR	i636, i156
	MOVR	i637, i157
	MOVR	i638, i158
	MOVR	i639, i159
	MOVR	i640, i160
	MOVR	i641, i161
	MOVR	i642, i162
	MOVR	i643, i163
	MOVR	i644, i164
	MOVR	i645, i165
	MOVR	i646, i166
	RET

loc_1F8A:
	MOVR	i145, i625
	MOVR	i146, i626
	MOVR	i147, i627
	MOVR	i148, i628
	MOVR	i149, i629
	MOVR	i150, i630
	MOVR	i151, i631
	MOVR	i152, i632
	MOVR	i153, i633
	MOVR	i154, i634
	MOVR	i155, i635
	MOVR	i156, i636
	MOVR	i157, i637
	MOVR	i158, i638
	MOVR	i159, i639
	MOVR	i160, i640
	MOVR	i161, i641
	MOVR	i162, i642
	MOVR	i163, i643
	MOVR	i164, i644
	MOVR	i165, i645
	MOVR	i166, i646
	RET

