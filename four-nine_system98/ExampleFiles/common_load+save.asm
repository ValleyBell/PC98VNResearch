cloc_080A:	; entry point
	CALL	cloc_0B48
	CALL	cloc_0B7C
	CMPI	i561, 1
	JNE	cloc_081E
	RET

cloc_081E:
	CALL	cloc_0AEC
	TBOPEN	9, 2, 19, 37, 6, 0
	MOVI	i561, 1
	RET

cloc_0838:	; unused
	CALL	cloc_0AAA
	CALL	cloc_0964
	CMPI	i563, 1
	JNE	cloc_084C
	RET

cloc_084C:
	TBOPEN	9, 7, 18, 33, 7, 2
	MOVI	i563, 1
	RET

cloc_0862:	; entry point
	CALL	cloc_0AAA
	CALL	cloc_0914
	RET

csel_086C:	; unused
	DW	1, 16, 208, 128, 224
	DW	2, 16, 224, 128, 240
	DW	3, 16, 240, 128, 256
	DW	4, 16, 256, 128, 272
	DW	0
csel_0896:	; unused
	DW	1, 32, 240, 144, 256
	DW	2, 32, 256, 144, 272
	DW	3, 32, 272, 144, 288
	DW	4, 32, 288, 144, 304
	DW	0
csel_08C0:	; unused
	DW	1, 32, 256, 144, 272
	DW	2, 32, 272, 144, 288
	DW	3, 32, 288, 144, 304
	DW	4, 32, 304, 144, 320
	DW	0
csel_08EA:	; unused
	DW	1, 32, 272, 144, 288
	DW	2, 32, 288, 144, 304
	DW	3, 32, 304, 144, 320
	DW	4, 32, 320, 144, 336
	DW	0

cloc_0914:	; entry point
	CALL	cloc_0922
	CALL	cloc_093C
	CALL	cloc_0964
	RET

cloc_0922:
	CMPI	i565, 0
	JEQ	cloc_093A
	TBCLOSE	8
	TBCLOSE	9
	MOVI	i565, 0
cloc_093A:
	RET

cloc_093C:
	CMPI	i563, 0
	JEQ	cloc_0962
	TBCLOSE	9
	MOVI	i563, 0
	CMD2F	2, 36, 280, 16, 128, 0, 0, 280
cloc_0962:
	RET

cloc_0964:
	JTBL	i564
	DW	cloc_097C	; 0
	DW	cloc_0972	; 1
	DW	cloc_096E	; 2

cloc_096E:
	TBCLOSE	9
cloc_0972:
	TBCLOSE	8
	MOVI	i564, 0
cloc_097C:
	RET

cloc_097E:
	CALL	cloc_0E6D
	MOVI	i48, 1
	MOVI	i49, 0
	MOVI	i50, 0
	MOVI	i51, 80
	MOVI	i52, 2
	MOVI	i53, 0
	MOVI	i56, 398
	MOVI	i57, 0
	LOOPSTI	0
cloc_09B6:
	LOOPJPR	i57, cloc_09B6
	ADDI	i57, 1
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	cloc_0A3A
	ADDI	i50, 4
	SUBI	i56, 4
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	cloc_0A3A
	ADDI	i50, 4
	SUBI	i56, 4
	JP	cloc_09B6

cloc_0A3A:
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

cloc_0AAA:
	CMPI	i190, 1
	JEQ	cloc_0AE0
	CALL	cloc_0B94
	IMGLOAD	0, 0, 0, 1, cfile_0B3E, 0	; winf.lsp
	GFX36
	MOVI	i190, 1
	IMGLOAD	0, 0, 0, 1, cfile_0AE2, 0	; BlackF.g
	CALL	cloc_097E
cloc_0AE0:
	RET

cfile_0AE2:
	DB	1, "BlackF.g", 0

cloc_0AEC:	; entry point
	CMPI	i190, 0
	JEQ	cloc_0B32
	CALL	cloc_0914
	MOVI	i190, 0
	IMGLOAD	0, 0, 0, 1, cfile_0B34, 0	; win3.lsp
	GFX36
	CALL	cloc_0914
	CALL	cloc_0B94
	PALFADE	0, 1
	IMGLOAD	0, 0, 0, 0, cfile_15C7, 0	; waku06b.g
	PALBW	0, 3
cloc_0B32:
	RET

cfile_0B34:
	DB	1, "win3.lsp", 0
