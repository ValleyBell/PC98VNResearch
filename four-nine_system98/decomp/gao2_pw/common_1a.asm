cloc_22D1:
	SFXSSG	19
	PRINT	15, cstr_2E57
	CMD79	cdata_2D8A
	PRINT	15, cstr_2E54
cloc_22E5:
	TBOPEN	9, 31, 9, 9, 6, 1
	BLIT1I	2, 16, 385, 16, 14, 0, 63, 145
	CHRDLY	i1000
	PRINT	9, cstr_2988
	CHRDLY	i352
cloc_2313:
	CMD3F	i321, i335
	CMD6A	512, 160, 607, 223
	MENUSEL	i112, i113, csel_29C6, cloc_2337
cloc_232D:
	CMD43	i321, i335
	JP	cloc_232D

cloc_2337:
	JTBL	i113
	DW	cloc_23A5	; 0
	DW	cloc_2343	; 1
	DW	cloc_23A5	; 2
	DW	cloc_2343	; 3

cloc_2343:
	TBCLOSE	9
	SFXSSG	19
	PRINT	15, cstr_2E57
	CMD79	cdata_2BC6
	PRINT	15, cstr_2E54
	JP	cloc_0120

cloc_235F:
	MOVI	i502, 0
	BGMFADE
	MOVI	i502, 0
	CMPI	i503, 0
	JEQ	cloc_2391
	MOVI	i503, 0
	GFX84
	BLIT1I	0, 43, 156, 2, 9, 0, 31, 156
cloc_2391:
	PRINT	15, cstr_2E57
	CMD79	cdata_2BC6
	PRINT	15, cstr_2E54
	LDSCENE	cfile_09BD	; snr\ss.lsp

cloc_23A5:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_23B7	; 0
	DW	cloc_264A	; 1
	DW	cloc_27B6	; 2
	DW	cloc_28AD	; 3

cloc_23B7:
	CMD3F	i323, i336
	CMD6A	512, 192, 607, 303
	TBOPEN	10, 21, 11, 18, 9, 1
	CHRDLY	i1000
	PRINT	10, cstr_2ADD
	CHRDLY	i352
	MENUSEL	i112, i113, csel_29F0, cloc_23F7
cloc_23ED:
	CMD43	i323, i336
	JP	cloc_23ED

cloc_23F7:
	JTBL	i113
	DW	cloc_240B	; 0
	DW	cloc_2403	; 1
	DW	cloc_240B	; 2
	DW	cloc_2403	; 3

cloc_2403:
	TBCLOSE	10
	JP	cloc_2313

cloc_240B:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_2498	; 0
	DW	cloc_24D6	; 1
	DW	cloc_2514	; 2
	DW	cloc_2552	; 3
	DW	cloc_2590	; 4
	DW	cloc_25CE	; 5
	DW	cloc_260C	; 6
cstr_242B:
	DS	"セーブしました。", 1, 0
cstr_243D:
	DS	"ファイル１に", 0
cstr_244A:
	DS	"ファイル２に", 0
cstr_2457:
	DS	"ファイル３に", 0
cstr_2464:
	DS	"ファイル４に", 0
cstr_2471:
	DS	"ファイル５に", 0
cstr_247E:
	DS	"ファイル６に", 0
cstr_248B:
	DS	"ファイル７に", 0

