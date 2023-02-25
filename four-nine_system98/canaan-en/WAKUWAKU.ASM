	JP	loc_010A

file_0104:
	DB	1, "ss.s", 0

loc_010A:
	CMPI	i575, 3
	JEQ	loc_0171
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 3
	BGMODEG	i0
	JTBL	i0
	DW	loc_0171	; 0
	DW	loc_0132	; 1
	DW	loc_013C	; 2
	DW	loc_0146	; 3

loc_0132:
	BGMSTOP
	BGMPLAY	file_0150	; G403_26.m
	JP	loc_0171

loc_013C:
	BGMSTOP
	BGMPLAY	file_015B	; G403_86.m
	JP	loc_0171

loc_0146:
	BGMSTOP
	BGMPLAY	file_0166	; G403_GS.m
	JP	loc_0171

file_0150:
	DB	1, "G403_26.m", 0
file_015B:
	DB	1, "G403_86.m", 0
file_0166:
	DB	1, "G403_GS.m", 0

loc_0171:
	CALL	loc_538A
	CMPI	i175, 9999
	JEQ	loc_01F3
loc_017F:
	IMGLOAD	0, 0, 0, 1, file_5DBD, 0	; waku06b.g
	IMGLOAD	0, 0, 1, 1, file_4E96, 1	; neko.g
	CALL	loc_4EF2
	SFXSSG	21
	IMGLOAD	65, 128, 0, 1, file_01D9, 0	; PTY000.g
	IMGLOAD	65, 128, 0, 1, file_01E3, 1	; PTY999.g
	CMD2F	1, 65, 128, 12, 160, 0, 65, 128
	CALL	loc_53BC
	JP	loc_01ED

file_01D9:
	DB	1, "PTY000.g", 0
file_01E3:
	DB	1, "PTY999.g", 0

loc_01ED:
	MOVI	i190, 0
loc_01F3:
	MOVI	i175, 0
loc_01F9:
	TBOPEN	8, 15, 7, 13, 10, 4
	PRINT	8, str_4E09
	CMD6A	256, 128, 257, 255
	CMD3F	i1000, i1000
	MENUSEL	i48, i49, data_022F, loc_028B
loc_0227:
	CMD42	1
	JP	loc_0227

data_022F:
	DW	1, 256, 128, 432, 144
	DW	2, 256, 144, 432, 160
	DW	3, 256, 160, 432, 176
	DW	4, 256, 176, 432, 192
	DW	5, 256, 192, 432, 208
	DW	6, 256, 208, 432, 224
	DW	7, 256, 224, 432, 240
	DW	8, 256, 240, 432, 256
	DW	9, 256, 256, 432, 272
	DW	0

loc_028B:
	JTBL	i49
	DW	loc_029F	; 0
	DW	loc_0297	; 1
	DW	loc_029F	; 2
	DW	loc_0297	; 3

loc_0297:
	TBCLOSE	8
	JP	loc_4DEB

loc_029F:
	TBCLOSE	8
	SUBI	i48, 1
	JTBL	i48
	DW	loc_02BD	; 0 Greeting
	DW	loc_4D67	; 1 Manual Supplement
	DW	loc_4DD7	; 2 Recollection Mode
	DW	loc_1A02	; 3 CG Mode
	DW	loc_0A95	; 4 Change Name
	DW	loc_0AA7	; 5 Sound Mode
	DW	loc_4FA2	; 6 Prologue
	DW	loc_4DEB	; 7 Main Menu

loc_02BD:
	TBOPEN	8, 14, 5, 18, 7, 4	; text box allowing for 7-2=5 lines with 18-3=15 full-width (30 half-width) characters
	PRINT	8, str_052B
	TBCLOSE	8
	;TBOPEN	8, 18, 17, 15, 4, 4	; text box allowing for 4-2=2 lines with 15-3=12 full-width (24 half-width) characters
	TBOPEN	8, 18, 17, 15, 5, 4	; larger text box to allow for 3 lines
	PRINT	8, str_0573
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_05AE
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_05FA
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0621
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_0660
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_067A
	TBCLOSE	8
	;TBOPEN	8, 18, 17, 15, 4, 4
	TBOPEN	8, 18, 17, 15, 5, 4
	PRINT	8, str_06C4
	CALL	loc_4E9E
	PRINT	8, str_06FD
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_071C
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_0743
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0775
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_07AC
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_07D4
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_081A
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_083A
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_0882
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_08AB
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_08E4
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0917
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_099D
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_09CE
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_0A11
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0A2D
	TBCLOSE	8
	TBOPEN	8, 18, 17, 15, 4, 4
	PRINT	8, str_0A58
	TBCLOSE	8
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_0A83
	PRINT	8, str_greeting_translation
	TBCLOSE	8
	JP	loc_01F3

; --- Translated by "Cone Cow Master" ---
str_0523:	; unused
	DB	"Greeting", 1, 0
str_052B:
	DB	0x03, 0x02, "“Good Afternoon! I'm Four-", 0x0D
	DB	"Nine's catgirl mascot.”", 1, 0
str_0573:
	DB	0x03, 0x0A, "“...As expected, I don't", 0x0D
	DB	"think anyone remembers", 0x0D	; TODO: line size!!
	DB	"...”", 1, 0
str_05AE:
	DB	0x03, 0x02, "“Uuu... I'm sure it's alright.", 0x0D
	DB	"Everyone has good memory.", 0x0D
	DB	"..."
	DSJ	0x7661	; emoji: surprised with cold sweat
	DB	"probably.”", 1, 0
str_05FA:
	DB	0x03, 0x0A, "“Not so with a certain", 0x0D
	DB	"somebody...”", 1, 0
str_0621:
	DB	0x03, 0x02, "“Excuse me. Even if I look", 0x0D
	DB	"like this, I still grew up a", 0x0D
	DB	"little."
	DSJ	0x7627	; anger 💢
	DB	"”", 1, 0
str_0660:
	DB	0x03, 0x0A, "“...Grew up how?”", 1, 0
str_067A:
	DB	0x03, 0x02, "“I learned to read a few more", 0x0D
	DB	"characters... My chest grew a", 0x0D
	DB	"bit more...”", 1, 0
str_06C4:
	DB	0x03, 0x0A, "“...Looks like your face", 0x0D
	DB	"has changed more than", 0x0D
	DB	"that...”", 1	; !! TODO: only 2 lines of space
	DB	0x03, 0x0F, "*Whack!*", 0
str_06FD:
	DB	1, 0x03, 0x0A, "“......ouch......”", 1, 0
str_071C:
	DB	0x03, 0x02, "“Don't worry about such super-", 0x0D
	DB	"fluous things!”", 1, 0
str_0743:
	DB	0x03, 0x0A, "“...Wouldn't a greeting", 0x0D
	DB	"be better?”", 1, 0
str_0775:
	DB	0x03, 0x02, "“Ha! I forgot because of this", 0x0D
	DB	"bodyless cat.”", 1, 0
str_07AC:
	DB	0x03, 0x0A, "“Yeah, yeah. Do your", 0x0D
	DB	"greeting.”", 1, 0
str_07D4:
	DB	0x03, 0x02, "“Umm, about the current work", 0x0D
	DB	"on [Canaan], there was a", 0x0D
	DB	"postponement of less than a", 0x0D
	DB	"year from schedule...”", 1, 0	
str_081A:
	DB	0x03, 0x0A, "“...It's been awhile...”", 1, 0
str_083A:
	DB	0x03, 0x02, "“Because of repeated delays,", 0x0D
	DB	"there were many rumors, like", 0x0D
	DB	"‘It's never coming out’...”", 1, 0
str_0882:
	DB	0x03, 0x0A, "“...That's right, it", 0x0D
	DB	"will be done...”", 1, 0
str_08AB:
	DB	0x03, 0x02, "“With the additional time, the", 0x0D
	DB	"content is now better than", 0x0D
	DB	"ever!”", 1, 0
str_08E4:
	DB	0x03, 0x0A, "“...Don't you say that", 0x0D
	DB	"every time?...”", 1, 0
str_0917:
	DB	0x03, 0x02, "“......Why are you always", 0x0D
	DB	"backtalking everything I", 0x0D
	DB	"say?!”", 1
	DB	"“...Because you are such a", 0x0D
	DB	"misbehaved cat, let's do this.", 0x0D
	DB	"Ei!"
	DSJ	0x763A	; alert (surprised)
	DB	"”", 1, 0
str_099D:
	DB	0x03, 0x0A, "“...U U, Do- Don't turn", 0x0D
	DB	"off my neck--!!”", 1, 0
str_09CE:
	DB	0x03, 0x02, "“Now then, please take your", 0x0D
	DB	"time enjoying [Canaan ~ The", 0x0D
	DB	"Promised Land]."
	DSJ	0x763D	; paw print 🐾
	DB	"”", 1, 0
str_0A11:
	DB	0x03, 0x0A, "“..."
	DSJ	0x762E	; emoji: open mouth 😮
	DB	"”", 1, 0
str_0A2D:
	DB	0x03, 0x02, "“...By the way, does a", 0x0D
	DB	"bodyless cat have a neck?”", 1, 0
str_0A58:
	DB	0x03, 0x0A, "“...Ha! It seems like...", 0x0D
	DB	"not...”", 1, 0
str_0A83:
	DB	0x03, 0x02, "“..."
	DSJ	0x7643	; sweat droplet 2
	DB	"”", 1
	DB	0x03, 0x0F, 0
str_greeting_translation:
	DB	"Thanks to Cone Cow Master for", "\r"
	DB	"the translation.", 1, 0

loc_0A95:
	MOVI	i112, 87
	LDSCENE	file_0A9F	; Nsel.s

file_0A9F:
	DB	1, "Nsel.s", 0

loc_0AA7:
	MOVI	i52, 0
loc_0AAD:
	BGMFADE
	MOVI	i575, 255
	TBOPEN	9, 14, 9, 18, 3, 4
	PRINT	9, str_19DF
	TBOPEN	8, 14, 5, 19, 3, 4
	MOVI	i1020, 20
	MOVI	i1016, 16
	MOVI	i50, 320
	MOVI	i51, 200
	CMD6A	0, 0, 639, 399
	CMD3F	i50, i51
	CMD41	i16, i17, i53, loc_0D1A
	JP	loc_0B67

loc_0B0D:
	CMD43	i48, i49
	CMD42	1
	CMPR	i51, i49
	JLT	loc_0B2F
	CMPR	i51, i49
	JGT	loc_0B43
	JP	loc_0B0D

loc_0B2F:
	CMPI	i52, 23
	JEQ	loc_0B57
	ADDI	i52, 1
	JP	loc_0B67

loc_0B43:
	CMPI	i52, 0
	JEQ	loc_0B61
	SUBI	i52, 1
	JP	loc_0B67

loc_0B57:
	MOVI	i52, 0
	JP	loc_0B67

loc_0B61:
	MOVI	i52, 23
loc_0B67:
	JTBL	i52
	DW	loc_0B9B	; 0
	DW	loc_0BA9	; 1
	DW	loc_0BB7	; 2
	DW	loc_0BC5	; 3
	DW	loc_0BD3	; 4
	DW	loc_0BE1	; 5
	DW	loc_0BEF	; 6
	DW	loc_0BFD	; 7
	DW	loc_0C0B	; 8
	DW	loc_0C19	; 9
	DW	loc_0C27	; 10
	DW	loc_0C35	; 11
	DW	loc_0C43	; 12
	DW	loc_0C51	; 13
	DW	loc_0C5F	; 14
	DW	loc_0C6D	; 15
	DW	loc_0C7B	; 16
	DW	loc_0C89	; 17
	DW	loc_0C97	; 18
	DW	loc_0CA5	; 19
	DW	loc_0CB3	; 20
	DW	loc_0CC1	; 21
	DW	loc_0CCF	; 22
	DW	loc_0CDD	; 23

