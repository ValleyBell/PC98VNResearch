cloc_0D2D:	; entry point
	CALL	cloc_0B94
	BLIT1I	2, 2, 16, 60, 320, 1, 2, 16
	RET

cloc_0D45:	; entry point
	MOVI	i64, 0
	CALL	cloc_0D65
	CALL	cloc_0BC6
	RET

cloc_0D55:	; entry point
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
	FRMSTI	0
cloc_0D99:
	FRMJPR	i55, cloc_0D99
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
	BLIT1R	i48, i49, i50, i51, i52, i53, i49, i50
	BLIT1R	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

cloc_0E1F:
	BLIT2R	i48, i49, i50, i51, i52, i53, i49, i50
	BLIT2R	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

cloc_0E51:	; entry point
	CALL	cloc_0B94
	BLIT1I	2, 2, 16, 60, 320, 1, 2, 16
	CALL	cloc_0D65
	RET