cfile_0B3E:
	DB	1, "winf.lsp", 0

cloc_0B48:
	JTBL	i562
	DW	cloc_0B66	; 0
	DW	cloc_0B5C	; 1
	DW	cloc_0B58	; 2
	DW	cloc_0B54	; 3

cloc_0B54:
	TBCLOSE	10
cloc_0B58:
	TBCLOSE	9
cloc_0B5C:
	TBCLOSE	8
	MOVI	i562, 0
cloc_0B66:
	RET

cloc_0B68:
	JTBL	i561
	DW	cloc_0B7A	; 0
	DW	cloc_0B70	; 1

cloc_0B70:
	TBCLOSE	9
	MOVI	i561, 0
cloc_0B7A:
	RET

cloc_0B7C:
	JTBL	i560
	DW	cloc_0B92	; 0
	DW	cloc_0B84	; 1

cloc_0B84:
	TBCLOSE	9
	TBCLOSE	8
	MOVI	i560, 0
cloc_0B92:
	RET

cloc_0B94:	; entry point
	CALL	cloc_0B68
	CALL	cloc_0B48
	CALL	cloc_0B7C
	RET

cloc_0BA2:	; entry point
	CALL	cloc_0AEC
	CALL	cloc_0B94
	CMPI	i672, 0
	JEQ	cloc_0BB6
	RET

cloc_0BB6:
	CALL	cloc_0C08
	RET

cloc_0BBC:	; entry point
	CALL	cloc_0E6D
	CALL	cloc_0CAD
	RET

cloc_0BC6:	; entry point
	MOVI	i0, 0
	PCOLSET	i0, i578, i577, i576
	MOVI	i0, 2
	PCOLSET	i0, i581, i580, i579
	MOVI	i0, 3
	PCOLSET	i0, i584, i583, i582
	MOVI	i0, 7
	PCOLSET	i0, i599, i598, i597
	RET

cloc_0C08:
	CALL	cloc_0B94
	IMGLOAD	2, 16, 0, 1, cfile_0C32, 0	; Black.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	CALL	cloc_0CAD
	RET

cfile_0C32:
	DB	1, "Black.lsp", 0
cfile_0C3D:
	DB	1, "BlackE.lsp", 0

cloc_0C49:	; unused
	CALL	cloc_0AEC
	CALL	cloc_0B94
	CMPI	i672, 0
	JEQ	cloc_0C7D
	IMGLOAD	2, 16, 0, 1, cfile_0C3D, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

cloc_0C7D:
	CALL	cloc_0C08
	IMGLOAD	2, 16, 0, 1, cfile_0C3D, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

cloc_0CA3:	; unused
	CALL	cloc_0E6D
	CALL	cloc_0CAD
	RET

cloc_0CAD:
	MOVI	i48, 2
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 1
	MOVI	i52, 320
	MOVI	i53, 0
	MOVI	i54, 61
	MOVI	i55, 1
	LOOPSTI	0
cloc_0CE1:
	LOOPJPR	i55, cloc_0CE1
	CMPI	i54, 1
	JEQ	cloc_0D2B
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i54, i50, i51, i52, i53, i54, i50
	ADDI	i49, 2
	SUBI	i54, 2
	ADDI	i55, 1
	JP	cloc_0CE1

cloc_0D2B:
	RET

cloc_0D2D:	; unused
	CALL	cloc_0B94
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	RET

cloc_0D45:	; unused
	MOVI	i64, 0
	CALL	cloc_0D65
	CALL	cloc_0BC6
	RET

cloc_0D55:	; unused
	MOVI	i64, 1
	CALL	cloc_0D65
	CALL	cloc_0BC6
	RET

cloc_0D65:
	MOVI	i48, 1
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 60
	MOVI	i52, 1
	MOVI	i53, 0
	MOVI	i54, 319
	MOVI	i55, 1
	LOOPSTI	0
cloc_0D99:
	LOOPJPR	i55, cloc_0D99
	CMPI	i54, 15
	JEQ	cloc_0DE1
	CALL	cloc_0DE3
	CMPI	i54, 15
	JEQ	cloc_0DE1
	CALL	cloc_0DE3
	CMPI	i54, 15
	JEQ	cloc_0DE1
	CALL	cloc_0DE3
	CMPI	i54, 15
	JEQ	cloc_0DE1
	CALL	cloc_0DE3
	ADDI	i55, 1
	JP	cloc_0D99

cloc_0DE1:
	RET