loc_0B9B:
	TBCLEAR	8
	PRINT	8, str_1836
	JP	loc_0D0C

loc_0BA9:
	TBCLEAR	8
	PRINT	8, str_1847
	JP	loc_0D0C

loc_0BB7:
	TBCLEAR	8
	PRINT	8, str_1854
	JP	loc_0D0C

loc_0BC5:
	TBCLEAR	8
	PRINT	8, str_1877
	JP	loc_0D0C

loc_0BD3:
	TBCLEAR	8
	PRINT	8, str_1888
	JP	loc_0D0C

loc_0BE1:
	TBCLEAR	8
	PRINT	8, str_18A7
	JP	loc_0D0C

loc_0BEF:
	TBCLEAR	8
	PRINT	8, str_18BC
	JP	loc_0D0C

loc_0BFD:
	TBCLEAR	8
	PRINT	8, str_18CD
	JP	loc_0D0C

loc_0C0B:
	TBCLEAR	8
	PRINT	8, str_18E2
	JP	loc_0D0C

loc_0C19:
	TBCLEAR	8
	PRINT	8, str_18E7
	JP	loc_0D0C

loc_0C27:
	TBCLEAR	8
	PRINT	8, str_1902
	JP	loc_0D0C

loc_0C35:
	TBCLEAR	8
	PRINT	8, str_1907
	JP	loc_0D0C

loc_0C43:
	TBCLEAR	8
	PRINT	8, str_1912
	JP	loc_0D0C

loc_0C51:
	TBCLEAR	8
	PRINT	8, str_1915
	JP	loc_0D0C

loc_0C5F:
	TBCLEAR	8
	PRINT	8, str_1926
	JP	loc_0D0C

loc_0C6D:
	TBCLEAR	8
	PRINT	8, str_1943
	JP	loc_0D0C

loc_0C7B:
	TBCLEAR	8
	PRINT	8, str_194E
	JP	loc_0D0C

loc_0C89:
	TBCLEAR	8
	PRINT	8, str_195B
	JP	loc_0D0C

loc_0C97:
	TBCLEAR	8
	PRINT	8, str_1976
	JP	loc_0D0C

loc_0CA5:
	TBCLEAR	8
	PRINT	8, str_1981
	JP	loc_0D0C

loc_0CB3:
	TBCLEAR	8
	PRINT	8, str_198A
	JP	loc_0D0C

loc_0CC1:
	TBCLEAR	8
	PRINT	8, str_1993
	JP	loc_0D0C

loc_0CCF:
	TBCLEAR	8
	PRINT	8, str_19B0
	JP	loc_0D0C

loc_0CDD:
	TBCLEAR	8
	PRINT	8, str_19C1
	JP	loc_0D0C

str_0CEB:	; unused
	DB	0x03, 0x02, "Press any key to stop.", 0x03, 0x0F, 0

loc_0D0C:
	WAIT	i1016
	CMD3F	i50, i51
	JP	loc_0B0D

loc_0D1A:
	JTBL	i53
	DW	loc_0D99	; 0
	DW	loc_0D26	; 1
	DW	loc_0D99	; 2
	DW	loc_0D26	; 3

loc_0D26:
	TBCLOSE	8
	TBCLOSE	9
	CMPI	i575, 3
	JEQ	loc_0D95
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 3
	BGMODEG	i0
	JTBL	i0
	DW	loc_0D95	; 0
	DW	loc_0D56	; 1
	DW	loc_0D60	; 2
	DW	loc_0D6A	; 3

loc_0D56:
	BGMSTOP
	BGMPLAY	file_0D74	; G403_26.m
	JP	loc_0D95

loc_0D60:
	BGMSTOP
	BGMPLAY	file_0D7F	; G403_86.m
	JP	loc_0D95

loc_0D6A:
	BGMSTOP
	BGMPLAY	file_0D8A	; G403_GS.m
	JP	loc_0D95

file_0D74:
	DB	1, "G403_26.m", 0
file_0D7F:
	DB	1, "G403_86.m", 0
file_0D8A:
	DB	1, "G403_GS.m", 0

loc_0D95:
	JP	loc_01F3

loc_0D99:
	JTBL	i52
	DW	loc_0DCD	; 0
	DW	loc_0E38	; 1
	DW	loc_0EA3	; 2
	DW	loc_0F0E	; 3
	DW	loc_0F79	; 4
	DW	loc_0FE4	; 5
	DW	loc_104F	; 6
	DW	loc_10BA	; 7
	DW	loc_1125	; 8
	DW	loc_1190	; 9
	DW	loc_11FB	; 10
	DW	loc_1266	; 11
	DW	loc_12D1	; 12
	DW	loc_133C	; 13
	DW	loc_13A7	; 14
	DW	loc_1412	; 15
	DW	loc_147D	; 16
	DW	loc_14E8	; 17
	DW	loc_1553	; 18
	DW	loc_15BE	; 19
	DW	loc_1629	; 20
	DW	loc_1694	; 21
	DW	loc_16FF	; 22
	DW	loc_176A	; 23

loc_0DCD:
	CMPI	i575, 0
	JEQ	loc_0E34
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 0
	BGMODEG	i0
	JTBL	i0
	DW	loc_0E34	; 0
	DW	loc_0DF5	; 1
	DW	loc_0DFF	; 2
	DW	loc_0E09	; 3

loc_0DF5:
	BGMSTOP
	BGMPLAY	file_0E13	; G400_26.m
	JP	loc_0E34

loc_0DFF:
	BGMSTOP
	BGMPLAY	file_0E1E	; G400_86.m
	JP	loc_0E34

loc_0E09:
	BGMSTOP
	BGMPLAY	file_0E29	; G400_GS.m
	JP	loc_0E34

file_0E13:
	DB	1, "G400_26.m", 0
file_0E1E:
	DB	1, "G400_86.m", 0
file_0E29:
	DB	1, "G400_GS.m", 0

loc_0E34:
	JP	loc_17F4

loc_0E38:
	CMPI	i575, 1
	JEQ	loc_0E9F
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 1
	BGMODEG	i0
	JTBL	i0
	DW	loc_0E9F	; 0
	DW	loc_0E60	; 1
	DW	loc_0E6A	; 2
	DW	loc_0E74	; 3

loc_0E60:
	BGMSTOP
	BGMPLAY	file_0E7E	; G401_26.m
	JP	loc_0E9F

loc_0E6A:
	BGMSTOP
	BGMPLAY	file_0E89	; G401_86.m
	JP	loc_0E9F

loc_0E74:
	BGMSTOP
	BGMPLAY	file_0E94	; G401_GS.m
	JP	loc_0E9F

file_0E7E:
	DB	1, "G401_26.m", 0
file_0E89:
	DB	1, "G401_86.m", 0
file_0E94:
	DB	1, "G401_GS.m", 0

loc_0E9F:
	JP	loc_17F4

loc_0EA3:
	CMPI	i575, 2
	JEQ	loc_0F0A
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 2
	BGMODEG	i0
	JTBL	i0
	DW	loc_0F0A	; 0
	DW	loc_0ECB	; 1
	DW	loc_0ED5	; 2
	DW	loc_0EDF	; 3

loc_0ECB:
	BGMSTOP
	BGMPLAY	file_0EE9	; G402_26.m
	JP	loc_0F0A

loc_0ED5:
	BGMSTOP
	BGMPLAY	file_0EF4	; G402_86.m
	JP	loc_0F0A

loc_0EDF:
	BGMSTOP
	BGMPLAY	file_0EFF	; G402_GS.m
	JP	loc_0F0A

file_0EE9:
	DB	1, "G402_26.m", 0
file_0EF4:
	DB	1, "G402_86.m", 0
file_0EFF:
	DB	1, "G402_GS.m", 0

loc_0F0A:
	JP	loc_17F4

loc_0F0E:
	CMPI	i575, 3
	JEQ	loc_0F75
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 3
	BGMODEG	i0
	JTBL	i0
	DW	loc_0F75	; 0
	DW	loc_0F36	; 1
	DW	loc_0F40	; 2
	DW	loc_0F4A	; 3

loc_0F36:
	BGMSTOP
	BGMPLAY	file_0F54	; G403_26.m
	JP	loc_0F75

loc_0F40:
	BGMSTOP
	BGMPLAY	file_0F5F	; G403_86.m
	JP	loc_0F75

loc_0F4A:
	BGMSTOP
	BGMPLAY	file_0F6A	; G403_GS.m
	JP	loc_0F75

file_0F54:
	DB	1, "G403_26.m", 0
file_0F5F:
	DB	1, "G403_86.m", 0
file_0F6A:
	DB	1, "G403_GS.m", 0

loc_0F75:
	JP	loc_17F4

loc_0F79:
	CMPI	i575, 4
	JEQ	loc_0FE0
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 4
	BGMODEG	i0
	JTBL	i0
	DW	loc_0FE0	; 0
	DW	loc_0FA1	; 1
	DW	loc_0FAB	; 2
	DW	loc_0FB5	; 3

loc_0FA1:
	BGMSTOP
	BGMPLAY	file_0FBF	; G404_26.m
	JP	loc_0FE0

loc_0FAB:
	BGMSTOP
	BGMPLAY	file_0FCA	; G404_86.m
	JP	loc_0FE0

loc_0FB5:
	BGMSTOP
	BGMPLAY	file_0FD5	; G404_GS.m
	JP	loc_0FE0

file_0FBF:
	DB	1, "G404_26.m", 0
file_0FCA:
	DB	1, "G404_86.m", 0
file_0FD5:
	DB	1, "G404_GS.m", 0

loc_0FE0:
	JP	loc_17F4

loc_0FE4:
	CMPI	i575, 5
	JEQ	loc_104B
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 5
	BGMODEG	i0
	JTBL	i0
	DW	loc_104B	; 0
	DW	loc_100C	; 1
	DW	loc_1016	; 2
	DW	loc_1020	; 3

loc_100C:
	BGMSTOP
	BGMPLAY	file_102A	; G405_26.m
	JP	loc_104B

loc_1016:
	BGMSTOP
	BGMPLAY	file_1035	; G405_86.m
	JP	loc_104B

loc_1020:
	BGMSTOP
	BGMPLAY	file_1040	; G405_GS.m
	JP	loc_104B

file_102A:
	DB	1, "G405_26.m", 0
file_1035:
	DB	1, "G405_86.m", 0
file_1040:
	DB	1, "G405_GS.m", 0

loc_104B:
	JP	loc_17F4

loc_104F:
	CMPI	i575, 6
	JEQ	loc_10B6
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 6
	BGMODEG	i0
	JTBL	i0
	DW	loc_10B6	; 0
	DW	loc_1077	; 1
	DW	loc_1081	; 2
	DW	loc_108B	; 3

loc_1077:
	BGMSTOP
	BGMPLAY	file_1095	; G406_26.m
	JP	loc_10B6

loc_1081:
	BGMSTOP
	BGMPLAY	file_10A0	; G406_86.m
	JP	loc_10B6

