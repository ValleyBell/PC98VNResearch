cloc_0F6F:	; entry point
	TBOPEN	8, 0, 12, 9, 6, 3
	PRINT	8, cstr_17EE
	CMD6A	16, 208, 17, 271
	CMD3F	i544, i552
	MENUSEL	i48, i49, csel_086C, cloc_0FAB
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
	JP	mainloc_back

cloc_0FBF:
	SUBI	i48, 1
	JTBL	i48
	DW	cloc_0FD1	; 0
	DW	cloc_121F	; 1
	DW	cloc_1579	; 2
	DW	cloc_15D2	; 3

cloc_0FD1:
	CMD3F	i545, i553
	CMD6A	32, 192, 33, 303
	TBOPEN	9, 1, 11, 14, 9, 4
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
	DW	1, 32, 192, 224, 208
	DW	2, 32, 208, 224, 224
	DW	3, 32, 224, 224, 240
	DW	4, 32, 240, 224, 256
	DW	5, 32, 256, 224, 272
	DW	6, 32, 272, 224, 288
	DW	7, 32, 288, 224, 304
	DW	0

cloc_108D:
	REGFSAV	0, cfile_178B	; cansav.da1
	STRCLR	s3
	STRCPYI	s3, cstr_1761
	FILETM	i17, s2, cfile_178B	; cansav.da1
	STRCAT	s3, s2
	STRCPYI	s3, cstr_17DF
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
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
	CALL	cloc_0838
	BLIT1I	2, 18, 280, 14, 128, 0, 0, 280
	PRINT	9, cstr_1881
	PRINT	9, cstr_1821
cloc_1211:
	CALL	cloc_093C
	JP	cloc_0F6F

cloc_121F:
	CMD3F	i274, i554
	CMD6A	32, 192, 33, 303
	TBOPEN	9, 1, 11, 14, 9, 4
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
	BLIT1R	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_145B

cloc_1433:
	BLIT1R	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_145B

cloc_1449:
	BLIT1R	i16, i677, i678, i17, i18, i19, i677, i678
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
	BLIT1R	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_14C3

cloc_149B:
	BLIT1R	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_14C3

cloc_14B1:
	BLIT1R	i16, i677, i678, i17, i18, i19, i677, i678
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
	BLIT1R	i16, i673, i674, i17, i18, i19, i673, i674
	JP	cloc_152B

cloc_1503:
	BLIT1R	i16, i675, i676, i17, i18, i19, i675, i676
	JP	cloc_152B

cloc_1519:
	BLIT1R	i16, i677, i678, i17, i18, i19, i677, i678
cloc_152B:
	SUBI	i679, 1
cloc_1531:
	CMPI	i190, 0
	JNE	cloc_154D
	CALL	cloc_0862
	IMGLOAD	0, 0, 0, 1, cfile_0AE2, 0	; BlackF.g
	CALL	cloc_097E
	CALL	cloc_0AEC
	JP	cloc_156D

cloc_154D:
	CALL	cloc_0862
	IMGLOAD	0, 0, 0, 1, cfile_0AE2, 0	; BlackF.g
	CALL	cloc_097E
cloc_156D:
	BGMFADE
	MOVI	i575, 255
	LDSCENE	initfile_0104	; ss.s

cloc_1579:
	TBCLOSE	8
	CALL	cloc_0862
	IMGLOAD	0, 0, 0, 1, cfile_0AE2, 0	; BlackF.g
	CALL	cloc_097E
	CALL	cloc_0914
	CALL	cloc_0B94
	PALFADE	0, 1
	IMGLOAD	0, 0, 0, 0, cfile_15C7, 0	; waku06b.g
	PALBW	0, 3
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