cloc_2498:
	REGFSAV	0, cfile_2A82	; SAVE_F1.lsp
	STRCLR	s3
	STRCPYI	s3, cstr_2BA3
	CALL	cloc_2AEE
	STRCAT	s3, s2
	FILETM	i113, s2, cfile_2A82	; SAVE_F1.lsp
	STRCAT	s3, s2
	STRCPYI	s3, cstr_2A80
	PRINT	15, cstr_243D
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_24D6:
	REGFSAV	0, cfile_2A8F	; SAVE_F2.lsp
	STRCLR	s4
	STRCPYI	s4, cstr_2BA8
	CALL	cloc_2AEE
	STRCAT	s4, s2
	FILETM	i113, s2, cfile_2A8F	; SAVE_F2.lsp
	STRCAT	s4, s2
	STRCPYI	s4, cstr_2A80
	PRINT	15, cstr_244A
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_2514:
	REGFSAV	0, cfile_2A9C	; SAVE_F3.lsp
	STRCLR	s5
	STRCPYI	s5, cstr_2BAD
	CALL	cloc_2AEE
	STRCAT	s5, s2
	FILETM	i113, s2, cfile_2A9C	; SAVE_F3.lsp
	STRCAT	s5, s2
	STRCPYI	s5, cstr_2A80
	PRINT	15, cstr_2457
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_2552:
	REGFSAV	0, cfile_2AA9	; SAVE_F4.lsp
	STRCLR	s6
	STRCPYI	s6, cstr_2BB2
	CALL	cloc_2AEE
	STRCAT	s6, s2
	FILETM	i113, s2, cfile_2AA9	; SAVE_F4.lsp
	STRCAT	s6, s2
	STRCPYI	s6, cstr_2A80
	PRINT	15, cstr_2464
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_2590:
	REGFSAV	0, cfile_2AB6	; SAVE_F5.lsp
	STRCLR	s7
	STRCPYI	s7, cstr_2BB7
	CALL	cloc_2AEE
	STRCAT	s7, s2
	FILETM	i113, s2, cfile_2AB6	; SAVE_F5.lsp
	STRCAT	s7, s2
	STRCPYI	s7, cstr_2A80
	PRINT	15, cstr_2471
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_25CE:
	REGFSAV	0, cfile_2AC3	; SAVE_F6.lsp
	STRCLR	s8
	STRCPYI	s8, cstr_2BBC
	CALL	cloc_2AEE
	STRCAT	s8, s2
	FILETM	i113, s2, cfile_2AC3	; SAVE_F6.lsp
	STRCAT	s8, s2
	STRCPYI	s8, cstr_2A80
	PRINT	15, cstr_247E
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_260C:
	REGFSAV	0, cfile_2AD0	; SAVE_F7.lsp
	STRCLR	s9
	STRCPYI	s9, cstr_2BC1
	CALL	cloc_2AEE
	STRCAT	s9, s2
	FILETM	i113, s2, cfile_2AD0	; SAVE_F7.lsp
	STRCAT	s9, s2
	STRCPYI	s9, cstr_2A80
	PRINT	15, cstr_248B
	PRINT	15, cstr_242B
	JP	cloc_22E5

cloc_264A:
	CMD3F	i325, i337
	CMD6A	512, 208, 607, 319
	TBOPEN	10, 21, 12, 18, 9, 1
	CHRDLY	i1000
	PRINT	10, cstr_2ADD
	CHRDLY	i352
	MENUSEL	i112, i113, csel_2A38, cloc_268E
cloc_2680:
	CMD42	1
	CMD43	i325, i337
	JP	cloc_2680

cloc_268E:
	JTBL	i113
	DW	cloc_26A2	; 0
	DW	cloc_269A	; 1
	DW	cloc_26A2	; 2
	DW	cloc_269A	; 3

cloc_269A:
	TBCLOSE	10
	JP	cloc_2313

cloc_26A2:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_26BA	; 0
	DW	cloc_26DE	; 1
	DW	cloc_2702	; 2
	DW	cloc_2726	; 3
	DW	cloc_274A	; 4
	DW	cloc_276E	; 5
	DW	cloc_2792	; 6

cloc_26BA:
	FILETM	i113, s2, cfile_2A82	; SAVE_F1.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2A82	; SAVE_F1.lsp
	JP	cloc_235F

cloc_26DE:
	FILETM	i113, s2, cfile_2A8F	; SAVE_F2.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2A8F	; SAVE_F2.lsp
	JP	cloc_235F

cloc_2702:
	FILETM	i113, s2, cfile_2A9C	; SAVE_F3.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2A9C	; SAVE_F3.lsp
	JP	cloc_235F

cloc_2726:
	FILETM	i113, s2, cfile_2AA9	; SAVE_F4.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2AA9	; SAVE_F4.lsp
	JP	cloc_235F

cloc_274A:
	FILETM	i113, s2, cfile_2AB6	; SAVE_F5.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2AB6	; SAVE_F5.lsp
	JP	cloc_235F

cloc_276E:
	FILETM	i113, s2, cfile_2AC3	; SAVE_F6.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2AC3	; SAVE_F6.lsp
	JP	cloc_235F

cloc_2792:
	FILETM	i113, s2, cfile_2AD0	; SAVE_F7.lsp
	CMPI	i113, 0
	JEQ	cloc_2680
	TBCLOSE	10
	TBCLOSE	9
	REGFLD	0, cfile_2AD0	; SAVE_F7.lsp
	JP	cloc_235F

cloc_27B6:
	CMD3F	i338, i0
	TBOPEN	10, 31, 13, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_27F6
	CHRDLY	i352
	CMD6A	544, 224, 575, 239
	MENUSEL	i112, i113, csel_2805, cloc_281B
cloc_27EC:
	CMD43	i338, i0
	JP	cloc_27EC

cstr_27F6:
	DS	0x0E, 0x3C, " 速い  遅い ", 0