loc_108B:
	BGMSTOP
	BGMPLAY	file_10AB	; G406_GS.m
	JP	loc_10B6

file_1095:
	DB	1, "G406_26.m", 0
file_10A0:
	DB	1, "G406_86.m", 0
file_10AB:
	DB	1, "G406_GS.m", 0

loc_10B6:
	JP	loc_17F4

loc_10BA:
	CMPI	i575, 7
	JEQ	loc_1121
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 7
	BGMODEG	i0
	JTBL	i0
	DW	loc_1121	; 0
	DW	loc_10E2	; 1
	DW	loc_10EC	; 2
	DW	loc_10F6	; 3

loc_10E2:
	BGMSTOP
	BGMPLAY	file_1100	; G407_26.m
	JP	loc_1121

loc_10EC:
	BGMSTOP
	BGMPLAY	file_110B	; G407_86.m
	JP	loc_1121

loc_10F6:
	BGMSTOP
	BGMPLAY	file_1116	; G407_GS.m
	JP	loc_1121

file_1100:
	DB	1, "G407_26.m", 0
file_110B:
	DB	1, "G407_86.m", 0
file_1116:
	DB	1, "G407_GS.m", 0

loc_1121:
	JP	loc_17F4

loc_1125:
	CMPI	i575, 8
	JEQ	loc_118C
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 8
	BGMODEG	i0
	JTBL	i0
	DW	loc_118C	; 0
	DW	loc_114D	; 1
	DW	loc_1157	; 2
	DW	loc_1161	; 3

loc_114D:
	BGMSTOP
	BGMPLAY	file_116B	; G408_26.m
	JP	loc_118C

loc_1157:
	BGMSTOP
	BGMPLAY	file_1176	; G408_86.m
	JP	loc_118C

loc_1161:
	BGMSTOP
	BGMPLAY	file_1181	; G408_GS.m
	JP	loc_118C

file_116B:
	DB	1, "G408_26.m", 0
file_1176:
	DB	1, "G408_86.m", 0
file_1181:
	DB	1, "G408_GS.m", 0

loc_118C:
	JP	loc_17F4

loc_1190:
	CMPI	i575, 9
	JEQ	loc_11F7
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 9
	BGMODEG	i0
	JTBL	i0
	DW	loc_11F7	; 0
	DW	loc_11B8	; 1
	DW	loc_11C2	; 2
	DW	loc_11CC	; 3

loc_11B8:
	BGMSTOP
	BGMPLAY	file_11D6	; G409_26.m
	JP	loc_11F7

loc_11C2:
	BGMSTOP
	BGMPLAY	file_11E1	; G409_86.m
	JP	loc_11F7

loc_11CC:
	BGMSTOP
	BGMPLAY	file_11EC	; G409_GS.m
	JP	loc_11F7

file_11D6:
	DB	1, "G409_26.m", 0
file_11E1:
	DB	1, "G409_86.m", 0
file_11EC:
	DB	1, "G409_GS.m", 0

loc_11F7:
	JP	loc_17F4

loc_11FB:
	CMPI	i575, 10
	JEQ	loc_1262
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 10
	BGMODEG	i0
	JTBL	i0
	DW	loc_1262	; 0
	DW	loc_1223	; 1
	DW	loc_122D	; 2
	DW	loc_1237	; 3

loc_1223:
	BGMSTOP
	BGMPLAY	file_1241	; G410_26.m
	JP	loc_1262

loc_122D:
	BGMSTOP
	BGMPLAY	file_124C	; G410_86.m
	JP	loc_1262

loc_1237:
	BGMSTOP
	BGMPLAY	file_1257	; G410_GS.m
	JP	loc_1262

file_1241:
	DB	1, "G410_26.m", 0
file_124C:
	DB	1, "G410_86.m", 0
file_1257:
	DB	1, "G410_GS.m", 0

loc_1262:
	JP	loc_17F4

loc_1266:
	CMPI	i575, 11
	JEQ	loc_12CD
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 11
	BGMODEG	i0
	JTBL	i0
	DW	loc_12CD	; 0
	DW	loc_128E	; 1
	DW	loc_1298	; 2
	DW	loc_12A2	; 3

loc_128E:
	BGMSTOP
	BGMPLAY	file_12AC	; G411_26.m
	JP	loc_12CD

loc_1298:
	BGMSTOP
	BGMPLAY	file_12B7	; G411_86.m
	JP	loc_12CD

loc_12A2:
	BGMSTOP
	BGMPLAY	file_12C2	; G411_GS.m
	JP	loc_12CD

file_12AC:
	DB	1, "G411_26.m", 0
file_12B7:
	DB	1, "G411_86.m", 0
file_12C2:
	DB	1, "G411_GS.m", 0

loc_12CD:
	JP	loc_17F4

loc_12D1:
	CMPI	i575, 12
	JEQ	loc_1338
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 12
	BGMODEG	i0
	JTBL	i0
	DW	loc_1338	; 0
	DW	loc_12F9	; 1
	DW	loc_1303	; 2
	DW	loc_130D	; 3

loc_12F9:
	BGMSTOP
	BGMPLAY	file_1317	; G412_26.m
	JP	loc_1338

loc_1303:
	BGMSTOP
	BGMPLAY	file_1322	; G412_86.m
	JP	loc_1338

loc_130D:
	BGMSTOP
	BGMPLAY	file_132D	; G412_GS.m
	JP	loc_1338

file_1317:
	DB	1, "G412_26.m", 0
file_1322:
	DB	1, "G412_86.m", 0
file_132D:
	DB	1, "G412_GS.m", 0

loc_1338:
	JP	loc_17F4

loc_133C:
	CMPI	i575, 13
	JEQ	loc_13A3
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 13
	BGMODEG	i0
	JTBL	i0
	DW	loc_13A3	; 0
	DW	loc_1364	; 1
	DW	loc_136E	; 2
	DW	loc_1378	; 3

loc_1364:
	BGMSTOP
	BGMPLAY	file_1382	; G413_26.m
	JP	loc_13A3

loc_136E:
	BGMSTOP
	BGMPLAY	file_138D	; G413_86.m
	JP	loc_13A3

loc_1378:
	BGMSTOP
	BGMPLAY	file_1398	; G413_GS.m
	JP	loc_13A3

file_1382:
	DB	1, "G413_26.m", 0
file_138D:
	DB	1, "G413_86.m", 0
file_1398:
	DB	1, "G413_GS.m", 0

loc_13A3:
	JP	loc_17F4

loc_13A7:
	CMPI	i575, 14
	JEQ	loc_140E
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 14
	BGMODEG	i0
	JTBL	i0
	DW	loc_140E	; 0
	DW	loc_13CF	; 1
	DW	loc_13D9	; 2
	DW	loc_13E3	; 3

loc_13CF:
	BGMSTOP
	BGMPLAY	file_13ED	; G414_26.m
	JP	loc_140E

loc_13D9:
	BGMSTOP
	BGMPLAY	file_13F8	; G414_86.m
	JP	loc_140E

loc_13E3:
	BGMSTOP
	BGMPLAY	file_1403	; G414_GS.m
	JP	loc_140E

file_13ED:
	DB	1, "G414_26.m", 0
file_13F8:
	DB	1, "G414_86.m", 0
file_1403:
	DB	1, "G414_GS.m", 0

loc_140E:
	JP	loc_17F4

loc_1412:
	CMPI	i575, 15
	JEQ	loc_1479
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 15
	BGMODEG	i0
	JTBL	i0
	DW	loc_1479	; 0
	DW	loc_143A	; 1
	DW	loc_1444	; 2
	DW	loc_144E	; 3

loc_143A:
	BGMSTOP
	BGMPLAY	file_1458	; G415_26.m
	JP	loc_1479

loc_1444:
	BGMSTOP
	BGMPLAY	file_1463	; G415_86.m
	JP	loc_1479

loc_144E:
	BGMSTOP
	BGMPLAY	file_146E	; G415_GS.m
	JP	loc_1479

file_1458:
	DB	1, "G415_26.m", 0
file_1463:
	DB	1, "G415_86.m", 0
file_146E:
	DB	1, "G415_GS.m", 0

loc_1479:
	JP	loc_17F4

loc_147D:
	CMPI	i575, 16
	JEQ	loc_14E4
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 16
	BGMODEG	i0
	JTBL	i0
	DW	loc_14E4	; 0
	DW	loc_14A5	; 1
	DW	loc_14AF	; 2
	DW	loc_14B9	; 3

loc_14A5:
	BGMSTOP
	BGMPLAY	file_14C3	; G416_26.m
	JP	loc_14E4

loc_14AF:
	BGMSTOP
	BGMPLAY	file_14CE	; G416_86.m
	JP	loc_14E4

loc_14B9:
	BGMSTOP
	BGMPLAY	file_14D9	; G416_GS.m
	JP	loc_14E4

file_14C3:
	DB	1, "G416_26.m", 0
file_14CE:
	DB	1, "G416_86.m", 0
file_14D9:
	DB	1, "G416_GS.m", 0

loc_14E4:
	JP	loc_17F4

loc_14E8:
	CMPI	i575, 17
	JEQ	loc_154F
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 17
	BGMODEG	i0
	JTBL	i0
	DW	loc_154F	; 0
	DW	loc_1510	; 1
	DW	loc_151A	; 2
	DW	loc_1524	; 3

loc_1510:
	BGMSTOP
	BGMPLAY	file_152E	; G417_26.m
	JP	loc_154F

loc_151A:
	BGMSTOP
	BGMPLAY	file_1539	; G417_86.m
	JP	loc_154F

loc_1524:
	BGMSTOP
	BGMPLAY	file_1544	; G417_GS.m
	JP	loc_154F

file_152E:
	DB	1, "G417_26.m", 0
file_1539:
	DB	1, "G417_86.m", 0
file_1544:
	DB	1, "G417_GS.m", 0

loc_154F:
	JP	loc_17F4

loc_1553:
	CMPI	i575, 18
	JEQ	loc_15BA
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 18
	BGMODEG	i0
	JTBL	i0
	DW	loc_15BA	; 0
	DW	loc_157B	; 1
	DW	loc_1585	; 2
	DW	loc_158F	; 3

loc_157B:
	BGMSTOP
	BGMPLAY	file_1599	; G418_26.m
	JP	loc_15BA

loc_1585:
	BGMSTOP
	BGMPLAY	file_15A4	; G418_86.m
	JP	loc_15BA

loc_158F:
	BGMSTOP
	BGMPLAY	file_15AF	; G418_GS.m
	JP	loc_15BA

file_1599:
	DB	1, "G418_26.m", 0
file_15A4:
	DB	1, "G418_86.m", 0
file_15AF:
	DB	1, "G418_GS.m", 0

loc_15BA:
	JP	loc_17F4

loc_15BE:
	CMPI	i575, 19
	JEQ	loc_1625
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 19
	BGMODEG	i0
	JTBL	i0
	DW	loc_1625	; 0
	DW	loc_15E6	; 1
	DW	loc_15F0	; 2
	DW	loc_15FA	; 3

loc_15E6:
	BGMSTOP
	BGMPLAY	file_1604	; G419_26.m
	JP	loc_1625

loc_15F0:
	BGMSTOP
	BGMPLAY	file_160F	; G419_86.m
	JP	loc_1625