cloc_0DE3:
	CMPI	i64, 1
	JEQ	cloc_0E1F
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

cloc_0E1F:
	GFX64	i48, i49, i50, i51, i52, i53, i49, i50
	GFX64	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

cloc_0E51:	; unused
	CALL	cloc_0B94
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	CALL	cloc_0D65
	RET

cloc_0E6D:
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

cloc_0F6F:
	TBOPEN	8, 31, 12, 9, 6, 3
	PRINT	8, cstr_17EE
	CMD6A	512, 208, 513, 271
	CMD3F	i544, i552
	MENUSEL	i48, i49, csel_15EA, cloc_0FAB
cloc_0F9D:
	CMD42	1
	CMD43	i544, i552
	JP	cloc_0F9D

cloc_0FAB:
	JTBL	i49
	DW	cloc_0FBF	; 0
	DW	cloc_0FB7	; 1
	DW	cloc_0FBF	; 2
	DW	cloc_0FB7	; 3

cloc_0FB7:
	TBCLOSE	8
	JP	initloc_010A

cloc_0FBF:
	SUBI	i48, 1
	JTBL	i48
	DW	cloc_0FD1	; 0
	DW	cloc_121F	; 1
	DW	cloc_1579	; 2
	DW	cloc_15D2	; 3

cloc_0FD1:
	CMD3F	i545, i553
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, cstr_1752
	MENUSEL	i48, i49, csel_1045, cloc_100D
cloc_0FFF:
	CMD43	i545, i553
	CMD42	1
	JP	cloc_0FFF

cloc_100D:
	JTBL	i49
	DW	cloc_1025	; 0
	DW	cloc_1019	; 1
	DW	cloc_1025	; 2
	DW	cloc_1019	; 3

cloc_1019:
	TBCLOSE	9
	TBCLOSE	8
	JP	cloc_0F6F

cloc_1025:
	SUBI	i48, 1
	TBCLOSE	9
	TBCLOSE	8
	JTBL	i48
	DW	cloc_108D	; 0
	DW	cloc_10C5	; 1
	DW	cloc_10FD	; 2
	DW	cloc_1135	; 3
	DW	cloc_116D	; 4
	DW	cloc_11A5	; 5
	DW	cloc_11DD	; 6
csel_1045:
	DW	1, 336, 176, 528, 192
	DW	2, 336, 192, 528, 208
	DW	3, 336, 208, 528, 224
	DW	4, 336, 224, 528, 240
	DW	5, 336, 240, 528, 256
	DW	6, 336, 256, 528, 272
	DW	7, 336, 272, 528, 288
	DW	0

cloc_108D:
	REGFSAV	0, cfile_178B	; cansav.da1
	STRCLR	s3
	STRCPYI	s3, cstr_1761
	FILETM	i17, s2, cfile_178B	; cansav.da1
	STRCAT	s3, s2
	STRCPYI	s3, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_1833
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_10C5:
	REGFSAV	0, cfile_1797	; cansav.da2
	STRCLR	s4
	STRCPYI	s4, cstr_1767
	FILETM	i17, s2, cfile_1797	; cansav.da2
	STRCAT	s4, s2
	STRCPYI	s4, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_1840
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_10FD:
	REGFSAV	0, cfile_17A3	; cansav.da3
	STRCLR	s5
	STRCPYI	s5, cstr_176D
	FILETM	i17, s2, cfile_17A3	; cansav.da3
	STRCAT	s5, s2
	STRCPYI	s5, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_184D
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_1135:
	REGFSAV	0, cfile_17AF	; cansav.da4
	STRCLR	s6
	STRCPYI	s6, cstr_1773
	FILETM	i17, s2, cfile_17AF	; cansav.da4
	STRCAT	s6, s2
	STRCPYI	s6, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_185A
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_116D:
	REGFSAV	0, cfile_17BB	; cansav.da5
	STRCLR	s7
	STRCPYI	s7, cstr_1779
	FILETM	i17, s2, cfile_17BB	; cansav.da5
	STRCAT	s7, s2
	STRCPYI	s7, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_1867
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_11A5:
	REGFSAV	0, cfile_17C7	; cansav.da6
	STRCLR	s8
	STRCPYI	s8, cstr_177F
	FILETM	i17, s2, cfile_17C7	; cansav.da6
	STRCAT	s8, s2
	STRCPYI	s8, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_1874
	PRINT	9, cstr_1821
	JP	cloc_1211

