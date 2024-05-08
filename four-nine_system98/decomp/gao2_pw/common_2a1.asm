cloc_0E45:
	SFXSSG	19
cloc_0E49:
	TBOPEN	9, 1, 19, 9, 6, 4
	CHRDLY	i1000
	PRINT	9, cstr_14BC
	CHRDLY	i352
cloc_0E65:
	CMD3F	i321, i335
	CMD6A	32, 320, 127, 383
	MENUSEL	i112, i113, csel_14FA, cloc_0E89
cloc_0E7F:
	CMD43	i321, i335
	JP	cloc_0E7F

cloc_0E89:
	JTBL	i113
	DW	cloc_0ED5	; 0
	DW	cloc_0E95	; 1
	DW	cloc_0ED5	; 2
	DW	cloc_0E95	; 3

cloc_0E95:
	TBCLOSE	9
	TBCLOSE	12
	SFXSSG	19
	WAITKEY	i0
	SFXSSG	19
	JP	cloc_06DF

cloc_0EAD:
	MOVI	i502, 0
	BGMFADE
	MOVI	i502, 0
	PRINT	15, cstr_2E57
	TBCLOSE	12
	LDSCENE	cfile_0EC9	; snr\ss.lsp

cfile_0EC9:
	DB	1, "snr\\ss.lsp", 0

cloc_0ED5:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_0EE7	; 0
	DW	cloc_117A	; 1
	DW	cloc_12E6	; 2
	DW	cloc_13DD	; 3

cloc_0EE7:
	CMD3F	i323, i336
	CMD6A	32, 272, 127, 383
	TBOPEN	10, 1, 16, 18, 9, 3
	CHRDLY	i1000
	PRINT	10, cstr_15C9
	CHRDLY	i352
	MENUSEL	i112, i113, csel_1524, cloc_0F27
cloc_0F1D:
	CMD43	i323, i336
	JP	cloc_0F1D

cloc_0F27:
	JTBL	i113
	DW	cloc_0F3B	; 0
	DW	cloc_0F33	; 1
	DW	cloc_0F3B	; 2
	DW	cloc_0F33	; 3

cloc_0F33:
	TBCLOSE	10
	JP	cloc_0E65

cloc_0F3B:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_0FC8	; 0
	DW	cloc_1006	; 1
	DW	cloc_1044	; 2
	DW	cloc_1082	; 3
	DW	cloc_10C0	; 4
	DW	cloc_10FE	; 5
	DW	cloc_113C	; 6
cstr_0F5B:
	DS	"セーブしました。", 1, 0
cstr_0F6D:
	DS	"ファイル１に", 0
cstr_0F7A:
	DS	"ファイル２に", 0
cstr_0F87:
	DS	"ファイル３に", 0
cstr_0F94:
	DS	"ファイル４に", 0
cstr_0FA1:
	DS	"ファイル５に", 0
cstr_0FAE:
	DS	"ファイル６に", 0
cstr_0FBB:
	DS	"ファイル７に", 0

cloc_0FC8:
	REGFSAV	0, cfile_156E	; SAVE_F1.lsp
	STRCLR	s3
	STRCPYI	s3, cstr_168F
	CALL	cloc_15DA
	STRCAT	s3, s2
	FILETM	i113, s2, cfile_156E	; SAVE_F1.lsp
	STRCAT	s3, s2
	STRCPYI	s3, cstr_156C
	PRINT	12, cstr_0F6D
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_1006:
	REGFSAV	0, cfile_157B	; SAVE_F2.lsp
	STRCLR	s4
	STRCPYI	s4, cstr_1694
	CALL	cloc_15DA
	STRCAT	s4, s2
	FILETM	i113, s2, cfile_157B	; SAVE_F2.lsp
	STRCAT	s4, s2
	STRCPYI	s4, cstr_156C
	PRINT	12, cstr_0F7A
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_1044:
	REGFSAV	0, cfile_1588	; SAVE_F3.lsp
	STRCLR	s5
	STRCPYI	s5, cstr_1699
	CALL	cloc_15DA
	STRCAT	s5, s2
	FILETM	i113, s2, cfile_1588	; SAVE_F3.lsp
	STRCAT	s5, s2
	STRCPYI	s5, cstr_156C
	PRINT	12, cstr_0F87
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_1082:
	REGFSAV	0, cfile_1595	; SAVE_F4.lsp
	STRCLR	s6
	STRCPYI	s6, cstr_169E
	CALL	cloc_15DA
	STRCAT	s6, s2
	FILETM	i113, s2, cfile_1595	; SAVE_F4.lsp
	STRCAT	s6, s2
	STRCPYI	s6, cstr_156C
	PRINT	12, cstr_0F94
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_10C0:
	REGFSAV	0, cfile_15A2	; SAVE_F5.lsp
	STRCLR	s7
	STRCPYI	s7, cstr_16A3
	CALL	cloc_15DA
	STRCAT	s7, s2
	FILETM	i113, s2, cfile_15A2	; SAVE_F5.lsp
	STRCAT	s7, s2
	STRCPYI	s7, cstr_156C
	PRINT	12, cstr_0FA1
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_10FE:
	REGFSAV	0, cfile_15AF	; SAVE_F6.lsp
	STRCLR	s8
	STRCPYI	s8, cstr_16A8
	CALL	cloc_15DA
	STRCAT	s8, s2
	FILETM	i113, s2, cfile_15AF	; SAVE_F6.lsp
	STRCAT	s8, s2
	STRCPYI	s8, cstr_156C
	PRINT	12, cstr_0FAE
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_113C:
	REGFSAV	0, cfile_15BC	; SAVE_F7.lsp
	STRCLR	s9
	STRCPYI	s9, cstr_16AD
	CALL	cloc_15DA
	STRCAT	s9, s2
	FILETM	i113, s2, cfile_15BC	; SAVE_F7.lsp
	STRCAT	s9, s2
	STRCPYI	s9, cstr_156C
	PRINT	12, cstr_0FBB
	PRINT	12, cstr_0F5B
	JP	cloc_0E49