loc_15FA:
	BGMSTOP
	BGMPLAY	file_161A	; G419_GS.m
	JP	loc_1625

file_1604:
	DB	1, "G419_26.m", 0
file_160F:
	DB	1, "G419_86.m", 0
file_161A:
	DB	1, "G419_GS.m", 0

loc_1625:
	JP	loc_17F4

loc_1629:
	CMPI	i575, 20
	JEQ	loc_1690
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 20
	BGMODEG	i0
	JTBL	i0
	DW	loc_1690	; 0
	DW	loc_1651	; 1
	DW	loc_165B	; 2
	DW	loc_1665	; 3

loc_1651:
	BGMSTOP
	BGMPLAY	file_166F	; G420_26.m
	JP	loc_1690

loc_165B:
	BGMSTOP
	BGMPLAY	file_167A	; G420_86.m
	JP	loc_1690

loc_1665:
	BGMSTOP
	BGMPLAY	file_1685	; G420_GS.m
	JP	loc_1690

file_166F:
	DB	1, "G420_26.m", 0
file_167A:
	DB	1, "G420_86.m", 0
file_1685:
	DB	1, "G420_GS.m", 0

loc_1690:
	JP	loc_17F4

loc_1694:
	CMPI	i575, 21
	JEQ	loc_16FB
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 21
	BGMODEG	i0
	JTBL	i0
	DW	loc_16FB	; 0
	DW	loc_16BC	; 1
	DW	loc_16C6	; 2
	DW	loc_16D0	; 3

loc_16BC:
	BGMSTOP
	BGMPLAY	file_16DA	; G421_26.m
	JP	loc_16FB

loc_16C6:
	BGMSTOP
	BGMPLAY	file_16E5	; G421_86.m
	JP	loc_16FB

loc_16D0:
	BGMSTOP
	BGMPLAY	file_16F0	; G421_GS.m
	JP	loc_16FB

file_16DA:
	DB	1, "G421_26.m", 0
file_16E5:
	DB	1, "G421_86.m", 0
file_16F0:
	DB	1, "G421_GS.m", 0

loc_16FB:
	JP	loc_17F4

loc_16FF:
	CMPI	i575, 22
	JEQ	loc_1766
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 22
	BGMODEG	i0
	JTBL	i0
	DW	loc_1766	; 0
	DW	loc_1727	; 1
	DW	loc_1731	; 2
	DW	loc_173B	; 3

loc_1727:
	BGMSTOP
	BGMPLAY	file_1745	; G422_26.m
	JP	loc_1766

loc_1731:
	BGMSTOP
	BGMPLAY	file_1750	; G422_86.m
	JP	loc_1766

loc_173B:
	BGMSTOP
	BGMPLAY	file_175B	; G422_GS.m
	JP	loc_1766

file_1745:
	DB	1, "G422_26.m", 0
file_1750:
	DB	1, "G422_86.m", 0
file_175B:
	DB	1, "G422_GS.m", 0

loc_1766:
	JP	loc_17F4

loc_176A:
	CMPI	i575, 23
	JEQ	loc_17D1
	BGMSTOP
	MOVI	i575, 255
	MOVI	i575, 23
	BGMODEG	i0
	JTBL	i0
	DW	loc_17D1	; 0
	DW	loc_1792	; 1
	DW	loc_179C	; 2
	DW	loc_17A6	; 3

loc_1792:
	BGMSTOP
	BGMPLAY	file_17B0	; G423_26.m
	JP	loc_17D1

loc_179C:
	BGMSTOP
	BGMPLAY	file_17BB	; G423_86.m
	JP	loc_17D1

loc_17A6:
	BGMSTOP
	BGMPLAY	file_17C6	; G423_GS.m
	JP	loc_17D1

file_17B0:
	DB	1, "G423_26.m", 0
file_17BB:
	DB	1, "G423_86.m", 0
file_17C6:
	DB	1, "G423_GS.m", 0

loc_17D1:
	JP	loc_17F4

str_17D5:
	DB	"Stop by pressing Confirm/Cancel", 0

loc_17F4:
	TBCLEAR	9
	PRINT	9, str_17D5
	CMD1E	i60
	JTBL	i60
	DW	loc_1822	; 0
	DW	loc_180E	; 1
	DW	loc_1822	; 2
	DW	loc_180E	; 3

loc_180E:
	TBCLOSE	9
	TBCLOSE	8
	BGMSTOP
	MOVI	i575, 255
	JP	loc_0AAD

loc_1822:
	BGMFADE
	MOVI	i575, 255
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_0AAD

str_1836:
	DB	"Ｐｒｏｌｏｇｕｅ", 0
str_1847:
	DB	"オープニング", 0
str_1854:
	DB	"Ｌｉｋｅ  ａ  Ｌｉｇｈｔ  Ｗｉｎｄ", 0
str_1877:
	DB	"お気軽に行こう。", 0
str_1888:
	DB	"Ｃｈｅｅｒｆｕｌ  ｐｅｏｐｌｅ", 0
str_18A7:
	DB	"あっち向いて、ほい！", 0
str_18BC:
	DB	"ｍｅｍｏｒｉｅｓ", 0
str_18CD:
	DB	"Ｈｏｌｌｏｗｎｅｓｓ", 0
str_18E2:
	DB	"８番", 0
str_18E7:
	DB	"Ｓｈａｄｏｗ  ｃｈａｓｅｒ", 0
str_1902:
	DB	"追想", 0
str_1907:
	DB	"届かぬ願い", 0
str_1912:
	DB	"絆", 0
str_1915:
	DB	"Ｃｒｙ  ｏｕｔ！", 0
str_1926:
	DB	"Ｄｏｎ’ｔ  ｌｅａｖｅ  ｍｅ", 0
str_1943:
	DB	"守護せし者", 0
str_194E:
	DB	"Ｓｅｅｋｅｒ", 0
str_195B:
	DB	"Ｃｏｏｌ  ｓｋｙ  ｂｌｕｅ", 0
str_1976:
	DB	"Ｒｕｉｎｓ", 0
str_1981:
	DB	"Ｃａｌｌ", 0
str_198A:
	DB	"Ｔｒｕｅ", 0
str_1993:
	DB	"Ｂｕｒｓｔ  ｏｆ  ｆｌａｍｅ", 0
str_19B0:
	DB	"いつか、きっと。", 0
str_19C1:
	DB	"約束", 0
str_19C6:	; unused
	;DB	"止めるまで順番に演奏する", 0
	DB	"Play sequentially until stopped.", 0
str_19DF:
	;DB	0x03, 0x02, "聞きたい曲のところで決定してね", 0x03, 0x0F, 0
	DB	0x03, 0x02, "Choose the song you want to hear.", 0x03, 0x0F, 0

loc_1A02:
	MOVR	i0, i145
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_1A1C
	JP	loc_1AC5

loc_1A1C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1A7E, 0	; CA026.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 12
	MOVI	i580, 14
	MOVI	i579, 15
	MOVI	i584, 10
	MOVI	i583, 12
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1A87

file_1A7E:
	DB	1, "CA026.g", 0

loc_1A87:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1AAF
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1AAF:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_1AC5:
	MOVR	i0, i146
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_1ADF
	JP	loc_1D97

loc_1ADF:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1B41, 0	; CA027C.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 6
	MOVI	i581, 12
	MOVI	i580, 8
	MOVI	i579, 7
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 10
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1B4B

file_1B41:
	DB	1, "CA027C.g", 0

loc_1B4B:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1B73
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1B73:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_1B9F, 1	; CA027B.g
	CALL	loc_5174
	JP	loc_1BA9

file_1B9F:
	DB	1, "CA027B.g", 0

loc_1BA9:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1BD1
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1BD1:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_1BFD, 1	; CA027A.g
	CALL	loc_5174
	JP	loc_1C07

file_1BFD:
	DB	1, "CA027A.g", 0

loc_1C07:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1C2F
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1C2F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1CA7, 0	; CA028.g
	MOVI	i578, 15
	MOVI	i577, 13
	MOVI	i576, 11
	MOVI	i581, 15
	MOVI	i580, 14
	MOVI	i579, 12
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 10
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1CB0

file_1CA7:
	DB	1, "CA028.g", 0

loc_1CB0:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1CD8
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1CD8:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1D50, 0	; CA029.g
	MOVI	i578, 0
	MOVI	i577, 0
	MOVI	i576, 0
	MOVI	i581, 0
	MOVI	i580, 0
	MOVI	i579, 0
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 10
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1D59

file_1D50:
	DB	1, "CA029.g", 0

loc_1D59:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1D81
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1D81:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_1D97:
	MOVR	i0, i147
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_1DB1
	JP	loc_20D2

loc_1DB1:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1E13, 0	; CA030.g
	MOVI	i578, 1
	MOVI	i577, 1
	MOVI	i576, 2
	MOVI	i581, 0
	MOVI	i580, 6
	MOVI	i579, 5
	MOVI	i584, 4
	MOVI	i583, 2
	MOVI	i582, 2
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1E1C

file_1E13:
	DB	1, "CA030.g", 0

loc_1E1C:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1E44
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1E44:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1EBC, 0	; CA031B.g
	MOVI	i578, 1
	MOVI	i577, 1
	MOVI	i576, 2
	MOVI	i581, 0
	MOVI	i580, 6
	MOVI	i579, 5
	MOVI	i584, 4
	MOVI	i583, 2
	MOVI	i582, 2
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_1EC6

file_1EBC:
	DB	1, "CA031B.g", 0

loc_1EC6:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1EEE
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1EEE:
	MOVR	i0, i147
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_1F08
	JP	loc_20D2

loc_1F08:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_1F34, 1	; CA031A.g
	CALL	loc_5174
	JP	loc_1F3E

file_1F34:
	DB	1, "CA031A.g", 0

loc_1F3E:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_1F66
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_1F66:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_1FEC, 0	; CA032B.g
	IMGLOAD	0, 0, 0, 1, file_1FF6, 1	; CA032A.g
	MOVI	i578, 1
	MOVI	i577, 1
	MOVI	i576, 2
	MOVI	i581, 0
	MOVI	i580, 6
	MOVI	i579, 5
	MOVI	i584, 4
	MOVI	i583, 2
	MOVI	i582, 2
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2000

file_1FEC:
	DB	1, "CA032B.g", 0
file_1FF6:
	DB	1, "CA032A.g", 0

loc_2000:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2028
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2028:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_208A, 0	; CA032B.g
	MOVI	i578, 1
	MOVI	i577, 1
	MOVI	i576, 2
	MOVI	i581, 0
	MOVI	i580, 6
	MOVI	i579, 5
	MOVI	i584, 4
	MOVI	i583, 2
	MOVI	i582, 2
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2094

file_208A:
	DB	1, "CA032B.g", 0

loc_2094:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_20BC
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_20BC:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_20D2:
	MOVR	i0, i148
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_20EC
	JP	loc_223E

loc_20EC:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_214E, 0	; CA033.g
	MOVI	i578, 8
	MOVI	i577, 5
	MOVI	i576, 13
	MOVI	i581, 15
	MOVI	i580, 10
	MOVI	i579, 9
	MOVI	i584, 15
	MOVI	i583, 13
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2157

file_214E:
	DB	1, "CA033.g", 0

loc_2157:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_217F
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_217F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_21F7, 0	; CA034.g
	MOVI	i578, 1
	MOVI	i577, 1
	MOVI	i576, 2
	MOVI	i581, 1
	MOVI	i580, 4
	MOVI	i579, 2
	MOVI	i584, 8
	MOVI	i583, 5
	MOVI	i582, 13
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 5
	CALL	loc_5174
	JP	loc_2200

