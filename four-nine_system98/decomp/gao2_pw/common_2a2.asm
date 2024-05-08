cloc_327E:
	SFXSSG	19
cloc_3282:
	TBOPEN	9, 1, 19, 9, 6, 4
	CHRDLY	i1000
	PRINT	9, cstr_38FD
	CHRDLY	i352
cloc_329E:
	CMD3F	i321, i335
	CMD6A	32, 320, 127, 383
	MENUSEL	i112, i113, csel_393B, cloc_32C2
cloc_32B8:
	CMD43	i321, i335
	JP	cloc_32B8

cloc_32C2:
	JTBL	i113
	DW	cloc_3312	; 0
	DW	cloc_32CE	; 1
	DW	cloc_3312	; 2
	DW	cloc_32CE	; 3

cloc_32CE:
	TBCLOSE	9
	TBCLOSE	12
	SFXSSG	19
	WAITKEY	i0
	SFXSSG	19
	JP	cloc_0355

cloc_32E6:
	MOVI	i502, 0
	BGMFADE
	MOVI	i502, 0
	PRINT	15, cstr_2E57
	TBCLOSE	12
	CMD79	cdata_116A	; NOT in common_2a1
	LDSCENE	cfile_3306	; snr\ss.lsp

cfile_3306:
	DB	1, "snr\\ss.lsp", 0

cloc_3312:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_3324	; 0
	DW	cloc_35B7	; 1
	DW	cloc_3723	; 2
	DW	cloc_381A	; 3

cloc_3324:
	CMD3F	i323, i336
	CMD6A	32, 272, 127, 383
	TBOPEN	10, 1, 16, 18, 9, 3
	CHRDLY	i1000
	PRINT	10, cstr_3A0A
	CHRDLY	i352
	MENUSEL	i112, i113, csel_3965, cloc_3364
cloc_335A:
	CMD43	i323, i336
	JP	cloc_335A

cloc_3364:
	JTBL	i113
	DW	cloc_3378	; 0
	DW	cloc_3370	; 1
	DW	cloc_3378	; 2
	DW	cloc_3370	; 3

cloc_3370:
	TBCLOSE	10
	JP	cloc_329E

cloc_3378:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_3405	; 0
	DW	cloc_3443	; 1
	DW	cloc_3481	; 2
	DW	cloc_34BF	; 3
	DW	cloc_34FD	; 4
	DW	cloc_353B	; 5
	DW	cloc_3579	; 6
cstr_3398:
	DS	"セーブしました。", 1, 0
cstr_33AA:
	DS	"ファイル１に", 0
cstr_33B7:
	DS	"ファイル２に", 0
cstr_33C4:
	DS	"ファイル３に", 0
cstr_33D1:
	DS	"ファイル４に", 0
cstr_33DE:
	DS	"ファイル５に", 0
cstr_33EB:
	DS	"ファイル６に", 0
cstr_33F8:
	DS	"ファイル７に", 0

cloc_3405:
	REGFSAV	0, cfile_39AF	; SAVE_F1.lsp
	STRCLR	s3
	STRCPYI	s3, cstr_3AD0
	CALL	cloc_3A1B
	STRCAT	s3, s2
	FILETM	i113, s2, cfile_39AF	; SAVE_F1.lsp
	STRCAT	s3, s2
	STRCPYI	s3, cstr_156C
	PRINT	12, cstr_33AA
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_3443:
	REGFSAV	0, cfile_39BC	; SAVE_F2.lsp
	STRCLR	s4
	STRCPYI	s4, cstr_3AD5
	CALL	cloc_3A1B
	STRCAT	s4, s2
	FILETM	i113, s2, cfile_39BC	; SAVE_F2.lsp
	STRCAT	s4, s2
	STRCPYI	s4, cstr_156C
	PRINT	12, cstr_33B7
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_3481:
	REGFSAV	0, cfile_39C9	; SAVE_F3.lsp
	STRCLR	s5
	STRCPYI	s5, cstr_3ADA
	CALL	cloc_3A1B
	STRCAT	s5, s2
	FILETM	i113, s2, cfile_39C9	; SAVE_F3.lsp
	STRCAT	s5, s2
	STRCPYI	s5, cstr_156C
	PRINT	12, cstr_33C4
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_34BF:
	REGFSAV	0, cfile_39D6	; SAVE_F4.lsp
	STRCLR	s6
	STRCPYI	s6, cstr_3ADF
	CALL	cloc_3A1B
	STRCAT	s6, s2
	FILETM	i113, s2, cfile_39D6	; SAVE_F4.lsp
	STRCAT	s6, s2
	STRCPYI	s6, cstr_156C
	PRINT	12, cstr_33D1
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_34FD:
	REGFSAV	0, cfile_39E3	; SAVE_F5.lsp
	STRCLR	s7
	STRCPYI	s7, cstr_3AE4
	CALL	cloc_3A1B
	STRCAT	s7, s2
	FILETM	i113, s2, cfile_39E3	; SAVE_F5.lsp
	STRCAT	s7, s2
	STRCPYI	s7, cstr_156C
	PRINT	12, cstr_33DE
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_353B:
	REGFSAV	0, cfile_39F0	; SAVE_F6.lsp
	STRCLR	s8
	STRCPYI	s8, cstr_3AE9
	CALL	cloc_3A1B
	STRCAT	s8, s2
	FILETM	i113, s2, cfile_39F0	; SAVE_F6.lsp
	STRCAT	s8, s2
	STRCPYI	s8, cstr_156C
	PRINT	12, cstr_33EB
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_3579:
	REGFSAV	0, cfile_39FD	; SAVE_F7.lsp
	STRCLR	s9
	STRCPYI	s9, cstr_3AEE
	CALL	cloc_3A1B
	STRCAT	s9, s2
	FILETM	i113, s2, cfile_39FD	; SAVE_F7.lsp
	STRCAT	s9, s2
	STRCPYI	s9, cstr_156C
	PRINT	12, cstr_33F8
	PRINT	12, cstr_3398
	JP	cloc_3282