cloc_117A:
	CMD3F	i325, i337
	CMD6A	32, 272, 127, 383
	TBOPEN	10, 1, 16, 18, 9, 3
	CHRDLY	i1000
	PRINT	10, cstr_15C9
	CHRDLY	i352
	MENUSEL	i112, i113, csel_1524, cloc_11BE
cloc_11B0:
	CMD42	1
	CMD43	i325, i337
	JP	cloc_11B0

cloc_11BE:
	JTBL	i113
	DW	cloc_11D2	; 0
	DW	cloc_11CA	; 1
	DW	cloc_11D2	; 2
	DW	cloc_11CA	; 3

cloc_11CA:
	TBCLOSE	10
	JP	cloc_0E65

cloc_11D2:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_11EA	; 0
	DW	cloc_120E	; 1
	DW	cloc_1232	; 2
	DW	cloc_1256	; 3
	DW	cloc_127A	; 4
	DW	cloc_129E	; 5
	DW	cloc_12C2	; 6

cloc_11EA:
	FILETM	i113, s2, cfile_156E	; SAVE_F1.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_156E	; SAVE_F1.lsp
	JP	cloc_0EAD

cloc_120E:
	FILETM	i113, s2, cfile_157B	; SAVE_F2.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_157B	; SAVE_F2.lsp
	JP	cloc_0EAD

cloc_1232:
	FILETM	i113, s2, cfile_1588	; SAVE_F3.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_1588	; SAVE_F3.lsp
	JP	cloc_0EAD

cloc_1256:
	FILETM	i113, s2, cfile_1595	; SAVE_F4.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_1595	; SAVE_F4.lsp
	JP	cloc_0EAD

cloc_127A:
	FILETM	i113, s2, cfile_15A2	; SAVE_F5.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_15A2	; SAVE_F5.lsp
	JP	cloc_0EAD

cloc_129E:
	FILETM	i113, s2, cfile_15AF	; SAVE_F6.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_15AF	; SAVE_F6.lsp
	JP	cloc_0EAD

cloc_12C2:
	FILETM	i113, s2, cfile_15BC	; SAVE_F7.lsp
	CMPI	i113, 0
	JEQ	cloc_11B0
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_15BC	; SAVE_F7.lsp
	JP	cloc_0EAD

cloc_12E6:
	CMD3F	i338, i0
	TBOPEN	10, 24, 22, 8, 3, 3
	CHRDLY	i1000
	PRINT	10, cstr_1326
	CHRDLY	i352
	CMD6A	432, 368, 463, 383
	MENUSEL	i112, i113, csel_1335, cloc_134B
cloc_131C:
	CMD43	i338, i0
	JP	cloc_131C

cstr_1326:
	DS	0x0E, 0x3C, " 速い  遅い ", 0
csel_1335:
	DW	1, 400, 368, 448, 384
	DW	2, 448, 368, 496, 384
	DW	0

cloc_134B:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_135F	; 0
	DW	cloc_135B	; 1
	DW	cloc_135F	; 2
	DW	cloc_135B	; 3

cloc_135B:
	JP	cloc_0E65

cloc_135F:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_136D	; 0
	DW	cloc_1381	; 1

cloc_136D:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	12, cstr_1395
	JP	cloc_0E65

cloc_1381:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	12, cstr_13B9
	JP	cloc_0E65

cstr_1395:
	DS	"メッセージ速度を＜速＞にしました。", 1, 0
cstr_13B9:
	DS	"メッセージ速度を＜遅＞にしました。", 1, 0