csel_2805:
	DW	1, 512, 224, 560, 240
	DW	2, 560, 224, 608, 240
	DW	0

cloc_281B:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_282F	; 0
	DW	cloc_282B	; 1
	DW	cloc_282F	; 2
	DW	cloc_282B	; 3

cloc_282B:
	JP	cloc_2313

cloc_282F:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_283D	; 0
	DW	cloc_2851	; 1

cloc_283D:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	15, cstr_2865
	JP	cloc_2313

cloc_2851:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	15, cstr_2889
	JP	cloc_2313

cstr_2865:
	DS	"メッセージ速度を＜速＞にしました。", 1, 0
cstr_2889:
	DS	"メッセージ速度を＜遅＞にしました。", 1, 0

cloc_28AD:
	CMD3F	i339, i0
	PRINT	15, cstr_295B
	TBOPEN	10, 31, 14, 8, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_28F3
	CHRDLY	i352
	CMD6A	544, 240, 575, 255
	MENUSEL	i112, i113, csel_2902, cloc_2918
cloc_28E9:
	CMD43	i339, i0
	JP	cloc_28E9

cstr_28F3:
	DS	0x0E, 0x96, " はい いいえ", 0
csel_2902:
	DW	1, 512, 240, 560, 256
	DW	2, 560, 240, 608, 256
	DW	0

cloc_2918:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_2930	; 0
	DW	cloc_2928	; 1
	DW	cloc_2930	; 2
	DW	cloc_2928	; 3

cloc_2928:
	TBCLEAR	15
	JP	cloc_2313

cloc_2930:
	TBCLEAR	15
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_2942	; 0
	DW	cloc_2928	; 1

cloc_2942:
	TBCLOSE	9
	LDSCENE	cfile_294A	; snr\pw_open.lsp

cfile_294A:
	DB	1, "snr\\pw_open.lsp", 0
cstr_295B:
	DS	0x0E, 0x1E, "トップメニューに戻ります。よろしいですか？", 0
cstr_2988:
	DS	0x0E, 0, "    セーブ    ", 0x0D
	DS	"    ロード    ", 0x0D
	DS	"メッセージ速度", 0x0D
	DS	"トップメニュー", 0
csel_29C6:
	DW	1, 512, 160, 624, 176
	DW	2, 512, 176, 624, 192
	DW	3, 512, 192, 624, 208
	DW	4, 512, 208, 624, 224
	DW	0
csel_29F0:
	DW	1, 352, 192, 608, 208
	DW	2, 352, 208, 608, 224
	DW	3, 352, 224, 608, 240
	DW	4, 352, 240, 608, 256
	DW	5, 352, 256, 608, 272
	DW	6, 352, 272, 608, 288
	DW	7, 352, 288, 608, 304
	DW	0
csel_2A38:
	DW	1, 352, 208, 608, 224
	DW	2, 352, 224, 608, 240
	DW	3, 352, 240, 608, 256
	DW	4, 352, 256, 608, 272
	DW	5, 352, 272, 608, 288
	DW	6, 352, 288, 608, 304
	DW	7, 352, 304, 608, 320
	DW	0
cstr_2A80:
	DS	0x0D, 0
cfile_2A82:
	DB	1, "SAVE_F1.lsp", 0
cfile_2A8F:
	DB	1, "SAVE_F2.lsp", 0
cfile_2A9C:
	DB	1, "SAVE_F3.lsp", 0
cfile_2AA9:
	DB	1, "SAVE_F4.lsp", 0
cfile_2AB6:
	DB	1, "SAVE_F5.lsp", 0
cfile_2AC3:
	DB	1, "SAVE_F6.lsp", 0
cfile_2AD0:
	DB	1, "SAVE_F7.lsp", 0
cstr_2ADD:
	DS	0x0E, 0x1E, 4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8, 4, 9, 0

cloc_2AEE:
	STRCLR	s2
	JTBL	i353
	DW	cfile_2A82	; 0
	DW	cloc_2B0A	; 1
	DW	cloc_2B12	; 2
	DW	cloc_2B1A	; 3
	DW	cloc_2B22	; 4
	DW	cloc_2B2A	; 5
	DW	cloc_2B32	; 6
	DW	cloc_2B3A	; 7
	DW	cloc_2B42	; 8
	DW	cloc_2B4A	; 9

cloc_2B0A:
	STRCPYI	s2, cstr_2B52
	RET

cloc_2B12:
	STRCPYI	s2, cstr_2B5B
	RET

cloc_2B1A:
	STRCPYI	s2, cstr_2B64
	RET