file_21F7:
	DB	1, "CA034.g", 0

loc_2200:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2228
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2228:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_223E:
	MOVR	i0, i149
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_2258
	JP	loc_2622

loc_2258:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_22BA, 0	; CA035C.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 5
	MOVI	i581, 11
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 14
	MOVI	i583, 13
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 5
	MOVI	i597, 5
	CALL	loc_5174
	JP	loc_22C4

file_22BA:
	DB	1, "CA035C.g", 0

loc_22C4:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_22EC
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_22EC:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_235C, 0	; CA035C.g
	IMGLOAD	0, 0, 0, 1, file_2366, 1	; CA035B.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 5
	MOVI	i581, 11
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 14
	MOVI	i583, 13
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 5
	MOVI	i597, 5
	CALL	loc_5174
	JP	loc_2370

file_235C:
	DB	1, "CA035C.g", 0
file_2366:
	DB	1, "CA035B.g", 0

loc_2370:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2398
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2398:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2416, 0	; CA035C.g
	IMGLOAD	0, 0, 0, 1, file_2420, 1	; CA035B.g
	IMGLOAD	0, 0, 0, 1, file_242A, 1	; CA035A.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 5
	MOVI	i581, 11
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 14
	MOVI	i583, 13
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 5
	MOVI	i597, 5
	CALL	loc_5174
	JP	loc_2434

file_2416:
	DB	1, "CA035C.g", 0
file_2420:
	DB	1, "CA035B.g", 0
file_242A:
	DB	1, "CA035A.g", 0

loc_2434:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_245C
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_245C:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_2488, 1	; CA035D.g
	CALL	loc_5174
	JP	loc_2492

file_2488:
	DB	1, "CA035D.g", 0

loc_2492:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_24BA
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_24BA:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2532, 0	; CA036.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 5
	MOVI	i581, 11
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 14
	MOVI	i583, 13
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_253B

file_2532:
	DB	1, "CA036.g", 0

loc_253B:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2563
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2563:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_25DB, 0	; CA037.g
	MOVI	i578, 9
	MOVI	i577, 7
	MOVI	i576, 5
	MOVI	i581, 11
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 14
	MOVI	i583, 13
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_25E4

file_25DB:
	DB	1, "CA037.g", 0

loc_25E4:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_260C
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_260C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_2622:
	MOVR	i0, i150
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_263C
	JP	loc_28E4

loc_263C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_269E, 0	; CA038A.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 14
	MOVI	i579, 10
	MOVI	i584, 15
	MOVI	i583, 7
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_26A8

file_269E:
	DB	1, "CA038A.g", 0

loc_26A8:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_26D0
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_26D0:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2740, 0	; CA038A.g
	IMGLOAD	0, 0, 0, 1, file_274A, 1	; CA038B.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 14
	MOVI	i579, 10
	MOVI	i584, 15
	MOVI	i583, 7
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2754

file_2740:
	DB	1, "CA038A.g", 0
file_274A:
	DB	1, "CA038B.g", 0

loc_2754:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_277C
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_277C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_27F4, 0	; CA039.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 14
	MOVI	i579, 10
	MOVI	i584, 15
	MOVI	i583, 7
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_27FD

file_27F4:
	DB	1, "CA039.g", 0

loc_27FD:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2825
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2825:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_289D, 0	; CA040.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 14
	MOVI	i579, 10
	MOVI	i584, 15
	MOVI	i583, 7
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_28A6

file_289D:
	DB	1, "CA040.g", 0

loc_28A6:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_28CE
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_28CE:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_28E4:
	MOVR	i0, i151
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_28FE
	JP	loc_2AF9

loc_28FE:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2960, 0	; CA041.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 9
	MOVI	i580, 8
	MOVI	i579, 15
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2969

file_2960:
	DB	1, "CA041.g", 0

loc_2969:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2991
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2991:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2A09, 0	; CA042.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 9
	MOVI	i580, 8
	MOVI	i579, 15
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2A12

file_2A09:
	DB	1, "CA042.g", 0

loc_2A12:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2A3A
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2A3A:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2AB2, 0	; CA043.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 9
	MOVI	i580, 8
	MOVI	i579, 15
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2ABB

file_2AB2:
	DB	1, "CA043.g", 0

loc_2ABB:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2AE3
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2AE3:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_2AF9:
	MOVR	i0, i152
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_2B13
	JP	loc_2BBC

loc_2B13:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2B75, 0	; CA044.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 9
	MOVI	i580, 7
	MOVI	i579, 5
	MOVI	i584, 11
	MOVI	i583, 9
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2B7E

file_2B75:
	DB	1, "CA044.g", 0

loc_2B7E:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2BA6
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2BA6:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_2BBC:
	MOVR	i0, i153
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_2BD6
	JP	loc_2EA8

loc_2BD6:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2C38, 0	; CA045B.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 7
	MOVI	i579, 4
	MOVI	i584, 5
	MOVI	i583, 11
	MOVI	i582, 7
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2C42

file_2C38:
	DB	1, "CA045B.g", 0

loc_2C42:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2C6A
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2C6A:
	MOVR	i0, i153
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_2C84
	JP	loc_2E92

loc_2C84:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_2CB0, 1	; CA045C.g
	CALL	loc_5174
	JP	loc_2CBA

file_2CB0:
	DB	1, "CA045C.g", 0

loc_2CBA:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2CE2
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2CE2:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_2D0E, 1	; CA045A.g
	CALL	loc_5174
	JP	loc_2D18

file_2D0E:
	DB	1, "CA045A.g", 0

loc_2D18:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2D40
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2D40:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2DB8, 0	; CA046.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 7
	MOVI	i579, 4
	MOVI	i584, 5
	MOVI	i583, 11
	MOVI	i582, 7
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2DC1

file_2DB8:
	DB	1, "CA046.g", 0

loc_2DC1:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2DE9
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2DE9:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2E61, 0	; CA047.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 7
	MOVI	i579, 4
	MOVI	i584, 5
	MOVI	i583, 11
	MOVI	i582, 7
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2E6A

file_2E61:
	DB	1, "CA047.g", 0

loc_2E6A:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2E92
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2E92:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_2EA8:
	MOVR	i0, i154
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_2EC2
	JP	loc_30D7

loc_2EC2:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2F24, 0	; CA048.g
	MOVI	i578, 1
	MOVI	i577, 3
	MOVI	i576, 7
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 5
	MOVI	i583, 6
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2F2D

file_2F24:
	DB	1, "CA048.g", 0

loc_2F2D:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_2F55
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_2F55:
	MOVR	i0, i154
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_2F6F
	JP	loc_30C1

loc_2F6F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_2FE7, 0	; CA049.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 9
	MOVI	i580, 9
	MOVI	i579, 11
	MOVI	i584, 0
	MOVI	i583, 7
	MOVI	i582, 6
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_2FF0

file_2FE7:
	DB	1, "CA049.g", 0

loc_2FF0:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3018
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3018:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3090, 0	; CA050.g
	MOVI	i578, 7
	MOVI	i577, 5
	MOVI	i576, 15
	MOVI	i581, 10
	MOVI	i580, 8
	MOVI	i579, 15
	MOVI	i584, 13
	MOVI	i583, 11
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3099

file_3090:
	DB	1, "CA050.g", 0

loc_3099:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_30C1
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_30C1:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_30D7:
	MOVR	i0, i155
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_30F1
	JP	loc_33F8

loc_30F1:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3153, 0	; CA051A.g
	MOVI	i578, 4
	MOVI	i577, 4
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 15
	MOVI	i579, 0
	MOVI	i584, 9
	MOVI	i583, 11
	MOVI	i582, 4
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_315D

file_3153:
	DB	1, "CA051A.g", 0

loc_315D:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3185
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3185:
	MOVR	i0, i155
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_319F
	JP	loc_33E2

loc_319F:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_31CB, 1	; CA051B.g
	CALL	loc_5174
	JP	loc_31D5

file_31CB:
	DB	1, "CA051B.g", 0

loc_31D5:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_31FD
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_31FD:
	MOVR	i0, i155
	ANDI	i0, 8
	CMPI	i0, 8
	JEQ	loc_3217
	JP	loc_33E2

loc_3217:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_328F, 0	; CA052A.g
	MOVI	i578, 5
	MOVI	i577, 11
	MOVI	i576, 7
	MOVI	i581, 1
	MOVI	i580, 5
	MOVI	i579, 3
	MOVI	i584, 0
	MOVI	i583, 7
	MOVI	i582, 4
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3299

file_328F:
	DB	1, "CA052A.g", 0

loc_3299:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_32C1
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_32C1:
	MOVR	i0, i155
	ANDI	i0, 16
	CMPI	i0, 16
	JEQ	loc_32DB
	JP	loc_33E2

loc_32DB:
	CALL	loc_5058
	CMD2F	0, 0, 0, 80, 400, 1, 0, 0
	IMGLOAD	0, 0, 0, 1, file_3307, 1	; CA052B.g
	CALL	loc_5174
	JP	loc_3311

file_3307:
	DB	1, "CA052B.g", 0

loc_3311:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3339
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3339:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_33B1, 0	; CA053.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 7
	MOVI	i580, 11
	MOVI	i579, 9
	MOVI	i584, 13
	MOVI	i583, 14
	MOVI	i582, 15
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_33BA

file_33B1:
	DB	1, "CA053.g", 0

loc_33BA:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_33E2
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_33E2:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_33F8:
	MOVR	i0, i156
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3412
	JP	loc_360D

loc_3412:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3474, 0	; CA054.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 5
	MOVI	i579, 3
	MOVI	i584, 2
	MOVI	i583, 7
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_347D

file_3474:
	DB	1, "CA054.g", 0

loc_347D:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_34A5
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_34A5:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_351D, 0	; CA055.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 0
	MOVI	i580, 4
	MOVI	i579, 3
	MOVI	i584, 2
	MOVI	i583, 6
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3526

file_351D:
	DB	1, "CA055.g", 0

loc_3526:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_354E
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_354E:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_35C6, 0	; CA056.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 4
	MOVI	i580, 5
	MOVI	i579, 4
	MOVI	i584, 2
	MOVI	i583, 7
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_35CF

file_35C6:
	DB	1, "CA056.g", 0

loc_35CF:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_35F7
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_35F7:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_360D:
	MOVR	i0, i157
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3627
	JP	loc_383C

loc_3627:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3689, 0	; CA057.g
	MOVI	i578, 15
	MOVI	i577, 12
	MOVI	i576, 14
	MOVI	i581, 15
	MOVI	i580, 10
	MOVI	i579, 11
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3692

file_3689:
	DB	1, "CA057.g", 0

loc_3692:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_36BA
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_36BA:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	MOVR	i0, i157
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_36EA
	JP	loc_383C

loc_36EA:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_374C, 0	; CA058.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 15
	MOVI	i580, 11
	MOVI	i579, 11
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3755

file_374C:
	DB	1, "CA058.g", 0

loc_3755:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_377D
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_377D:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_37F5, 0	; CA059.g
	MOVI	i578, 15
	MOVI	i577, 6
	MOVI	i576, 7
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 15
	MOVI	i583, 12
	MOVI	i582, 13
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_37FE

