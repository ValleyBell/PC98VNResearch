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
	PALCSET	i0, i578, i577, i576
	MOVI	i0, 2
	PALCSET	i0, i581, i580, i579
	MOVI	i0, 3
	PALCSET	i0, i584, i583, i582
	MOVI	i0, 7
	PALCSET	i0, i599, i598, i597
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

cloc_0C49:	; entry point
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

cloc_0CA3:	; entry point
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