cloc_13DD:
	CMD3F	i339, i0
	PRINT	12, cstr_148F
	TBOPEN	10, 24, 22, 8, 3, 3
	CHRDLY	i1000
	PRINT	10, cstr_1423
	CHRDLY	i352
	CMD6A	432, 368, 463, 383
	MENUSEL	i112, i113, csel_1432, cloc_1448
cloc_1419:
	CMD43	i339, i0
	JP	cloc_1419

cstr_1423:
	DS	0x0E, 0x96, " はい いいえ", 0
csel_1432:
	DW	1, 400, 368, 448, 384
	DW	2, 448, 368, 496, 384
	DW	0

cloc_1448:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_1460	; 0
	DW	cloc_1458	; 1
	DW	cloc_1460	; 2
	DW	cloc_1458	; 3

cloc_1458:
	TBCLEAR	12
	JP	cloc_0E65

cloc_1460:
	TBCLEAR	12
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_1472	; 0
	DW	cloc_1458	; 1

cloc_1472:
	TBCLOSE	9
	TBCLOSE	12
	LDSCENE	cfile_147E	; snr\pw_open.lsp

cfile_147E:
	DB	1, "snr\\pw_open.lsp", 0
cstr_148F:
	DS	0x0E, 0x1E, "トップメニューに戻ります。よろしいですか？", 0
cstr_14BC:
	DS	0x0E, 0, "    セーブ    ", 0x0D
	DS	"    ロード    ", 0x0D
	DS	"メッセージ速度", 0x0D
	DS	"トップメニュー", 0
csel_14FA:
	DW	1, 32, 320, 144, 336
	DW	2, 32, 336, 144, 352
	DW	3, 32, 352, 144, 368
	DW	4, 32, 368, 144, 384
	DW	0
csel_1524:
	DW	1, 32, 272, 288, 288
	DW	2, 32, 288, 288, 304
	DW	3, 32, 304, 288, 320
	DW	4, 32, 320, 288, 336
	DW	5, 32, 336, 288, 352
	DW	6, 32, 352, 288, 368
	DW	7, 32, 368, 288, 384
	DW	0
cstr_156C:
	DS	0x0D, 0
cfile_156E:
	DB	1, "SAVE_F1.lsp", 0
cfile_157B:
	DB	1, "SAVE_F2.lsp", 0
cfile_1588:
	DB	1, "SAVE_F3.lsp", 0
cfile_1595:
	DB	1, "SAVE_F4.lsp", 0
cfile_15A2:
	DB	1, "SAVE_F5.lsp", 0
cfile_15AF:
	DB	1, "SAVE_F6.lsp", 0
cfile_15BC:
	DB	1, "SAVE_F7.lsp", 0
cstr_15C9:
	DS	0x0E, 0x1E, 4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8, 4, 9, 0

cloc_15DA:
	STRCLR	s2
	JTBL	i353
	DW	cfile_156E	; 0
	DW	cloc_15F6	; 1
	DW	cloc_15FE	; 2
	DW	cloc_1606	; 3
	DW	cloc_160E	; 4
	DW	cloc_1616	; 5
	DW	cloc_161E	; 6
	DW	cloc_1626	; 7
	DW	cloc_162E	; 8
	DW	cloc_1636	; 9

cloc_15F6:
	STRCPYI	s2, cstr_163E
	RET

cloc_15FE:
	STRCPYI	s2, cstr_1647
	RET

cloc_1606:
	STRCPYI	s2, cstr_1650
	RET

cloc_160E:
	STRCPYI	s2, cstr_1659
	RET

cloc_1616:
	STRCPYI	s2, cstr_1662
	RET

cloc_161E:
	STRCPYI	s2, cstr_166B
	RET

cloc_1626:
	STRCPYI	s2, cstr_1674
	RET

cloc_162E:
	STRCPYI	s2, cstr_167D
	RET

cloc_1636:
	STRCPYI	s2, cstr_1686
	RET

cstr_163E:
	DS	"第１章  ", 0
cstr_1647:
	DS	"第２章  ", 0
cstr_1650:
	DS	"第３章  ", 0
cstr_1659:
	DS	"第４章  ", 0
cstr_1662:
	DS	"第５章  ", 0
cstr_166B:
	DS	"第６章  ", 0
cstr_1674:
	DS	"第７章  ", 0
cstr_167D:
	DS	"第８章  ", 0
cstr_1686:
	DS	"最終章  ", 0
cstr_168F:
	DS	"１：", 0
cstr_1694:
	DS	"２：", 0
cstr_1699:
	DS	"３：", 0
cstr_169E:
	DS	"４：", 0
cstr_16A3:
	DS	"５：", 0
cstr_16A8:
	DS	"６：", 0
cstr_16AD:
	DS	"７：", 0
cstr_2E57:
	DS	8, 0, 0
cstr_2E54:
	DS	8, 1, 0