cloc_11DD:
	REGFSAV	0, cfile_17D3	; cansav.da7
	STRCLR	s9
	STRCPYI	s9, cstr_1785
	FILETM	i17, s2, cfile_17D3	; cansav.da7
	STRCAT	s9, s2
	STRCPYI	s9, cstr_17DF
	CALL	cloc_080A
	PRINT	9, cstr_1881
	PRINT	9, cstr_1821
cloc_1211:
	TBCLOSE	9
	MOVI	i561, 0
	JP	cloc_0F6F

cloc_121F:
	CMD3F	i274, i554
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, cstr_1752
	MENUSEL	i16, i17, csel_1045, cloc_1261
	MOVI	i34, 50
cloc_1253:
	CMD42	1
	CMD43	i274, i554
	JP	cloc_1253

cloc_1261:
	JTBL	i17
	DW	cloc_1279	; 0
	DW	cloc_126D	; 1
	DW	cloc_1279	; 2
	DW	cloc_126D	; 3

cloc_126D:
	TBCLOSE	9
	TBCLOSE	8
	JP	cloc_0F6F

cloc_1279:
	SUBI	i16, 1
	MOVR	i34, i32
	JTBL	i16
	DW	cloc_1297	; 0
	DW	cloc_12C9	; 1
	DW	cloc_12FB	; 2
	DW	cloc_132D	; 3
	DW	cloc_135F	; 4
	DW	cloc_1391	; 5
	DW	cloc_13C3	; 6

cloc_1297:
	FILETM	i17, s2, cfile_178B	; cansav.da1
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_178B	; cansav.da1
	CALL	cloc_1914
	JP	cloc_13F1

cloc_12C9:
	FILETM	i17, s2, cfile_1797	; cansav.da2
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_1797	; cansav.da2
	CALL	cloc_1914
	JP	cloc_13F1

cloc_12FB:
	FILETM	i17, s2, cfile_17A3	; cansav.da3
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_17A3	; cansav.da3
	CALL	cloc_1914
	JP	cloc_13F1

cloc_132D:
	FILETM	i17, s2, cfile_17AF	; cansav.da4
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_17AF	; cansav.da4
	CALL	cloc_1914
	JP	cloc_13F1

cloc_135F:
	FILETM	i17, s2, cfile_17BB	; cansav.da5
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_17BB	; cansav.da5
	CALL	cloc_1914
	JP	cloc_13F1

cloc_1391:
	FILETM	i17, s2, cfile_17C7	; cansav.da6
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_17C7	; cansav.da6
	CALL	cloc_1914
	JP	cloc_13F1

cloc_13C3:
	FILETM	i17, s2, cfile_17D3	; cansav.da7
	CMPI	i17, 0
	JEQ	cloc_1253
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, cfile_17E2	; cansav.sys
	CALL	cloc_188E
	REGFLD	0, cfile_17D3	; cansav.da7
	CALL	cloc_1914
cloc_13F1:
	BGMFADE
	MOVI	i575, 255
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	cloc_1461	; 0
	DW	cloc_141D	; 1
	DW	cloc_1433	; 2
	DW	cloc_1449	; 3

cloc_141D:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_145B

cloc_1433:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_145B

cloc_1449:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
cloc_145B:
	SUBI	i679, 1
cloc_1461:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	cloc_14C9	; 0
	DW	cloc_1485	; 1
	DW	cloc_149B	; 2
	DW	cloc_14B1	; 3

cloc_1485:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_14C3

cloc_149B:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_14C3

cloc_14B1:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
cloc_14C3:
	SUBI	i679, 1
cloc_14C9:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	cloc_1531	; 0
	DW	cloc_14ED	; 1
	DW	cloc_1503	; 2
	DW	cloc_1519	; 3

cloc_14ED:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_152B

cloc_1503:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_152B

cloc_1519:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
cloc_152B:
	SUBI	i679, 1
cloc_1531:
	CMPI	i190, 1
	JNE	cloc_154D
	CALL	cloc_0C08
	MOVI	i190, 0
	CALL	cloc_0AAA
	JP	cloc_156D

cloc_154D:
	IMGLOAD	65, 128, 0, 0, cfile_1563, 0	; PTY000.g
	CALL	cloc_0BC6
	JP	cloc_156D

cfile_1563:
	DB	1, "PTY000.g", 0

cloc_156D:
	BGMFADE
	MOVI	i575, 255
	LDSCENE	initfile_0104	; ss.s