cloc_2B22:
	STRCPYI	s2, cstr_2B6D
	RET

cloc_2B2A:
	STRCPYI	s2, cstr_2B76
	RET

cloc_2B32:
	STRCPYI	s2, cstr_2B7F
	RET

cloc_2B3A:
	STRCPYI	s2, cstr_2B88
	RET

cloc_2B42:
	STRCPYI	s2, cstr_2B91
	RET

cloc_2B4A:
	STRCPYI	s2, cstr_2B9A
	RET

cstr_2B52:
	DS	"第１章  ", 0
cstr_2B5B:
	DS	"第２章  ", 0
cstr_2B64:
	DS	"第３章  ", 0
cstr_2B6D:
	DS	"第４章  ", 0
cstr_2B76:
	DS	"第５章  ", 0
cstr_2B7F:
	DS	"第６章  ", 0
cstr_2B88:
	DS	"第７章  ", 0
cstr_2B91:
	DS	"第８章  ", 0
cstr_2B9A:
	DS	"最終章  ", 0
cstr_2BA3:
	DS	"１：", 0
cstr_2BA8:
	DS	"２：", 0
cstr_2BAD:
	DS	"３：", 0
cstr_2BB2:
	DS	"４：", 0
cstr_2BB7:
	DS	"５：", 0
cstr_2BBC:
	DS	"６：", 0
cstr_2BC1:
	DS	"７：", 0
cdata_2BC6:
	DW	1, 0, 0, 0, 1, 1, 0, 0
	DW	1, 1, 1, 0, 0, 2, 1, 1
	DW	0, 0, 3, 1, 1, 0, 0, 4
	DW	1, 1, 0, 0, 5, 1, 1, 0
	DW	0, 6, 1, 1, 0, 0, 7, 1
	DW	1, 0, 0, 8, 1, 1, 0, 0
	DW	9, 1, 1, 0, 0, 10, 1, 1
	DW	0, 0, 11, 1, 1, 0, 0, 12
	DW	1, 1, 0, 0, 13, 1, 1, 0
	DW	0, 14, 1, 1, 0, 0, 15, 1
	DW	1, 0, 1, 15, 1, 1, 0, 2
	DW	15, 1, 1, 0, 3, 15, 1, 1
	DW	0, 4, 15, 2, 1, 0, 5, 15
	DW	2, 1, 0, 6, 15, 2, 1, 0
	DW	7, 15, 3, 1, 0, 8, 15, 3
	DW	1, 0, 9, 15, 3, 1, 0, 10
	DW	15, 4, 1, 0, 11, 15, 4, 1
	DW	0, 12, 15, 5, 1, 0, 13, 15
	DW	6, 1, 0, 14, 15, 7, 1, 0
	DW	15, 15, 9, 1, 0, 14, 14, 6
	DW	1, 0, 13, 13, 5, 1, 0, 12
	DW	12, 4, 1, 0, 11, 11, 4, 1
	DW	0, 10, 10, 4, 1, 0, 9, 9
	DW	3, 1, 0, 8, 8, 3, 1, 0
	DW	7, 7, 3, 1, 0, 6, 6, 2
	DW	1, 0, 5, 5, 2, 1, 0, 4
	DW	4, 2, 1, 0, 3, 3, 1, 1
	DW	0, 2, 2, 1, 1, 0, 1, 1
	DW	1, 0
cdata_2D8A:
	DW	1, 5, 0, 15, 4, 1, 6, 1
	DW	15, 2, 1, 7, 2, 15, 1, 1
	DW	8, 3, 15, 1, 1, 9, 4, 15
	DW	1, 1, 10, 5, 15, 1, 1, 11
	DW	6, 15, 1, 1, 12, 7, 15, 1
	DW	1, 13, 8, 15, 1, 1, 14, 9
	DW	15, 2, 1, 15, 10, 15, 4, 1
	DW	14, 9, 15, 2, 1, 13, 8, 15
	DW	1, 1, 12, 7, 15, 1, 1, 11
	DW	6, 15, 1, 1, 10, 5, 15, 1
	DW	1, 9, 4, 15, 1, 1, 8, 3
	DW	15, 1, 1, 7, 2, 15, 1, 1
	DW	6, 1, 15, 2, 0
cstr_2E54:
	DS	8, 1, 0
cstr_2E57:
	DS	8, 0, 0

cloc_2E5A:
	TBOPEN	10, 6, 15, 7, 8, 2
	TBOPEN	11, 13, 15, 21, 8, 3
	GFX8C
	PRINT	11, cstr_2A80
	RET

cloc_2E80:
	TBCLOSE	11
	TBCLOSE	10
	RET