cloc_35B7:
	CMD3F	i325, i337
	CMD6A	32, 272, 127, 383
	TBOPEN	10, 1, 16, 18, 9, 3
	CHRDLY	i1000
	PRINT	10, cstr_3A0A
	CHRDLY	i352
	MENUSEL	i112, i113, csel_3965, cloc_35FB
cloc_35ED:
	CMD42	1
	CMD43	i325, i337
	JP	cloc_35ED

cloc_35FB:
	JTBL	i113
	DW	cloc_360F	; 0
	DW	cloc_3607	; 1
	DW	cloc_360F	; 2
	DW	cloc_3607	; 3

cloc_3607:
	TBCLOSE	10
	JP	cloc_329E

cloc_360F:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_3627	; 0
	DW	cloc_364B	; 1
	DW	cloc_366F	; 2
	DW	cloc_3693	; 3
	DW	cloc_36B7	; 4
	DW	cloc_36DB	; 5
	DW	cloc_36FF	; 6

cloc_3627:
	FILETM	i113, s2, cfile_39AF	; SAVE_F1.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39AF	; SAVE_F1.lsp
	JP	cloc_32E6

cloc_364B:
	FILETM	i113, s2, cfile_39BC	; SAVE_F2.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39BC	; SAVE_F2.lsp
	JP	cloc_32E6

cloc_366F:
	FILETM	i113, s2, cfile_39C9	; SAVE_F3.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39C9	; SAVE_F3.lsp
	JP	cloc_32E6

cloc_3693:
	FILETM	i113, s2, cfile_39D6	; SAVE_F4.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39D6	; SAVE_F4.lsp
	JP	cloc_32E6

cloc_36B7:
	FILETM	i113, s2, cfile_39E3	; SAVE_F5.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39E3	; SAVE_F5.lsp
	JP	cloc_32E6

cloc_36DB:
	FILETM	i113, s2, cfile_39F0	; SAVE_F6.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39F0	; SAVE_F6.lsp
	JP	cloc_32E6

cloc_36FF:
	FILETM	i113, s2, cfile_39FD	; SAVE_F7.lsp
	CMPI	i113, 0
	JEQ	cloc_35ED
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_39FD	; SAVE_F7.lsp
	JP	cloc_32E6

cloc_3723:
	CMD3F	i338, i0
	TBOPEN	10, 24, 22, 8, 3, 3
	CHRDLY	i1000
	PRINT	10, cstr_3763
	CHRDLY	i352
	CMD6A	432, 368, 463, 383
	MENUSEL	i112, i113, csel_3772, cloc_3788
cloc_3759:
	CMD43	i338, i0
	JP	cloc_3759

cstr_3763:
	DS	0x0E, 0x3C, " 速い  遅い ", 0
csel_3772:
	DW	1, 400, 368, 448, 384
	DW	2, 448, 368, 496, 384
	DW	0

cloc_3788:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_379C	; 0
	DW	cloc_3798	; 1
	DW	cloc_379C	; 2
	DW	cloc_3798	; 3

cloc_3798:
	JP	cloc_329E

cloc_379C:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_37AA	; 0
	DW	cloc_37BE	; 1

cloc_37AA:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	12, cstr_37D2
	JP	cloc_329E

cloc_37BE:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	12, cstr_37F6
	JP	cloc_329E

cstr_37D2:
	DS	"メッセージ速度を＜速＞にしました。", 1, 0
cstr_37F6:
	DS	"メッセージ速度を＜遅＞にしました。", 1, 0