cloc_1579:
	TBCLOSE	8
	CALL	cloc_0C08
	REGCLR	i48, i95
	REGCLR	i112, i136
	REGCLR	i272, i287
	BGMFADE
	MOVI	i575, 255
	IMGLOAD	65, 128, 0, 0, cfile_15B1, 0	; PTY000.g
	CALL	cloc_0BC6
	JP	cloc_15BB

cfile_15B1:
	DB	1, "PTY000.g", 0

cloc_15BB:
	LDSCENE	cfile_15BF	; open.s

cfile_15BF:
	DB	1, "open.s", 0
cfile_15C7:
	DB	1, "waku06b.g", 0

cloc_15D2:
	TBCLOSE	8
	IMGLOAD	0, 0, 0, 1, cfile_0AE2, 0	; BlackF.g
	CALL	cloc_097E
	DOSEXIT

csel_15EA:
	DW	1, 512, 208, 624, 224
	DW	2, 512, 224, 624, 240
	DW	3, 512, 240, 624, 256
	DW	4, 512, 256, 624, 272
	DW	5, 512, 272, 624, 288
	DW	6, 512, 288, 624, 304
	DW	0
sel_1628:	; unused
	DW	1, 480, 240, 592, 256
	DW	2, 480, 256, 592, 272
	DW	3, 480, 272, 592, 288
	DW	4, 480, 288, 592, 304
	DW	5, 480, 304, 592, 320
	DW	6, 480, 320, 592, 336
	DW	7, 480, 336, 592, 352
	DW	8, 480, 352, 592, 368
	DW	0
sel_167A:	; unused
	DW	1, 480, 256, 592, 272
	DW	2, 480, 272, 592, 288
	DW	3, 480, 288, 592, 304
	DW	4, 480, 304, 592, 320
	DW	5, 480, 320, 592, 336
	DW	6, 480, 336, 592, 352
	DW	7, 480, 352, 592, 368
	DW	0
sel_16C2:	; unused
	DW	1, 480, 272, 592, 288
	DW	2, 480, 288, 592, 304
	DW	3, 480, 304, 592, 320
	DW	4, 480, 320, 592, 336
	DW	5, 480, 336, 592, 352
	DW	6, 480, 352, 592, 368
	DW	7, 480, 368, 592, 384
	DW	8, 480, 384, 592, 400
	DW	0
sel_1714:	; unused
	DW	1, 480, 288, 592, 304
	DW	2, 480, 304, 592, 320
	DW	3, 480, 320, 592, 336
	DW	4, 480, 336, 592, 352
	DW	5, 480, 352, 592, 368
	DW	6, 480, 368, 592, 384
	DW	0
cstr_1752:
	DB	4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8, 4, 9, 0
cstr_1761:
	DB	"１： ", 0
cstr_1767:
	DB	"２： ", 0
cstr_176D:
	DB	"３： ", 0
cstr_1773:
	DB	"４： ", 0
cstr_1779:
	DB	"５： ", 0
cstr_177F:
	DB	"６： ", 0
cstr_1785:
	DB	"７： ", 0
cfile_178B:
	DB	1, "cansav.da1", 0
cfile_1797:
	DB	1, "cansav.da2", 0
cfile_17A3:
	DB	1, "cansav.da3", 0
cfile_17AF:
	DB	1, "cansav.da4", 0
cfile_17BB:
	DB	1, "cansav.da5", 0
cfile_17C7:
	DB	1, "cansav.da6", 0
cfile_17D3:
	DB	1, "cansav.da7", 0
cstr_17DF:
	DB	" ", 0x0D, 0
cfile_17E2:
	DB	1, "cansav.sys", 0
cstr_17EE:
	DB	"    セーブ", 0x0D
	DB	"    ロード", 0x0D
	DB	"トップメニュー", 0x0D
	DB	" ＤＯＳに戻る", 0
cstr_1821:
	DB	"セーブしました。", 1, 0
cstr_1833:
	DB	"ファイル１に", 0
cstr_1840:
	DB	"ファイル２に", 0
cstr_184D:
	DB	"ファイル３に", 0
cstr_185A:
	DB	"ファイル４に", 0
cstr_1867:
	DB	"ファイル５に", 0
cstr_1874:
	DB	"ファイル６に", 0
cstr_1881:
	DB	"ファイル７に", 0

cloc_188E:
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

cloc_1914:
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