file_37F5:
	DB	1, "CA059.g", 0

loc_37FE:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3826
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3826:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_383C:
	MOVR	i0, i158
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3856
	JP	loc_3A51

loc_3856:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_38B8, 0	; CA060.g
	MOVI	i578, 8
	MOVI	i577, 8
	MOVI	i576, 10
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 5
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_38C1

file_38B8:
	DB	1, "CA060.g", 0

loc_38C1:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_38E9
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_38E9:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3961, 0	; CA061.g
	MOVI	i578, 8
	MOVI	i577, 8
	MOVI	i576, 10
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 5
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_396A

file_3961:
	DB	1, "CA061.g", 0

loc_396A:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3992
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3992:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3A0A, 0	; CA062.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 10
	MOVI	i580, 6
	MOVI	i579, 15
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3A13

file_3A0A:
	DB	1, "CA062.g", 0

loc_3A13:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3A3B
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3A3B:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_3A51:
	MOVR	i0, i159
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_3A6B
	JP	loc_3B14

loc_3A6B:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3ACD, 0	; CA063.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 7
	MOVI	i579, 9
	MOVI	i584, 15
	MOVI	i583, 12
	MOVI	i582, 13
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3AD6

file_3ACD:
	DB	1, "CA063.g", 0

loc_3AD6:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3AFE
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3AFE:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_3B14:
	MOVR	i0, i159
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3B2E
	JP	loc_3C80

loc_3B2E:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3B90, 0	; CA064.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 7
	MOVI	i579, 9
	MOVI	i584, 15
	MOVI	i583, 12
	MOVI	i582, 13
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3B99

file_3B90:
	DB	1, "CA064.g", 0

loc_3B99:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3BC1
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3BC1:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3C39, 0	; CA065.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 7
	MOVI	i579, 9
	MOVI	i584, 15
	MOVI	i583, 12
	MOVI	i582, 13
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3C42

file_3C39:
	DB	1, "CA065.g", 0

loc_3C42:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3C6A
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3C6A:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_3C80:
	MOVR	i0, i160
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3C9A
	JP	loc_3E95

loc_3C9A:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3CFC, 0	; CA066.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 12
	MOVI	i580, 12
	MOVI	i579, 13
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3D05

file_3CFC:
	DB	1, "CA066.g", 0

loc_3D05:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3D2D
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3D2D:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3DA5, 0	; CA067.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 12
	MOVI	i580, 12
	MOVI	i579, 13
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3DAE

file_3DA5:
	DB	1, "CA067.g", 0

loc_3DAE:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3DD6
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3DD6:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3E4E, 0	; CA068.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 12
	MOVI	i580, 12
	MOVI	i579, 13
	MOVI	i584, 15
	MOVI	i583, 7
	MOVI	i582, 9
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3E57

file_3E4E:
	DB	1, "CA068.g", 0

loc_3E57:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3E7F
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3E7F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_3E95:
	MOVR	i0, i161
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_3EAF
	JP	loc_40AA

loc_3EAF:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3F11, 0	; CA069.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 10
	MOVI	i580, 9
	MOVI	i579, 14
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3F1A

file_3F11:
	DB	1, "CA069.g", 0

loc_3F1A:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3F42
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3F42:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_3FBA, 0	; CA070.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 15
	MOVI	i580, 8
	MOVI	i579, 8
	MOVI	i584, 13
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_3FC3

file_3FBA:
	DB	1, "CA070.g", 0

loc_3FC3:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_3FEB
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_3FEB:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4063, 0	; CA071.g
	MOVI	i578, 15
	MOVI	i577, 9
	MOVI	i576, 5
	MOVI	i581, 10
	MOVI	i580, 9
	MOVI	i579, 14
	MOVI	i584, 15
	MOVI	i583, 8
	MOVI	i582, 8
	MOVI	i599, 5
	MOVI	i598, 5
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_406C

file_4063:
	DB	1, "CA071.g", 0

loc_406C:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4094
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4094:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_40AA:
	MOVR	i0, i162
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_40C4
	JP	loc_42BF

loc_40C4:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4126, 0	; CA072.g
	MOVI	i578, 2
	MOVI	i577, 2
	MOVI	i576, 3
	MOVI	i581, 2
	MOVI	i580, 3
	MOVI	i579, 5
	MOVI	i584, 4
	MOVI	i583, 5
	MOVI	i582, 7
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_412F

file_4126:
	DB	1, "CA072.g", 0

loc_412F:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4157
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4157:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_41CF, 0	; CA073.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 2
	MOVI	i580, 5
	MOVI	i579, 4
	MOVI	i584, 2
	MOVI	i583, 7
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_41D8

file_41CF:
	DB	1, "CA073.g", 0

loc_41D8:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4200
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4200:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4278, 0	; CA074.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 2
	MOVI	i580, 4
	MOVI	i579, 4
	MOVI	i584, 2
	MOVI	i583, 7
	MOVI	i582, 5
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4281

file_4278:
	DB	1, "CA074.g", 0

loc_4281:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_42A9
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_42A9:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_42BF:
	MOVR	i0, i163
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_42D9
	JP	loc_4382

loc_42D9:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_433B, 0	; CA075.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 9
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4344

file_433B:
	DB	1, "CA075.g", 0

loc_4344:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_436C
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_436C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_4382:
	MOVR	i0, i163
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_439C
	JP	loc_44EE

loc_439C:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_43FE, 0	; CA076.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 9
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4407

file_43FE:
	DB	1, "CA076.g", 0

loc_4407:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_442F
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_442F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_44A7, 0	; CA077.g
	MOVI	i578, 4
	MOVI	i577, 4
	MOVI	i576, 4
	MOVI	i581, 9
	MOVI	i580, 9
	MOVI	i579, 9
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_44B0

file_44A7:
	DB	1, "CA077.g", 0

loc_44B0:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_44D8
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_44D8:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_44EE:
	MOVR	i0, i164
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_4508
	JP	loc_45B4

loc_4508:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4578, 0	; CA078A.g
	IMGLOAD	0, 0, 0, 1, file_4582, 1	; CA078B.g
	MOVI	i578, 8
	MOVI	i577, 8
	MOVI	i576, 9
	MOVI	i581, 10
	MOVI	i580, 10
	MOVI	i579, 11
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_458C

file_4578:
	DB	1, "CA078A.g", 0
file_4582:
	DB	1, "CA078B.g", 0

loc_458C:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_45B4
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_45B4:
	MOVR	i0, i164
	ANDI	i0, 2
	CMPI	i0, 2
	JEQ	loc_45CE
	JP	loc_47E2

loc_45CE:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_463E, 0	; CA078B.g
	IMGLOAD	0, 0, 0, 1, file_4648, 1	; CA078A.g
	MOVI	i578, 8
	MOVI	i577, 8
	MOVI	i576, 9
	MOVI	i581, 10
	MOVI	i580, 10
	MOVI	i579, 11
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4652

file_463E:
	DB	1, "CA078B.g", 0
file_4648:
	DB	1, "CA078A.g", 0

loc_4652:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_467A
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_467A:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_46F2, 0	; CA079.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 2
	MOVI	i580, 5
	MOVI	i579, 9
	MOVI	i584, 11
	MOVI	i583, 11
	MOVI	i582, 11
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_46FB

file_46F2:
	DB	1, "CA079.g", 0

loc_46FB:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4723
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4723:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_479B, 0	; CA080.g
	MOVI	i578, 4
	MOVI	i577, 4
	MOVI	i576, 4
	MOVI	i581, 8
	MOVI	i580, 8
	MOVI	i579, 9
	MOVI	i584, 12
	MOVI	i583, 12
	MOVI	i582, 12
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_47A4

file_479B:
	DB	1, "CA080.g", 0

loc_47A4:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_47CC
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_47CC:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_47E2:
	MOVR	i0, i165
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_47FC
	JP	loc_4A8C

loc_47FC:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_485E, 0	; CA081.g
	MOVI	i578, 9
	MOVI	i577, 9
	MOVI	i576, 12
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 12
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4867

file_485E:
	DB	1, "CA081.g", 0

loc_4867:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_488F
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_488F:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4907, 0	; CA082.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 9
	MOVI	i580, 9
	MOVI	i579, 12
	MOVI	i584, 15
	MOVI	i583, 9
	MOVI	i582, 10
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4910

file_4907:
	DB	1, "CA082.g", 0

loc_4910:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4938
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4938:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_49B0, 0	; CA083A.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 12
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_49BA

file_49B0:
	DB	1, "CA083A.g", 0

loc_49BA:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_49E2
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_49E2:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4A44, 0	; CA083B.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 12
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4A4E

file_4A44:
	DB	1, "CA083B.g", 0

loc_4A4E:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4A76
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4A76:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_4A8C:
	MOVR	i0, i166
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_4AA6
	JP	loc_4CA1

loc_4AA6:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4B08, 0	; CA084.g
	MOVI	i578, 4
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 15
	MOVI	i580, 7
	MOVI	i579, 8
	MOVI	i584, 7
	MOVI	i583, 2
	MOVI	i582, 11
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4B11

file_4B08:
	DB	1, "CA084.g", 0

loc_4B11:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4B39
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4B39:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4BB1, 0	; CA085.g
	MOVI	i578, 7
	MOVI	i577, 2
	MOVI	i576, 11
	MOVI	i581, 12
	MOVI	i580, 13
	MOVI	i579, 14
	MOVI	i584, 15
	MOVI	i583, 14
	MOVI	i582, 10
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4BBA

file_4BB1:
	DB	1, "CA085.g", 0

loc_4BBA:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4BE2
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4BE2:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4C5A, 0	; CA086.g
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 0
	MOVI	i580, 15
	MOVI	i579, 0
	MOVI	i584, 12
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4C63

file_4C5A:
	DB	1, "CA086.g", 0

loc_4C63:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4C8B
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4C8B:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_4CA1:
	MOVR	i0, i167
	ANDI	i0, 1
	CMPI	i0, 1
	JEQ	loc_4CBB
	JP	loc_4D63

loc_4CBB:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_4D1D, 0	; E016.g
	MOVI	i578, 3
	MOVI	i577, 3
	MOVI	i576, 3
	MOVI	i581, 6
	MOVI	i580, 2
	MOVI	i579, 6
	MOVI	i584, 3
	MOVI	i583, 5
	MOVI	i582, 8
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	CALL	loc_5174
	JP	loc_4D25

file_4D1D:
	DB	1, "E016.g", 0

loc_4D25:
	CMD1E	i0
	CMPI	i0, 1
	JNE	loc_4D4D
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	JP	loc_017F

loc_4D4D:
	CALL	loc_5058
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_4D63:
	JP	loc_017F

loc_4D67:
	TBOPEN	8, 14, 5, 18, 7, 4
	PRINT	8, str_4D83
	TBCLOSE	8
	JP	loc_01F3

str_4D83:
	;DB	"マニュアル補足です。", 1
	;DB	"画面の右側に表示されるミニＣＧは", 0x0D
	;DB	"現在の同行者を表しています。", 1, 0
	DB	"Manual Supplement.", 1
	DB	"The mini CGs displayed on the", 0x0D
	DB	"right-hand side of the screen", 0x0D
	DB	"represent the current party.", 1, 0

loc_4DD7:
	MOVI	i175, 9999
	LDSCENE	file_4DE1	; Omoide.s

file_4DE1:
	DB	1, "Omoide.s", 0