cloc_381A:
	CMD3F	i339, i0
	PRINT	12, cstr_38D0
	TBOPEN	10, 24, 22, 8, 3, 3
	CHRDLY	i1000
	PRINT	10, cstr_3860
	CHRDLY	i352
	CMD6A	432, 368, 463, 383
	MENUSEL	i112, i113, csel_386F, cloc_3885
cloc_3856:
	CMD43	i339, i0
	JP	cloc_3856

cstr_3860:
	DS	0x0E, 0x96, " はい いいえ", 0
csel_386F:
	DW	1, 400, 368, 448, 384
	DW	2, 448, 368, 496, 384
	DW	0

cloc_3885:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_389D	; 0
	DW	cloc_3895	; 1
	DW	cloc_389D	; 2
	DW	cloc_3895	; 3

cloc_3895:
	TBCLEAR	12
	JP	cloc_329E

cloc_389D:
	TBCLEAR	12
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_38AF	; 0
	DW	cloc_3895	; 1

cloc_38AF:
	TBCLOSE	9
	TBCLOSE	12
	CMD79	cdata_116A	; NOT in common_2a1
	LDSCENE	cfile_38BF	; snr\pw_open.lsp

cfile_38BF:
	DB	1, "snr\\pw_open.lsp", 0
cstr_38D0:
	DS	0x0E, 0x1E, "トップメニューに戻ります。よろしいですか？", 0
cstr_38FD:
	DS	0x0E, 0, "    セーブ    ", 0x0D
	DS	"    ロード    ", 0x0D
	DS	"メッセージ速度", 0x0D
	DS	"トップメニュー", 0
csel_393B:
	DW	1, 32, 320, 144, 336
	DW	2, 32, 336, 144, 352
	DW	3, 32, 352, 144, 368
	DW	4, 32, 368, 144, 384
	DW	0
csel_3965:
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
cfile_39AF:
	DB	1, "SAVE_F1.lsp", 0
cfile_39BC:
	DB	1, "SAVE_F2.lsp", 0
cfile_39C9:
	DB	1, "SAVE_F3.lsp", 0
cfile_39D6:
	DB	1, "SAVE_F4.lsp", 0
cfile_39E3:
	DB	1, "SAVE_F5.lsp", 0
cfile_39F0:
	DB	1, "SAVE_F6.lsp", 0
cfile_39FD:
	DB	1, "SAVE_F7.lsp", 0
cstr_3A0A:
	DS	0x0E, 0x1E, 4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8, 4, 9, 0

cloc_3A1B:
	STRCLR	s2
	JTBL	i353
	DW	cfile_39AF	; 0
	DW	cloc_3A37	; 1
	DW	cloc_3A3F	; 2
	DW	cloc_3A47	; 3
	DW	cloc_3A4F	; 4
	DW	cloc_3A57	; 5
	DW	cloc_3A5F	; 6
	DW	cloc_3A67	; 7
	DW	cloc_3A6F	; 8
	DW	cloc_3A77	; 9

cloc_3A37:
	STRCPYI	s2, cstr_3A7F
	RET

cloc_3A3F:
	STRCPYI	s2, cstr_3A88
	RET

cloc_3A47:
	STRCPYI	s2, cstr_3A91
	RET

cloc_3A4F:
	STRCPYI	s2, cstr_3A9A
	RET

cloc_3A57:
	STRCPYI	s2, cstr_3AA3
	RET

cloc_3A5F:
	STRCPYI	s2, cstr_3AAC
	RET

cloc_3A67:
	STRCPYI	s2, cstr_3AB5
	RET

cloc_3A6F:
	STRCPYI	s2, cstr_3ABE
	RET

cloc_3A77:
	STRCPYI	s2, cstr_3AC7
	RET

cstr_3A7F:
	DS	"第１章  ", 0
cstr_3A88:
	DS	"第２章  ", 0
cstr_3A91:
	DS	"第３章  ", 0
cstr_3A9A:
	DS	"第４章  ", 0
cstr_3AA3:
	DS	"第５章  ", 0
cstr_3AAC:
	DS	"第６章  ", 0
cstr_3AB5:
	DS	"第７章  ", 0
cstr_3ABE:
	DS	"第８章  ", 0
cstr_3AC7:
	DS	"最終章  ", 0
cstr_3AD0:
	DS	"１：", 0
cstr_3AD5:
	DS	"２：", 0
cstr_3ADA:
	DS	"３：", 0
cstr_3ADF:
	DS	"４：", 0
cstr_3AE4:
	DS	"５：", 0
cstr_3AE9:
	DS	"６：", 0
cstr_3AEE:
	DS	"７：", 0
cstr_2E57:
	DS	8, 0, 0
cstr_2E54:
	DS	8, 1, 0

