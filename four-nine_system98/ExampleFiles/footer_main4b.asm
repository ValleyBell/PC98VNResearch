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