loc_4DEB:
	BGMFADE
	MOVI	i575, 255
	IMGLOAD	0, 0, 0, 1, file_5DBD, 0	; waku06b.g
	CALL	loc_4EF2
	LDSCENE	file_5DB5	; open.s

str_4E09:
	DB	0x03, 0x0F
;	DB	"        ご挨拶", 0x0D
;	DB	"    マニュアル補足", 0x0D
;	DB	"      回想モード", 0x0D
;	DB	"      ＣＧモード", 0x0D
;	DB	"       名前変更", 0x0D
;	DB	"    サウンドモード", 0x0D
;	DB	"      プロローグ", 0x0D
;	DB	"    メインメニュー", 0
	;	"______________________" line size marker for easier alignment estimation
	DB	"       Greeting"       , 0x0D
	DB	"   Manual Supplement"  , 0x0D
	DB	"   Recollection Mode"  , 0x0D
	DB	"        CG Mode"       , 0x0D
	DB	"      Change Name"     , 0x0D
	DB	"      Sound Mode"      , 0x0D
	DB	"       Prologue"       , 0x0D
	DB	"       Main Menu"      , 0
file_4E96:
	DB	1, "neko.g", 0

loc_4E9E:
	SFXSSG	17
	MOVI	i16, 0
	MOVI	i17, 0
	MOVI	i19, 2
	MOVI	i20, 0
loc_4EBA:
	CMD62	i17, i16
	WAIT	i19
	ADDI	i17, 1
	CMD62	i17, i16
	WAIT	i19
	SUBI	i17, 1
	ADDI	i20, 1
	CMPI	i20, 5
	JNE	loc_4EBA
	CMD62	i16, i16
	RET

loc_4EF2:
	MOVI	i17, 2
	MOVI	i18, 8
	MOVI	i19, 0
	MOVI	i22, 1
	MOVI	i1000, 0
	MOVI	i1001, 1
	MOVI	i1008, 8
loc_4F1C:
	WAIT	i1001
	CMD62	i1000, i18
	GFX68	i19, i1008
	ADDR	i18, i1008
	ADDR	i19, i1008
	CMPI	i18, 400
	JNE	loc_4F1C
	WAIT	i1001
	CMD62	i1000, i1000
	GFX68	i19, i1008
	MOVI	i999, 0
	MOVI	i578, 0
	MOVI	i577, 15
	MOVI	i576, 0
	MOVI	i581, 15
	MOVI	i580, 9
	MOVI	i579, 10
	MOVI	i584, 12
	MOVI	i583, 13
	MOVI	i582, 14
	MOVI	i599, 6
	MOVI	i598, 6
	MOVI	i597, 6
	RET

loc_4FA2:
	LDSCENE	file_4FA6	; prologue.s

file_4FA6:
	DB	1, "prologue.s", 0

loc_4FB2:	; unused
	CALL	loc_533E
	CALL	loc_535E
	CMPI	i560, 1
	JNE	loc_4FC6
	RET

loc_4FC6:
	CALL	loc_52E2
	TBOPEN	8, 5, 16, 7, 7, 1
	TBOPEN	9, 12, 16, 22, 7, 2
	CMD2F	0, 12, 264, 12, 96, 2, 68, 304
	MOVI	i560, 1
	RET

loc_5000:
	CALL	loc_533E
	CALL	loc_5372
	CMPI	i561, 1
	JNE	loc_5014
	RET

loc_5014:
	CALL	loc_52E2
	TBOPEN	9, 2, 19, 37, 6, 0
	MOVI	i561, 1
	RET

loc_502E:	; unused
	CALL	loc_52A0
	CALL	loc_515A
	CMPI	i563, 1
	JNE	loc_5042
	RET

loc_5042:
	TBOPEN	9, 7, 18, 33, 7, 2
	MOVI	i563, 1
	RET

loc_5058:
	CALL	loc_52A0
	CALL	loc_510A
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

loc_510A:
	CALL	loc_5118
	CALL	loc_5132
	CALL	loc_515A
	RET

loc_5118:
	CMPI	i565, 0
	JEQ	loc_5130
	TBCLOSE	8
	TBCLOSE	9
	MOVI	i565, 0
loc_5130:
	RET

loc_5132:
	CMPI	i563, 0
	JEQ	loc_5158
	TBCLOSE	9
	MOVI	i563, 0
	CMD2F	2, 36, 280, 16, 128, 0, 0, 280
loc_5158:
	RET

loc_515A:
	JTBL	i564
	DW	loc_5172	; 0
	DW	loc_5168	; 1
	DW	loc_5164	; 2

loc_5164:
	TBCLOSE	9
loc_5168:
	TBCLOSE	8
	MOVI	i564, 0
loc_5172:
	RET

loc_5174:
	CALL	loc_5663
	MOVI	i48, 1
	MOVI	i49, 0
	MOVI	i50, 0
	MOVI	i51, 80
	MOVI	i52, 2
	MOVI	i53, 0
	MOVI	i56, 398
	MOVI	i57, 0
	LOOPSTI	0
loc_51AC:
	LOOPJPR	i57, loc_51AC
	ADDI	i57, 1
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	loc_5230
	ADDI	i50, 4
	SUBI	i56, 4
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i56, i51, i52, i53, i49, i56
	CMPI	i56, 2
	JEQ	loc_5230
	ADDI	i50, 4
	SUBI	i56, 4
	JP	loc_51AC

loc_5230:
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

loc_52A0:
	CMPI	i190, 1
	JEQ	loc_52D6
	CALL	loc_538A
	IMGLOAD	0, 0, 0, 1, file_5334, 0	; winf.lsp
	GFX36
	MOVI	i190, 1
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
loc_52D6:
	RET

file_52D8:
	DB	1, "BlackF.g", 0

loc_52E2:
	CMPI	i190, 0
	JEQ	loc_5328
	CALL	loc_510A
	MOVI	i190, 0
	IMGLOAD	0, 0, 0, 1, file_532A, 0	; win3.lsp
	GFX36
	CALL	loc_510A
	CALL	loc_538A
	PALFADE	0, 1
	IMGLOAD	0, 0, 0, 0, file_5DBD, 0	; waku06b.g
	PALBW	0, 3
loc_5328:
	RET

file_532A:
	DB	1, "win3.lsp", 0
file_5334:
	DB	1, "winf.lsp", 0

loc_533E:
	JTBL	i562
	DW	loc_535C	; 0
	DW	loc_5352	; 1
	DW	loc_534E	; 2
	DW	loc_534A	; 3

loc_534A:
	TBCLOSE	10
loc_534E:
	TBCLOSE	9
loc_5352:
	TBCLOSE	8
	MOVI	i562, 0
loc_535C:
	RET

loc_535E:
	JTBL	i561
	DW	loc_5370	; 0
	DW	loc_5366	; 1

loc_5366:
	TBCLOSE	9
	MOVI	i561, 0
loc_5370:
	RET

loc_5372:
	JTBL	i560
	DW	loc_5388	; 0
	DW	loc_537A	; 1

loc_537A:
	TBCLOSE	9
	TBCLOSE	8
	MOVI	i560, 0
loc_5388:
	RET

loc_538A:
	CALL	loc_535E
	CALL	loc_533E
	CALL	loc_5372
	RET

loc_5398:	; unused
	CALL	loc_52E2
	CALL	loc_538A
	CMPI	i672, 0
	JEQ	loc_53AC
	RET

loc_53AC:
	CALL	loc_53FE
	RET

loc_53B2:	; unused
	CALL	loc_5663
	CALL	loc_54A3
	RET

loc_53BC:
	MOVI	i0, 0
	PCOLSET	i0, i578, i577, i576
	MOVI	i0, 2
	PCOLSET	i0, i581, i580, i579
	MOVI	i0, 3
	PCOLSET	i0, i584, i583, i582
	MOVI	i0, 7
	PCOLSET	i0, i599, i598, i597
	RET

loc_53FE:
	CALL	loc_538A
	IMGLOAD	2, 16, 0, 1, file_5428, 0	; Black.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	CALL	loc_54A3
	RET

file_5428:
	DB	1, "Black.lsp", 0
file_5433:
	DB	1, "BlackE.lsp", 0

loc_543F:	; unused
	CALL	loc_52E2
	CALL	loc_538A
	CMPI	i672, 0
	JEQ	loc_5473
	IMGLOAD	2, 16, 0, 1, file_5433, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

loc_5473:
	CALL	loc_53FE
	IMGLOAD	2, 16, 0, 1, file_5433, 0	; BlackE.lsp
	CMD2F	1, 2, 16, 60, 320, 2, 2, 16
	RET

loc_5499:	; unused
	CALL	loc_5663
	CALL	loc_54A3
	RET

loc_54A3:
	MOVI	i48, 2
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 1
	MOVI	i52, 320
	MOVI	i53, 0
	MOVI	i54, 61
	MOVI	i55, 1
	LOOPSTI	0
loc_54D7:
	LOOPJPR	i55, loc_54D7
	CMPI	i54, 1
	JEQ	loc_5521
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i54, i50, i51, i52, i53, i54, i50
	ADDI	i49, 2
	SUBI	i54, 2
	ADDI	i55, 1
	JP	loc_54D7

loc_5521:
	RET

loc_5523:	; unused
	CALL	loc_538A
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	RET

loc_553B:	; unused
	MOVI	i64, 0
	CALL	loc_555B
	CALL	loc_53BC
	RET

loc_554B:	; unused
	MOVI	i64, 1
	CALL	loc_555B
	CALL	loc_53BC
	RET

loc_555B:
	MOVI	i48, 1
	MOVI	i49, 2
	MOVI	i50, 16
	MOVI	i51, 60
	MOVI	i52, 1
	MOVI	i53, 0
	MOVI	i54, 319
	MOVI	i55, 1
	LOOPSTI	0
loc_558F:
	LOOPJPR	i55, loc_558F
	CMPI	i54, 15
	JEQ	loc_55D7
	CALL	loc_55D9
	CMPI	i54, 15
	JEQ	loc_55D7
	CALL	loc_55D9
	CMPI	i54, 15
	JEQ	loc_55D7
	CALL	loc_55D9
	CMPI	i54, 15
	JEQ	loc_55D7
	CALL	loc_55D9
	ADDI	i55, 1
	JP	loc_558F

loc_55D7:
	RET

loc_55D9:
	CMPI	i64, 1
	JEQ	loc_5615
	GFX3A	i48, i49, i50, i51, i52, i53, i49, i50
	GFX3A	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

loc_5615:
	GFX64	i48, i49, i50, i51, i52, i53, i49, i50
	GFX64	i48, i49, i54, i51, i52, i53, i49, i54
	ADDI	i50, 2
	SUBI	i54, 2
	RET

loc_5647:	; unused
	CALL	loc_538A
	CMD2F	2, 2, 16, 60, 320, 1, 2, 16
	CALL	loc_555B
	RET

loc_5663:
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

loc_5765:
	TBOPEN	8, 31, 12, 9, 6, 3
	PRINT	8, str_5FE4
	CMD6A	512, 208, 513, 271
	CMD3F	i544, i552
	MENUSEL	i48, i49, data_5DE0, loc_57A1
loc_5793:
	CMD42	1
	CMD43	i544, i552
	JP	loc_5793

loc_57A1:
	JTBL	i49
	DW	loc_57B5	; 0
	DW	loc_57AD	; 1
	DW	loc_57B5	; 2
	DW	loc_57AD	; 3

loc_57AD:
	TBCLOSE	8
	JP	loc_01F9

loc_57B5:
	SUBI	i48, 1
	JTBL	i48
	DW	loc_57C7	; 0
	DW	loc_5A15	; 1
	DW	loc_5D6F	; 2
	DW	loc_5DC8	; 3

loc_57C7:
	CMD3F	i545, i553
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, str_5F48
	MENUSEL	i48, i49, data_583B, loc_5803
loc_57F5:
	CMD43	i545, i553
	CMD42	1
	JP	loc_57F5

loc_5803:
	JTBL	i49
	DW	loc_581B	; 0
	DW	loc_580F	; 1
	DW	loc_581B	; 2
	DW	loc_580F	; 3

loc_580F:
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_5765

loc_581B:
	SUBI	i48, 1
	TBCLOSE	9
	TBCLOSE	8
	JTBL	i48
	DW	loc_5883	; 0
	DW	loc_58BB	; 1
	DW	loc_58F3	; 2
	DW	loc_592B	; 3
	DW	loc_5963	; 4
	DW	loc_599B	; 5
	DW	loc_59D3	; 6
data_583B:
	DW	1, 336, 176, 528, 192
	DW	2, 336, 192, 528, 208
	DW	3, 336, 208, 528, 224
	DW	4, 336, 224, 528, 240
	DW	5, 336, 240, 528, 256
	DW	6, 336, 256, 528, 272
	DW	7, 336, 272, 528, 288
	DW	0

loc_5883:
	REGFSAV	0, file_5F81	; cansav.da1
	STRCLR	s3
	STRCPYI	s3, str_5F57
	FILETM	i17, s2, file_5F81	; cansav.da1
	STRCAT	s3, s2
	STRCPYI	s3, str_5FD5
	CALL	loc_5000
	PRINT	9, str_6029
	PRINT	9, str_6017
	JP	loc_5A07

loc_58BB:
	REGFSAV	0, file_5F8D	; cansav.da2
	STRCLR	s4
	STRCPYI	s4, str_5F5D
	FILETM	i17, s2, file_5F8D	; cansav.da2
	STRCAT	s4, s2
	STRCPYI	s4, str_5FD5
	CALL	loc_5000
	PRINT	9, str_6036
	PRINT	9, str_6017
	JP	loc_5A07

loc_58F3:
	REGFSAV	0, file_5F99	; cansav.da3
	STRCLR	s5
	STRCPYI	s5, str_5F63
	FILETM	i17, s2, file_5F99	; cansav.da3
	STRCAT	s5, s2
	STRCPYI	s5, str_5FD5
	CALL	loc_5000
	PRINT	9, str_6043
	PRINT	9, str_6017
	JP	loc_5A07

loc_592B:
	REGFSAV	0, file_5FA5	; cansav.da4
	STRCLR	s6
	STRCPYI	s6, str_5F69
	FILETM	i17, s2, file_5FA5	; cansav.da4
	STRCAT	s6, s2
	STRCPYI	s6, str_5FD5
	CALL	loc_5000
	PRINT	9, str_6050
	PRINT	9, str_6017
	JP	loc_5A07

loc_5963:
	REGFSAV	0, file_5FB1	; cansav.da5
	STRCLR	s7
	STRCPYI	s7, str_5F6F
	FILETM	i17, s2, file_5FB1	; cansav.da5
	STRCAT	s7, s2
	STRCPYI	s7, str_5FD5
	CALL	loc_5000
	PRINT	9, str_605D
	PRINT	9, str_6017
	JP	loc_5A07

loc_599B:
	REGFSAV	0, file_5FBD	; cansav.da6
	STRCLR	s8
	STRCPYI	s8, str_5F75
	FILETM	i17, s2, file_5FBD	; cansav.da6
	STRCAT	s8, s2
	STRCPYI	s8, str_5FD5
	CALL	loc_5000
	PRINT	9, str_606A
	PRINT	9, str_6017
	JP	loc_5A07

loc_59D3:
	REGFSAV	0, file_5FC9	; cansav.da7
	STRCLR	s9
	STRCPYI	s9, str_5F7B
	FILETM	i17, s2, file_5FC9	; cansav.da7
	STRCAT	s9, s2
	STRCPYI	s9, str_5FD5
	CALL	loc_5000
	PRINT	9, str_6077
	PRINT	9, str_6017
loc_5A07:
	TBCLOSE	9
	MOVI	i561, 0
	JP	loc_5765

loc_5A15:
	CMD3F	i274, i554
	CMD6A	496, 176, 497, 287
	TBOPEN	9, 20, 10, 14, 9, 4
	PRINT	9, str_5F48
	MENUSEL	i16, i17, data_583B, loc_5A57
	MOVI	i34, 50
loc_5A49:
	CMD42	1
	CMD43	i274, i554
	JP	loc_5A49

loc_5A57:
	JTBL	i17
	DW	loc_5A6F	; 0
	DW	loc_5A63	; 1
	DW	loc_5A6F	; 2
	DW	loc_5A63	; 3

loc_5A63:
	TBCLOSE	9
	TBCLOSE	8
	JP	loc_5765

loc_5A6F:
	SUBI	i16, 1
	MOVR	i34, i32
	JTBL	i16
	DW	loc_5A8D	; 0
	DW	loc_5ABF	; 1
	DW	loc_5AF1	; 2
	DW	loc_5B23	; 3
	DW	loc_5B55	; 4
	DW	loc_5B87	; 5
	DW	loc_5BB9	; 6

loc_5A8D:
	FILETM	i17, s2, file_5F81	; cansav.da1
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5F81	; cansav.da1
	CALL	loc_610A
	JP	loc_5BE7

loc_5ABF:
	FILETM	i17, s2, file_5F8D	; cansav.da2
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5F8D	; cansav.da2
	CALL	loc_610A
	JP	loc_5BE7

loc_5AF1:
	FILETM	i17, s2, file_5F99	; cansav.da3
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5F99	; cansav.da3
	CALL	loc_610A
	JP	loc_5BE7

loc_5B23:
	FILETM	i17, s2, file_5FA5	; cansav.da4
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5FA5	; cansav.da4
	CALL	loc_610A
	JP	loc_5BE7

loc_5B55:
	FILETM	i17, s2, file_5FB1	; cansav.da5
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5FB1	; cansav.da5
	CALL	loc_610A
	JP	loc_5BE7

loc_5B87:
	FILETM	i17, s2, file_5FBD	; cansav.da6
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5FBD	; cansav.da6
	CALL	loc_610A
	JP	loc_5BE7

loc_5BB9:
	FILETM	i17, s2, file_5FC9	; cansav.da7
	CMPI	i17, 0
	JEQ	loc_5A49
	TBCLOSE	9
	TBCLOSE	8
	REGFLD	0, file_5FD8	; cansav.sys
	CALL	loc_6084
	REGFLD	0, file_5FC9	; cansav.da7
	CALL	loc_610A
loc_5BE7:
	BGMFADE
	MOVI	i575, 255
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_5C57	; 0
	DW	loc_5C13	; 1
	DW	loc_5C29	; 2
	DW	loc_5C3F	; 3

loc_5C13:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_5C51

loc_5C29:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_5C51

loc_5C3F:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_5C51:
	SUBI	i679, 1
loc_5C57:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_5CBF	; 0
	DW	loc_5C7B	; 1
	DW	loc_5C91	; 2
	DW	loc_5CA7	; 3

loc_5C7B:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_5CB9

loc_5C91:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_5CB9

loc_5CA7:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_5CB9:
	SUBI	i679, 1
loc_5CBF:
	MOVI	i16, 2
	MOVI	i17, 12
	MOVI	i18, 96
	MOVI	i19, 0
	JTBL	i679
	DW	loc_5D27	; 0
	DW	loc_5CE3	; 1
	DW	loc_5CF9	; 2
	DW	loc_5D0F	; 3

loc_5CE3:
	GFX3A	i16, i673, i674, i17, i18, i19, i673, i674
	JP	loc_5D21

loc_5CF9:
	GFX3A	i16, i675, i676, i17, i18, i19, i675, i676
	JP	loc_5D21

loc_5D0F:
	GFX3A	i16, i677, i678, i17, i18, i19, i677, i678
loc_5D21:
	SUBI	i679, 1
loc_5D27:
	CMPI	i190, 1
	JNE	loc_5D43
	CALL	loc_53FE
	MOVI	i190, 0
	CALL	loc_52A0
	JP	loc_5D63

loc_5D43:
	IMGLOAD	65, 128, 0, 0, file_5D59, 0	; PTY000.g
	CALL	loc_53BC
	JP	loc_5D63

file_5D59:
	DB	1, "PTY000.g", 0

loc_5D63:
	BGMFADE
	MOVI	i575, 255
	LDSCENE	file_0104	; ss.s

loc_5D6F:
	TBCLOSE	8
	CALL	loc_53FE
	REGCLR	i48, i95
	REGCLR	i112, i136
	REGCLR	i272, i287
	BGMFADE
	MOVI	i575, 255
	IMGLOAD	65, 128, 0, 0, file_5DA7, 0	; PTY000.g
	CALL	loc_53BC
	JP	loc_5DB1

file_5DA7:
	DB	1, "PTY000.g", 0

loc_5DB1:
	LDSCENE	file_5DB5	; open.s

file_5DB5:
	DB	1, "open.s", 0
file_5DBD:
	DB	1, "waku06b.g", 0

loc_5DC8:
	TBCLOSE	8
	IMGLOAD	0, 0, 0, 1, file_52D8, 0	; BlackF.g
	CALL	loc_5174
	DOSEXIT

data_5DE0:
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
str_5F48:
	DB	0x04, 0x03, 0x04, 0x04, 0x04, 0x05, 0x04, 0x06, 0x04, 0x07, 0x04, 0x08, 0x04, 0x09, 0
str_5F57:
	DB	"１： ", 0
str_5F5D:
	DB	"２： ", 0
str_5F63:
	DB	"３： ", 0
str_5F69:
	DB	"４： ", 0
str_5F6F:
	DB	"５： ", 0
str_5F75:
	DB	"６： ", 0
str_5F7B:
	DB	"７： ", 0
file_5F81:
	DB	1, "cansav.da1", 0
file_5F8D:
	DB	1, "cansav.da2", 0
file_5F99:
	DB	1, "cansav.da3", 0
file_5FA5:
	DB	1, "cansav.da4", 0
file_5FB1:
	DB	1, "cansav.da5", 0
file_5FBD:
	DB	1, "cansav.da6", 0
file_5FC9:
	DB	1, "cansav.da7", 0
str_5FD5:
	DB	" ", 0x0D, 0
file_5FD8:
	DB	1, "cansav.sys", 0
str_5FE4:
	DB	"    セーブ", 0x0D
	DB	"    ロード", 0x0D
	DB	"トップメニュー", 0x0D
	DB	" ＤＯＳに戻る", 0
str_6017:
	DB	"セーブしました。", 1, 0
str_6029:
	DB	"ファイル１に", 0
str_6036:
	DB	"ファイル２に", 0
str_6043:
	DB	"ファイル３に", 0
str_6050:
	DB	"ファイル４に", 0
str_605D:
	DB	"ファイル５に", 0
str_606A:
	DB	"ファイル６に", 0
str_6077:
	DB	"ファイル７に", 0

loc_6084:
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

loc_610A:
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

