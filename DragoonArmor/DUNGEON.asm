; Input	MD5   :	63D7588D35D2AF3BE15064C3ABE5B4EA
; Input	CRC32 :	E82D2576

; File Name   :	R:\DUNGEON.EXE
; Format      :	MS-DOS executable (EXE)
; Base Address:	1000h Range: 10000h-236F0h Loaded length: 136F0h
; Entry	Point :	1D36:1D2A

		.686p
		.mmx
		.model large

; ===========================================================================

; Segment type:	Regular
seg000		segment	byte public 'UNK' use16
		assume cs:seg000
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 5Ch dup(0)
byte_1005C	db 10h dup(0)		; DATA XREF: sub_1DE2B+94o
					; sub_1DE2B+C7o ...
byte_1006C	db 194h	dup(0),	4 dup(7), 9 ; DATA XREF: sub_1DE2B+9Eo
					; sub_1DE2B+D1o ...
off_10205	dw offset off_1020F	; 0 ; DATA XREF: sub_1E160+9o
		dw offset off_102CC	; 1
		dw offset off_1038B	; 2
		dw offset off_1044D	; 3
		dw offset off_1050D	; 4
off_1020F	dw offset aDungeonPicBat_; 0 ; DATA XREF: seg000:off_10205o
		dw offset aDungeonPicSlim; 1 ; "\x15 \\DUNGEON\\PIC\\BAT.ADA"
		dw offset aDungeonPicSkel; 2
		dw offset aDungeonPicKobo; 3
		dw offset aDungeonPicOrc_; 4
		dw offset aDungeonPicZomb; 5
		dw offset aDungeonPicGa_0; 6
aDungeonPicBat_	db 15h,' \DUNGEON\PIC\BAT.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicSlim	db 17h,' \DUNGEON\PIC\SLIME.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicSkel	db 18h,' \DUNGEON\PIC\SKELET.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicKobo	db 18h,' \DUNGEON\PIC\KOBOLD.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicOrc_	db 15h,' \DUNGEON\PIC\ORC.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicZomb	db 18h,' \DUNGEON\PIC\ZOMBIE.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
aDungeonPicGa_0	db 18h,' \DUNGEON\PIC\GARDIA.ADA' ; DATA XREF: seg000:off_1020Fo
		db  0Dh
off_102CC	dw offset aDungeonPicOgre; 0 ; DATA XREF: seg000:off_10205o
		dw offset aDungeonPicGhou; 1 ; "\x16 \\DUNGEON\\PIC\\OGRE.ADA"
		dw offset aDungeonPicScor; 2
		dw offset aDungeonPicGobl; 3
		dw offset aDungeonPicWill; 4
		dw offset aDungeonPicBand; 5
		dw offset aDungeonPicHorn; 6
aDungeonPicOgre	db 16h,' \DUNGEON\PIC\OGRE.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicGhou	db 17h,' \DUNGEON\PIC\GHOUL.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicScor	db 18h,' \DUNGEON\PIC\SCORPI.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicGobl	db 18h,' \DUNGEON\PIC\GOBLIN.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicWill	db 16h,' \DUNGEON\PIC\WILL.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicBand	db 18h,' \DUNGEON\PIC\BANDIT.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
aDungeonPicHorn	db 18h,' \DUNGEON\PIC\HORNET.ADA' ; DATA XREF: seg000:off_102CCo
		db  0Dh
off_1038B	dw offset aDungeonPicGarg; 0 ; DATA XREF: seg000:off_10205o
		dw offset aDungeonPicLivi; 1 ; "\x18 \\DUNGEON\\PIC\\GARGOY.ADA"
		dw offset aDungeonPicGian; 2
		dw offset aDungeonPicTref; 3
		dw offset aDungeonPicHobg; 4
		dw offset aDungeonPicHalp; 5
		dw offset aDungeonPicGorg; 6
aDungeonPicGarg	db 18h,' \DUNGEON\PIC\GARGOY.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicLivi	db 18h,' \DUNGEON\PIC\LIVING.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicGian	db 17h,' \DUNGEON\PIC\GIANT.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicTref	db 18h,' \DUNGEON\PIC\TREFID.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicHobg	db 18h,' \DUNGEON\PIC\HOBGOB.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicHalp	db 17h,' \DUNGEON\PIC\HALPY.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
aDungeonPicGorg	db 18h,' \DUNGEON\PIC\GORGON.ADA' ; DATA XREF: seg000:off_1038Bo
		db  0Dh
off_1044D	dw offset aDungeonPicChim; 0 ; DATA XREF: seg000:off_10205o
		dw offset aDungeonPicGole; 1 ; "\x18 \\DUNGEON\\PIC\\CHIMER.ADA"
		dw offset aDungeonPicCycl; 2
		dw offset aDungeonPicTrol; 3
		dw offset aDungeonPicMino; 4
		dw offset aDungeonPicWyve; 5
		dw offset aDungeonPicDark; 6
aDungeonPicChim	db 18h,' \DUNGEON\PIC\CHIMER.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicGole	db 17h,' \DUNGEON\PIC\GOLEM.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicCycl	db 18h,' \DUNGEON\PIC\CYCLOP.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicTrol	db 17h,' \DUNGEON\PIC\TROLL.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicMino	db 18h,' \DUNGEON\PIC\MINOTA.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicWyve	db 18h,' \DUNGEON\PIC\WYVERN.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
aDungeonPicDark	db 16h,' \DUNGEON\PIC\DARK.ADA' ; DATA XREF: seg000:off_1044Do
		db  0Dh
off_1050D	dw offset aDungeonPicGrif; 0 ; DATA XREF: seg000:off_10205o
		dw offset aDungeonPicDemo; 1 ; "\x18 \\DUNGEON\\PIC\\GRIFFO.ADA"
		dw offset aDungeonPicVamp; 2
		dw offset aDungeonPicHydr; 3
		dw offset aDungeonPicMedu; 4
		dw offset aDungeonPicJ_ad; 5
		dw offset aDungeonPicP_ad; 6
		dw offset aDungeonPic_ada; 7
		dw offset aDungeonPicGard; 8
		dw offset aDungeonPicDrag; 9
aDungeonPicGrif	db 18h,' \DUNGEON\PIC\GRIFFO.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicDemo	db 17h,' \DUNGEON\PIC\DEMON.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicVamp	db 18h,' \DUNGEON\PIC\VAMPIR.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicHydr	db 17h,' \DUNGEON\PIC\HYDRA.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicMedu	db 18h,' \DUNGEON\PIC\MEDUSA.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicJ_ad	db 16h,' \DUNGEON\PIC\¿ﬁ¶Ω.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicP_ad	db 16h,' \DUNGEON\PIC\ÿØÃﬂ.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPic_ada	db 18h,' \DUNGEON\PIC\Õ›¿≤∏›.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicGard	db 17h,' \DUNGEON\PIC\GARD2.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
aDungeonPicDrag	db 18h,' \DUNGEON\PIC\DRAGON.ADA' ; DATA XREF: seg000:off_1050Do
		db  0Dh
		dw offset weaponList	; 0
		dw offset armorList	; 1
		dw offset shieldList	; 2
		dw offset itemList	; 3
weaponList	dw offset aWpn_Bare	; 0 ; DATA XREF: seg000:061Eo
					; GetWeaponProps+8o ...
		dw offset aDagger	; 1 ; "ëféË"
		dw offset aHammer	; 2
		dw offset aShortSword	; 3
		dw offset aLongSword	; 4
		dw offset aBroadSword	; 5
		dw offset aFalchion	; 6
		dw offset aBastard	; 7
		dw offset aGreatSword	; 8
		dw offset aSilvrBastard	; 9
		dw offset aDragonSlayer	; 10
aWpn_Bare	db 'ëféË',0             ; DATA XREF: seg000:weaponListo
		dw 0			; price
		db 0, 1, 4, 0		; STR, ?, ?, ?
aDagger		db 'É_ÉKÅ|',0           ; DATA XREF: seg000:weaponListo
		dw 10
		db 5, 1, 6, 0
aHammer		db 'ÉnÉìÉ}Å|',0         ; DATA XREF: seg000:weaponListo
		dw 20
		db 15, 1, 8, 2
aShortSword	db 'ÉVÉáÅ|ÉgÉ\Å|Éh',0   ; DATA XREF: seg000:weaponListo
		dw 50
		db 20, 2, 6, 0
aLongSword	db 'ÉçÉìÉOÉ\Å|Éh',0     ; DATA XREF: seg000:weaponListo
		dw 100
		db 35, 3, 6, 6
aBroadSword	db 'ÉuÉçÅ|ÉhÉ\Å|Éh',0   ; DATA XREF: seg000:weaponListo
		dw 500
		db 40, 3, 8, 8
aFalchion	db 'ÉtÉ@ÉãÉVÉIÉì',0     ; DATA XREF: seg000:weaponListo
		dw 600
		db 28h,	4, 6, 8
aBastard	db 'ÉoÉXÉ^Å|Éh',0       ; DATA XREF: seg000:weaponListo
		dw 1500
		db 60, 6, 6, 10
aGreatSword	db 'ÉOÉåÅ|ÉgÉ\Å|Éh',0   ; DATA XREF: seg000:weaponListo
		dw 10000
		db 100,	10, 6, 10
aSilvrBastard	db 'ã‚ÇÃÉoÉXÉ^Å|Éh',0   ; DATA XREF: seg000:weaponListo
					; ShowItemObtain:loc_1D647o
		dw 30000
		db 60, 10, 10, 20
aDragonSlayer	db 'ÇcÅDÉXÉåÉCÉÑÅ|',0   ; DATA XREF: seg000:weaponListo
		dw 60000
		db 40, 10, 20, 30
armorList	dw offset aArmor_None	; 0 ; DATA XREF: seg000:061Eo
					; CalcStrAndDex+4o
		dw offset aRobe		; 1 ; "Ç»Çµ"
		dw offset aLeatherArmor	; 2
		dw offset aRingMail	; 3
		dw offset aScaleMail	; 4
		dw offset aHalfPlate	; 5
		dw offset aChainMail	; 6
		dw offset aPlateMail	; 7
		dw offset aMithrilMail	; 8
		dw offset aSilverPlate	; 9
		dw offset aDragonArmor	; 10
aArmor_None	db 'Ç»Çµ',0             ; DATA XREF: seg000:armorListo
		dw 0			; price
		db 0, 0, 0		; STR, DEX, DEF
aRobe		db 'ÉçÅ|Éu',0           ; DATA XREF: seg000:armorListo
		dw 10
		db 2, 2, 2
aLeatherArmor	db 'ÉåÉUÅ|ÉAÅ|É}Å|',0   ; DATA XREF: seg000:armorListo
		dw 30
		db 4, 1, 5
aRingMail	db 'ÉäÉìÉOÉÅÉCÉã',0     ; DATA XREF: seg000:armorListo
		dw 50
		db 12, 3, 10
aScaleMail	db 'ÉXÉPÅ|ÉãÉÅÉCÉã',0   ; DATA XREF: seg000:armorListo
		dw 100
		db 20, 5, 15
aHalfPlate	db 'ÉnÅ[ÉtÉvÉåÅ[Ég',0   ; DATA XREF: seg000:armorListo
		dw 500
		db 60, 7, 20
aChainMail	db 'É`ÉFÉCÉìÉÅÉCÉã',0   ; DATA XREF: seg000:armorListo
		dw 800
		db 70, 10, 30
aPlateMail	db 'ÉvÉåÅ|ÉgÉÅÉCÉã',0   ; DATA XREF: seg000:armorListo
		dw 1500
		db 120,	20, 40
aMithrilMail	db 'É~ÉXÉäÉãÉÅÉCÉã',0   ; DATA XREF: seg000:armorListo
		dw 5000
		db 100,	20, 60
aSilverPlate	db 'ã‚ÇÃÉvÉåÅ|Ég',0     ; DATA XREF: seg000:armorListo
					; ShowItemObtain:loc_1D676o
		dw 10000
		db 100,	15, 100
aDragonArmor	db 'ÇcÅDÉAÅ|É}Å|',0     ; DATA XREF: seg000:armorListo
		dw 50000
		db 60, 0, 150
shieldList	dw offset aShield_None	; 0 ; DATA XREF: seg000:061Eo
					; CalcStrAndDex+1Ao
		dw offset aCutterShld	; 1 ; "Ç»Çµ"
		dw offset aWoodenShld	; 2
		dw offset aSmallShld	; 3
		dw offset aRoundShld	; 4
		dw offset aLargeShld	; 5
		dw offset aWallShld	; 6
		dw offset aSilverShld	; 7
		dw offset aDScaleShld	; 8
aShield_None	db 'Ç»Çµ',0             ; DATA XREF: seg000:shieldListo
		dw 0			; price
		db 0, 0, 0		; STR, DEX, DEF
aCutterShld	db 'ÉJÉbÉ^Å|ÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
		dw 10
		db 2, 0, 2
aWoodenShld	db 'ÉEÉbÉhÇrÇàÅD',0     ; DATA XREF: seg000:shieldListo
		dw 50
		db 5, 1, 5
aSmallShld	db 'ÉXÉÇÅ|ÉãÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
		dw 100
		db 10, 3, 10
aRoundShld	db 'ÉâÉEÉìÉhÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
		dw 200
		db 20, 6, 15
aLargeShld	db 'ÉâÅ|ÉWÇrÇàÅD',0     ; DATA XREF: seg000:shieldListo
		dw 500
		db 30, 10, 20
aWallShld	db 'ÉEÉHÅ|ÉãÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
		dw 1000
		db 50, 30, 30
aSilverShld	db 'ÉVÉãÉoÅ|ÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
					; ShowItemObtain:loc_1D6A5o
		dw 5000
		db 20, 5, 50
aDScaleShld	db 'ÇcÅDÇrÅDÇrÇàÅD',0   ; DATA XREF: seg000:shieldListo
					; Dragon Scale Shield
		dw 30000
		db 10, 0, 50
itemList	dw offset aNone_1	; 0 ; DATA XREF: seg000:061Eo
		dw offset aCrystal	; 1 ; "Ç»Çµ"
		dw offset aHilt		; 2
		dw offset aRibbon	; 3
		dw offset aStillSword	; 4
		dw offset aHBookVol_1	; 5
		dw offset aHBookVol_2	; 6
		dw offset aHBookVol_3	; 7
		dw offset aRingOfStr	; 8
		dw offset aRingOfDef	; 9
		dw offset aKey		; 10
aNone_1		db 'Ç»Çµ',0             ; DATA XREF: seg000:itemListo
		dw 0
		db 0
aCrystal	db 'ÉNÉäÉXÉ^Éã',0       ; DATA XREF: seg000:itemListo
		dw 0
		db 0
aHilt		db 'åïÇÃïø',0           ; DATA XREF: seg000:itemListo
		dw 0
		db 0
aRibbon		db 'ÉäÉ{Éì',0           ; DATA XREF: seg000:itemListo
		dw 0
		db 0
aStillSword	db 'ÉXÉeÉBÉãÉ\Å[Éh',0   ; DATA XREF: seg000:itemListo
		dw 0
		db 10
aHBookVol_1	db 'Ç¶Ç¡ÇøÇ»ñ{ÇPä™',0   ; DATA XREF: seg000:itemListo
		dw 10000
		db 1
aHBookVol_2	db 'Ç¶Ç¡ÇøÇ»ñ{ÇQä™',0   ; DATA XREF: seg000:itemListo
		dw 15000
		db 1
aHBookVol_3	db 'Ç¶Ç¡ÇøÇ»ñ{ÇRä™',0   ; DATA XREF: seg000:itemListo
		dw 20000
		db 1
aRingOfStr	db '"Ring of STR"}',0   ; DATA XREF: seg000:itemListo
		dw 3000
		db 0
aRingOfDef	db '"Ring of DEF"}',0   ; DATA XREF: seg000:itemListo
		dw 5000
		db 0
aKey		db 'åÆ',0               ; DATA XREF: seg000:itemListo
		dw 0
		db 0
		dw offset aDmgTxt_Crit1	; 0 ; "\aÇbÇíÇâÇîÇâÇÉÇÅÇåÅ@ÇgÇâÇîÅ@ÅI\n"
		dw offset aDmgTxt_Crit2	; 1
		dw offset aDmgTxt_Defeat; 2
		dw offset aDmgTxt_TakeDmg; 3
		dw offset aDmgTxt_DealDmg; 4
aDmgTxt_Crit1	db 7,'ÇbÇíÇâÇîÇâÇÉÇÅÇåÅ@ÇgÇâÇîÅ@ÅI',0Ah ; DATA XREF: seg000:0947o
					; Critical hit!
aDmgTxt_Crit2	db 7,'Ç©Ç¢ÇµÇÒÇÃàÍåÇÅI',0Ah ; DATA XREF: seg000:0947o
					; A critical hit!
aDmgTxt_Defeat	db 7,'Ç±ÇØÇΩÅ@ÅI',0Ah   ; DATA XREF: seg000:0947o
					; Defeated!
aDmgTxt_TakeDmg	db 7,'ÇÃÉ_ÉÅÅ[ÉWÇÇ§ÇØÇΩ',0Ah ; DATA XREF: seg000:0947o
					; Damage suffered.
aDmgTxt_DealDmg	db 7,'ÇÃÉ_ÉÅÅ[ÉWÇÇ†ÇΩÇ¶ÇΩ',0Ah ; DATA XREF: seg000:0947o
					; Damage dealt.
itemNameBuffer	db 50h dup(0)		; DATA XREF: ShowItemObtain+2F6o
					; ShowItemObtain+325o ...
aItemObtained1	db 4,1Ah,0Ah		; DATA XREF: ShowItemObtain+2EFo
					; ShowItemObtain+31Eo ...
aItemObtained2	db 7,'Å@ÇèEÇ¡ÇΩ',0Dh,13h,0Ah ; DATA XREF: ShowItemObtain+2FDo
					; ShowItemObtain+32Co ...
plrCanNotRun	db 0			; DATA XREF: DoBossBattlew
					; DoBossBattle+8w ...
byte_10A19	db 0			; DATA XREF: sub_1E442+795w
					; sub_1EC06+16r ...
byte_10A1A	db 0			; DATA XREF: sub_1EAF8+Bw
					; sub_1EAF8+4Bw ...
aDungeonPicEnd_	db 15h,' \DUNGEON\PIC\END.ADA' ; DATA XREF: sub_1DE2B+123o
		db  0Dh
byte_10A32	db 0			; DATA XREF: sub_1E442+4E0w
					; sub_1EFDC+23r ...
byte_10A33	db 0			; DATA XREF: ShowItemObtain+51Cw
					; ShowItemObtain+56Ew ...
floorMDatData	db 258h	dup(0)		; DATA XREF: sub_1E1AB+Ao
					; ReadFileMDAT+38o
word_10C8C	dw 0			; DATA XREF: sub_1E1AB+Dw
					; CopyMonsterNamer ...
MnstNameText	db 7,13h		; DATA XREF: ShowMnstAppearTxt+2o
					; sub_1E442+584o ...
CurMonsterName	db 16h dup(0)		; DATA XREF: CopyMonsterName+4o
					; sub_1E442+143o ...
MnstAppearText	db 'Å@Ç™Å@',0,0,'Å@ïCÅ@Ç¢Ç‹Ç∑ÅD',12h,0Ah ; DATA XREF: ShowMnstAppearTxt+16o
					; ShowMnstAppearTxt+11w
					; " x #appears"
btlMonsterPtrs	dw offset word_10CD0	; 0 ; DATA XREF: sub_1E1AB+46o
					; sub_1E442+B9o ...
		dw offset word_10CD0+2	; 1
		dw offset word_10CD0+4	; 2
		dw offset word_10CD0+6	; 3
		dw offset word_10CD0+8	; 4
		dw offset word_10CD0+0Ah; 5
		dw offset word_10CD0+0Ch; 6
		dw offset word_10CD0+0Eh; 7
		dw offset word_10CD0+10h; 8
word_10CD0	dw 0Bh dup(0)		; DATA XREF: seg000:btlMonsterPtrso
					; sub_1E1AB+7Eo ...
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
byte_10CF6	db 0Bh dup(0)		; DATA XREF: DetermineTurnOrder+Eo
					; DetermineTurnOrder+1Bo ...
byte_10D01	db 0Bh dup(0)		; DATA XREF: DetermineTurnOrder+16o
					; DetermineTurnOrder+50o ...
byte_10D0C	db 0Bh dup(0)		; DATA XREF: DetermineTurnOrder+3o
					; DetermineTurnOrder+37o ...
		dw offset aDungeonMes1f_m; 0 ; "\\DUNGEON\\MES\\1F.MES"
		dw offset aDungeonMes2f_m; 1
		dw offset aDungeonMes3f_m; 2
		dw offset aDungeonMes4f_m; 3
		dw offset aDungeonMes5f_m; 4
aDungeonMes1f_m	db '\DUNGEON\MES\1F.MES',0 ; DATA XREF: seg000:0D17o
					; ShowItemObtain:loc_1D840o ...
aDungeonMes2f_m	db '\DUNGEON\MES\2F.MES',0 ; DATA XREF: seg000:0D17o
					; ShowItemObtain:loc_1D905o ...
aDungeonMes3f_m	db '\DUNGEON\MES\3F.MES',0 ; DATA XREF: seg000:0D17o
					; ShowItemObtain:loc_1D99Eo ...
aDungeonMes4f_m	db '\DUNGEON\MES\4F.MES',0 ; DATA XREF: seg000:0D17o
					; seg001:loc_1DA11o ...
aDungeonMes5f_m	db '\DUNGEON\MES\5F.MES',0 ; DATA XREF: seg000:0D17o
					; ShowItemObtain:loc_1DB15o ...
aDungeonMesCamp	db '\DUNGEON\MES\CAMP.MES',0 ; DATA XREF: sub_1DDA7+3o
aDungeonMesShop	db '\DUNGEON\MES\SHOP.MES',0 ; DATA XREF: DoShop+3o
aDungeonMesStar	db '\DUNGEON\MES\START.MES',0 ; DATA XREF: RunStartMES+3o
aDungeonMesOver	db '\DUNGEON\MES\OVER.MES',0 ; DATA XREF: sub_1DE2B+1CBo
aDungeonMesOn_3	db '\DUNGEON\MES\ONSEN1.MES',0 ; DATA XREF: ShowItemObtain:loc_1D3D8o
aDungeonMesOn_2	db '\DUNGEON\MES\ONSEN2.MES',0 ; DATA XREF: ShowItemObtain:loc_1D3E1o
aDungeonMesOn_1	db '\DUNGEON\MES\ONSEN3.MES',0 ; DATA XREF: ShowItemObtain:loc_1D3EAo
aDungeonMesOn_0	db '\DUNGEON\MES\ONSEN4.MES',0 ; DATA XREF: ShowItemObtain:loc_1D3F3o
aDungeonMesOnse	db '\DUNGEON\MES\ONSEN5.MES',0 ; DATA XREF: ShowItemObtain:loc_1D3FCo
aDungeonLoadada	db '\DUNGEON\LOADADA4.EXE',0 ; DATA XREF: sub_1DE2B+11Do
					; sub_1DE2B+185o ...
aDungeonLodada2	db '\DUNGEON\LODADA24.EXE',0
aDungeonPicBaSh	db 24,' \DUNGEON\PIC\BA-SHO.ADA'
		db  0Dh
aDungeonPicCamp	db 22,' \DUNGEON\PIC\CAMP.ADA'
		db  0Dh
aDungeonPicWaku	db 22,' \DUNGEON\PIC\WAKU.ADA' ; DATA XREF: sub_1DE2B+18Bo
					; start+AEo
		db  0Dh
aPlay_exe_0	db 'PLAY.EXE',0         ; DATA XREF: sub_1DE2B+84o
					; sub_1DE2B+B7o ...
aStart		db 6,' START'           ; DATA XREF: sub_1DE2B+F0o
					; DoBattle+86o	...
		db  0Dh
aStop		db 5,' STOP'            ; DATA XREF: sub_1DE2B+8Ao
					; DoBattle+20o	...
		db  0Dh
aDungeonMusicMe	db 23,' \DUNGEON\MUSIC\MEI-Q.M' ; DATA XREF: DoBattle+FAo
					; start+110o
		db  0Dh
aDungeonMusicPe	db 23,' \DUNGEON\MUSIC\PEACE.M'
		db  0Dh
aDungeonMusicMo	db 23,' \DUNGEON\MUSIC\MONST.M' ; DATA XREF: DoBattle+53o
		db  0Dh
aDungeonMusicBo	db 22,' \DUNGEON\MUSIC\BOSS.M'
		db  0Dh
aDungeonMusicSh	db 22,' \DUNGEON\MUSIC\SHOP.M' ; DATA XREF: sub_1DE2B+BDo
		db  0Dh
word_10F5F	dw 0			; DATA XREF: sub_1DE2B+87o
					; sub_1DE2B+BAo ...
word_10F61	dw 0			; DATA XREF: sub_1DE2B+8Aw
					; sub_1DE2B+BDw ...
word_10F63	dw 0			; DATA XREF: sub_1DE2B+90w
					; sub_1DE2B+C3w ...
word_10F65	dw 0			; DATA XREF: sub_1DE2B+94w
					; sub_1DE2B+C7w ...
word_10F67	dw 0			; DATA XREF: sub_1DE2B+9Aw
					; sub_1DE2B+CDw ...
word_10F69	dw 0			; DATA XREF: sub_1DE2B+9Ew
					; sub_1DE2B+D1w ...
word_10F6B	dw 0			; DATA XREF: sub_1DE2B+A4w
					; sub_1DE2B+D7w ...
aDungeonPicMove	db '\DUNGEON\PIC\MOVE.MDA',0 ; DATA XREF: sub_1F217+8o
		db 0Dh,0Ah,'$'
aDungeonPicBa_0	db '\DUNGEON\PIC\BA-A.MDA',0
		db 0Dh,0Ah,'$'
byte_10F9F	db  22h,0B1h		; DATA XREF: sub_1F217+11o
		db  2Eh, 2Eh
		db  2Eh, 2Eh
		db  2Eh,0B2h
		db  2Eh, 2Eh
		db 0B3h, 2Eh
		db  2Eh, 2Eh
		db 0B4h, 2Eh
		db  2Eh, 2Eh
		db  2Eh, 2Eh
		db 0B1h, 2Eh
		db  2Eh, 2Eh
		db  2Eh, 2Eh
		db  4Ch, 22h
		db    0
		db  22h,0B5h
		db  2Eh, 2Eh
		db 0B6h, 2Eh
		db  2Eh,0B5h
		db  2Eh, 2Eh
		db 0B6h, 2Eh
		db  2Eh,0B5h
		db  2Eh, 2Eh
		db 0B6h, 2Eh
		db  2Eh, 22h
		db    0
		db  22h,0B1h
		db  2Eh,0B2h
		db  2Eh,0B3h
		db  2Eh,0B4h
		db  2Eh,0B5h
		db  2Eh,0B6h
		db  2Eh,0B7h
		db  2Eh,0B8h
		db  2Eh,0B9h
		db  2Eh,0BAh
		db  2Eh, 4Ch
		db  22h,   0
byte_10FE9	db 0			; DATA XREF: ShowItemObtain:loc_1D3B0r
					; ShowItemObtain:ShowOnsenw ...
byte_10FEA	db 0			; DATA XREF: ShowItemObtain:loc_1D606w
					; seg001:loc_1F851r
byte_10FEB	db 0			; DATA XREF: ShowItemObtain+5w
					; sub_1F580+36w ...
byte_10FEC	db 0			; DATA XREF: ShowItemObtain:loc_1D600w
					; sub_1F2E9:loc_1F2FFw	...
word_10FED	dw 0Ah dup(0)		; DATA XREF: ShowItemObtain:loc_1D422o
					; ShowItemObtain:loc_1D45Bo ...
byte_11001	db 0			; DATA XREF: sub_1DE2B+66w
					; sub_1DE2B:loc_1DF77w	...
byte_11002	db 0			; DATA XREF: sub_1DE2B+6Bw
					; sub_1DE2B+151w ...
byte_11003	db 0			; DATA XREF: sub_1DE2B+70w
					; sub_1DE2B+156w ...
byte_11004	db 0			; DATA XREF: sub_1DE2B+75w
					; sub_1DE2B+15Bw ...
byte_11005	db 0			; DATA XREF: sub_1F6DB-1E2r
					; sub_1F6DB-1D9w ...
aMonster	db 'Monster',0Dh,0Ah,'$'
byte_11010	db 0			; DATA XREF: DoBattleMain+6w
					; sub_1E442+23Dw
plrAttackMode	db 0			; DATA XREF: sub_1E442+49r
					; sub_1E442+89r ...
byte_11012	db 0			; DATA XREF: sub_1E442:loc_1E915w
					; sub_1EAF8+78r ...
battleResult	db 0			; DATA XREF: ShowItemObtainw
					; ShowItemObtain+524r ...
		db 0Dh dup(0)
aDoorLocked	db 6,'åÆÇ™ÅAÇ©Ç©Ç¡ÇƒÇ¢ÇÈÇÊÅ[',0Ah ; DATA XREF: sub_1F580+31o
aGoUpstairs	db 7,'è„Ç÷ÇÃäKíiÇ≈Ç∑ÅBìoÇËÇ‹Ç∑Ç©ÅHÅ@ÅmÇxÇèÇíÇmÅn',0Ah
					; DATA XREF: ShowItemObtain+E2o
aGoDownstairs	db 7,'â∫Ç÷ÇÃäKíiÇ≈Ç∑ÅBâ∫ÇËÇ‹Ç∑Ç©ÅHÅ@ÅmÇxÇèÇíÇmÅn',0Ah
					; DATA XREF: ShowItemObtain+167o
		db 7,'ÇÌÅ[Å[Å[Å[',0Dh,0Ah
aWhatWillYouDo	db 7,13h,'Ç«Ç§ÇµÇ‹Ç∑Ç©Å@ÅH',0Ah ; DATA XREF: Battle_GetPlrAction+9o
aWhichSpellCast	db 7,13h,'ÉtÉBÉìÇ…Ç«ÇÃñÇñ@ÇÇÇ®äËÇ¢ÇµÇ‹Ç∑Ç©Å@ÅH',0Ah
					; DATA XREF: Battle_GetPlrAction+21o
aB@		db 7,'Å@',0Ah
aDodged		db 'Å@ÇµÇ©ÇµÅCÇ©ÇÌÇ≥ÇÍÇΩ',0Dh,0Ah ; DATA XREF: seg001:138Co
aEvaded		db 'Å@ÇµÇ©ÇµÅCÇ©ÇÌÇµÇΩ',0Dh,0Ah ; DATA XREF: sub_1E442+2C8o
aFailed		db 'Å@ÇµÇ©ÇµÅCé∏îsÇµÇΩ',0Dh,0Ah ; DATA XREF: DoPlayerRunAway+52o
					; seg001:13B4o
aPlrAttack	db 7,13h,'ÉâÉìÉfÉBÉXÇÕçUåÇÇµÇΩ',0Ah ; Randis attacks!
aPlrDefend	db 7,13h,'ÉâÉìÉfÉBÉXÇÕéÁÇ¡ÇΩ',0Dh,0Ah ; DATA XREF: sub_1E442+234o
					; Randis defends!
aPlrRunAway	db 7,13h,'ÉâÉìÉfÉBÉXÇÕì¶Ç∞ÇæÇµÇΩ',0Ah ; DATA XREF: DoPlayerRunAway+9o
					; Randis runs away!
aEscaped	db 'Å@ì¶Ç∞ÇÍÇΩ',0Dh,0Ah ; DATA XREF: DoPlayerRunAway+44o
					; Managed to escape!
aMonstAtk1	db 7,13h,0Ah		; DATA XREF: sub_1E442+4FDo
					; sub_1E442+7A0o ...
aMonstAtk2	db 'ÇÃçUåÇ',0Ah         ; DATA XREF: sub_1E442+50Bo
aDamageToMonst	db 7,'É|ÉCÉìÉgÇÃÉ_ÉÅÅ|ÉWÇÇ†ÇΩÇ¶ÇΩÅD',0Dh,0Ah ; DATA XREF: sub_1E442+1AFo
					; sub_1E442+48Ao
					; # damage.
aDamageToPlr	db 7,'É_ÉÅÅ[ÉWÅIÅI',0Dh,0Ah ; DATA XREF: sub_1E442+5CEo
					; sub_1E442+860o ...
					; # damage!
aDefeated	db 'ÇÕÅCì|ÇÍÇΩ',0Dh,0Ah ; DATA XREF: sub_1E442+14Ao
					; sub_1E442+1C8o
					; [Monster] defeated.
aPlrDead	db 1Ah,2,'ÉâÉìÉfÉBÉXÇÕéÄÇÒÇæ',7,0Dh,0Ah ; DATA XREF: sub_1E442+21Fo
					; Randis is dead.
aPlrAtkAgain	db 12h,7,'Ç≥ÇÁÇ…ÅCÉâÉìÉfÉBÉXÇÕçUåÇÇµÇΩ',0Dh,0Ah ; DATA XREF: sub_1E442+181o
					; Randis attacked again!
aLevelUp	db 3,1Ah,'ÉåÉxÉãÉAÉbÉvÅ@ÅI',0Ah ; DATA XREF: CheckLevelUp+21o
aLevelNReached	db 7,'Å@ÉåÉxÉãÇ…è„Ç™Ç¡ÇΩ',12h,0Dh,0Ah ; DATA XREF: CheckLevelUp+3Bo
aMaxHP		db 'ÇgÇoÇlÇ`ÇwÇÕÅA',0Ah ; DATA XREF: CheckLevelUp+5Ao
					; HP MAX is
aHPHasReached	db 'Ç…Ç»ÇËÇ‹ÇµÇΩ',0Dh,12h,0Ah ; DATA XREF: CheckLevelUp+6Co
					; N reached.
asc_11232	db 1Ah,0Ah		; DATA XREF: sub_1E442+CDo
					; sub_1E442+197o ...
asc_11234	db 12h,0Ah		; DATA XREF: sub_1E442+13Co
					; sub_1E442+1BAo
aFinCasts1	db 1Ah,7,'ÉtÉBÉìÇÕÅ@',0Ah ; DATA XREF: sub_1E442+306o
					; sub_1E442+3FDo ...
aFinCasts2	db 7,'Å@ÇÇ©ÇØÇΩÅ@ÅI',0Dh,0Ah ; DATA XREF: sub_1E442+314o
					; sub_1E442+40Bo ...
aFinPleaseUse1	db 1Ah,5,'ÉtÉBÉìÅCÅ@',0Ah ; DATA XREF: sub_1E442+3ADo
					; sub_1E442+3C5o ...
aFinPleaseUse2	db 5,'Å@ÇÇ©ÇØÇƒÇ≠ÇÍ',0Dh,7,0Ah ; DATA XREF: sub_1E442+3BBo
					; sub_1E442+3D3o ...
asc_11273	db 12h,7,0Ah		; DATA XREF: sub_1E442+31Bo
					; sub_1E442+412o ...
aFinNoCasting	db 12h,6,'Ç‚ÇüÇÊÅCÇﬂÇÒÇ«Ç≠Ç≥Ç¢ÅEÅEÅE',0Dh,12h,5,'Ç∞Ç¡ÅCÇªÅCÇªÇÒÇ ÇüÅEÅEÅE',0Dh,7,1Ah,0Ah
					; DATA XREF: sub_1E442+2A0o
					; I don't want to, it's too much trouble.
aCastHeal	db 4,'âÒïúÇÃñÇñ@',0Ah   ; DATA XREF: sub_1E442+30Do
					; sub_1E442+3B4o
aCastGuard	db 4,'ñhå‰ÇÃñÇñ@',0Ah   ; DATA XREF: sub_1E442+3CCo
					; sub_1E442+404o
aCastBlast	db 4,'çUåÇÇÃñÇñ@',0Ah   ; DATA XREF: seg001:14C6o
					; sub_1E442+444o
asc_112D5	db 12h,0Ah		; DATA XREF: sub_1E442+374o
aHPRecover	db 7,'É|ÉCÉìÉgâÒïúÇµÇΩ',0Dh,7,1Ah,0Ah ; DATA XREF: sub_1E442+388o
aMonstBreath	db 'ÇÕÉuÉåÉXÇêÅÇ¢ÇΩÅI',0Ah ; DATA XREF: sub_1E442+58Bo
					; [Monster] took a breath!
aFireResist	db 5,'ä√Ç¢ÇÌÅAÉhÉâÉSÉìÇÃÇ§ÇÎÇ±ÇÕâäÇÇ‡ñhÇÆÅIÅI',7,0Dh,0Ah
					; DATA XREF: sub_1E442+5EFo
					; Nice,	dragon scales resisted the fire!
aMonstGlare	db 7,'Å@ÇÕÅCÇ…ÇÁÇÒÇæ',0Ah ; DATA XREF: sub_1E442+630o
					; [Monster] glares at you.
aTurnIntoStone	db 12h,5,'Ç§Ç®ÅEÅEÇ®Ç®Ç®ÇßÇßÇßÇßÇ¡ÅEÅEÅE',2,'Ç“Ç´Å[ÇÒÅö',0Dh
					; DATA XREF: sub_1E442+63Eo
		db 12h,6,'ÇµÇ¡Ç©ÇËÇµÇƒÇÊÇ¡ÅIÅ@Ç±ÇÒÇ»Ç∆Ç±Ç≈êŒÇ…Ç»Ç¡ÇƒÇÈèÍçáÇ∂Ç·Ç»Ç¢Ç≈ÇµÇÂÇ'
		db '¡ÅIÅIÅI',7,0Dh,0Ah
aPlrStrDrain	db 2,12h,'Ç†Ç»ÇΩÇÕÅCóÕÇãzÇÌÇÍÇƒÇµÇ‹Ç¡ÇΩ',7,0Dh,0Ah
					; DATA XREF: sub_1E442+681o
					; Randis' strength is being drained!
aPlrEnemyHit	db 1Ah,5,'Ç§Ç®Ç®Ç®Ç®Ç¡ÅI',2,'ÉhÉJÉbÅIÅ@',12h,6,'ìñÇΩÇ¡ÇƒÇÈÅI',0Ah
					; DATA XREF: sub_1E442+A3o
					; Aaaaaah! Crash! Enemy	hit!
aPlrDmgDealt2	db 6,'É_ÉÅÅ[ÉWÇ¢Ç¡ÇΩÇÌÅIÅ@ÇªÇÃí≤éqÅI',0Dh,7 ; DATA XREF: CalcDamage2Mnst+1Do
					; N damage dealt! Keep it up!
		db  0Ah
aSlashNice	db 1Ah,2,'ÉhÉoÉVÉÖÉbÅIÅIÅ@' ; DATA XREF: sub_1E442+A59o
					; Slash!
		db 12h,6,'ÉiÉCÉXÉqÉbÉgÅI',0Ah ; Nice!
aPlrDmgDealt1	db 6,'Ç¢Ç¡ÇΩÇÌÅI',0Dh,7,1Ah,0Ah ; DATA XREF: sub_1E442+A76o
					; N damage dealt!
aPlrAtkMiss	db 1Ah,7,'Ç∑Ç©Ç¡Å@Åô'   ; DATA XREF: sub_1E442+2B4o
					; "Aaaaaah!
		db 5,'Å@Å@Å@Å@Å@Ç†ÇËÇ·ÅHÅ@ÇÕÇ∏ÇµÇΩÅEÅEÅE',0Dh ; Uh? I missed...
		db 7,1Ah,0Ah
aPlrAtkNoEffect	db 12h,6,'Ç≈Ç‡ÅCÇ»ÇÒÇ∆Ç‡Ç»Ç¢Ç›ÇΩÇ¢ÇÊÅEÅE',0Dh,7,1Ah,0Ah
					; DATA XREF: sub_1E442+2BEo
					; But it has no	effect...
aCast		db 7,'ÇÕ',4,0Ah         ; DATA XREF: sub_1E442+7AEo
					; sub_1E442+83Eo ...
aB@vgvbvuvfvubi	db 7,'ÇÃñÇñ@Çè•Ç¶ÇΩ',0Dh,0Ah ; DATA XREF: sub_1E442+7BCo
					; sub_1E442+84Co ...
aSpellCure	db 'ÇbÇïÇíÇÖ',0Ah       ; DATA XREF: sub_1E442+7B5o
aSpellFireBall	db 'ÇeÇâÇíÇÖÇaÇÅÇåÇå',0Ah ; DATA XREF: sub_1E442+845o
aSpellHealEX	db 'ÇgÇÖÇÅÇåÇâÇéÇáÇdÇw',0Ah ; DATA XREF: sub_1E442+8BAo
aSpellFireArrow	db 'ÇeÇâÇíÇÖÇ`ÇíÇíÇèÇó',0Ah ; DATA XREF: sub_1E442+915o
aSpellFullHeal	db 'ÇgÇÖÇÅÇåÇâÇéÇáÇoÇe',0Ah ; DATA XREF: sub_1E442+957o
aSpellFireStorm	db 'ÇeÇâÇíÇÖÇrÇîÇèÇíÇç',0Ah ; DATA XREF: sub_1E442+9B2o
aFallDamage	db 7,'Å@ÇÃÉ_ÉÅÅ|ÉWÇÇ§ÇØÇΩ',0Dh,0Ah ; DATA XREF: ShowItemObtain+1EDo
					; ShowItemObtain+23Eo ...
aTrapDoor1	db 5,'Ç¢ÇƒÇƒÇ•ÅEÅEÅE',0Dh ; DATA XREF: ShowItemObtain+204o
					; Ouch!
		db 12h,6,'ÇæÇ¢Ç∂ÇÂÇ§Ç‘ÅHÅ@ÅEÅEÅEÇΩÇ≠Ç‡Ç§ÅAÉtÉHÉEÇ≥ÇÒÇ…íçà”Ç≥ÇÍÇƒÇΩÇ∂Ç·Ç»Ç' ; Are you OK?... Fou warned you about this.
		db '¢ÇÃÅB',0Dh
		db 5,12h,'Ç®Ç‹Ç¶ÇÕÇ¢Ç¢ÇÊÅIÅ@ãÛîÚÇ◊ÇÈÇÒÇæÇ©ÇÁÅEÅEÅE',0Dh,1Ah,7,0Ah ; Easy for you to say, you can fly!
aTrapDoor2	db 5,'Ç¢ÇƒÇƒÇ•ÅEÅEÅE',0Dh ; DATA XREF: ShowItemObtain+29Ao
		db 12h,6,'ÉhÉWÇÀÇ•ÅBìØÇ∂ÉgÉâÉbÉvÇ…âΩìxÇ‡Ç–Ç¡Ç©Ç©ÇÈÇ±Ç∆Ç»Ç¢ÇÃÇ…ÅEÅEÅE',0Dh
		db 12h,5,'ÇÌÇ©Ç¡ÇƒÇÈÇÒÇ»ÇÁã≥Ç¶ÇƒÇ≠ÇÍÇÊÅIÅI',0Dh
		db 12h,6,'íjÇ»ÇÁÅAé©ï™ÇÃçsìÆÇ…ê”îCÇ∆ÇËÇ»Ç≥Ç¢Ç»ÅB',0Dh,1Ah,0Ah
aTrapDoor3	db 5,'Ç¢ÇƒÇƒÇ•ÅEÅEÅE',0Dh ; DATA XREF: ShowItemObtain+255o
		db 12h,6,'ÇæÇ¢Ç∂ÇÂÇ§Ç‘ÅHÅ@ÅEÅEÅEÇΩÇ≠Ç‡Ç§ÅAÉtÉHÉEÇ≥ÇÒÇ…íçà”Ç≥ÇÍÇƒÇΩÇ∂Ç·Ç»Ç'
		db '¢ÇÃÅB',0Dh
		db 12h,5,'ÅEÅEÅEÇ‹Ç≥Ç©ÇRäKÇ©ÇÁíºí ÇÃóéÇµåäÇæÇ¡ÇΩÇ∆ÇÕévÇÌÇ»Ç©Ç¡ÇΩÅEÅEÅE',0Dh,1Ah
		db 0Ah
byte_116F5	db 6, 82h, 0D3h, 82h, 0A4h, 81h, 45h, 81h, 45h,	81h, 45h
					; DATA XREF: sub_1D721+31o
		db 82h,	0A8h, 94h, 0E6h, 82h, 0EAh, 82h, 0B3h, 82h, 0DCh
		db 81h,	42h, 95h, 0F3h,	94h, 0A0h, 82h,	0CDh, 81h, 48h
		db 0Dh,	12h, 5,	82h, 0A0h, 82h,	0A0h, 81h, 41h,	82h, 0A2h
		db 82h,	0DCh, 8Ah, 4Ah,	82h, 0AFh, 82h,	0C4h, 82h, 0DDh
		db 82h,	0E9h, 81h, 45h,	81h, 45h, 81h, 45h, 82h, 0C6h
		db 81h,	41h, 8Ah, 4Ah, 82h, 0A2h, 82h, 0BDh, 81h, 49h
		db 0Dh,	1Ah, 6,	81h, 45h, 81h, 45h, 81h, 45h, 82h, 0C8h
		db 82h,	0C9h, 82h, 0AAh, 93h, 0FCh, 82h, 0C1h, 82h, 0C4h
		db 82h,	0BDh, 81h, 48h,	0Dh, 12h, 5, 83h, 4Eh, 83h, 8Ah
		db 83h,	58h, 83h, 5Eh, 83h, 8Bh, 82h, 0BEh, 81h, 45h, 81h
		db 45h,	81h, 45h, 0Dh, 1Ah, 6, 8Ch, 95h, 82h, 0CCh, 83h
		db 75h,	83h, 8Ch, 81h, 5Bh, 83h, 68h, 82h, 0CCh, 82h, 50h
		db 82h,	0C2h, 82h, 0A9h, 82h, 0B5h, 82h, 0E7h, 81h, 45h
		db 81h,	45h, 81h, 45h, 0Dh, 12h, 5, 82h, 0BDh, 82h, 0D4h
		db 82h,	0F1h, 82h, 0CBh, 81h, 42h, 81h,	40h, 95h, 0BFh
		db 82h,	0CCh, 82h, 0ADh, 82h, 0DAh, 82h, 0DDh, 82h, 0C9h
		db 82h,	0ABh, 82h, 0C1h, 82h, 0BFh, 82h, 0E8h, 94h, 5Bh
		db 82h,	0DCh, 82h, 0C1h, 82h, 0BDh, 82h, 0B5h, 81h, 42h
		db 0Dh,	1Ah, 6,	82h, 0B3h, 81h,	41h, 82h, 0AEh,	82h, 0B8h
		db 82h,	0AEh, 82h, 0B8h, 82h, 0B5h, 82h, 0C4h, 82h, 0A2h
		db 82h,	0E9h, 83h, 71h,	83h, 7Dh, 82h, 0CDh, 82h, 0C8h
		db 82h,	0A2h, 82h, 0EDh, 82h, 0E6h, 81h, 42h, 92h, 54h
		db 8Dh,	0F5h, 82h, 0F0h, 91h, 0B1h, 82h, 0AFh, 82h, 0DCh
		db 82h,	0B5h, 82h, 0E5h, 81h, 42h, 0Dh,	1Ah, 7,	0Ah
byte_117F8	db 5, 82h, 0EDh, 81h, 45h, 81h,	45h, 82h, 0C1h,	81h, 49h
					; DATA XREF: sub_1D721+57o
		db 81h,	40h, 83h, 74h, 83h, 42h, 83h, 93h, 81h,	49h, 81h
		db 40h,	82h, 0BFh, 82h,	0E5h, 82h, 0C1h, 82h, 0C6h, 91h
		db 0D2h, 82h, 0C1h, 82h, 0BDh, 81h, 49h, 81h, 49h, 81h
		db 40h,	82h, 54h, 82h, 0C2h, 82h, 0DFh,	82h, 0F0h, 82h
		db 0C2h, 82h, 0AFh, 82h, 0BDh, 82h, 0E7h, 81h, 45h, 81h
		db 45h,	81h, 49h, 81h, 49h, 0Dh, 12h, 6, 82h, 0A6h, 81h
		db 48h,	81h, 40h, 82h, 0A0h, 81h, 45h, 81h, 45h, 8Ch, 0F5h
		db 82h,	0CCh, 83h, 75h,	83h, 8Ch, 81h, 5Bh, 83h, 68h, 82h
		db 0AAh, 81h, 45h, 81h,	45h, 81h, 45h, 0Dh, 1Ah, 5, 82h
		db 0B1h, 82h, 0EAh, 82h, 0AAh, 93h, 60h, 90h, 0E0h, 82h
		db 0CCh, 81h, 45h, 81h,	45h, 8Ch, 0F5h,	82h, 0CCh, 8Ch
		db 95h,	81h, 45h, 81h, 45h, 81h, 45h, 81h, 45h,	12h, 7
		db 81h,	40h, 81h, 40h, 83h, 73h, 83h, 56h, 83h,	62h, 0Dh
		db 12h,	6, 82h,	0A0h, 82h, 0EAh, 81h, 45h, 81h,	45h, 81h
		db 48h,	81h, 40h, 83h, 89h, 83h, 93h, 83h, 66h,	83h, 42h
		db 83h,	58h, 81h, 41h, 82h, 0C7h, 82h, 0A4h, 82h, 0B5h
		db 82h,	0BDh, 82h, 0CCh, 81h, 48h, 81h,	40h, 82h, 0DAh
		db 81h,	5Bh, 82h, 0C1h,	82h, 0C6h, 81h,	45h, 81h, 45h
		db 81h,	45h, 0Dh, 12h, 5, 90h, 0C3h, 82h, 0A9h,	82h, 0C9h
		db 81h,	49h, 81h, 40h, 92h, 4Eh, 82h, 0A9h, 82h, 0AAh
		db 98h,	62h, 82h, 0B5h,	82h, 0A9h, 82h,	0AFh, 82h, 0C4h
		db 82h,	0A2h, 82h, 0E9h, 82h, 0F1h, 82h, 0BEh, 81h, 49h
		db 81h,	40h, 93h, 0AAh,	82h, 0CCh, 92h,	86h, 82h, 0C9h
		db 92h,	0BCh, 90h, 0DAh, 81h, 49h, 0Dh,	1Ah, 7,	95h, 0BDh
		db 89h,	0B8h, 82h, 0C8h, 82h, 0E9h, 8Ch, 95h, 82h, 0F0h
		db 8Eh,	0E8h, 82h, 0C9h, 82h, 0B5h, 97h, 45h, 8Eh, 0D2h
		db 82h,	0E6h, 81h, 45h,	81h, 45h, 81h, 45h, 82h, 0BBh
		db 82h,	0C8h, 82h, 0BDh, 82h, 0C9h, 90h, 5Ch, 82h, 0B5h
		db 93h,	6Eh, 82h, 0B7h,	82h, 0B1h, 82h,	0C6h, 82h, 0AAh
		db 82h,	0A0h, 82h, 0E9h, 81h, 45h, 81h,	45h, 81h, 45h
		db 0Dh,	1Ah, 7,	82h, 0B1h, 82h,	0CCh, 8Ch, 95h,	82h, 0CDh
		db 8Eh,	45h, 88h, 0D3h,	82h, 0F0h, 8Eh,	9Dh, 82h, 0C1h
		db 82h,	0C4h, 90h, 55h,	82h, 0E9h, 82h,	0C1h, 82h, 0C4h
		db 82h,	0CDh, 82h, 0C8h, 82h, 0E7h, 82h, 0CAh, 81h, 45h
		db 81h,	45h, 81h, 45h, 82h, 0B1h, 82h, 0CCh, 8Ch, 95h
		db 82h,	0CDh, 96h, 0BDh, 82h, 0F0h, 92h, 44h, 82h, 0A4h
		db 82h,	0BDh, 82h, 0DFh, 82h, 0C9h, 90h, 55h, 82h, 0E9h
		db 82h,	0C1h, 82h, 0C4h, 82h, 0CDh, 82h, 0C8h, 82h, 0E7h
		db 82h,	0CAh, 81h, 45h,	81h, 45h, 81h, 45h, 96h, 0BDh
		db 82h,	0F0h, 8Bh, 7Eh,	82h, 0A4h, 82h,	0BDh, 82h, 0DFh
		db 82h,	0C9h, 90h, 55h,	82h, 0E9h, 82h,	0A4h, 82h, 0CCh
		db 82h,	0BEh, 81h, 45h,	81h, 45h, 81h, 45h, 0Dh, 1Ah, 7
		db 88h,	0C5h, 82h, 0F0h, 8Eh, 61h, 82h,	0E9h, 82h, 0BDh
		db 82h,	0DFh, 82h, 0C9h, 93h, 53h, 82h,	0CCh, 8Ch, 95h
		db 82h,	0F0h, 90h, 55h,	82h, 0E9h, 82h,	0A2h, 81h, 41h
		db 88h,	0C5h, 82h, 0A9h, 82h, 0E7h, 8Ch, 0F5h, 82h, 0F0h
		db 8Eh,	0E6h, 82h, 0E8h, 96h, 0DFh, 82h, 0B7h, 82h, 0BDh
		db 82h,	0DFh, 82h, 0C9h, 8Ch, 0F5h, 82h, 0CCh, 8Ch, 95h
		db 82h,	0F0h, 90h, 55h,	82h, 0E9h, 82h,	0A4h, 82h, 0CCh
		db 82h,	0BEh, 81h, 45h,	81h, 45h, 81h, 45h, 0Dh, 1Ah, 7
		db 82h,	0BBh, 82h, 0CCh, 82h, 0B1h, 82h, 0C6h, 81h, 45h
		db 81h,	45h, 81h, 45h, 82h, 0E0h, 82h, 0B5h, 82h, 0BBh
		db 82h,	0C8h, 82h, 0BDh, 82h, 0AAh, 90h, 53h, 82h, 0C9h
		db 8Dh,	8Fh, 82h, 0DEh,	82h, 0C6h, 90h,	0BEh, 82h, 0A4h
		db 82h,	0C8h, 82h, 0E7h, 81h, 45h, 81h,	45h, 81h, 45h
		db 8Eh,	84h, 82h, 0CDh,	82h, 0BBh, 82h,	0C8h, 82h, 0BDh
		db 82h,	0F0h, 8Ch, 0F5h, 82h, 0CCh, 8Ch, 95h, 8Eh, 6Dh
		db 82h,	0C6h, 94h, 46h,	82h, 0DFh, 82h,	0E6h, 82h, 0A4h
		db 81h,	45h, 81h, 45h, 81h, 45h, 90h, 0BEh, 82h, 0A6h
		db 82h,	0E9h, 82h, 0A9h, 81h, 48h, 0Dh,	12h, 5,	82h, 0CDh
		db 82h,	0A2h, 81h, 45h,	81h, 45h, 81h, 45h, 82h, 0EDh
		db 82h,	0A9h, 82h, 0E8h, 82h, 0DCh, 82h, 0B5h, 82h, 0BDh
		db 81h,	45h, 81h, 45h, 81h, 45h, 81h, 49h, 0Dh,	1Ah, 7
		db 82h,	0E6h, 82h, 0EBh, 82h, 0B5h, 82h, 0A2h, 81h, 45h
		db 81h,	45h, 82h, 0C5h,	82h, 0CDh, 81h,	41h, 82h, 0BBh
		db 82h,	0CCh, 81h, 77h,	8Eh, 9Eh, 81h, 78h, 82h, 0AAh
		db 97h,	88h, 82h, 0E9h,	82h, 0DCh, 82h,	0C5h, 81h, 45h
		db 81h,	45h, 81h, 45h, 8Eh, 84h, 82h, 0CDh, 82h, 0B5h
		db 82h,	0CEh, 82h, 0B5h, 82h, 0CCh, 96h, 0B0h, 82h, 0E8h
		db 82h,	0C9h, 82h, 0C2h, 82h, 0ADh, 81h, 45h, 81h, 45h
		db 81h,	45h, 82h, 0BBh,	82h, 0C8h, 82h,	0BDh, 82h, 0AAh
		db 8Ch,	0C4h, 82h, 0D1h, 82h, 0A9h, 82h, 0AFh, 82h, 0EAh
		db 82h,	0CEh, 81h, 41h,	8Eh, 84h, 82h, 0CDh, 82h, 0DCh
		db 82h,	0BDh, 82h, 0E6h, 82h, 0DDh, 82h, 0AAh, 82h, 0A6h
		db 82h,	0E9h, 82h, 0BEh, 82h, 0EBh, 82h, 0A4h, 81h, 45h
		db 81h,	45h, 81h, 45h, 81h, 45h, 0Dh, 1Ah, 5, 81h, 45h
		db 81h,	45h, 81h, 45h, 81h, 45h, 81h, 45h, 81h,	45h, 81h
		db 45h,	81h, 45h, 0Dh, 1Ah, 5, 82h, 0E0h, 82h, 0A4h, 81h
		db 45h,	81h, 45h, 81h, 45h, 89h, 0BDh, 82h, 0E0h, 95h
		db 0B7h, 82h, 0B1h, 82h, 0A6h, 82h, 0C8h, 82h, 0A2h, 81h
		db 45h,	81h, 45h, 81h, 45h, 0Dh, 12h, 6, 82h, 0C8h, 82h
		db 0F1h, 82h, 0C4h, 8Ch, 0BEh, 82h, 0C1h, 82h, 0C4h, 82h
		db 0BDh, 82h, 0CCh, 81h, 48h, 0Dh, 1Ah,	5, 96h,	0BDh, 82h
		db 0F0h, 92h, 44h, 82h,	0A4h, 82h, 0BDh, 82h, 0DFh, 82h
		db 0C9h, 8Ch, 95h, 82h,	0F0h, 90h, 55h,	82h, 0E9h, 82h
		db 0A4h, 82h, 0C8h, 81h, 45h, 81h, 45h,	81h, 45h, 82h
		db 0C1h, 82h, 0C4h, 81h, 42h, 82h, 0DCh, 82h, 0E9h, 82h
		db 0C5h, 81h, 41h, 8Ch,	95h, 82h, 0AAh,	98h, 62h, 82h
		db 0B5h, 82h, 0A9h, 82h, 0AFh, 82h, 0C4h, 82h, 0ABh, 82h
		db 0C4h, 82h, 0A2h, 82h, 0E9h, 82h, 0E6h, 82h, 0A4h, 82h
		db 0BEh, 82h, 0C1h, 82h, 0BDh, 81h, 45h, 81h, 45h, 81h
		db 45h,	0Dh, 1Ah, 6, 82h, 0A0h,	81h, 45h, 81h, 45h, 81h
		db 45h,	83h, 75h, 83h, 8Ch, 81h, 5Bh, 83h, 68h,	82h, 0AAh
		db 8Fh,	0C1h, 82h, 0A6h, 82h, 0BDh, 82h, 0EDh, 81h, 45h
		db 81h,	45h, 81h, 45h, 0Dh, 1Ah, 0Ah
word_11BCD	dw 0			; DATA XREF: start+33w	fopen-2F5r
word_11BCF	dw 0			; DATA XREF: start+37w	fopen-2F1r
curGold		dw 0			; DATA XREF: sub_1E442+210r
					; sub_1E442+216w ...
curLevel	dw 0			; DATA XREF: SetInitialStats+47w
					; SetInitialStats+8Aw ...
maxHP		dw 0			; DATA XREF: ShowItemObtain+5Dr
					; sub_1E442:loc_1E7A8r	...
curHP		dw 0			; DATA XREF: ShowItemObtain+60w
					; ShowItemObtain+1F5r ...
curLvlExp	dw 0			; DATA XREF: sub_1E442+201r
					; sub_1E442+207w ...
characterStr	db 0			; DATA XREF: sub_1E442+74r
					; sub_1E442+69Dr ...
characterDex	db 0			; DATA XREF: sub_1E442+68Br
					; sub_1E442:loc_1EAD7w	...
btlSpellStr	dw 0			; DATA XREF: sub_1E442+323r
					; sub_1E442+41Ar ...
btlRemSpells	dw 0			; DATA XREF: DoBattler	DoBattle+Aw ...
equippedWeapon	dw 0			; DATA XREF: ShowItemObtain+302w
					; GetWeaponPropsr ...
equippedArmor	dw 0			; DATA XREF: ShowItemObtain+331w
					; SetInitialStats+19w ...
equippedShield	dw 0			; DATA XREF: ShowItemObtain+360w
					; sub_1E442+5B4r ...
word_11BE7	dw 0			; DATA XREF: sub_1D721r sub_1D721+9w ...
word_11BE9	dw 0			; DATA XREF: ShowItemObtain:loc_1D490r
					; sub_1D721+68w
immunePetrify	dw 0			; DATA XREF: sub_1E442+635r
word_11BED	dw 0			; DATA XREF: sub_1D721+5Cw
		dw 0
		dw 0
		dw 0
hasRingOfStr	dw 0			; DATA XREF: CalcStrAndDex+61r
hasRingOfDef	dw 0			; DATA XREF: CalcPlrDamage+2Dr
word_11BF9	dw 0			; DATA XREF: sub_1F6DB+ADr
byte_11BFB	db 0			; DATA XREF: sub_1F60B+6r sub_1F626r ...
byte_11BFC	db 0			; DATA XREF: sub_1F60B+Er seg001:24E2r
byte_11BFD	db 0			; DATA XREF: ShowItemObtain+84Ew
					; ShowItemObtain+967w ...
byte_11BFE	db 0			; DATA XREF: ShowItemObtain+853w
					; ShowItemObtain+96Cw ...
byte_11BFF	db 0			; DATA XREF: ShowItemObtain:loc_1DCC2w
					; sub_1F5C1+12w ...
byte_11C00	db 0			; DATA XREF: ShowItemObtain+63r
					; ShowItemObtain+B4r ...
byte_11C01	db 0			; DATA XREF: ShowItemObtain:loc_1D47Ar
					; ShowItemObtain+546w
byte_11C02	db 0			; DATA XREF: ShowItemObtain:loc_1D838r
					; ShowItemObtain+4F8w
byte_11C03	db 0			; DATA XREF: ShowItemObtain:loc_1D85Er
					; ShowItemObtain+54Bw
byte_11C04	db 0			; DATA XREF: ShowItemObtain:loc_1D484r
					; ShowItemObtain:loc_1D8B1r ...
byte_11C05	db 0			; DATA XREF: ShowItemObtain:loc_1D8FDr
					; ShowItemObtain+5BDw
byte_11C06	db 0			; DATA XREF: ShowItemObtain:loc_1D923r
					; ShowItemObtain+60Aw
byte_11C07	db 0			; DATA XREF: ShowItemObtain:loc_1D970r
					; ShowItemObtain+630w
byte_11C08	db 0			; DATA XREF: ShowItemObtain:loc_1D996r
					; ShowItemObtain+656w
byte_11C09	db 0			; DATA XREF: ShowItemObtain:loc_1D9BCr
					; ShowItemObtain+67Cw
byte_11C0A	db 0			; DATA XREF: ShowItemObtain:loc_1D9E2r
					; ShowItemObtain+6A2w
byte_11C0B	db 0			; DATA XREF: seg001:06A9r seg001:06C1w
byte_11C0C	db 0			; DATA XREF: ShowItemObtain:loc_1DA27r
					; ShowItemObtain+6E7w
byte_11C0D	db 0			; DATA XREF: ShowItemObtain:loc_1DA4Dr
					; ShowItemObtain+70Dw
byte_11C0E	db 0			; DATA XREF: ShowItemObtain:loc_1DA73r
					; ShowItemObtain+75Aw
byte_11C0F	db 0			; DATA XREF: ShowItemObtain:loc_1DAC0r
					; ShowItemObtain+7A7w
byte_11C10	db 0			; DATA XREF: ShowItemObtain:loc_1DB0Dr
					; ShowItemObtain+7CDw
byte_11C11	db 0			; DATA XREF: ShowItemObtain:loc_1DB33r
					; ShowItemObtain+7F3w
byte_11C12	db 0			; DATA XREF: ShowItemObtain:loc_1DB59r
					; ShowItemObtain+819w
byte_11C13	db 0			; DATA XREF: ShowItemObtain:loc_1DB7Fr
					; ShowItemObtain+834w
byte_11C14	db 0			; DATA XREF: ShowItemObtain:loc_1DBC8r
					; ShowItemObtain+8AFw
byte_11C15	db 0			; DATA XREF: ShowItemObtain:loc_1DC15r
					; ShowItemObtain+8D5w
byte_11C16	db 0			; DATA XREF: ShowItemObtain:loc_1DC3Br
					; ShowItemObtain+91Fw
byte_11C17	db 0			; DATA XREF: ShowItemObtain+1B6r
					; ShowItemObtain:loc_1D520w
byte_11C18	db 0			; DATA XREF: ShowItemObtain:loc_1D56Ar
					; ShowItemObtain+211w
byte_11C19	db 0			; DATA XREF: ShowItemObtain:loc_1D63Fr
					; ShowItemObtain+308w
byte_11C1A	db 0			; DATA XREF: ShowItemObtain:loc_1D66Er
					; ShowItemObtain+337w
byte_11C1B	db 0			; DATA XREF: ShowItemObtain:loc_1D69Dr
					; ShowItemObtain+366w
byte_11C1C	db 0			; DATA XREF: ShowItemObtain:loc_1D6CCr
					; ShowItemObtain+377w
byte_11C1D	db 0			; DATA XREF: ShowItemObtain:loc_1D6DDr
					; ShowItemObtain+388w
byte_11C1E	db 0			; DATA XREF: ShowItemObtain:loc_1D6EEr
					; ShowItemObtain+399w
byte_11C1F	db 0			; DATA XREF: ShowItemObtain:loc_1D6FFr
					; ShowItemObtain+3AAw
byte_11C20	db 0			; DATA XREF: ShowItemObtain:loc_1D710r
					; ShowItemObtain+3BBw
		db 12h dup(0)
armorDef	db 0			; DATA XREF: DoBattleMainr
					; CalcStrAndDex+Aw ...
curStrength	db 0			; DATA XREF: CalcStrAndDex+79w
					; CalcStrAndDex:loc_1F47Cw ...
curDexterity	db 0			; DATA XREF: DoBattleMain+21r
					; CalcStrAndDex:loc_1F472w ...
equipmentDex	db 0			; DATA XREF: CalcStrAndDex+Ew
					; CalcStrAndDex+2Dr ...
equipmentStr	db 0			; DATA XREF: CalcStrAndDex+12w
					; CalcStrAndDex+3Ar ...
weaponName	db 16h dup(0)		; DATA XREF: GetWeaponProps+Er
weaponProps	db 0, 0, 0		; DATA XREF: GetWeaponProps+22o
damageDealt	db 0			; DATA XREF: sub_1E442+71w
					; sub_1E442+7Dr ...
actionID_Plr	db 0			; DATA XREF: Battle_GetPlrAction+11w
					; sub_1E442:loc_1E47Ar	...
actionID_Fin	db 0			; DATA XREF: Battle_GetPlrAction+29w
					; sub_1E442:loc_1E726r
btlPlayerDef	db 0			; DATA XREF: DoBattleMain+3w
					; sub_1E442+239w ...
btlPlayerDex	db 0			; DATA XREF: DoBattleMain+24w
					; DetermineTurnOrder+1Er ...
monsterCount	db 0			; DATA XREF: sub_1E1AB+39w
					; ShowMnstAppearTxt+9r	...
byte_11C57	db 0			; DATA XREF: sub_1E442+3w
					; sub_1E442+2Dr
monsterDefense	db 0			; DATA XREF: DoBattleMain+12w
					; CalcDamage2Mnst+3r
word_11C59	dw 0			; DATA XREF: DoBattleMain+18w
					; sub_1E442+1FCr
word_11C5B	dw 0			; DATA XREF: DoBattleMain+1Ew
					; sub_1E442+20Br
byte_11C5D	db 0			; DATA XREF: DoBattleMain+4Fw
					; sub_1E442+B2r ...
word_11C5E	dw 0			; DATA XREF: sub_1E442+56w
					; sub_1E442:loc_1E4D5r	...
byte_11C60	db 0			; DATA XREF: DoBattleMain+27w
					; sub_1E442+14Fw ...
byte_11C61	db 0			; DATA XREF: DoBattleMain+2Cw
					; DoBattleMain+47w ...
		db 82h,	6Bh, 81h, 40h, 82h, 75h, 81h, 46h, 0Ah,	12h, 82h
		db 67h,	82h, 6Fh, 81h, 40h, 81h, 46h, 0Ah, 12h,	82h, 67h
		db 82h,	6Fh, 82h, 6Ch, 81h, 46h, 0Ah, 12h, 82h,	72h, 82h
		db 73h,	82h, 71h, 81h, 46h, 0Ah, 12h, 82h, 72h,	82h, 73h
		db 82h,	6Ch, 81h, 46h, 0Ah, 12h, 82h, 72h, 81h,	51h, 82h
		db 71h,	81h, 46h, 0Ah, 12h, 82h, 63h, 81h, 51h,	82h, 71h
		db 81h,	46h, 0Ah, 12h, 82h, 63h, 82h, 64h, 82h,	77h, 81h
		db 46h,	0Ah, 12h, 82h, 63h, 82h, 64h, 82h, 6Ch,	81h, 46h
		db 0Ah,	12h, 82h, 60h, 82h, 62h, 81h, 40h, 81h,	46h, 0Ah
		db 12h,	82h, 65h, 82h, 6Bh, 82h, 75h, 81h, 46h,	0Ah, 12h
		db 8Ch,	95h, 81h, 40h, 81h, 40h, 81h, 46h, 0Ah,	12h, 8Ah
		db 5Ah,	81h, 40h, 81h, 40h, 81h, 46h, 0Ah, 12h,	8Fh, 82h
		db 81h,	40h, 81h, 40h, 81h, 46h, 0Ah, 12h, 82h,	64h, 82h
		db 77h,	82h, 6Fh, 81h, 46h, 0Ah, 12h, 82h, 66h,	81h, 40h
		db 82h,	6Fh, 81h, 46h, 0Ah, 12h, 8Ah, 4Bh, 81h,	40h, 81h
		db 40h,	81h, 46h, 0Ah, 12h, 82h, 77h, 81h, 40h,	81h, 40h
		db 81h,	46h, 0Ah, 12h, 82h, 78h, 81h, 40h, 81h,	40h, 81h
		db 46h,	0Ah, 12h, 83h, 4Eh, 83h, 8Ah, 83h, 58h,	81h, 46h
		db 0Ah
word_11D29	dw 0			; DATA XREF: sub_1E442+354w
					; sub_1E442+379r ...
btlHealData	db 1, 6, 0		; DATA XREF: sub_1E442+326o
		db 2, 6, 0		; amount of randomized HP restored for "Heal" spell
		db 2, 10, 0
		db 2, 20, 0
		db 1, 100, 0
		db 0, 0, 255
btlPlrGuardDef	db 0			; DATA XREF: DoBattleMain+31w
					; sub_1E442+425w ...
btlGuardData	db 2, 5, 10, 15, 20, 30, 0 ; DATA XREF:	sub_1E442+41Do
					; amount of defence increase for "Guard" spell
btlBlastData	db 1, 10, 0		; DATA XREF: sub_1E8DB+3o
		db 2, 10, 0		; amount of randomized damage restored for "Blast" spell
		db 2, 20, 0
		db 3, 20, 0
		db 1, 100, 0
		db 10, 20, 0
cheatMode	db 0			; DATA XREF: start+85w
					; SetInitialStatsr
		db 6 dup(0)
		dw 0
		dw seg seg000
		dw 0A800h
		dw 0B000h
		dw 0B800h
		dw 0A000h
		dw 0A100h
floorMapData	db 190h	dup(0)		; DATA XREF: sub_1F626:loc_1F638o
					; ReadFileDMAP+3Co
floorEvtData	db 190h	dup(0)		; DATA XREF: sub_1F2E9o sub_1F30Bo ...
byte_1208C	db 0			; DATA XREF: sub_1F5D9+1Cr
					; sub_1F5D9+2Bw ...
byte_1208D	db 0			; DATA XREF: sub_1F580+9r
					; sub_1F580+3Bw ...
		db 22h dup(0)
byte_120B0	db 0			; DATA XREF: DrawNumberFW_03+4w
					; DrawNumberFW_5+4w ...
word_120B1	dw 0			; DATA XREF: DrawNumberFW_03w
					; DrawNumberFW_03+32r ...
		db    0
aPlay_exe	db 'PLAY.EXE',0         ; DATA XREF: fopen-330o
aStart_0	db 6,' START'
		db  0Dh
aStop_0		db 5,' STOP'            ; DATA XREF: fopen-32Ao
asc_120CB	db 0Dh,0		; DATA XREF: fopen-32Do
		db    0
word_120CE	dw 0			; DATA XREF: fopen-32Aw
word_120D0	dw 0			; DATA XREF: fopen-324w
word_120D2	dw 0			; DATA XREF: fopen-320w
word_120D4	dw 0			; DATA XREF: fopen-31Aw
word_120D6	dw 0			; DATA XREF: fopen-316w
word_120D8	dw 0			; DATA XREF: fopen-310w
byte_120DA	db 0			; DATA XREF: sub_1F6DBw
					; sub_1F6DB:loc_1F711r	...
off_120DB	dw offset byte_120E3	; 0 ; DATA XREF: sub_1F5D9+9o
		dw offset byte_120FB	; 1
		dw offset byte_12113	; 2
		dw offset byte_1212B	; 3
byte_120E3	db  -1,	 0		; DATA XREF: seg000:off_120DBo
		db   0,	 0
		db   1,	 0
		db  -1,	 1
		db   0,	 1
		db   1,	 1
		db  -1,	 2
		db   0,	 2
		db   1,	 2
		db  -1,	 3
		db   0,	 3
		db   1,	 3
byte_120FB	db   0,	-1		; DATA XREF: seg000:off_120DBo
		db   0,	 0
		db   0,	 1
		db  -1,	-1
		db  -1,	 0
		db  -1,	 1
		db  -2,	-1
		db  -2,	 0
		db  -2,	 1
		db  -3,	-1
		db  -3,	 0
		db  -3,	 1
byte_12113	db   1,	 0		; DATA XREF: seg000:off_120DBo
		db   0,	 0
		db  -1,	 0
		db   1,	-1
		db   0,	-1
		db  -1,	-1
		db   1,	-2
		db   0,	-2
		db  -1,	-2
		db   1,	-3
		db   0,	-3
		db  -1,	-3
byte_1212B	db   0,	 1		; DATA XREF: seg000:off_120DBo
		db   0,	 0
		db   0,	-1
		db   1,	 1
		db   1,	 0
		db   1,	-1
		db   2,	 1
		db   2,	 0
		db   2,	-1
		db   3,	 1
		db   3,	 0
		db   3,	-1
byte_12143	db 3, 0, 1, 2		; DATA XREF: sub_1F6DB+C8o
		db 0, 1, 2, 3
		db 1, 2, 3, 0
		db 2, 3, 0, 1
off_12153	dw offset loc_1F805, offset sub_1F580 ;	DATA XREF: sub_1F6DB+D6o
		dw offset loc_1F819, offset sub_1F580
		dw offset loc_1F82B, offset sub_1F580
		dw offset loc_1F83D, offset sub_1F580
byte_12163	db 0			; DATA XREF: DrawNumberFW_03+12w
					; DrawDigitFW_0+12w ...
aDir		db 'DIR='               ; DATA XREF: seg001:253Eo
		db 0FFh
aFloor		db 'FLOOR='             ; DATA XREF: seg001:252Fo
		db 0FFh
off_12170	dw offset aDungeonDataD1_; 0 ; DATA XREF: ReadFileDMAP+Ao
		dw offset aDungeonDataD2_; 1 ; "\\DUNGEON\\DATA\\D1.MAP"
		dw offset aDungeonDataD3_; 2
		dw offset aDungeonDataD4_; 3
		dw offset aDungeonDataD5_; 4
aDungeonDataD1_	db '\DUNGEON\DATA\D1.MAP',0 ; DATA XREF: seg000:off_12170o
		db 0Dh,0Ah,'$'
aDungeonDataD2_	db '\DUNGEON\DATA\D2.MAP',0 ; DATA XREF: seg000:off_12170o
		db 0Dh,0Ah,'$'
aDungeonDataD3_	db '\DUNGEON\DATA\D3.MAP',0 ; DATA XREF: seg000:off_12170o
		db 0Dh,0Ah,'$'
aDungeonDataD4_	db '\DUNGEON\DATA\D4.MAP',0 ; DATA XREF: seg000:off_12170o
		db 0Dh,0Ah,'$'
aDungeonDataD5_	db '\DUNGEON\DATA\D5.MAP',0 ; DATA XREF: seg000:off_12170o
		db 0Dh,0Ah,'$'
off_121F2	dw offset aDungeonDataD_0; 0 ; DATA XREF: ReadFileDEVE+9o
		dw offset aDungeonDataD_1; 1 ; "\\DUNGEON\\DATA\\D1.EVE"
		dw offset aDungeonDataD_2; 2
		dw offset aDungeonDataD_3; 3
		dw offset aDungeonDataD_4; 4
aDungeonDataD_0	db '\DUNGEON\DATA\D1.EVE',0 ; DATA XREF: seg000:off_121F2o
		db 0Dh,0Ah,'$'
aDungeonDataD_1	db '\DUNGEON\DATA\D2.EVE',0 ; DATA XREF: seg000:off_121F2o
		db 0Dh,0Ah,'$'
aDungeonDataD_2	db '\DUNGEON\DATA\D3.EVE',0 ; DATA XREF: seg000:off_121F2o
		db 0Dh,0Ah,'$'
aDungeonDataD_3	db '\DUNGEON\DATA\D4.EVE',0 ; DATA XREF: seg000:off_121F2o
		db 0Dh,0Ah,'$'
aDungeonDataD_4	db '\DUNGEON\DATA\D5.EVE',0 ; DATA XREF: seg000:off_121F2o
		db 0Dh,0Ah,'$'
off_12274	dw offset aDungeonDataM1_; 0 ; DATA XREF: ReadFileMDAT+Ao
		dw offset aDungeonDataM2_; 1 ; "\\DUNGEON\\DATA\\M1.DAT"
		dw offset aDungeonDataM3_; 2
		dw offset aDungeonDataM4_; 3
		dw offset aDungeonDataM5_; 4
aDungeonDataM1_	db '\DUNGEON\DATA\M1.DAT',0 ; DATA XREF: seg000:off_12274o
		db 0Dh,0Ah,'$'
aDungeonDataM2_	db '\DUNGEON\DATA\M2.DAT',0 ; DATA XREF: seg000:off_12274o
		db 0Dh,0Ah,'$'
aDungeonDataM3_	db '\DUNGEON\DATA\M3.DAT',0 ; DATA XREF: seg000:off_12274o
		db 0Dh,0Ah,'$'
aDungeonDataM4_	db '\DUNGEON\DATA\M4.DAT',0 ; DATA XREF: seg000:off_12274o
		db 0Dh,0Ah,'$'
aDungeonDataM5_	db '\DUNGEON\DATA\M5.DAT',0 ; DATA XREF: seg000:off_12274o
		db 0Dh,0Ah,'$'
aDungeonDataM6_	db '\DUNGEON\DATA\M6.DAT',0
		db 0Dh,0Ah,'$'
fileReadBuffer	dw 0			; DATA XREF: ReadFileDMAP+10o
					; ReadFileDEVE+10o ...
		db 1FEh	dup(0)
word_1250E	dw 0			; DATA XREF: ReadFileDMAP+28r
					; ReadFileDMAP+46r ...
word_12510	dw 0			; DATA XREF: ReadFileDMAP+20r
					; ReadFileDEVE+20r ...
word_12512	dw 0			; DATA XREF: start:loc_1F0EBw
					; ReadFileDMAP+1Cr ...
a_map		db '.MAP',0
a_eve		db 0Dh,0Ah,'$'
a_eve_0		db '.EVE',0
		db 0Dh,0Ah,'$'
aDungeonPutMove	db 'Dungeon Put & Move Routine',0Dh,0Ah ; DATA XREF: fopen+41o
		db 'DUNGEON',0Dh,0Ah,'$'
aVdvwvdvbvOFsvV	db 'ÇdÇwÇdÇbÇ…é∏îsÇµÇ‹ÇµÇΩÅB',0Dh,0Ah,'$' ; DATA XREF: fopen+88o
aGbgvgkbVkxNxvV	db 'ÉÅÉÇÉäÅ|Ç™ïœçXÇ≈Ç´Ç‹ÇπÇÒÅB',0Dh,0Ah,'$' ; DATA XREF: fopen+67o
aGbgvgkbVkkmxVV	db 'ÉÅÉÇÉäÅ[Ç™ämï€Ç≈Ç´Ç‹ÇπÇÒÅB',0Dh,0Ah,'$' ; DATA XREF: start+DC7o
aGbgvgkbVIXVOFs	db 'ÉÅÉÇÉäÅ[ÇÃâï˙Ç…é∏îsÇµÇ‹ÇµÇΩÅB',0Dh,0Ah,'$' ; DATA XREF: seg001:2B12o
aGtg@gcglvkgibG	db 'ÉtÉ@ÉCÉãÇ™ÉIÅ[ÉvÉìÇ≈Ç´Ç‹ÇπÇÒÅB',0Dh,0Ah,'$' ; DATA XREF: fopen+A6o
aGfbGVUVNuvTjvG	db 'ÉfÅ[É^Çì«Ç›çûÇ›íÜÇ…ÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇΩÅB',0Dh,0Ah,'$'
					; DATA XREF: fopen+CEo
aERROR		db 'ÇdÇqÇqÇnÇqÅ@',0,0,0Dh,0Ah,'$' ; DATA XREF: fopen+5Do
					; fopen+7Eo ...
aExtErrorCodes	db 'ägí£ÉGÉâÅ|ÉRÅ|ÉhÅ@',0,0,0Dh,0Ah ; DATA XREF: sub_1FE7C+30o
					; Extended error codes
aGggibGngigxb@	db 'ÉGÉâÅ|ÉNÉâÉXÅ@',0,0,0Dh,0Ah ; DATA XREF: sub_1FE7C+15w
aIFVSPib@	db 'â¬î\Ç»ëŒèàÅ@',0,0,0Dh,0Ah ; DATA XREF: sub_1FE7C+21w
aXtiPuxB@	db 'ïtâ¡èÓïÒÅ@',0,0,0Dh,0Ah,'$' ; DATA XREF: sub_1FE7C+2Dw
byte_12666	db 4B00h dup(0)		; DATA XREF: sub_2035B+1Do
					; sub_203BF+1Eo ...
aCamp		db 'ÇbÅ@Ç`Å@ÇlÅ@Ço',0Ah ; CAMP
aActionsPlr	db 'ÇΩÅ@ÇΩÅ@Ç©Å@Ç§',1Ch ; DATA XREF: Battle_GetPlrActiono
					; Attack
		db 'Å@Ç‹Å@Ç‡Å@ÇÈÅ@',1Ch ; Defend
		db 'Å@Ç…Å@Ç∞Å@ÇÈÅ@',0Ah ; Run Away
aActionsFin	db 'Ç©Å@Ç¢Å@Ç”Å@Ç≠',1Ch ; DATA XREF: Battle_GetPlrAction+18o
					; Heal
		db 'Ç⁄Å@Ç§Å@Ç¨Å@ÇÂ',1Ch ; Guard
		db 'Ç±Å@Ç§Å@Ç∞Å@Ç´',0Ah ; Blast
aActionsDebug	db 'Ç†Å@Ç¢Å@ÇƒÅ@Çﬁ',1Ch ; Item
		db 'Å@Ç‹Å@ÇŸÅ@Ç§Å@',1Ch ; Magic
		db 'Ç≈Å@Ç°Å@Ç∑Å@Ç≠',0Ah ; Disk
asc_171FC	db 'ÉRÉ}ÉìÉhÅ@ÇPÅ@',1Ch ; DATA XREF: seg001:311Co
					; Command 1
		db 'ÉRÉ}ÉìÉhÅ@ÇQÅ@',1Ch ; Command 2
		db 'ÉRÉ}ÉìÉhÅ@ÇRÅ@',1Ch ; Command 3
		db 'ÉRÉ}ÉìÉhÅ@ÇSÅ@',1Ch ; Command 4
		db 'ÉRÉ}ÉìÉhÅ@ÇTÅ@',1Ch ; Command 5
		db '0ÉRÉ}ÉìÉhÅ@ÇUÅ@',1Ch ; Command 6
		db 'ÉRÉ}ÉìÉhÅ@ÇVÅ@',1Ch ; Command 7
		db 'ÉRÉ}ÉìÉhÅ@ÇWÅ@',1Ch ; Command 8
		db 'ÉRÉ}ÉìÉhÅ@ÇXÅ@',1Ch ; Command 9
		db 'ÉRÉ}ÉìÉhÅ@ÇPÇO',0Ah ; Command 10
		dw seg seg000
word_17295	dw 0A800h		; DATA XREF: sub_20272+1r sub_20295+1r
word_17297	dw 0B000h		; DATA XREF: sub_20272+8r
word_17299	dw 0B800h		; DATA XREF: sub_20272+Fr
		dw 0E000h
byte_1729D	db 0			; DATA XREF: sub_1FED7+9w
					; sub_1FED7+2Aw ...
byte_1729E	db 0			; DATA XREF: sub_202EC+11w
					; sub_202EC+25r ...
byte_1729F	db 0			; DATA XREF: sub_1FF47+18w
					; sub_1FF47+32w ...
		db    0
byte_172A1	db 0			; DATA XREF: sub_1FED7+18w
					; sub_1FED7+23w ...
byte_172A2	db 4			; DATA XREF: sub_1FED7+3r
byte_172A3	db 0			; DATA XREF: sub_20096+10r
					; sub_20096+1Ew ...
		db 1Bh dup(0)
byte_172BF	db 0Ch dup(0)		; DATA XREF: seg001:2567o
byte_172CB	db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 1, 2, 3,	6, 7, 8
					; DATA XREF: sub_1F6DB:loc_1F76Er
					; seg001:2573o
		db 13, 14, 15, 20, 21, 22, 4, 0, 9, 10,	16, 17,	23, 24
		db 5, 0, 12, 11, 19, 18, 26, 25
		dw offset byte_17327	; 0
		dw offset byte_1732C	; 1
		dw offset byte_17331	; 2
		dw offset byte_17337	; 3
		dw offset byte_1733C	; 4
		dw offset byte_17341	; 5
		dw offset byte_17347	; 6
		dw offset byte_1734D	; 7
		dw offset byte_17353	; 8
		dw offset byte_17358	; 9
		dw offset byte_1735D	; 10
		dw offset byte_17362	; 11
		dw offset byte_17367	; 12
		dw offset byte_1736D	; 13
		dw offset byte_17373	; 14
		dw offset byte_17379	; 15
		dw offset byte_1737E	; 16
		dw offset byte_17383	; 17
		dw offset byte_17388	; 18
		dw offset byte_1738D	; 19
		dw offset byte_17393	; 20
		dw offset byte_17399	; 21
		dw offset byte_1739F	; 22
		dw offset byte_173A4	; 23
		dw offset byte_173A9	; 24
		dw offset byte_173AE	; 25
byte_17327	db 2, -1, -1, 1, -1	; DATA XREF: seg000:72F3o
byte_1732C	db 9, -1, -1, 8, -1	; DATA XREF: seg000:72F3o
byte_17331	db 2, 9, -1, 2,	-1, -1	; DATA XREF: seg000:72F3o
byte_17337	db 2, -1, 1, -1, -1	; DATA XREF: seg000:72F3o
byte_1733C	db 9, -1, 3, -1, -1	; DATA XREF: seg000:72F3o
byte_17341	db 2, 3, -1, -1, 2, -1	; DATA XREF: seg000:72F3o
byte_17347	db 9, 8, -1, -1, 7, -1	; DATA XREF: seg000:72F3o
byte_1734D	db 3, 8, -1, 6,	-1, -1	; DATA XREF: seg000:72F3o
byte_17353	db 11, -1, 4, -1, -1	; DATA XREF: seg000:72F3o
byte_17358	db 3, -1, 5, -1, -1	; DATA XREF: seg000:72F3o
byte_1735D	db 8, -1, 7, -1, -1	; DATA XREF: seg000:72F3o
byte_17362	db 12, -1, 8, -1, -1	; DATA XREF: seg000:72F3o
byte_17367	db 3, 4, -1, -1, 3, -1	; DATA XREF: seg000:72F3o
byte_1736D	db 8, 7, -1, -1, 6, -1	; DATA XREF: seg000:72F3o
byte_17373	db 4, 7, -1, 11, -1, -1	; DATA XREF: seg000:72F3o
byte_17379	db 13, -1, 9, -1, -1	; DATA XREF: seg000:72F3o
byte_1737E	db 4, -1, 10, -1, -1	; DATA XREF: seg000:72F3o
byte_17383	db 7, -1, 12, -1, -1	; DATA XREF: seg000:72F3o
byte_17388	db 14, -1, 13, -1, -1	; DATA XREF: seg000:72F3o
byte_1738D	db 4, 5, -1, -1, 4, -1	; DATA XREF: seg000:72F3o
byte_17393	db 7, 6, -1, -1, 5, -1	; DATA XREF: seg000:72F3o
byte_17399	db 5, 6, -1, 16, -1, -1	; DATA XREF: seg000:72F3o
byte_1739F	db 15, -1, 14, -1, -1	; DATA XREF: seg000:72F3o
byte_173A4	db 5, -1, 15, -1, -1	; DATA XREF: seg000:72F3o
byte_173A9	db 6, -1, 17, -1, -1	; DATA XREF: seg000:72F3o
byte_173AE	db 16, -1, 18, -1, -1	; DATA XREF: seg000:72F3o
		db 0FDh,   0
		db  0Dh, 20h
		db  15h, 60h
		db  19h, 80h
		db  1Bh, 90h
		db  1Fh, 90h
		db  21h, 80h
		db  25h, 60h
		db  2Dh, 20h
		db  3Dh,   0
		db    5, 60h
		db  35h, 60h
		db  11h, 80h
		db  29h, 80h
		db  17h, 90h
		db  23h, 90h
		db  40h,   7, 0Dh
		db  4Dh,   7, 20h
		db  6Dh,   7, 0Dh
		db 0C5h, 15h,	8
		db 0CDh, 15h,	8
		db 0D5h, 15h, 10h
		db 0E5h, 15h,	8
		db 0EDh, 15h,	8
		db  11h, 1Dh,	4
		db  15h, 1Dh,	4
		db  19h, 1Dh,	8
		db  21h, 1Dh,	4
		db  25h, 1Dh,	4
		db 0B7h, 20h,	2
		db 0B9h, 20h,	2
		db 0BBh, 20h,	4
		db 0BFh, 20h,	2
		db 0C1h, 20h,	2
		db    0,   4
		db    4,   8
		db  0Ch,   4
		db  10h,   2
		db  15h,   2
		db  17h,   4
		db  1Bh,   8
		db  23h,   4
		dw offset byte_1744D	; 0
		dw offset byte_17453	; 1
		dw offset byte_17459	; 2
		dw offset byte_1745F	; 3
		dw offset byte_17464	; 4
		dw offset byte_17469	; 5
		dw offset byte_1746F	; 6
		dw offset byte_17475	; 7
		dw offset byte_1747B	; 8
		dw offset byte_17480	; 9
		dw offset byte_17485	; 10
		dw offset byte_1748A	; 11
		dw offset byte_1748F	; 12
		dw offset byte_17495	; 13
		dw offset byte_1749B	; 14
		dw offset byte_174A1	; 15
		dw offset byte_174A6	; 16
		dw offset byte_174AB	; 17
		dw offset byte_174B0	; 18
		dw offset byte_174B5	; 19
		dw offset byte_174B8	; 20
		dw offset byte_174BB	; 21
		dw offset byte_174C1	; 22
		dw offset byte_174C6	; 23
		dw offset byte_174CB	; 24
		dw offset byte_174D0	; 25
byte_1744D	db 1, 2, -1, -1, 1, -1	; DATA XREF: seg000:7419o
byte_17453	db 3, 4, -1, -1, 2, -1	; DATA XREF: seg000:7419o
byte_17459	db 6, 7, -1, 2,	-1, -1	; DATA XREF: seg000:7419o
byte_1745F	db 5, -1, 1, -1, -1	; DATA XREF: seg000:7419o
byte_17464	db 8, -1, 3, -1, -1	; DATA XREF: seg000:7419o
byte_17469	db 9, 10, -1, -1, 3, -1	; DATA XREF: seg000:7419o
byte_1746F	db 11, 12, -1, -1, 4, -1 ; DATA	XREF: seg000:7419o
byte_17475	db 15, 16, -1, 6, -1, -1 ; DATA	XREF: seg000:7419o
byte_1747B	db 13, -1, 4, -1, -1	; DATA XREF: seg000:7419o
byte_17480	db 14, -1, 5, -1, -1	; DATA XREF: seg000:7419o
byte_17485	db 17, -1, 7, -1, -1	; DATA XREF: seg000:7419o
byte_1748A	db 18, -1, 8, -1, -1	; DATA XREF: seg000:7419o
byte_1748F	db 19, 20, -1, -1, 5, -1 ; DATA	XREF: seg000:7419o
byte_17495	db 21, 22, -1, -1, 6, -1 ; DATA	XREF: seg000:7419o
byte_1749B	db 25, 26, -1, 11, -1, -1 ; DATA XREF: seg000:7419o
byte_174A1	db 23, -1, 9, -1, -1	; DATA XREF: seg000:7419o
byte_174A6	db 24, -1, 10, -1, -1	; DATA XREF: seg000:7419o
byte_174AB	db 27, -1, 12, -1, -1	; DATA XREF: seg000:7419o
byte_174B0	db 28, -1, 13, -1, -1	; DATA XREF: seg000:7419o
byte_174B5	db 80h,	0E9h, 1Eh	; DATA XREF: seg000:7419o
byte_174B8	db 81h,	29h, 1Fh	; DATA XREF: seg000:7419o
byte_174BB	db 31, 32, -1, 16, -1, -1 ; DATA XREF: seg000:7419o
byte_174C1	db 29, -1, 14, -1, -1	; DATA XREF: seg000:7419o
byte_174C6	db 30, -1, 15, -1, -1	; DATA XREF: seg000:7419o
byte_174CB	db 33, -1, 17, -1, -1	; DATA XREF: seg000:7419o
byte_174D0	db 34, -1, 18, -1, -1	; DATA XREF: seg000:7419o
		db    1,   0, 50h,   0
		db  49h,   7, 48h,   0
		db  39h,   0, 50h,   1
		db  71h,   7, 48h,   1
		db 0C5h, 15h, 30h,   0
		db 0D5h, 15h, 30h,   0
		db 0E5h, 15h, 30h,   1
		db 0F5h, 15h, 30h,   1
		db  8Fh, 0Eh, 34h,   0
		db 0D3h, 15h, 24h,   0
		db 0E7h, 15h, 24h,   1
		db 0ABh, 0Eh, 34h,   1
		db    9, 1Dh, 18h,   0
		db  11h, 1Dh, 18h,   0
		db  19h, 1Dh, 18h,   0
		db  21h, 1Dh, 18h,   1
		db  29h, 1Dh, 18h,   1
		db  31h, 1Dh, 18h,   1
		db  76h, 19h, 1Ah,   0
		db  18h, 1Dh, 12h,   0
		db  22h, 1Dh, 12h,   1
		db  84h, 19h, 1Ah,   1
		db 0B3h, 20h, 0Ch,   0
		db 0B7h, 20h, 0Ch,   0
		db 0BBh, 20h, 0Ch,   0
		db 0BFh, 20h, 0Ch,   1
		db 0C3h, 20h, 0Ch,   1
		db 0C7h, 20h, 0Ch,   1
		db  88h, 22h,	6,   0
		db  8Ah, 22h,	6,   0
		db  8Ch, 22h,	6,   1
		db  8Eh, 22h,	6,   1
		db  90h, 22h,	6,   1
		db  92h, 22h,	6,   1
byte_1755D	db 0C0h, 15h,	5	; DATA XREF: sub_2035B+11o
		db 0D5h, 15h, 10h
		db 0F5h, 15h,	5
		db    9, 1Dh,	4
		db  0Dh, 1Dh,	4
		db  19h, 1Dh,	8
		db  29h, 1Dh,	4
		db  2Dh, 1Dh,	4
		db 0B3h, 20h,	2
		db 0B5h, 20h,	2
		db 0BBh, 20h,	4
		db 0C3h, 20h,	2
		db 0C5h, 20h,	2
		db  88h, 22h,	1
		db  89h, 22h,	1
		db  8Ch, 22h,	2
		db  90h, 22h,	1
		db  91h, 22h,	1
byte_17593	db    5,   0,	4	; DATA XREF: sub_20382+11o
		db  31h,   4,	4
		db  0Fh,   8,	4
		db  27h, 0Ch,	4
		db  16h, 0Eh,	2
		db  22h, 10h,	2
		db  19h, 11h,	2
		db  1Fh, 12h,	2
byte_175AB	db  0Ch,   0		; DATA XREF: sub_20402+2o
		db  0Ch,   0
		db  0Fh,   0
		db  0Fh,   0
		db  0Ch,0C0h
		db  0Ch,0C0h
		db  0Ch, 30h
		db  0Ch, 30h
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch,   0
		db  0Ch, 30h
byte_17615	db    0, 0Ch		; DATA XREF: sub_2041F+2o
		db    0, 0Ch
		db    0, 3Ch
		db    0, 3Ch
		db    0,0CCh
		db    0,0CCh
		db    3, 0Ch
		db    3, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db  0Ch, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ch
		db    0, 0Ah
aClumsy		db 'ÉwÉ^ÉNÉ\Å@ÅIÅIÅI',0Dh,0Ah,'$'
a000000h	db 1Bh,'[000;000H$'
byte_17699	db 0, 0, 0, 0		; DATA XREF: GetRandom_Range+5o
word_1769D	dw 0			; DATA XREF: RNG_GetNext+3r
					; RNG_GetNext+7r
word_1769F	dw 0			; DATA XREF: RNG_GetNext+Br
					; RNG_GetNext+Fw
word_176A1	dw 0C8ECh		; DATA XREF: RNG_GetNext+24w
					; RNG_GetNext+28r
word_176A3	dw 0AE2h		; DATA XREF: RNG_GetNext+14r
					; RNG_Advance+21r ...
word_176A5	dw 3FFFh		; DATA XREF: RNG_GetNext+18r
					; RNG_Advance+17r ...
word_176A7	dw 0FD2Dh		; DATA XREF: RNG_GetNext+1Cr
					; RNG_Advance+Dr ...
word_176A9	dw 0A512h		; DATA XREF: RNG_GetNext+20r
					; RNG_Advancew	...
rngRolls	dw 0			; DATA XREF: ShowItemObtain+1C5w
					; ShowItemObtain+216w ...
rngRange	dw 0			; DATA XREF: ShowItemObtain+1CBw
					; ShowItemObtain+21Cw ...
rngBaseVal	dw 0			; DATA XREF: ShowItemObtain+1D1w
					; ShowItemObtain+222w ...
rngBitMask	dw 0FFFFh		; DATA XREF: ShowItemObtain+1D7w
					; ShowItemObtain+228w ...
		align 10h
byte_176C0	db 280h	dup(0)		; DATA XREF: seg001:3A00o seg001:3A26o ...
mesFilePath	db 28h dup(0)		; DATA XREF: ExecMESFile+Co
off_17968	dw offset off_1799E	; 0 ; DATA XREF: DrawDialogText+149o
					; DrawDialogText+162o ...
		dw offset MESVars	; 1
		dw offset byte_179E4	; 2
		dw offset byte_179EE	; 3
		dw offset byte_179F8	; 4
		dw offset byte_17A02	; 5
		dw offset byte_17A0C	; 6
		dw offset byte_17A16	; 7
		dw offset byte_17A20	; 8
		dw offset byte_17A2A	; 9
		dw offset byte_17A34	; 10
		dw offset byte_17A3E	; 11
		dw offset byte_17A48	; 12
		dw offset byte_17A52	; 13
		dw 0
		dw offset byte_17A5C
		dw offset byte_17A66
		dw offset byte_17A70
		dw offset byte_17A7A
word_1798E	dw 0			; DATA XREF: ExecMESFile+8w
					; seg001:3476w	...
		dw offset byte_17A84
		dw offset byte_17A8E
		dw 0
		dw offset byte_17A98
		dw offset byte_17AA2
		dw offset byte_17AAC
		dw offset byte_17AB6
off_1799E	dw offset byte_17AC0	; DATA XREF: seg000:off_17968o
					; ExecMESFile+1Cr ...
		dw 0
off_179A2	dw offset byte_17AC0	; DATA XREF: seg001:3959r
					; seg001:loc_20CC0r ...
		dw 0
		dw 0
word_179A8	dw 0Ah			; DATA XREF: sub_209D2+16r
					; sub_2101D+9r
word_179AA	dw 0CF80h		; DATA XREF: DrawSJISChar_D+2Dr
					; DrawJISChar+8r
word_179AC	dw 5			; DATA XREF: seg001:38A5r
word_179AE	dw 0			; DATA XREF: DrawDialogText+C1r
					; DrawDialogText+114r
byte_179B0	db 5			; DATA XREF: seg001:345Er
					; sub_2091B+15r ...
byte_179B1	db 0Eh			; DATA XREF: sub_208CC+21r
					; sub_209D2+12r
word_179B2	dw 60, 20		; DATA XREF: sub_208CC+8o
					; sub_2091B+5Co
		dw 60, 30
		dw 60, 40
		dw 60, 50
		dw 60, 60
		dw 60, 70
		dw 60, 80
		dw 60, 90
		dw 60, 100
		dw 60, 110
MESVars		db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
					; Vars_MES2Dgno ...
byte_179E4	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_179EE	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_179F8	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A02	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A0C	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A16	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A20	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A2A	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A34	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A3E	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A48	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A52	db 0Ah dup(0)		; DATA XREF: seg000:off_17968o
byte_17A5C	db 0Ah dup(0)		; DATA XREF: seg000:7986o
byte_17A66	db 0Ah dup(0)		; DATA XREF: seg000:7986o
byte_17A70	db 0Ah dup(0)		; DATA XREF: seg000:7986o
byte_17A7A	db 0Ah dup(0)		; DATA XREF: seg000:7986o
byte_17A84	db 0Ah dup(0)		; DATA XREF: seg000:7990o
byte_17A8E	db 0Ah dup(0)		; DATA XREF: seg000:7990o
byte_17A98	db 0Ah dup(0)		; DATA XREF: seg000:7996o
byte_17AA2	db 0Ah dup(0)		; DATA XREF: seg000:7996o
byte_17AAC	db 0Ah dup(0)		; DATA XREF: seg000:7996o
byte_17AB6	db 0Ah dup(0)		; DATA XREF: seg000:7996o
byte_17AC0	db 5000h dup(0)		; DATA XREF: seg000:off_1799Eo
					; seg000:off_179A2o
word_1CAC0	dw 0			; DATA XREF: sub_2058F+2w seg001:3709r
word_1CAC2	dw 8801h		; DATA XREF: sub_21078+8r sub_21078+Cw
byte_1CAC4	db 0			; DATA XREF: sub_21040+1w sub_21040+Cw ...
word_1CAC5	dw 0			; DATA XREF: seg001:37D7w seg001:382Dr ...
word_1CAC7	dw 0			; DATA XREF: seg001:37DEw seg001:3831r ...
word_1CAC9	dw 4Fh			; DATA XREF: seg001:37E5w seg001:3839r ...
word_1CACB	dw 18Fh			; DATA XREF: seg001:37ECw seg001:3842r ...
word_1CACD	dw 5			; DATA XREF: DrawDialogText:loc_20639r
					; DrawDialogText+FDr ...
word_1CACF	dw 64h			; DATA XREF: DrawDialogText+A9r
					; DrawDialogText+101r ...
byte_1CAD1	db 0			; DATA XREF: DrawDialogText+B6r
					; DrawDialogText+CEr ...
byte_1CAD2	db 6			; DATA XREF: DrawDialogText+BAr
					; DrawDialogText+10Cr ...
		db 28h dup(0)
byte_1CAFB	db 0Ah dup(0)		; DATA XREF: sub_2091Bo sub_2091B+59o
		db 0FFh
word_1CB06	dw 0			; DATA XREF: seg001:loc_207CAw
					; sub_207DF+7Er
word_1CB08	dw 0			; DATA XREF: seg001:loc_207ACw
					; seg001:346Dw	...
word_1CB0A	dw 0			; DATA XREF: sub_207DF+3w
					; sub_207DF+23r ...
word_1CB0C	dw 0			; DATA XREF: seg001:36F2w seg001:374Dr ...
word_1CB0E	dw 0			; DATA XREF: seg001:36ECw seg001:3743r ...
word_1CB10	dw 0			; DATA XREF: DrawDialogText+23r
					; DrawDialogText+32w ...
word_1CB12	dw 0			; DATA XREF: DrawDialogText+2Ar
					; DrawDialogText+38r ...
byte_1CB14	db 32h dup(0)		; DATA XREF: seg001:38B7o seg001:38D4o
byte_1CB46	db 80h dup(0)		; DATA XREF: seg001:38F4o seg001:3B3Bo ...
word_1CBC6	dw 0			; DATA XREF: seg001:3A1Cw seg001:3A1Fr ...
aFlag0		db 'FLAG0',0            ; DATA XREF: seg001:39FDo seg001:3A15o ...
dword_1CBCE	dd 0			; DATA XREF: seg001:3900w seg001:3932r ...
byte_1CBD2	db 0			; DATA XREF: DrawDialogText+3r
					; DrawDialogText+Aw ...
		db 28h dup(0)
word_1CBFB	dw 0			; DATA XREF: seg001:3903o seg001:391Er
word_1CBFD	dw 0			; DATA XREF: seg001:3922r
word_1CBFF	dw 0			; DATA XREF: seg001:3926r
word_1CC01	dw 0			; DATA XREF: seg001:392Ar
word_1CC03	dw 0			; DATA XREF: seg001:392Er
word_1CC05	dw 0			; DATA XREF: seg001:3A44w sub_20E08+4r
word_1CC07	dw 0			; DATA XREF: seg001:3A52w
					; sub_20E08:loc_20E13r
word_1CC09	dw 0			; DATA XREF: seg001:3A4Bw
					; sub_20E08+18r
word_1CC0B	dw 0			; DATA XREF: seg001:3A58w
					; sub_20E08:loc_20E27r
		db 0, 0, 0, 0
word_1CC11	dw 0			; DATA XREF: seg001:3A3Dw
					; sub_20E08+69r
		db 1, 2, 4, 8, 10h, 20h, 40h, 80h
byte_1CC1B	db    1,   1,	5,   2,	  9,   3, 0Dh,	 4, 11h,   5
					; DATA XREF: sub_20DC3+7o
		db    2,   1,	6,   2,	0Ah,   3, 0Eh,	 4, 12h,   5
		db    3,   1,	7,   2,	0Bh,   3, 0Fh,	 4, 13h,   5
		db    4,   1,	8,   2,	0Ch,   3, 10h,	 4,   1,   5
		db    5,   1,	9,   2,	0Dh,   3, 11h,	 4,   2,   5
		db    6,   1, 0Ah,   2,	0Eh,   3, 12h,	 4,   3,   5
		db    7,   1, 0Bh,   2,	0Fh,   3, 13h,	 4,   4,   5
		db    8,   1, 0Ch,   2,	10h,   3,   1,	 4,   5,   5
		db    9,   1, 0Dh,   2,	11h,   3,   2,	 4,   6,   5
		db  0Ah,   1, 0Eh,   2,	12h,   3,   3,	 4,   7,   5
		db  0Bh,   1, 0Fh,   2,	13h,   3,   4,	 4,   8,   5
		db  0Ch,   1, 10h,   2,	  1,   3,   5,	 4,   9,   5
		db  0Dh,   1, 11h,   2,	  2,   3,   6,	 4, 0Ah,   5
		db  0Eh,   1, 12h,   2,	  3,   3,   7,	 4, 0Bh,   5
		db  0Fh,   1, 13h,   2,	  4,   3,   8,	 4, 0Ch,   5
		db  10h,   1,	1,   2,	  5,   3,   9,	 4, 0Dh,   5
		db  11h,   1,	2,   2,	  6,   3, 0Ah,	 4, 0Eh,   5
		db  12h,   1,	3,   2,	  7,   3, 0Bh,	 4, 0Fh,   5
		db  13h,   1,	4,   2,	  8,   3, 0Ch,	 4, 10h,   5
		db 0FFh,0FFh
byte_1CCDB	db 9			; DATA XREF: ExecMESFile+60w
					; DrawDialogText+D1r ...
byte_1CCDC	db 9			; DATA XREF: ExecMESFile+65w
					; DrawDialogText+E2r ...
word_1CCDD	dw 0			; DATA XREF: sub_21581+13w
					; sub_21734+13w ...
word_1CCDF	dw 0			; DATA XREF: sub_21581+1Ew
					; sub_21734+1Ew ...
		dw 0
word_1CCE3	dw 0			; DATA XREF: sub_2162A:loc_2163Ar
					; sub_21823:loc_21837r
word_1CCE5	dw 0			; DATA XREF: sub_21581+27w
					; sub_2162A+E8r ...
word_1CCE7	dw 0			; DATA XREF: sub_21581+2Fw
					; sub_2162A+7r	...
		dw 0
		dw 0
word_1CCED	dw 0			; DATA XREF: sub_21581w sub_2162A+16r	...
word_1CCEF	dw 0			; DATA XREF: sub_21581+6w sub_2162Ar ...
byte_1CCF1	db 4			; DATA XREF: sub_21568+9w
					; sub_2162A+3Br
byte_1CCF2	db 258h	dup(0)		; DATA XREF: sub_2162A+33o
					; sub_2162A+CEo ...
byte_1CF4A	db 258h	dup(0)		; DATA XREF: sub_2162A+D1o
a000000h_0	db 1Bh,'[000;000H$'     ; DATA XREF: seg001:47B5o seg001:4889o ...
a000c		db 1Bh,'[000C$'
a30m		db 1Bh,'[30m$'
a34m		db 1Bh,'[34m$'
a31m		db 1Bh,'[31m$'
a35m		db 1Bh,'[35m$'
a32m		db 1Bh,'[32m$'
a36m		db 1Bh,'[36m$'
a33m		db 1Bh,'[33m$'
a37m		db 1Bh,'[37m$'
a40m		db 1Bh,'[40m$'
a44m		db 1Bh,'[44m$'
a41m		db 1Bh,'[41m$'
a45m		db 1Bh,'[45m$'
a42m		db 1Bh,'[42m$'
a46m		db 1Bh,'[46m$'
a43m		db 1Bh,'[43m$'
a47m		db 1Bh,'[47m$'
aAdvi_exe	db 'ADVI.EXE',0
aVevsvevgcpgbgv	db 'ÇÖÇòÇÖÇÉópÉÅÉÇÉäÅ[Çämï€Ç≈Ç´Ç‹ÇπÇÒ',0Dh,0Ah,'$'
hFileMES	dw 0			; DATA XREF: ReadMESFile:loc_21360w
					; ReadMESFile+24r ...
aGtg@gcglvUVNuv	db 'ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩÅB',0Dh,0Ah,'$'
					; DATA XREF: ReadMESFile+10o
					; ReadMESFile+54o
aVVcvovVjvVbvVV	db 'Ç”ÇÁÇÆÇÇ¶Ç≈Ç°Ç¡Ç∆Ç∑ÇÈÇ‡Å[Ç«$'
aNowEditNo	db 'NOW EDIT No = $'
word_1D295	dw 0			; DATA XREF: seg001:45B1r seg001:45B9w ...
aVVVVVVjvVbvVVV	db 'ÇÍÇ∂Ç∑ÇΩÇÃÇ¶Ç≈Ç°Ç¡Ç∆ÇﬁÇßÅ[Ç«$' ; DATA XREF: seg001:47BCo
aEditReg_0	db 'edit reg *:     $'  ; DATA XREF: seg001:48F6o
					; sub_21CDA+49o
unk_1D2C5	db    5			; DATA XREF: sub_21FF3+6o
byte_1D2C6	db 0			; DATA XREF: sub_21FF3+Fr
asc_1D2C7	db '          $'        ; DATA XREF: sub_21FF3+1Do
word_1D2D2	dw 0			; DATA XREF: seg001:47D6r seg001:47DEw ...
aVabVFzcVVjvVbv	db 'ÇÌÅ[Ç«îzóÒÇÃÇ¶Ç≈Ç°Ç¡Ç∆Ç‡ÇßÇ«$' ; DATA XREF: sub_21DB6+52o
aEditReg	db 'edit reg *[    ]:     $' ; DATA XREF: sub_21F2F+49o
word_1D308	dw 0			; DATA XREF: sub_21DB6+6Cr
					; sub_21DB6+74w ...
word_1D30A	dw 0A000h		; DATA XREF: sub_21A52+18r
					; sub_21CDA+56r ...
word_1D30C	dw 0A800h		; DATA XREF: sub_208CC:loc_208F1r
					; sub_213B6+6r	...
word_1D30E	dw 0B000h		; DATA XREF: sub_208CC+2Dr
					; sub_213B6+13r ...
word_1D310	dw 0B800h		; DATA XREF: sub_208CC+35r
					; sub_213B6+20r ...
off_1D312	dw offset loc_206C2	; 0 ; DATA XREF: DrawDialogText+7Do
		dw offset loc_206D3	; 1
		dw offset loc_206EC	; 2
		dw offset loc_20711	; 3
		dw offset loc_20734	; 4
		dw offset loc_20783	; 5
		dw offset loc_207A6	; 6
		dw offset loc_207A9	; 7
		dw offset loc_207AC	; 8
		dw offset loc_20A23	; 9
		dw offset loc_20A75	; 10
		dw offset loc_20B05	; 11
		dw offset loc_20B18	; 12
		dw offset loc_20BBD	; 13
		dw offset loc_20B34	; 14
		dw offset loc_20B52	; 15
		dw offset loc_20B62	; 16
		dw offset loc_20B7A	; 17
		dw offset loc_20C01	; 18
		dw offset loc_20C3E	; 19
		dw offset loc_20CA6	; 20
		dw offset loc_20C4B	; 21
		dw offset loc_20C5D	; 22
		dw offset loc_20C9E	; 23
		dw offset loc_20CD5	; 24
		dw offset loc_20D18	; 25
		dw offset loc_20D2E	; 26
		dw offset loc_20D4B	; 27
		dw offset loc_20D55	; 28
		dw offset loc_20D69	; 29
		dw offset loc_20D99	; 30
		dw offset loc_20E8E	; 31
		dw offset loc_20EB3	; 32
		dw offset loc_20F34	; 33
		dw offset loc_20F48	; 34
		dw offset loc_20F65	; 35
		dw offset loc_20F71	; 36
		dw offset loc_20F84	; 37
		align 4
seg000		ends

; ===========================================================================

; Segment type:	Pure code
seg001		segment	byte public 'CODE' use16
		assume cs:seg001
		assume es:nothing, ss:nothing, ds:seg000, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


ShowItemObtain	proc near		; CODE XREF: start:loc_1F212p

; FUNCTION CHUNK AT 0440 SIZE 00000269 BYTES
; FUNCTION CHUNK AT 06C7 SIZE 0000025E BYTES
; FUNCTION CHUNK AT 092B SIZE 0000011C BYTES
; FUNCTION CHUNK AT 0A84 SIZE 0000001D BYTES

		mov	battleResult, 0
		mov	byte_10FEB, 0
		cmp	al, 0Ah
		jb	short loc_1D384
		cmp	al, 46h
		jnb	short loc_1D375
		jmp	loc_1D60C
; ---------------------------------------------------------------------------

loc_1D375:				; CODE XREF: ShowItemObtain+10j
		cmp	al, 64h
		jnb	short loc_1D37C
		jmp	loc_1D7A0
; ---------------------------------------------------------------------------

loc_1D37C:				; CODE XREF: ShowItemObtain+17j
		cmp	al, 8Ch
		jnb	short locret_1D383
		jmp	loc_1DDE9
; ---------------------------------------------------------------------------

locret_1D383:				; CODE XREF: ShowItemObtain+1Ej
					; ShowItemObtain+ACj ...
		retn
; ---------------------------------------------------------------------------

loc_1D384:				; CODE XREF: ShowItemObtain+Cj
		cmp	al, 1
		jz	short loc_1D405
		cmp	al, 2
		jnz	short loc_1D38F
		jmp	loc_1D49C
; ---------------------------------------------------------------------------

loc_1D38F:				; CODE XREF: ShowItemObtain+2Aj
		cmp	al, 3
		jnz	short loc_1D396
		jmp	loc_1D4E0
; ---------------------------------------------------------------------------

loc_1D396:				; CODE XREF: ShowItemObtain+31j
		cmp	al, 4
		jz	short loc_1D3B0
		cmp	al, 5
		jnz	short loc_1D3A1
		jmp	loc_1D606
; ---------------------------------------------------------------------------

loc_1D3A1:				; CODE XREF: ShowItemObtain+3Cj
		cmp	al, 6
		jnz	short loc_1D3A8
		jmp	loc_1DDE4
; ---------------------------------------------------------------------------

loc_1D3A8:				; CODE XREF: ShowItemObtain+43j
		cmp	al, 7
		jnz	short locret_1D3AF
		jmp	loc_1D600
; ---------------------------------------------------------------------------

locret_1D3AF:				; CODE XREF: ShowItemObtain+4Aj
		retn
; ---------------------------------------------------------------------------

loc_1D3B0:				; CODE XREF: ShowItemObtain+38j
		cmp	byte_10FE9, 0
		jz	short ShowOnsen
		retn
; ---------------------------------------------------------------------------

ShowOnsen:				; CODE XREF: ShowItemObtain+55j
		mov	byte_10FE9, 1
		mov	ax, maxHP
		mov	curHP, ax
		mov	al, byte_11C00
		cmp	al, 1
		jz	short loc_1D3D8
		cmp	al, 2
		jz	short loc_1D3E1
		cmp	al, 3
		jz	short loc_1D3EA
		cmp	al, 4
		jz	short loc_1D3F3
		jmp	short loc_1D3FC
; ---------------------------------------------------------------------------

loc_1D3D8:				; CODE XREF: ShowItemObtain+68j
		mov	bx, offset aDungeonMesOn_3 ; "\\DUNGEON\\MES\\ONSEN1.MES"
		mov	ax, 0
		jmp	RunMESScript2
; ---------------------------------------------------------------------------

loc_1D3E1:				; CODE XREF: ShowItemObtain+6Cj
		mov	bx, offset aDungeonMesOn_2 ; "\\DUNGEON\\MES\\ONSEN2.MES"
		mov	ax, 0
		jmp	RunMESScript2
; ---------------------------------------------------------------------------

loc_1D3EA:				; CODE XREF: ShowItemObtain+70j
		mov	bx, offset aDungeonMesOn_1 ; "\\DUNGEON\\MES\\ONSEN3.MES"
		mov	ax, 0
		jmp	RunMESScript2
; ---------------------------------------------------------------------------

loc_1D3F3:				; CODE XREF: ShowItemObtain+74j
		mov	bx, offset aDungeonMesOn_0 ; "\\DUNGEON\\MES\\ONSEN4.MES"
		mov	ax, 0
		jmp	RunMESScript2
; ---------------------------------------------------------------------------

loc_1D3FC:				; CODE XREF: ShowItemObtain+76j
		mov	bx, offset aDungeonMesOnse ; "\\DUNGEON\\MES\\ONSEN5.MES"
		mov	ax, 0
		jmp	RunMESScript2
; ---------------------------------------------------------------------------

loc_1D405:				; CODE XREF: ShowItemObtain+26j
		cmp	byte_10FE9, 0
		jz	short loc_1D40F
		jmp	locret_1D383
; ---------------------------------------------------------------------------

loc_1D40F:				; CODE XREF: ShowItemObtain+AAj
		mov	byte_10FE9, 1
		cmp	byte_11C00, 1
		jz	short loc_1D47A
		cmp	byte_11C00, 3
		jz	short loc_1D490

loc_1D422:				; CODE XREF: ShowItemObtain:loc_1D48Ej
					; ShowItemObtain:loc_1D49Aj
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aGoUpstairs ; "\aè„Ç÷ÇÃäKíiÇ≈Ç∑ÅBìoÇËÇ‹Ç∑Ç©ÅHÅ@ÅmÇxÇèÇí"...
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F691
		jb	short loc_1D45B
		inc	byte_11C00
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		call	LoadDungeonFiles
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1D45B:				; CODE XREF: ShowItemObtain+EAj
					; ShowItemObtain+16Fj
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1D47A:				; CODE XREF: ShowItemObtain+B9j
		cmp	byte_11C01, 1
		jz	short loc_1D484
		jmp	locret_1D383
; ---------------------------------------------------------------------------

loc_1D484:				; CODE XREF: ShowItemObtain+11Fj
		cmp	byte_11C04, 2
		jz	short loc_1D48E
		jmp	locret_1D383
; ---------------------------------------------------------------------------

loc_1D48E:				; CODE XREF: ShowItemObtain+129j
		jmp	short loc_1D422
; ---------------------------------------------------------------------------

loc_1D490:				; CODE XREF: ShowItemObtain+C0j
		cmp	word_11BE9, 0
		jnz	short loc_1D49A
		jmp	locret_1D383
; ---------------------------------------------------------------------------

loc_1D49A:				; CODE XREF: ShowItemObtain+135j
		jmp	short loc_1D422
; ---------------------------------------------------------------------------

loc_1D49C:				; CODE XREF: ShowItemObtain+2Cj
		cmp	byte_10FE9, 0
		jz	short loc_1D4A6
		jmp	locret_1D383
; ---------------------------------------------------------------------------

loc_1D4A6:				; CODE XREF: ShowItemObtain+141j
		mov	byte_10FE9, 1
		mov	si, 0FEDh
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aGoDownstairs ; "\aâ∫Ç÷ÇÃäKíiÇ≈Ç∑ÅBâ∫ÇËÇ‹Ç∑Ç©ÅHÅ@ÅmÇxÇèÇí"...
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F691
		jb	short loc_1D45B
		dec	byte_11C00
		call	LoadDungeonFiles
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1D4E0:				; CODE XREF: ShowItemObtain+33j
		mov	al, byte_11C00
		push	ax
		mov	byte_11C00, 1
		call	LoadDungeonFiles
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		pop	ax
		cmp	al, 3
		jz	short loc_1D56A
		cmp	byte_11C17, 0
		jz	short loc_1D520
		jmp	loc_1D5BB
; ---------------------------------------------------------------------------

loc_1D520:				; CODE XREF: ShowItemObtain+1BBj
		mov	byte_11C17, 1
		mov	rngRolls, 1
		mov	rngRange, 5
		mov	rngBaseVal, 0
		mov	rngBitMask, 7
		call	GetRandom_Range
		push	ax
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aFallDamage ; "\aÅ@ÇÃÉ_ÉÅÅ|ÉWÇÇ§ÇØÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		pop	ax
		mov	bx, ax
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1D55F
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D55F:				; CODE XREF: ShowItemObtain+1FAj
		mov	curHP, ax
		xor	ax, ax
		mov	si, offset aTrapDoor1 ;	"\x05Ç¢ÇƒÇƒÇ•ÅEÅEÅE\r"
		int	0F0h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1D56A:				; CODE XREF: ShowItemObtain+1B4j
		cmp	byte_11C18, 0
		jnz	short loc_1D5BB
		mov	byte_11C18, 1
		mov	rngRolls, 1
		mov	rngRange, 5
		mov	rngBaseVal, 0
		mov	rngBitMask, 7
		call	GetRandom_Range
		push	ax
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aFallDamage ; "\aÅ@ÇÃÉ_ÉÅÅ|ÉWÇÇ§ÇØÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		pop	ax
		mov	bx, ax
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1D5B0
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D5B0:				; CODE XREF: ShowItemObtain+24Bj
		mov	curHP, ax
		xor	ax, ax
		mov	si, offset aTrapDoor3 ;	"\x05Ç¢ÇƒÇƒÇ•ÅEÅEÅE\r"
		int	0F0h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1D5BB:				; CODE XREF: ShowItemObtain+1BDj
					; ShowItemObtain+20Fj
		mov	rngRolls, 1
		mov	rngRange, 5
		mov	rngBaseVal, 0
		mov	rngBitMask, 7
		call	GetRandom_Range
		push	ax
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aFallDamage ; "\aÅ@ÇÃÉ_ÉÅÅ|ÉWÇÇ§ÇØÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		pop	ax
		mov	bx, ax
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1D5F5
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D5F5:				; CODE XREF: ShowItemObtain+290j
		mov	curHP, ax
		xor	ax, ax
		mov	si, offset aTrapDoor2 ;	"\x05Ç¢ÇƒÇƒÇ•ÅEÅEÅE\r"
		int	0F0h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1D600:				; CODE XREF: ShowItemObtain+4Cj
		mov	byte_10FEC, 1
		retn
; ---------------------------------------------------------------------------

loc_1D606:				; CODE XREF: ShowItemObtain+3Ej
		mov	byte_10FEA, 1
		retn
; ---------------------------------------------------------------------------

loc_1D60C:				; CODE XREF: ShowItemObtain+12j
		cmp	al, 0Bh
		jz	short loc_1D63F
		cmp	al, 0Ch
		jz	short loc_1D66E
		cmp	al, 0Dh
		jnz	short loc_1D61B
		jmp	loc_1D69D
; ---------------------------------------------------------------------------

loc_1D61B:				; CODE XREF: ShowItemObtain+2B6j
		cmp	al, 12h
		jnz	short loc_1D622
		jmp	loc_1D6CC
; ---------------------------------------------------------------------------

loc_1D622:				; CODE XREF: ShowItemObtain+2BDj
		cmp	al, 13h
		jnz	short loc_1D629
		jmp	loc_1D6DD
; ---------------------------------------------------------------------------

loc_1D629:				; CODE XREF: ShowItemObtain+2C4j
		cmp	al, 14h
		jnz	short loc_1D630
		jmp	loc_1D6EE
; ---------------------------------------------------------------------------

loc_1D630:				; CODE XREF: ShowItemObtain+2CBj
		cmp	al, 15h
		jnz	short loc_1D637
		jmp	loc_1D6FF
; ---------------------------------------------------------------------------

loc_1D637:				; CODE XREF: ShowItemObtain+2D2j
		cmp	al, 16h
		jnz	short locret_1D63E
		jmp	loc_1D710
; ---------------------------------------------------------------------------

locret_1D63E:				; CODE XREF: ShowItemObtain+2D9j
		retn
; ---------------------------------------------------------------------------

loc_1D63F:				; CODE XREF: ShowItemObtain+2AEj
		cmp	byte_11C19, 1
		jnz	short loc_1D647
		retn
; ---------------------------------------------------------------------------

loc_1D647:				; CODE XREF: ShowItemObtain+2E4j
		mov	si, offset aSilvrBastard ; "ã‚ÇÃÉoÉXÉ^Å|Éh"
		call	CopyItemName
		xor	ax, ax
		mov	si, offset aItemObtained1 ; "\x04\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset itemNameBuffer
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aItemObtained2 ; "\aÅ@ÇèEÇ¡ÇΩ\r\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	equippedWeapon,	9
		mov	byte_11C19, 1
		retn
; ---------------------------------------------------------------------------

loc_1D66E:				; CODE XREF: ShowItemObtain+2B2j
		cmp	byte_11C1A, 1
		jnz	short loc_1D676
		retn
; ---------------------------------------------------------------------------

loc_1D676:				; CODE XREF: ShowItemObtain+313j
		mov	si, offset aSilverPlate	; "ã‚ÇÃÉvÉåÅ|Ég"
		call	CopyItemName
		xor	ax, ax
		mov	si, offset aItemObtained1 ; "\x04\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset itemNameBuffer
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aItemObtained2 ; "\aÅ@ÇèEÇ¡ÇΩ\r\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	equippedArmor, 9
		mov	byte_11C1A, 1
		retn
; ---------------------------------------------------------------------------

loc_1D69D:				; CODE XREF: ShowItemObtain+2B8j
		cmp	byte_11C1B, 1
		jnz	short loc_1D6A5
		retn
; ---------------------------------------------------------------------------

loc_1D6A5:				; CODE XREF: ShowItemObtain+342j
		mov	si, offset aSilverShld ; "ÉVÉãÉoÅ|ÇrÇàÅD"
		call	CopyItemName
		xor	ax, ax
		mov	si, offset aItemObtained1 ; "\x04\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset itemNameBuffer
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aItemObtained2 ; "\aÅ@ÇèEÇ¡ÇΩ\r\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	equippedShield,	7
		mov	byte_11C1B, 1
		retn
; ---------------------------------------------------------------------------

loc_1D6CC:				; CODE XREF: ShowItemObtain+2BFj
		cmp	byte_11C1C, 1
		jnz	short loc_1D6D4
		retn
; ---------------------------------------------------------------------------

loc_1D6D4:				; CODE XREF: ShowItemObtain+371j
		call	sub_1D721
		mov	byte_11C1C, 1
		retn
; ---------------------------------------------------------------------------

loc_1D6DD:				; CODE XREF: ShowItemObtain+2C6j
		cmp	byte_11C1D, 1
		jnz	short loc_1D6E5
		retn
; ---------------------------------------------------------------------------

loc_1D6E5:				; CODE XREF: ShowItemObtain+382j
		call	sub_1D721
		mov	byte_11C1D, 1
		retn
; ---------------------------------------------------------------------------

loc_1D6EE:				; CODE XREF: ShowItemObtain+2CDj
		cmp	byte_11C1E, 1
		jnz	short loc_1D6F6
		retn
; ---------------------------------------------------------------------------

loc_1D6F6:				; CODE XREF: ShowItemObtain+393j
		call	sub_1D721
		mov	byte_11C1E, 1
		retn
; ---------------------------------------------------------------------------

loc_1D6FF:				; CODE XREF: ShowItemObtain+2D4j
		cmp	byte_11C1F, 1
		jnz	short loc_1D707
		retn
; ---------------------------------------------------------------------------

loc_1D707:				; CODE XREF: ShowItemObtain+3A4j
		call	sub_1D721
		mov	byte_11C1F, 1
		retn
; ---------------------------------------------------------------------------

loc_1D710:				; CODE XREF: ShowItemObtain+2DBj
		cmp	byte_11C20, 1
		jnz	short loc_1D718
		retn
; ---------------------------------------------------------------------------

loc_1D718:				; CODE XREF: ShowItemObtain+3B5j
		call	sub_1D721
		mov	byte_11C20, 1
		retn
ShowItemObtain	endp


; =============== S U B	R O U T	I N E =======================================


sub_1D721	proc near		; CODE XREF: ShowItemObtain:loc_1D6D4p
					; ShowItemObtain:loc_1D6E5p ...
		mov	ax, word_11BE7
		cmp	ax, 9
		jnb	short loc_1D732
		inc	ax
		mov	word_11BE7, ax
		cmp	ax, 5
		jz	short loc_1D758

loc_1D732:				; CODE XREF: sub_1D721+6j
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset byte_116F5
		int	0F0h		; used by BASIC	while in interpreter
		retn
; ---------------------------------------------------------------------------

loc_1D758:				; CODE XREF: sub_1D721+Fj
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset byte_117F8
		int	0F0h		; used by BASIC	while in interpreter
		mov	word_11BED, 1
		mov	word_11BE7, 0
		mov	word_11BE9, 0
		retn
sub_1D721	endp


; =============== S U B	R O U T	I N E =======================================


CopyItemName	proc near		; CODE XREF: ShowItemObtain+2EAp
					; ShowItemObtain+319p ...
		mov	di, offset itemNameBuffer
		cld

loc_1D794:				; CODE XREF: CopyItemName+Aj
		lodsw
		cmp	al, 0
		jz	short loc_1D79C
		stosw
		jmp	short loc_1D794
; ---------------------------------------------------------------------------

loc_1D79C:				; CODE XREF: CopyItemName+7j
		mov	byte ptr [di], 0Ah
		retn
CopyItemName	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ShowItemObtain

loc_1D7A0:				; CODE XREF: ShowItemObtain+19j
		mov	ah, 0
		sub	al, 47h
		cmp	al, 0
		jnz	short loc_1D7AB
		jmp	loc_1D838
; ---------------------------------------------------------------------------

loc_1D7AB:				; CODE XREF: ShowItemObtain+446j
		cmp	al, 1
		jnz	short loc_1D7B2
		jmp	loc_1D85E
; ---------------------------------------------------------------------------

loc_1D7B2:				; CODE XREF: ShowItemObtain+44Dj
		cmp	al, 2
		jnz	short loc_1D7B9
		jmp	loc_1D8B1
; ---------------------------------------------------------------------------

loc_1D7B9:				; CODE XREF: ShowItemObtain+454j
		cmp	al, 3
		jnz	short loc_1D7C0
		jmp	loc_1D8FD
; ---------------------------------------------------------------------------

loc_1D7C0:				; CODE XREF: ShowItemObtain+45Bj
		cmp	al, 4
		jnz	short loc_1D7C7
		jmp	loc_1D923
; ---------------------------------------------------------------------------

loc_1D7C7:				; CODE XREF: ShowItemObtain+462j
		cmp	al, 5
		jnz	short loc_1D7CE
		jmp	loc_1D970
; ---------------------------------------------------------------------------

loc_1D7CE:				; CODE XREF: ShowItemObtain+469j
		cmp	al, 6
		jnz	short loc_1D7D5
		jmp	loc_1D996
; ---------------------------------------------------------------------------

loc_1D7D5:				; CODE XREF: ShowItemObtain+470j
		cmp	al, 7
		jnz	short loc_1D7DC
		jmp	loc_1D9BC
; ---------------------------------------------------------------------------

loc_1D7DC:				; CODE XREF: ShowItemObtain+477j
		cmp	al, 8
		jnz	short loc_1D7E3
		jmp	loc_1D9E2
; ---------------------------------------------------------------------------

loc_1D7E3:				; CODE XREF: ShowItemObtain+47Ej
		cmp	al, 9
		jnz	short loc_1D7EA
		jmp	locret_1DA08
; ---------------------------------------------------------------------------

loc_1D7EA:				; CODE XREF: ShowItemObtain+485j
		cmp	al, 0Ah
		jnz	short loc_1D7F1
		jmp	loc_1DA27
; ---------------------------------------------------------------------------

loc_1D7F1:				; CODE XREF: ShowItemObtain+48Cj
		cmp	al, 0Bh
		jnz	short loc_1D7F8
		jmp	loc_1DA4D
; ---------------------------------------------------------------------------

loc_1D7F8:				; CODE XREF: ShowItemObtain+493j
		cmp	al, 0Ch
		jnz	short loc_1D7FF
		jmp	loc_1DA73
; ---------------------------------------------------------------------------

loc_1D7FF:				; CODE XREF: ShowItemObtain+49Aj
		cmp	al, 0Dh
		jnz	short loc_1D806
		jmp	loc_1DAC0
; ---------------------------------------------------------------------------

loc_1D806:				; CODE XREF: ShowItemObtain+4A1j
		cmp	al, 0Eh
		jnz	short loc_1D80D
		jmp	loc_1DB0D
; ---------------------------------------------------------------------------

loc_1D80D:				; CODE XREF: ShowItemObtain+4A8j
		cmp	al, 0Fh
		jnz	short loc_1D814
		jmp	loc_1DB33
; ---------------------------------------------------------------------------

loc_1D814:				; CODE XREF: ShowItemObtain+4AFj
		cmp	al, 10h
		jnz	short loc_1D81B
		jmp	loc_1DB59
; ---------------------------------------------------------------------------

loc_1D81B:				; CODE XREF: ShowItemObtain+4B6j
		cmp	al, 13h
		jnz	short loc_1D822
		jmp	loc_1DB7F
; ---------------------------------------------------------------------------

loc_1D822:				; CODE XREF: ShowItemObtain+4BDj
		cmp	al, 14h
		jnz	short loc_1D829
		jmp	loc_1DBC8
; ---------------------------------------------------------------------------

loc_1D829:				; CODE XREF: ShowItemObtain+4C4j
		cmp	al, 15h
		jnz	short loc_1D830
		jmp	loc_1DC15
; ---------------------------------------------------------------------------

loc_1D830:				; CODE XREF: ShowItemObtain+4CBj
		cmp	al, 16h
		jnz	short locret_1D837
		jmp	loc_1DC3B
; ---------------------------------------------------------------------------

locret_1D837:				; CODE XREF: ShowItemObtain+4D2j
		retn
; ---------------------------------------------------------------------------

loc_1D838:				; CODE XREF: ShowItemObtain+448j
		cmp	byte_11C02, 1
		jnz	short loc_1D840
		retn
; ---------------------------------------------------------------------------

loc_1D840:				; CODE XREF: ShowItemObtain+4DDj
		mov	bx, offset aDungeonMes1f_m ; "\\DUNGEON\\MES\\1F.MES"
		mov	ax, 0
		call	RunMESScript	; 1F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C02, 1
		retn
; ---------------------------------------------------------------------------

loc_1D85E:				; CODE XREF: ShowItemObtain+44Fj
		cmp	byte_11C03, 1
		jnz	short loc_1D866
		retn
; ---------------------------------------------------------------------------

loc_1D866:				; CODE XREF: ShowItemObtain+503j
		mov	bx, offset aDungeonMes1f_m ; "\\DUNGEON\\MES\\1F.MES"
		mov	ax, 1
		call	RunMESScript	; 1F.MES
		cmp	ax, 0
		jnz	short loc_1D875
		retn
; ---------------------------------------------------------------------------

loc_1D875:				; CODE XREF: ShowItemObtain+512j
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 5
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1D88E
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D88E:				; CODE XREF: ShowItemObtain+529j
		mov	bx, offset aDungeonMes1f_m ; "\\DUNGEON\\MES\\1F.MES"
		mov	ax, 2
		call	RunMESScript	; 1F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C01, 1
		mov	byte_11C03, 1
		retn
; ---------------------------------------------------------------------------

loc_1D8B1:				; CODE XREF: ShowItemObtain+456j
		cmp	byte_11C04, 2
		jnz	short loc_1D8B9
		retn
; ---------------------------------------------------------------------------

loc_1D8B9:				; CODE XREF: ShowItemObtain+556j
		mov	bx, offset aDungeonMes1f_m ; "\\DUNGEON\\MES\\1F.MES"
		mov	ax, 3
		call	RunMESScript	; 1F.MES
		cmp	ax, 0
		jz	short loc_1D8E0
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 7
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1D8E0
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D8E0:				; CODE XREF: ShowItemObtain+565j
					; ShowItemObtain+57Bj
		mov	bx, offset aDungeonMes1f_m ; "\\DUNGEON\\MES\\1F.MES"
		mov	ax, 4
		call	RunMESScript	; 1F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		inc	byte_11C04
		retn
; ---------------------------------------------------------------------------

loc_1D8FD:				; CODE XREF: ShowItemObtain+45Dj
		cmp	byte_11C05, 1
		jnz	short loc_1D905
		retn
; ---------------------------------------------------------------------------

loc_1D905:				; CODE XREF: ShowItemObtain+5A2j
		mov	bx, offset aDungeonMes2f_m ; "\\DUNGEON\\MES\\2F.MES"
		mov	ax, 0
		call	RunMESScript	; 2F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C05, 1
		retn
; ---------------------------------------------------------------------------

loc_1D923:				; CODE XREF: ShowItemObtain+464j
		cmp	byte_11C06, 1
		jnz	short loc_1D92B
		retn
; ---------------------------------------------------------------------------

loc_1D92B:				; CODE XREF: ShowItemObtain+5C8j
		mov	bx, offset aDungeonMes2f_m ; "\\DUNGEON\\MES\\2F.MES"
		mov	ax, 2
		call	RunMESScript	; 2F.MES
		cmp	ax, 0
		jz	short loc_1D952
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 2
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1D952
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1D952:				; CODE XREF: ShowItemObtain+5D7j
					; ShowItemObtain+5EDj
		mov	bx, offset aDungeonMes2f_m ; "\\DUNGEON\\MES\\2F.MES"
		mov	ax, 3
		call	RunMESScript	; 2F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C06, 1
		retn
; ---------------------------------------------------------------------------

loc_1D970:				; CODE XREF: ShowItemObtain+46Bj
		cmp	byte_11C07, 1
		jnz	short loc_1D978
		retn
; ---------------------------------------------------------------------------

loc_1D978:				; CODE XREF: ShowItemObtain+615j
		mov	bx, offset aDungeonMes2f_m ; "\\DUNGEON\\MES\\2F.MES"
		mov	ax, 4
		call	RunMESScript	; 2F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C07, 1
		retn
; ---------------------------------------------------------------------------

loc_1D996:				; CODE XREF: ShowItemObtain+472j
		cmp	byte_11C08, 1
		jnz	short loc_1D99E
		retn
; ---------------------------------------------------------------------------

loc_1D99E:				; CODE XREF: ShowItemObtain+63Bj
		mov	bx, offset aDungeonMes3f_m ; "\\DUNGEON\\MES\\3F.MES"
		mov	ax, 0
		call	RunMESScript	; 3F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C08, 1
		retn
; ---------------------------------------------------------------------------

loc_1D9BC:				; CODE XREF: ShowItemObtain+479j
		cmp	byte_11C09, 1
		jnz	short loc_1D9C4
		retn
; ---------------------------------------------------------------------------

loc_1D9C4:				; CODE XREF: ShowItemObtain+661j
		mov	bx, offset aDungeonMes3f_m ; "\\DUNGEON\\MES\\3F.MES"
		mov	ax, 2
		call	RunMESScript	; 3F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C09, 1
		retn
; ---------------------------------------------------------------------------

loc_1D9E2:				; CODE XREF: ShowItemObtain+480j
		cmp	byte_11C0A, 1
		jnz	short loc_1D9EA
		retn
; ---------------------------------------------------------------------------

loc_1D9EA:				; CODE XREF: ShowItemObtain+687j
		mov	bx, offset aDungeonMes3f_m ; "\\DUNGEON\\MES\\3F.MES"
		mov	ax, 3
		call	RunMESScript	; 3F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C0A, 1
		retn
; ---------------------------------------------------------------------------

locret_1DA08:				; CODE XREF: ShowItemObtain+487j
		retn
; END OF FUNCTION CHUNK	FOR ShowItemObtain
; ---------------------------------------------------------------------------
		cmp	byte_11C0B, 1
		jnz	short loc_1DA11
		retn
; ---------------------------------------------------------------------------

loc_1DA11:				; CODE XREF: seg001:06AEj
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 0
		call	RunMESScript	; 4F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_11C0B, 1
		retn
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ShowItemObtain

loc_1DA27:				; CODE XREF: ShowItemObtain+48Ej
		cmp	byte_11C0C, 1
		jnz	short loc_1DA2F
		retn
; ---------------------------------------------------------------------------

loc_1DA2F:				; CODE XREF: ShowItemObtain+6CCj
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 1
		call	RunMESScript	; 4F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C0C, 1
		retn
; ---------------------------------------------------------------------------

loc_1DA4D:				; CODE XREF: ShowItemObtain+495j
		cmp	byte_11C0D, 1
		jnz	short loc_1DA55
		retn
; ---------------------------------------------------------------------------

loc_1DA55:				; CODE XREF: ShowItemObtain+6F2j
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 2
		call	RunMESScript	; 4F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C0D, 1
		retn
; ---------------------------------------------------------------------------

loc_1DA73:				; CODE XREF: ShowItemObtain+49Cj
		cmp	byte_11C0E, 1
		jnz	short loc_1DA7B
		retn
; ---------------------------------------------------------------------------

loc_1DA7B:				; CODE XREF: ShowItemObtain+718j
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 3
		call	RunMESScript	; 4F.MES
		cmp	ax, 0
		jz	short loc_1DAA2
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 7
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1DAA2
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1DAA2:				; CODE XREF: ShowItemObtain+727j
					; ShowItemObtain+73Dj
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 4
		call	RunMESScript	; 4F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C0E, 1
		retn
; ---------------------------------------------------------------------------

loc_1DAC0:				; CODE XREF: ShowItemObtain+4A3j
		cmp	byte_11C0F, 1
		jnz	short loc_1DAC8
		retn
; ---------------------------------------------------------------------------

loc_1DAC8:				; CODE XREF: ShowItemObtain+765j
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 5
		call	RunMESScript	; 4F.MES
		cmp	ax, 0
		jz	short loc_1DAEF
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 4
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1DAEF
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1DAEF:				; CODE XREF: ShowItemObtain+774j
					; ShowItemObtain+78Aj
		mov	bx, offset aDungeonMes4f_m ; "\\DUNGEON\\MES\\4F.MES"
		mov	ax, 6
		call	RunMESScript	; 4F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C0F, 1
		retn
; ---------------------------------------------------------------------------

loc_1DB0D:				; CODE XREF: ShowItemObtain+4AAj
		cmp	byte_11C10, 1
		jnz	short loc_1DB15
		retn
; ---------------------------------------------------------------------------

loc_1DB15:				; CODE XREF: ShowItemObtain+7B2j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 1
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C10, 1
		retn
; ---------------------------------------------------------------------------

loc_1DB33:				; CODE XREF: ShowItemObtain+4B1j
		cmp	byte_11C11, 1
		jnz	short loc_1DB3B
		retn
; ---------------------------------------------------------------------------

loc_1DB3B:				; CODE XREF: ShowItemObtain+7D8j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 2
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C11, 1
		retn
; ---------------------------------------------------------------------------

loc_1DB59:				; CODE XREF: ShowItemObtain+4B8j
		cmp	byte_11C12, 1
		jnz	short loc_1DB61
		retn
; ---------------------------------------------------------------------------

loc_1DB61:				; CODE XREF: ShowItemObtain+7FEj
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 0
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C12, 1
		retn
; ---------------------------------------------------------------------------

loc_1DB7F:				; CODE XREF: ShowItemObtain+4BFj
		cmp	byte_11C13, 1
		jnz	short loc_1DB87
		retn
; ---------------------------------------------------------------------------

loc_1DB87:				; CODE XREF: ShowItemObtain+824j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 5
		call	RunMESScript	; 5F.MES
		cmp	al, 0
		jz	short loc_1DBA9
		mov	byte_11C13, 1
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		retn
; ---------------------------------------------------------------------------

loc_1DBA9:				; CODE XREF: ShowItemObtain+832j
		mov	byte_11C00, 5
		mov	byte_11BFD, 9
		mov	byte_11BFE, 4
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		retn
; ---------------------------------------------------------------------------

loc_1DBC8:				; CODE XREF: ShowItemObtain+4C6j
		cmp	byte_11C14, 1
		jnz	short loc_1DBD0
		retn
; ---------------------------------------------------------------------------

loc_1DBD0:				; CODE XREF: ShowItemObtain+86Dj
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 3
		call	RunMESScript	; 5F.MES
		cmp	ax, 0
		jz	short loc_1DBF7
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	byte_10A33, 9
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1DBF7
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1DBF7:				; CODE XREF: ShowItemObtain+87Cj
					; ShowItemObtain+892j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 4
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C14, 1
		retn
; ---------------------------------------------------------------------------

loc_1DC15:				; CODE XREF: ShowItemObtain+4CDj
		cmp	byte_11C15, 1
		jnz	short loc_1DC1D
		retn
; ---------------------------------------------------------------------------

loc_1DC1D:				; CODE XREF: ShowItemObtain+8BAj
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 6
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C15, 1
		retn
; ---------------------------------------------------------------------------

loc_1DC3B:				; CODE XREF: ShowItemObtain+4D4j
		cmp	byte_11C16, 1
		jnz	short loc_1DC43
		retn
; ---------------------------------------------------------------------------

loc_1DC43:				; CODE XREF: ShowItemObtain+8E0j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 7
		call	RunMESScript	; 5F.MES
		cmp	ax, 0
		jz	short loc_1DC67
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		mov	byte_10A33, 0Ah
		call	DoBossBattle
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1DC67
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

loc_1DC67:				; CODE XREF: ShowItemObtain+8EFj
					; ShowItemObtain+902j
		mov	bx, offset aDungeonMes5f_m ; "\\DUNGEON\\MES\\5F.MES"
		mov	ax, 8
		call	RunMESScript	; 5F.MES
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		mov	byte_11C16, 1
		retn
; END OF FUNCTION CHUNK	FOR ShowItemObtain

; =============== S U B	R O U T	I N E =======================================


DoShop		proc near		; CODE XREF: seg001:loc_1F85Bp
		mov	ax, 1
		mov	bx, offset aDungeonMesShop ; "\\DUNGEON\\MES\\SHOP.MES"
DoShop		endp

; START	OF FUNCTION CHUNK FOR ShowItemObtain

RunMESScript2:				; CODE XREF: ShowItemObtain+7Ej
					; ShowItemObtain+87j ...
		call	RunMESScript	; START.MES/ONSEN#.MES/SHOP.MES
		push	ax
		call	CalcStrAndDex
		call	DrawPlayerStats
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		pop	ax
		cmp	al, 1
		jz	short loc_1DCFF
		cmp	al, 2
		jz	short loc_1DD19
		cmp	al, 3
		jnz	short loc_1DCAD
		jmp	loc_1DD33
; ---------------------------------------------------------------------------

loc_1DCAD:				; CODE XREF: ShowItemObtain+948j
		cmp	al, 4
		jnz	short loc_1DCB4
		jmp	loc_1DD4D
; ---------------------------------------------------------------------------

loc_1DCB4:				; CODE XREF: ShowItemObtain+94Fj
		cmp	al, 5
		jnz	short loc_1DCBB
		jmp	loc_1DD67
; ---------------------------------------------------------------------------

loc_1DCBB:				; CODE XREF: ShowItemObtain+956j
		cmp	al, 6
		jnz	short loc_1DCC2
		jmp	loc_1DD81
; ---------------------------------------------------------------------------

loc_1DCC2:				; CODE XREF: ShowItemObtain+95Dj
		mov	byte_11BFF, 1
		mov	byte_11BFD, 0Ah
		mov	byte_11BFE, 13h
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		mov	byte_11C00, 1
		call	LoadDungeonFiles
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DCFF:				; CODE XREF: ShowItemObtain+940j
		mov	byte_11C00, 1
		call	LoadDungeonFiles
		mov	byte_11BFD, 7
		mov	byte_11BFE, 3
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DD19:				; CODE XREF: ShowItemObtain+944j
		mov	byte_11C00, 2
		call	LoadDungeonFiles
		mov	byte_11BFD, 3
		mov	byte_11BFE, 7
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DD33:				; CODE XREF: ShowItemObtain+94Aj
		mov	byte_11C00, 3
		call	LoadDungeonFiles
		mov	byte_11BFD, 0Fh
		mov	byte_11BFE, 0Fh
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DD4D:				; CODE XREF: ShowItemObtain+951j
		mov	byte_11C00, 4
		call	LoadDungeonFiles
		mov	byte_11BFD, 5
		mov	byte_11BFE, 5
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DD67:				; CODE XREF: ShowItemObtain+958j
		mov	byte_11C00, 5
		call	LoadDungeonFiles
		mov	byte_11BFD, 0Ch
		mov	byte_11BFE, 0Ah
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_1F580
		retn
; ---------------------------------------------------------------------------

loc_1DD81:				; CODE XREF: ShowItemObtain+95Fj
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		retn
; END OF FUNCTION CHUNK	FOR ShowItemObtain

; =============== S U B	R O U T	I N E =======================================


sub_1DDA7	proc near		; CODE XREF: sub_1F6DB:loc_1F7FFp
		mov	ax, 1
		mov	bx, offset aDungeonMesCamp ; "\\DUNGEON\\MES\\CAMP.MES"
		call	RunMESScript	; CAMP.MES
		call	CalcStrAndDex
		call	DrawPlayerStats
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		retn
sub_1DDA7	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ShowItemObtain

loc_1DDE4:				; CODE XREF: ShowItemObtain+45j
		call	sub_1F30B
		jmp	short loc_1DE4C
; ---------------------------------------------------------------------------

loc_1DDE9:				; CODE XREF: ShowItemObtain+20j
		push	ax
		call	sub_1F30B
		pop	ax
		sub	al, 100
		mov	byte_10A33, al
		call	DoBossBattle
		cmp	battleResult, 2
		jnz	short locret_1DE00
		jmp	loc_1DE85
; ---------------------------------------------------------------------------

locret_1DE00:				; CODE XREF: ShowItemObtain+A9Bj
		retn
; END OF FUNCTION CHUNK	FOR ShowItemObtain

; =============== S U B	R O U T	I N E =======================================


DoBossBattle	proc near		; CODE XREF: ShowItemObtain+521p
					; ShowItemObtain+573p ...
		mov	plrCanNotRun, 1
		call	DoBattle
		mov	plrCanNotRun, 0
		retn
DoBossBattle	endp


; =============== S U B	R O U T	I N E =======================================


RunStartMES	proc near		; CODE XREF: SetInitialStats:loc_1F25Bp
					; SetInitialStats+75p
		mov	ax, 0
		mov	bx, offset aDungeonMesStar ; "\\DUNGEON\\MES\\START.MES"
		jmp	RunMESScript2
RunStartMES	endp


; =============== S U B	R O U T	I N E =======================================


RunMESScript	proc near		; CODE XREF: ShowItemObtain+4E6p
					; ShowItemObtain+50Cp ...
		push	ax
		push	bx
		call	Vars_Dgn2MES
		pop	bx
		pop	ax
		call	ExecMESFile
		push	ax
		call	Vars_MES2Dgn
		call	CalcStrAndDex
		pop	ax
		retn
RunMESScript	endp


; =============== S U B	R O U T	I N E =======================================


sub_1DE2B	proc near		; CODE XREF: start+183p
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 0FFh
		call	GetRandom_Range
		cmp	ax, 5
		jbe	short loc_1DE4C
		retn
; ---------------------------------------------------------------------------

loc_1DE4C:				; CODE XREF: ShowItemObtain+A87j
					; sub_1DE2B+1Ej
		xor	ax, ax
		mov	al, byte_11C00
		dec	al
		add	ax, 200h
		mov	bx, ax
		xor	ax, ax
		mov	al, [bx]
		dec	ax
		mov	rngRolls, 1
		mov	rngRange, ax
		mov	rngBaseVal, 0
		mov	rngBitMask, 0Fh
		call	GetRandom_Range
		mov	byte_10A33, al
		call	DoBattle
		mov	al, battleResult
		cmp	al, 2
		jz	short loc_1DE83
		retn
; ---------------------------------------------------------------------------

loc_1DE83:				; CODE XREF: sub_1DE2B+55j
		jmp	short $+2

loc_1DE85:				; CODE XREF: ShowItemObtain+1FCj
					; ShowItemObtain+24Dj ...
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	byte_11001, 3
		mov	byte_11002, 2
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		call	sub_20272
		mov	ax, ds
		mov	es, ax
		assume es:seg000
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStop ; " STOP"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1DEDE
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1DEDE:				; CODE XREF: sub_1DE2B+AEj
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonMusicSh ; " \\DUNGEON\\MUSIC\\SHOP.M"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1DF11
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1DF11:				; CODE XREF: sub_1DE2B+E1j
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStart ; " START"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1DF44
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1DF44:				; CODE XREF: sub_1DE2B+114j
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aDungeonLoadada ; "\\DUNGEON\\LOADADA4.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonPicEnd_ ; "\x15 \\DUNGEON\\PIC\\END.ADA"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1DF77
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1DF77:				; CODE XREF: sub_1DE2B+147j
		mov	byte_11001, 3
		mov	byte_11002, 0
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		pop	ax
		call	sub_1FA7B
		call	sub_20272
		mov	byte_11001, 3
		mov	byte_11002, 2
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aDungeonLoadada ; "\\DUNGEON\\LOADADA4.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonPicWaku ; " \\DUNGEON\\PIC\\WAKU.ADA"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1DFDF
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1DFDF:				; CODE XREF: sub_1DE2B+1AFj
		mov	byte_11001, 3
		mov	byte_11002, 0
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		mov	bx, offset aDungeonMesOver ; "\\DUNGEON\\MES\\OVER.MES"
		mov	ax, 0
		call	RunMESScript	; OVER.MES
		jmp	loc_1F189
sub_1DE2B	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


DoBattle	proc near		; CODE XREF: DoBossBattle+5p
					; sub_1DE2B+4Dp
		mov	ax, btlRemSpells
		cmp	ax, 10
		jnb	short loc_1E00F
		inc	ax
		inc	ax
		mov	btlRemSpells, ax

loc_1E00F:				; CODE XREF: DoBattle+6j
		call	sub_1E1AB
		call	CopyMonsterName
		call	sub_1E160
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStop ; " STOP"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E04B
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E04B:				; CODE XREF: DoBattle+44j
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonMusicMo ; " \\DUNGEON\\MUSIC\\MONST.M"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E07E
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E07E:				; CODE XREF: DoBattle+77j
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStart ; " START"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E0B1
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E0B1:				; CODE XREF: DoBattle+AAj
		call	DoBattleMain
		mov	al, battleResult
		cmp	al, 2
		jnz	short loc_1E0BC
		retn
; ---------------------------------------------------------------------------

loc_1E0BC:				; CODE XREF: DoBattle+B7j
		call	CheckLevelUp
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStop ; " STOP"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E0F2
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E0F2:				; CODE XREF: DoBattle+EBj
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonMusicMe ; " \\DUNGEON\\MUSIC\\MEI-Q.M"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E125
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E125:				; CODE XREF: DoBattle+11Ej
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStart ; " START"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1E158
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1E158:				; CODE XREF: DoBattle+151j
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		call	sub_20295
		retn
DoBattle	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E160	proc near		; CODE XREF: DoBattle+13p
		mov	ah, 0
		mov	al, byte_11C00
		dec	al
		add	ax, ax
		add	ax, offset off_10205
		mov	bx, ax
		mov	bx, [bx]
		mov	ah, 0
		mov	al, byte_10A33
		dec	al
		add	ax, ax
		add	bx, ax
		mov	si, [bx]
		mov	dx, offset aDungeonLoadada ; "\\DUNGEON\\LOADADA4.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, si
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short locret_1E1AA
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

locret_1E1AA:				; CODE XREF: sub_1E160+45j
		retn
sub_1E160	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E1AB	proc near		; CODE XREF: DoBattle:loc_1E00Fp
		mov	al, byte_10A33
		dec	al
		mov	cx, 31h
		mul	cl
		add	ax, offset floorMDatData
		mov	word_10C8C, ax
		mov	si, ax
		mov	bx, ax
		xor	ax, ax
		mov	al, [bx+2Ch]
		cmp	ax, 0
		jnz	short loc_1E1CC
		call	sub_1E235

loc_1E1CC:				; CODE XREF: sub_1E1AB+1Cj
		mov	rngRolls, 1
		mov	rngRange, ax
		mov	rngBaseVal, 0
		mov	rngBitMask, 0Fh
		call	GetRandom_Range
		mov	monsterCount, al
		mov	cx, ax
		xor	dx, dx

loc_1E1EB:				; CODE XREF: sub_1E1AB+7Cj
		push	cx
		push	dx
		mov	bx, dx
		shl	bx, 1
		add	bx, offset btlMonsterPtrs
		mov	di, [bx]
		xor	ax, ax
		mov	bx, ax
		mov	cx, ax
		mov	al, [si+1Ch]
		mov	bl, [si+1Dh]
		mov	cl, [si+1Eh]
		mov	rngRolls, ax
		mov	rngRange, bx
		mov	rngBaseVal, cx
		mov	rngBitMask, 1Fh
		call	GetRandom_Range
		mov	[di], al
		xor	ax, ax
		mov	al, [si+17h]
		mov	[di+1],	al
		pop	dx
		pop	cx
		inc	dx
		loop	loc_1E1EB
		mov	si, offset word_10CD0
		mov	di, (offset word_10CD0+12h)
		mov	cx, 0Ah
		cld
		movsw
		retn
sub_1E1AB	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E235	proc near		; CODE XREF: sub_1E1AB+1Ep
		mov	ax, 1
		retn
sub_1E235	endp


; =============== S U B	R O U T	I N E =======================================


CopyMonsterName	proc near		; CODE XREF: DoBattle+10p
		mov	si, word_10C8C
		mov	di, offset CurMonsterName
		mov	cx, 0Ah
		rep movsw
		mov	byte ptr [di], 0Ah
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Eh ; 'N'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		retn
CopyMonsterName	endp


; =============== S U B	R O U T	I N E =======================================


ShowMnstAppearTxt proc near		; CODE XREF: DoBattleMain:battle_loopp
		xor	ax, ax
		mov	si, offset MnstNameText	; "\a\x13"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	al, monsterCount
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr MnstAppearText+6, ax
		xor	ax, ax
		mov	si, offset MnstAppearText ; "Å@Ç™Å@Å@ïCÅ@Ç¢Ç‹Ç∑ÅD\x12\n"
		int	0F0h		; used by BASIC	while in interpreter
		retn
ShowMnstAppearTxt endp

; ---------------------------------------------------------------------------
		pusha
		push	es
		mov	bx, 0A000h
		mov	es, bx
		assume es:nothing
		xor	ax, ax
		mov	di, 280h
		mov	cx, 280h
		rep stosw
		mov	di, 280h
		mov	al, byte_10A33
		call	nullsub_1
		xor	dx, dx
		mov	cx, dx
		mov	cl, monsterCount

loc_1E2A5:				; CODE XREF: seg001:0F74j
		pusha
		mov	ax, dx
		shl	ax, 1
		add	ax, 0CBEh
		mov	bx, ax
		mov	bx, [bx]
		pusha
		mov	al, 14h
		mul	dl
		add	ax, 320h
		mov	di, ax
		mov	al, [bx]
		call	nullsub_1
		popa
		pusha
		mov	al, 14h
		mul	dl
		add	ax, 460h
		mov	di, ax
		mov	al, [bx+1]
		call	nullsub_1
		popa
		popa
		inc	dx
		loop	loc_1E2A5
		pop	es
		assume es:nothing
		mov	ah, 2
		mov	dl, 7
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
; ---------------------------------------------------------------------------
		popa
		retn
; ---------------------------------------------------------------------------
		xor	cx, cx
		mov	cl, [si]
		retn

; =============== S U B	R O U T	I N E =======================================


DoBattleMain	proc near		; CODE XREF: DoBattle:loc_1E0B1p
		mov	al, armorDef
		mov	btlPlayerDef, al
		mov	byte_11010, 0
		mov	si, word_10C8C
		mov	al, [si+15h]
		mov	monsterDefense,	al
		mov	ax, [si+18h]
		mov	word_11C59, ax
		mov	ax, [si+1Ah]
		mov	word_11C5B, ax
		mov	al, curDexterity
		mov	btlPlayerDex, al
		mov	byte_11C60, 0
		mov	byte_11C61, 0
		mov	btlPlrGuardDef,	0

battle_loop:				; CODE XREF: DoBattleMain+69j
		call	ShowMnstAppearTxt
		call	Battle_GetPlrAction
		call	DoPlayerRunAway
		jb	short locret_1E34F
		call	sub_1E397
		call	sub_1EE03
		mov	byte_11C61, 0
		call	DetermineTurnOrder
		mov	byte_11C5D, 1
		call	sub_1E442
		mov	al, battleResult
		cmp	al, 1
		jz	short locret_1E34F
		cmp	al, 2
		jz	short locret_1E350
		mov	al, monsterCount
		cmp	al, 0
		jz	short locret_1E34F
		jmp	short battle_loop
; ---------------------------------------------------------------------------

locret_1E34F:				; CODE XREF: DoBattleMain+3Fj
					; DoBattleMain+5Cj ...
		retn
; ---------------------------------------------------------------------------

locret_1E350:				; CODE XREF: DoBattleMain+60j
		retn
DoBattleMain	endp


; =============== S U B	R O U T	I N E =======================================


Battle_GetPlrAction proc near		; CODE XREF: DoBattleMain+39p
		mov	si, offset aActionsPlr ; "ÇΩÅ@ÇΩÅ@Ç©Å@Ç§\x1C"
		mov	ah, 4
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aWhatWillYouDo ; "\a\x13Ç«Ç§ÇµÇ‹Ç∑Ç©Å@ÅH\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	GetActionKey
		mov	actionID_Plr, al
		cmp	al, 3
		jz	short loc_1E37D
		mov	si, offset aActionsFin ; "Ç©Å@Ç¢Å@Ç”Å@Ç≠\x1C"
		mov	ah, 4
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aWhichSpellCast ; "\a\x13ÉtÉBÉìÇ…Ç«ÇÃñÇñ@ÇÇÇ®äËÇ¢ÇµÇ‹Ç∑Ç©Å@Å"...
		int	0F0h		; used by BASIC	while in interpreter
		call	GetActionKey
		mov	actionID_Fin, al

loc_1E37D:				; CODE XREF: Battle_GetPlrAction+16j
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		retn
Battle_GetPlrAction endp


; =============== S U B	R O U T	I N E =======================================


GetActionKey	proc near		; CODE XREF: Battle_GetPlrAction+Ep
					; Battle_GetPlrAction+26p ...
		mov	ah, 6
		int	0F0h		; used by BASIC	while in interpreter
		cmp	al, 0
		jz	short GetActionKey
		cmp	al, 3
		ja	short GetActionKey
		push	ax
		mov	ah, 2
		mov	dl, 7
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		pop	ax
		retn
GetActionKey	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E397	proc near		; CODE XREF: DoBattleMain+41p
		mov	al, byte_11C61
		cmp	al, 0
		jnz	short loc_1E39F
		retn
; ---------------------------------------------------------------------------

loc_1E39F:				; CODE XREF: sub_1E397+5j
		mov	bl, al
		mov	bh, 0
		push	bx
		shl	bx, 1
		mov	di, offset word_10CD0
		add	bx, di
		mov	si, bx
		pop	bx
		mov	cx, 9
		sub	cx, bx
		cld
		rep movsw
		retn
sub_1E397	endp


; =============== S U B	R O U T	I N E =======================================


DetermineTurnOrder proc	near		; CODE XREF: DoBattleMain+4Cp
		cld
		xor	ax, ax
		mov	di, offset byte_10D0C
		mov	cx, 0Bh
		rep stosb
		mov	cx, 0Bh
		mov	di, offset byte_10CF6
		rep stosb
		mov	cx, 0Bh
		mov	di, offset byte_10D01
		rep stosb
		mov	di, offset byte_10CF6
		mov	al, btlPlayerDex
		stosb
		mov	al, btlPlayerDex
		stosb
		xor	cx, cx
		mov	cl, monsterCount
		mov	si, word_10C8C

loc_1E3E7:				; CODE XREF: DetermineTurnOrder+35j
		mov	al, [si+14h]
		stosb
		inc	si
		loop	loc_1E3E7
		mov	di, offset byte_10D0C
		xor	ax, ax
		xor	cx, cx
		mov	cl, monsterCount
		add	cl, 2

loc_1E3FC:				; CODE XREF: DetermineTurnOrder+48j
		stosb
		inc	al
		loop	loc_1E3FC
		mov	cx, 0Bh
		mov	si, offset byte_10CF6
		mov	di, offset byte_10D01
		rep movsb
		mov	di, offset byte_10CF6
		mov	bx, offset byte_10D0C
		xor	cx, cx
		mov	cl, al
		dec	cx

loc_1E417:				; CODE XREF: DetermineTurnOrder+88j
		push	bx
		push	di
		mov	dx, 1

loc_1E41C:				; CODE XREF: DetermineTurnOrder+84j
		cmp	dx, cx
		jz	short loc_1E43D
		mov	al, [di+1]
		mov	ah, [di]
		cmp	al, ah
		jnb	short loc_1E438
		mov	[di+1],	ah
		mov	[di], al
		mov	al, [bx+1]
		mov	ah, [bx]
		mov	[bx+1],	ah
		mov	[bx], al

loc_1E438:				; CODE XREF: DetermineTurnOrder+70j
		inc	bx
		inc	di
		inc	dx
		jmp	short loc_1E41C
; ---------------------------------------------------------------------------

loc_1E43D:				; CODE XREF: DetermineTurnOrder+67j
		pop	di
		pop	bx
		loop	loc_1E417
		retn
DetermineTurnOrder endp


; =============== S U B	R O U T	I N E =======================================


sub_1E442	proc near		; CODE XREF: DoBattleMain+54p

; FUNCTION CHUNK AT 1211 SIZE 00000116 BYTES
; FUNCTION CHUNK AT 1380 SIZE 0000000A BYTES
; FUNCTION CHUNK AT 1394 SIZE 0000001E BYTES
; FUNCTION CHUNK AT 13BC SIZE 000000B9 BYTES
; FUNCTION CHUNK AT 148D SIZE 00000030 BYTES
; FUNCTION CHUNK AT 14D5 SIZE 000000A6 BYTES
; FUNCTION CHUNK AT 15B5 SIZE 0000007F BYTES
; FUNCTION CHUNK AT 1664 SIZE 00000075 BYTES
; FUNCTION CHUNK AT 1709 SIZE 00000028 BYTES
; FUNCTION CHUNK AT 1761 SIZE 00000034 BYTES
; FUNCTION CHUNK AT 182F SIZE 00000077 BYTES
; FUNCTION CHUNK AT 18DB SIZE 000001C8 BYTES
; FUNCTION CHUNK AT 1B32 SIZE 0000004E BYTES

		mov	al, monsterCount
		mov	byte_11C57, al
		mov	battleResult, 0
		mov	si, offset byte_10D0C
		xor	bp, bp

loc_1E452:				; CODE XREF: sub_1E442+34j
		inc	bp
		lodsb
		push	si
		push	bp
		cmp	al, 0
		jz	short loc_1E47A
		cmp	al, 1
		jnz	short loc_1E461
		jmp	loc_1E71C
; ---------------------------------------------------------------------------

loc_1E461:				; CODE XREF: sub_1E442+1Aj
		jmp	loc_1E915
; ---------------------------------------------------------------------------

loc_1E464:				; CODE XREF: sub_1E442+3Dj
					; sub_1E442+D2j ...
		pop	bp
		pop	si
		mov	al, battleResult
		cmp	al, 0
		jnz	short locret_1E479
		xor	ax, ax
		mov	al, byte_11C57
		inc	ax
		inc	ax
		cmp	ax, bp
		jnz	short loc_1E452
		retn
; ---------------------------------------------------------------------------

locret_1E479:				; CODE XREF: sub_1E442+29j
		retn
; ---------------------------------------------------------------------------

loc_1E47A:				; CODE XREF: sub_1E442+16j
		mov	al, actionID_Plr
		cmp	al, 3
		jz	short loc_1E464
		cmp	al, 2
		jnz	short plrAct1_Attack
		jmp	plrAct2_Defend
; ---------------------------------------------------------------------------

plrAct1_Attack:				; CODE XREF: sub_1E442+41j
		call	RollPlrAtkMode
		cmp	plrAttackMode, 3
		jnz	short loc_1E495	; mode 0/1 - hit target
		jmp	loc_1E6F4	; mode 3 - miss
; ---------------------------------------------------------------------------

loc_1E495:				; CODE XREF: sub_1E442+4Ej
		mov	ax, (offset byte_10D01+2)
		mov	word_11C5E, ax
		call	GetWeaponProps
		mov	rngRolls, bx
		mov	rngRange, cx
		mov	rngBaseVal, dx
		mov	rngBitMask, 1Fh
		call	GetRandom_Range
		mov	damageDealt, al
		mov	al, characterStr
		mov	cl, 10
		div	cl
		mov	cl, al
		mov	al, damageDealt
		add	al, cl		; damage = weaponDamage	+ characterSTR / 10
		jnb	short loc_1E4C8
		mov	al, 255

loc_1E4C8:				; CODE XREF: sub_1E442+82j
		mov	damageDealt, al
		cmp	plrAttackMode, 1
		jnz	short loc_1E4D5
		jmp	loc_1EE92	; attack mode 1: critical hit
; ---------------------------------------------------------------------------

loc_1E4D5:				; CODE XREF: sub_1E442+8Ej
					; sub_1E442+192j
		mov	bx, word_11C5E
		mov	al, [bx]
		call	sub_1EF7C
		jnb	short loc_1E4E3
		jmp	loc_1E6F4
; ---------------------------------------------------------------------------

loc_1E4E3:				; CODE XREF: sub_1E442+9Cj
		xor	ax, ax
		mov	si, offset aPlrEnemyHit	; "\x1A\x05Ç§Ç®Ç®Ç®Ç®Ç¡ÅI\x02ÉhÉJÉbÅIÅ@\x12\x06ìñÇΩÇ¡ÇƒÇÈ"...
		int	0F0h		; used by BASIC	while in interpreter
		call	CalcDamage2Mnst
		jnb	short loc_1E4F2
		jmp	loc_1E6FE
; ---------------------------------------------------------------------------

loc_1E4F2:				; CODE XREF: sub_1E442+ABj
		mov	bh, 0
		mov	bl, byte_11C5D
		dec	bx
		shl	bx, 1
		add	bx, offset btlMonsterPtrs
		mov	si, [bx]
		mov	al, [si]
		mov	bl, damageDealt
		sub	al, bl
		jbe	short loc_1E571
		mov	[si], al
		xor	ax, ax
		mov	si, offset asc_11232 ; "\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
sub_1E442	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlash_C7x3	proc near		; CODE XREF: CalcDamage2Mnst+Bp
		push	ax
		mov	cx, 3

loc_1E51B:				; CODE XREF: ScrFlash_C7x3+7j
					; ScrFlash_C7x6+4j
		call	ScrFlashOne_7
		loop	loc_1E51B
		pop	ax
		retn
ScrFlash_C7x3	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlashOne_7	proc near		; CODE XREF: ScrFlash_C7x3:loc_1E51Bp
		push	cx
		mov	al, 74h
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E527:				; CODE XREF: ScrFlashOne_7:loc_1E527j
		loop	loc_1E527

loc_1E529:				; CODE XREF: ScrFlashOne_7:loc_1E529j
		loop	loc_1E529
		mov	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E52F:				; CODE XREF: ScrFlashOne_7:loc_1E52Fj
		loop	loc_1E52F
		pop	cx
		retn
ScrFlashOne_7	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlash_C7x6	proc near		; CODE XREF: sub_1E442+A54p
		push	ax
		mov	cx, 6
		jmp	short loc_1E51B
ScrFlash_C7x6	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlash_C6x2	proc near		; CODE XREF: sub_1E442+320p
					; sub_1E442+417p ...
		push	ax
		mov	cx, 2

loc_1E53D:				; CODE XREF: ScrFlash_C6x2+7j
		call	ScrFlashOne_6
		loop	loc_1E53D
		pop	ax
		retn
ScrFlash_C6x2	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlashOne_6	proc near		; CODE XREF: ScrFlash_C6x2:loc_1E53Dp
		push	cx
		mov	al, 64h
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E549:				; CODE XREF: ScrFlashOne_6:loc_1E549j
		loop	loc_1E549

loc_1E54B:				; CODE XREF: ScrFlashOne_6:loc_1E54Bj
		loop	loc_1E54B
		mov	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E551:				; CODE XREF: ScrFlashOne_6:loc_1E551j
		loop	loc_1E551
		pop	cx
		retn
ScrFlashOne_6	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlash_C2x3	proc near		; CODE XREF: CalcPlrDamage+49p
		push	ax
		mov	cx, 3

loc_1E559:				; CODE XREF: ScrFlash_C2x3+7j
		call	ScrFlashOne_2
		loop	loc_1E559
		pop	ax
		retn
ScrFlash_C2x3	endp


; =============== S U B	R O U T	I N E =======================================


ScrFlashOne_2	proc near		; CODE XREF: ScrFlash_C2x3:loc_1E559p
		push	cx
		mov	al, 24h
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E565:				; CODE XREF: ScrFlashOne_2:loc_1E565j
		loop	loc_1E565

loc_1E567:				; CODE XREF: ScrFlashOne_2:loc_1E567j
		loop	loc_1E567
		mov	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A

loc_1E56D:				; CODE XREF: ScrFlashOne_2:loc_1E56Dj
		loop	loc_1E56D
		pop	cx
		retn
ScrFlashOne_2	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E571:				; CODE XREF: sub_1E442+C7j
					; sub_1E442+A96j
		mov	byte ptr [si], 0
		sub	bl, al
		shr	bl, 1
		mov	damageDealt, bl
		xor	ax, ax
		mov	si, offset asc_11234 ; "\x12\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aDefeated ; "ÇÕÅCì|ÇÍÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		inc	byte_11C60
		mov	al, monsterCount
		dec	al
		mov	monsterCount, al
		jnz	short loc_1E5A2
		jmp	loc_1E633
; ---------------------------------------------------------------------------

loc_1E5A2:				; CODE XREF: sub_1E442+15Bj
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 7Fh
		call	GetRandom_Range
		cmp	al, 60
		ja	short loc_1E5D7
		xor	ax, ax
		mov	si, offset aPlrAtkAgain	; "\x12\aÇ≥ÇÁÇ…ÅCÉâÉìÉfÉBÉXÇÕçUåÇÇµÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		inc	byte_11C61
		inc	byte_11C5D
		inc	word_11C5E
		jmp	loc_1E4D5
; ---------------------------------------------------------------------------

loc_1E5D7:				; CODE XREF: sub_1E442+17Dj
		xor	ax, ax
		mov	si, offset asc_11232 ; "\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E5E1:				; CODE XREF: sub_1E442+476j
		pusha
		mov	al, damageDealt
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aDamageToMonst ; "\aÉ|ÉCÉìÉgÇÃÉ_ÉÅÅ|ÉWÇÇ†ÇΩÇ¶ÇΩÅD\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		popa
		mov	byte ptr [si], 0
		xor	ax, ax
		mov	si, offset asc_11234 ; "\x12\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aDefeated ; "ÇÕÅCì|ÇÍÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		inc	byte_11C60
		mov	al, monsterCount
		dec	al
		mov	monsterCount, al
		jz	short loc_1E633
		xor	ax, ax
		mov	si, offset asc_11232 ; "\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		inc	byte_11C61
		inc	word_11C5E
		inc	byte_11C5D
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E633:				; CODE XREF: sub_1E442+15Dj
					; sub_1E442+1D9j
		mov	battleResult, 1
		mov	ch, 0
		mov	cl, byte_11C60
		mov	ax, word_11C59
		mul	cx
		mov	bx, curLvlExp
		add	bx, ax
		mov	curLvlExp, bx
		mov	ax, word_11C5B
		mul	cx
		mov	bx, curGold
		add	bx, ax
		mov	curGold, bx
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E65F:				; CODE XREF: sub_1E442+53Ej
					; sub_1E442+5E1j ...
		xor	ax, ax
		mov	si, offset aPlrDead ; "\x1A\x02ÉâÉìÉfÉBÉXÇÕéÄÇÒÇæ\a\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	ax, 0
		mov	curHP, ax
		mov	battleResult, 2
		jmp	loc_1E464
; ---------------------------------------------------------------------------

plrAct2_Defend:				; CODE XREF: sub_1E442+43j
		xor	ax, ax
		mov	si, offset aPlrDefend ;	"\a\x13ÉâÉìÉfÉBÉXÇÕéÁÇ¡ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		shl	btlPlayerDef, 1
		mov	byte_11010, 1
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


DoPlayerRunAway	proc near		; CODE XREF: DoBattleMain+3Cp
		cmp	actionID_Plr, 3
		jnz	short loc_1E6DE
		xor	ax, ax
		mov	si, offset aPlrRunAway ; "\a\x13ÉâÉìÉfÉBÉXÇÕì¶Ç∞ÇæÇµÇΩ\n"
		int	0F0h		; used by BASIC	while in interpreter
		cmp	plrCanNotRun, 1
		jz	short loc_1E6D7
		mov	al, btlPlayerDex
		mov	si, word_10C8C
		mov	bl, [si+14h]
		cmp	al, bl
		jb	short loc_1E6D7
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 7Fh
		call	GetRandom_Range
		cmp	al, 60
		ja	short loc_1E6D7
		xor	ax, ax
		mov	si, offset aEscaped ; "Å@ì¶Ç∞ÇÍÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	battleResult, 1
		stc
		retn
; ---------------------------------------------------------------------------

loc_1E6D7:				; CODE XREF: DoPlayerRunAway+13j
					; DoPlayerRunAway+21j ...
		xor	ax, ax
		mov	si, offset aFailed ; "Å@ÇµÇ©ÇµÅCé∏îsÇµÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter

loc_1E6DE:				; CODE XREF: DoPlayerRunAway+5j
		clc
		retn
DoPlayerRunAway	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E6E0:				; CODE XREF: sub_1E442+3C0j
					; sub_1E442+3D8j ...
		xor	ax, ax
		mov	si, offset aFinNoCasting ; "\x12\x06Ç‚ÇüÇÊÅCÇﬂÇÒÇ«Ç≠Ç≥Ç¢ÅEÅEÅE\r\x12\x05Ç∞Ç¡ÅCÇª"...
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442
; ---------------------------------------------------------------------------
		xor	ax, ax
		mov	si, offset aDodged ; "Å@ÇµÇ©ÇµÅCÇ©ÇÌÇ≥ÇÍÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E6F4:				; CODE XREF: sub_1E442+50j
					; sub_1E442+9Ej
		xor	ax, ax
		mov	si, offset aPlrAtkMiss ; "\x1A\aÇ∑Ç©Ç¡Å@Åô"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E6FE:				; CODE XREF: sub_1E442+ADj
		xor	ax, ax
		mov	si, offset aPlrAtkNoEffect ; "\x12\x06Ç≈Ç‡ÅCÇ»ÇÒÇ∆Ç‡Ç»Ç¢Ç›ÇΩÇ¢ÇÊÅEÅE\r\a\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

atkEvade:				; CODE XREF: sub_1E442+51Aj
					; sub_1E442+525j ...
		xor	ax, ax
		mov	si, offset aEvaded ; "Å@ÇµÇ©ÇµÅCÇ©ÇÌÇµÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442
; ---------------------------------------------------------------------------
		xor	ax, ax
		mov	si, offset aFailed ; "Å@ÇµÇ©ÇµÅCé∏îsÇµÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E71C:				; CODE XREF: sub_1E442+1Cj
		mov	al, actionID_Plr
		cmp	al, 3
		jnz	short loc_1E726
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E726:				; CODE XREF: sub_1E442+2DFj
		mov	al, actionID_Fin
		cmp	al, 1
		jz	short loc_1E737	; Fin action 1 - heal
		cmp	al, 2
		jnz	short loc_1E734	; Fin action 3 - blast
		jmp	loc_1E835	; Fin action 2 - guard
; ---------------------------------------------------------------------------

loc_1E734:				; CODE XREF: sub_1E442+2EDj
		jmp	loc_1E872
; ---------------------------------------------------------------------------

loc_1E737:				; CODE XREF: sub_1E442+2E9j
		mov	ax, btlRemSpells
		cmp	ax, 0
		jnz	short loc_1E742
		jmp	loc_1E7ED
; ---------------------------------------------------------------------------

loc_1E742:				; CODE XREF: sub_1E442+2FBj
		dec	ax		; NOTE:	Only the "heal"	spells make Fin	tired.
		mov	btlRemSpells, ax ; "Guard" and "Blast" don't decrease the counter.
		xor	ax, ax
		mov	si, offset aFinCasts1 ;	"\x1A\aÉtÉBÉìÇÕÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastHeal ; "\x04âÒïúÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinCasts2 ;	"\aÅ@ÇÇ©ÇØÇΩÅ@ÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset asc_11273 ; "\x12\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	ScrFlash_C6x2
		mov	ax, btlSpellStr
		mov	si, offset btlHealData
		dec	al
		mov	cl, 3
		mul	cl
		add	si, ax
		mov	ax, 0
		mov	bx, ax
		mov	cx, ax
		mov	al, [si]
		mov	bl, [si+1]
		mov	cl, [si+2]
		mov	rngRolls, ax
		mov	rngRange, bx
		mov	rngBaseVal, cx
		mov	rngBitMask, 0FFh
		call	GetRandom_Range
		mov	word_11D29, ax
		mov	bx, ax
		mov	ax, curHP
		add	ax, bx
		cmp	ax, 999
		jbe	short loc_1E7A8
		call	sub_1E7E9

loc_1E7A8:				; CODE XREF: sub_1E442+361j
		cmp	ax, maxHP
		jbe	short loc_1E7B1
		call	sub_1E7D5

loc_1E7B1:				; CODE XREF: sub_1E442+36Aj
		mov	curHP, ax
		xor	ax, ax
		mov	si, offset asc_112D5 ; "\x12\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	ax, word_11D29
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 8
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aHPRecover ;	"\aÉ|ÉCÉìÉgâÒïúÇµÇΩ\r\a\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	DrawPlayerStats
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1E7D5	proc near		; CODE XREF: sub_1E442+36Cp
		mov	bx, maxHP
		sub	ax, bx
		mov	bx, word_11D29
		sub	bx, ax
		mov	word_11D29, bx
		mov	ax, maxHP
		retn
sub_1E7D5	endp


; =============== S U B	R O U T	I N E =======================================


sub_1E7E9	proc near		; CODE XREF: sub_1E442+363p
		mov	ax, 999
		retn
sub_1E7E9	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E7ED:				; CODE XREF: sub_1E442+2FDj
		xor	ax, ax
		mov	si, offset aFinPleaseUse1 ; "\x1A\x05ÉtÉBÉìÅCÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastHeal ; "\x04âÒïúÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinPleaseUse2 ; "\x05Å@ÇÇ©ÇØÇƒÇ≠ÇÍ\r\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E6E0
; ---------------------------------------------------------------------------

loc_1E805:				; CODE XREF: sub_1E442+3F9j
		xor	ax, ax
		mov	si, offset aFinPleaseUse1 ; "\x1A\x05ÉtÉBÉìÅCÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastGuard ;	"\x04ñhå‰ÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinPleaseUse2 ; "\x05Å@ÇÇ©ÇØÇƒÇ≠ÇÍ\r\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E6E0
; END OF FUNCTION CHUNK	FOR sub_1E442
; ---------------------------------------------------------------------------

loc_1E81D:				; unused - supposed to show "Fin, please use Blast!"
		xor	ax, ax
		mov	si, offset aFinPleaseUse1 ; "\x1A\x05ÉtÉBÉìÅCÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastBlast ;	"\x04çUåÇÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinPleaseUse2 ; "\x05Å@ÇÇ©ÇØÇƒÇ≠ÇÍ\r\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E6E0
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E835:				; CODE XREF: sub_1E442+2EFj
		mov	ax, btlRemSpells
		cmp	ax, 0
		jz	short loc_1E805
		xor	ax, ax
		mov	si, offset aFinCasts1 ;	"\x1A\aÉtÉBÉìÇÕÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastGuard ;	"\x04ñhå‰ÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinCasts2 ;	"\aÅ@ÇÇ©ÇØÇΩÅ@ÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset asc_11273 ; "\x12\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	ScrFlash_C6x2
		mov	ax, btlSpellStr
		mov	si, offset btlGuardData
		dec	ax
		add	si, ax
		mov	al, [si]
		add	btlPlrGuardDef,	al
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E872:				; CODE XREF: sub_1E442:loc_1E734j
		mov	ax, btlRemSpells
		cmp	ax, 0
		jnz	short loc_1E87D
		jmp	loc_1E6E0	; [BUG]	should jump to loc_1E81D
; ---------------------------------------------------------------------------

loc_1E87D:				; CODE XREF: sub_1E442+436j
		xor	ax, ax
		mov	si, offset aFinCasts1 ;	"\x1A\aÉtÉBÉìÇÕÅ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCastBlast ;	"\x04çUåÇÇÃñÇñ@\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aFinCasts2 ;	"\aÅ@ÇÇ©ÇØÇΩÅ@ÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset asc_11273 ; "\x12\a\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	ScrFlash_C6x2
		call	sub_1E8DB
		mov	bh, 0
		mov	bl, byte_11C5D
		dec	bx
		shl	bx, 1
		add	bx, offset word_10CD0
		mov	si, bx
		mov	al, [si]
		mov	bl, damageDealt
		sub	al, bl
		ja	short loc_1E8BB
		jmp	loc_1E5E1
; ---------------------------------------------------------------------------

loc_1E8BB:				; CODE XREF: sub_1E442+474j
		mov	[si], al
		mov	al, damageDealt
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aDamageToMonst ; "\aÉ|ÉCÉìÉgÇÃÉ_ÉÅÅ|ÉWÇÇ†ÇΩÇ¶ÇΩÅD\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset asc_11232 ; "\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1E8DB	proc near		; CODE XREF: sub_1E442+45Ap
		mov	ax, btlSpellStr
		mov	si, offset btlBlastData
		dec	al
		mov	cl, 3
		mul	cl
		add	si, ax
		mov	ax, 0
		mov	bx, ax
		mov	cx, ax
		mov	al, [si]
		mov	bl, [si+1]
		mov	cl, [si+2]
		mov	rngRolls, ax
		mov	rngRange, bx
		mov	rngBaseVal, cx
		mov	rngBitMask, 0FFh
		call	GetRandom_Range
		mov	damageDealt, al
		retn
sub_1E8DB	endp

; ---------------------------------------------------------------------------
		mov	al, 0
		retn
; ---------------------------------------------------------------------------
		clc
		retn
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E915:				; CODE XREF: sub_1E442:loc_1E461j
		mov	byte_11012, al
		call	sub_1EE4D
		jnb	short loc_1E920
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1E920:				; CODE XREF: sub_1E442+4D9j
		mov	al, 1
		mov	byte_10A32, al
		call	sub_1E994
		jnb	short loc_1E92D
		jmp	loc_1E9C4
; ---------------------------------------------------------------------------

loc_1E92D:				; CODE XREF: sub_1E442+4E6j
		call	sub_1EA39
		jnb	short loc_1E935
		jmp	loc_1EA69
; ---------------------------------------------------------------------------

loc_1E935:				; CODE XREF: sub_1E442+4EEj
		call	sub_1EAF8
		jnb	short loc_1E93D
		jmp	loc_1EB8F
; ---------------------------------------------------------------------------

loc_1E93D:				; CODE XREF: sub_1E442+4F6j
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aMonstAtk2 ;	"ÇÃçUåÇ\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	RollPlrAtkMode
		cmp	plrAttackMode, 3
		jnz	short loc_1E95F
		jmp	atkEvade
; ---------------------------------------------------------------------------

loc_1E95F:				; CODE XREF: sub_1E442+518j
		mov	al, byte_10D01
		call	sub_1EFDC
		jnb	short loc_1E96A
		jmp	atkEvade
; ---------------------------------------------------------------------------

loc_1E96A:				; CODE XREF: sub_1E442+523j
		call	CalcPlrDamage
		jnb	short loc_1E972
		jmp	atkEvade
; ---------------------------------------------------------------------------

loc_1E972:				; CODE XREF: sub_1E442+52Bj
		mov	al, damageDealt
		mov	bh, 0
		mov	bl, al
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1E983
		jmp	loc_1E65F
; ---------------------------------------------------------------------------

loc_1E983:				; CODE XREF: sub_1E442+53Cj
		mov	curHP, ax
		call	sub_1EA91
		jnb	short loc_1E98E
		jmp	loc_1EAC1
; ---------------------------------------------------------------------------

loc_1E98E:				; CODE XREF: sub_1E442+547j
		call	DrawPlayerStats
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1E994	proc near		; CODE XREF: sub_1E442+4E3p
		mov	si, word_10C8C
		mov	bl, [si+28h]
		and	bl, bl
		jz	short loc_1E9C2
		push	bx
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		pop	bx
		cmp	al, bl
		ja	short loc_1E9C2
		stc
		retn
; ---------------------------------------------------------------------------

loc_1E9C2:				; CODE XREF: sub_1E994+9j
					; sub_1E994+2Aj
		clc
		retn
sub_1E994	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1E9C4:				; CODE XREF: sub_1E442+4E8j
		xor	ax, ax
		mov	si, offset MnstNameText	; "\a\x13"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aMonstBreath	; "ÇÕÉuÉåÉXÇêÅÇ¢ÇΩÅI\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	si, word_10C8C
		mov	al, [si+29h]
		mov	bl, [si+2Ah]
		mov	ah, 0
		mov	bh, 0
		mov	rngRolls, ax
		mov	rngRange, bx
		mov	rngBaseVal, 0
		mov	rngBitMask, 0FFh
		call	GetRandom_Range
		cmp	equippedShield,	8
		jnz	short loc_1EA01
		sub	al, 50
		jb	short loc_1EA2F

loc_1EA01:				; CODE XREF: sub_1E442+5B9j
		mov	damageDealt, al
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aDamageToPlr	; "\aÉ_ÉÅÅ[ÉWÅIÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	al, damageDealt
		mov	bh, 0
		mov	bl, al
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1EA26
		jmp	loc_1E65F
; ---------------------------------------------------------------------------

loc_1EA26:				; CODE XREF: sub_1E442+5DFj
		mov	curHP, ax
		call	DrawPlayerStats
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1EA2F:				; CODE XREF: sub_1E442+5BDj
		xor	ax, ax
		mov	si, offset aFireResist ; "\x05ä√Ç¢ÇÌÅAÉhÉâÉSÉìÇÃÇ§ÇÎÇ±ÇÕâäÇÇ‡ñhÇÆÅI"...
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1EA39	proc near		; CODE XREF: sub_1E442:loc_1E92Dp
		mov	si, word_10C8C
		mov	bl, [si+24h]
		and	bl, bl
		jz	short loc_1EA67
		push	bx
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		pop	bx
		cmp	al, bl
		ja	short loc_1EA67
		stc
		retn
; ---------------------------------------------------------------------------

loc_1EA67:				; CODE XREF: sub_1EA39+9j
					; sub_1EA39+2Aj
		clc
		retn
sub_1EA39	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1EA69:				; CODE XREF: sub_1E442+4F0j
		xor	ax, ax
		mov	si, offset MnstNameText	; "\a\x13"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aMonstGlare ; "\aÅ@ÇÕÅCÇ…ÇÁÇÒÇæ\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	ax, immunePetrify
		and	al, al
		jnz	short loc_1EA8E
		xor	ax, ax
		mov	si, offset aTurnIntoStone ; "\x12\x05Ç§Ç®ÅEÅEÇ®Ç®Ç®ÇßÇßÇßÇßÇ¡ÅEÅEÅE\x02Ç“Ç´Å["...
		int	0F0h		; used by BASIC	while in interpreter
		mov	ax, 0
		mov	curHP, ax
		jmp	loc_1E65F
; ---------------------------------------------------------------------------

loc_1EA8E:				; CODE XREF: sub_1E442+63Aj
		jmp	atkEvade
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1EA91	proc near		; CODE XREF: sub_1E442+544p
		mov	si, word_10C8C
		mov	bl, [si+26h]
		and	bl, bl
		jz	short loc_1EABF
		push	bx
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		pop	bx
		cmp	al, bl
		ja	short loc_1EABF
		stc
		retn
; ---------------------------------------------------------------------------

loc_1EABF:				; CODE XREF: sub_1EA91+9j
					; sub_1EA91+2Aj
		clc
		retn
sub_1EA91	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1EAC1:				; CODE XREF: sub_1E442+549j
		xor	ax, ax
		mov	si, offset aPlrStrDrain	; "\x02\x12Ç†Ç»ÇΩÇÕÅCóÕÇãzÇÌÇÍÇƒÇµÇ‹Ç¡ÇΩ\a\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	CalcStatIncrease
		mov	bl, al
		mov	al, characterDex
		sub	al, bl
		jnb	short loc_1EAD7
		call	sub_1EAF5

loc_1EAD7:				; CODE XREF: sub_1E442+690j
		mov	characterDex, al
		call	CalcStatIncrease
		mov	bl, al
		mov	al, characterStr
		sub	al, bl
		jnb	short loc_1EAE9
		call	sub_1EAF5

loc_1EAE9:				; CODE XREF: sub_1E442+6A2j
		mov	characterStr, al
		call	CalcStrAndDex
		call	DrawPlayerStats
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1EAF5	proc near		; CODE XREF: sub_1E442+692p
					; sub_1E442+6A4p
		xor	ax, ax
		retn
sub_1EAF5	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EAF8	proc near		; CODE XREF: sub_1E442:loc_1E935p
		mov	si, word_10C8C
		mov	al, [si+2Dh]
		and	al, al
		jz	short loc_1EB6C
		mov	byte_10A1A, al
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	bl, al
		mov	al, [si+2Eh]
		cmp	al, 0FFh
		jz	short loc_1EB6E
		cmp	al, bl
		jb	short loc_1EB30
		stc
		retn
; ---------------------------------------------------------------------------

loc_1EB30:				; CODE XREF: sub_1EAF8+34j
		mov	si, word_10C8C
		mov	al, [si+2Fh]
		and	al, al
		jz	short loc_1EB6C
		cmp	al, 2
		jz	short loc_1EB6C
		cmp	al, 9
		jz	short loc_1EB6C
		mov	byte_10A1A, al
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	bl, al
		mov	al, [si+30h]
		cmp	al, bl
		jb	short loc_1EB6C
		stc
		retn
; ---------------------------------------------------------------------------

loc_1EB6C:				; CODE XREF: sub_1EAF8+9j
					; sub_1EAF8+41j ...
		clc
		retn
; ---------------------------------------------------------------------------

loc_1EB6E:				; CODE XREF: sub_1EAF8+30j
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, 0CD0h
		add	si, 0CE2h
		mov	al, [si]
		mov	dl, [bx]
		shr	al, 1
		cmp	dl, al
		ja	short loc_1EB6C
		stc
		retn
sub_1EAF8	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1EB8F:				; CODE XREF: sub_1E442+4F8j
		mov	al, byte_10A1A
		cmp	al, 1
		jz	short loc_1EBBC
		cmp	al, 5
		jnz	short loc_1EB9D
		jmp	loc_1EC3B
; ---------------------------------------------------------------------------

loc_1EB9D:				; CODE XREF: sub_1E442+756j
		cmp	al, 0Eh
		jnz	short loc_1EBA4
		jmp	loc_1ECC1
; ---------------------------------------------------------------------------

loc_1EBA4:				; CODE XREF: sub_1E442+75Dj
		cmp	al, 0Fh
		jnz	short loc_1EBAB
		jmp	loc_1ED0B
; ---------------------------------------------------------------------------

loc_1EBAB:				; CODE XREF: sub_1E442+764j
		cmp	al, 11h
		jnz	short loc_1EBB2
		jmp	loc_1ED66
; ---------------------------------------------------------------------------

loc_1EBB2:				; CODE XREF: sub_1E442+76Bj
		cmp	al, 12h
		jnz	short loc_1EBB9
		jmp	loc_1EDA8
; ---------------------------------------------------------------------------

loc_1EBB9:				; CODE XREF: sub_1E442+772j
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1EBBC:				; CODE XREF: sub_1E442+752j
		mov	rngRolls, 1
		mov	rngRange, 0Ah
		mov	rngBaseVal, 0
		mov	rngBitMask, 0Fh
		call	GetRandom_Range
		mov	byte_10A19, al
		call	sub_1EC06
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellCure ;	"ÇbÇïÇíÇÖ\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1EC06	proc near		; CODE XREF: sub_1E442+798p
					; sub_1E442+89Dp
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, offset word_10CD0
		mov	al, [bx]
		mov	cl, [bx+1]
		add	al, byte_10A19
		jnb	short loc_1EC25
		call	sub_1EC38

loc_1EC25:				; CODE XREF: sub_1EC06+1Aj
		add	si, (offset word_10CD0+12h)
		mov	cl, [si]
		cmp	al, cl
		jbe	short loc_1EC32
		call	sub_1EC35

loc_1EC32:				; CODE XREF: sub_1EC06+27j
		mov	[bx], al
		retn
sub_1EC06	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EC35	proc near		; CODE XREF: sub_1EC06+29p
		mov	al, cl
		retn
sub_1EC35	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EC38	proc near		; CODE XREF: sub_1EC06+1Cp
		mov	al, 0FFh
		retn
sub_1EC38	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1EC3B:				; CODE XREF: sub_1E442+758j
		mov	rngRolls, 1
		mov	rngRange, 0Ah
		mov	rngBaseVal, 0
		mov	rngBitMask, 0Fh
		call	GetRandom_Range
		mov	damageDealt, al
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, offset word_10CD0
		mov	cl, [bx+1]
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellFireBall ; "ÇeÇâÇíÇÖÇaÇÅÇåÇå\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter

loc_1EC93:				; CODE XREF: sub_1E442+921j
					; sub_1E442+9BEj
		mov	al, damageDealt
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aDamageToPlr	; "\aÉ_ÉÅÅ[ÉWÅIÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	al, damageDealt
		mov	bh, 0
		mov	bl, al
		mov	ax, curHP
		sub	ax, bx
		ja	short loc_1ECB8
		jmp	loc_1E65F
; ---------------------------------------------------------------------------

loc_1ECB8:				; CODE XREF: sub_1E442+871j
		mov	curHP, ax
		call	DrawPlayerStats
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1ECC1:				; CODE XREF: sub_1E442+75Fj
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	byte_10A19, al
		call	sub_1EC06
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellHealEX	; "ÇgÇÖÇÅÇåÇâÇéÇáÇdÇw\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1ED0B:				; CODE XREF: sub_1E442+766j
		mov	rngRolls, 6
		mov	rngRange, 0Ah
		mov	rngBaseVal, 0
		mov	rngBitMask, 0Fh
		call	GetRandom_Range
		mov	damageDealt, al
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, offset word_10CD0
		mov	cl, [bx+1]
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellFireArrow ; "ÇeÇâÇíÇÖÇ`ÇíÇíÇèÇó\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1EC93
; ---------------------------------------------------------------------------

loc_1ED66:				; CODE XREF: sub_1E442+76Dj
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, offset word_10CD0
		add	si, (offset word_10CD0+12h)
		mov	al, [si]
		mov	[bx], al
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellFullHeal ; "ÇgÇÖÇÅÇåÇâÇéÇáÇoÇe\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1E464
; ---------------------------------------------------------------------------

loc_1EDA8:				; CODE XREF: sub_1E442+774j
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	damageDealt, al
		mov	bh, 0
		mov	bl, byte_11012
		sub	bx, 2
		shl	bx, 1
		mov	si, bx
		add	bx, offset word_10CD0
		mov	cl, [bx+1]
		call	ScrFlash_C6x2
		xor	ax, ax
		mov	si, offset aMonstAtk1 ;	"\a\x13\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset CurMonsterName
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aCast ; "\aÇÕ\x04\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aSpellFireStorm ; "ÇeÇâÇíÇÖÇrÇîÇèÇíÇç\n"
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aB@vgvbvuvfvubi ; "\aÇÃñÇñ@Çè•Ç¶ÇΩ\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		jmp	loc_1EC93
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


sub_1EE03	proc near		; CODE XREF: DoBattleMain+44p
		mov	si, word_10C8C
		mov	bl, [si+25h]
		and	bl, bl
		jz	short locret_1EE44
		mov	cl, bl
		mov	al, monsterCount
		and	al, al
		jnz	short loc_1EE18
		retn
; ---------------------------------------------------------------------------

loc_1EE18:				; CODE XREF: sub_1EE03+12j
					; sub_1EE03+1Ej
		push	ax
		dec	al
		call	sub_1EE24
		pop	ax
		dec	al
		jnz	short loc_1EE18
		retn
sub_1EE03	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EE24	proc near		; CODE XREF: sub_1EE03+18p
		mov	bl, al
		mov	bh, 0
		add	bx, bx
		add	bx, offset word_10CD0
		mov	dx, [bx]
		push	bx
		mov	bl, al
		mov	bh, 0
		add	bx, bx
		add	bx, (offset word_10CD0+12h)
		mov	ax, [bx]
		pop	bx
		add	dl, cl
		jb	short loc_1EE45

loc_1EE42:				; CODE XREF: sub_1EE24+23j
					; seg001:1AEBj
		mov	[bx], dx

locret_1EE44:				; CODE XREF: sub_1EE03+9j
		retn
; ---------------------------------------------------------------------------

loc_1EE45:				; CODE XREF: sub_1EE24+1Cj
		mov	dl, 0FFh
		jmp	short loc_1EE42
sub_1EE24	endp

; ---------------------------------------------------------------------------
		mov	dl, al
		jmp	short loc_1EE42

; =============== S U B	R O U T	I N E =======================================


sub_1EE4D	proc near		; CODE XREF: sub_1E442+4D6p
		mov	bh, 0
		mov	bl, byte_11012
		dec	bx
		dec	bx
		add	bx, bx
		add	bx, offset btlMonsterPtrs
		mov	bx, [bx]
		mov	al, [bx]
		cmp	al, 0
		jz	short loc_1EE65
		clc
		retn
; ---------------------------------------------------------------------------

loc_1EE65:				; CODE XREF: sub_1EE4D+14j
		stc
		retn
sub_1EE4D	endp


; =============== S U B	R O U T	I N E =======================================


CalcDamage2Mnst	proc near		; CODE XREF: sub_1E442+A8p
		mov	al, damageDealt
		mov	bl, monsterDefense
		sub	al, bl
		jbe	short loc_1EE8B
		call	ScrFlash_C7x3
		mov	damageDealt, al
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aPlrDmgDealt2 ; "\x06É_ÉÅÅ[ÉWÇ¢Ç¡ÇΩÇÌÅIÅ@ÇªÇÃí≤éqÅI\r\a"
		int	0F0h		; used by BASIC	while in interpreter
		clc
		retn
; ---------------------------------------------------------------------------

loc_1EE8B:				; CODE XREF: CalcDamage2Mnst+9j
		mov	damageDealt, 0
		stc
		retn
CalcDamage2Mnst	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1E442

loc_1EE92:				; CODE XREF: sub_1E442+90j
		mov	al, damageDealt
		push	ax
		call	ScrFlash_C7x6
		xor	ax, ax
		mov	si, offset aSlashNice ;	"\x1A\x02ÉhÉoÉVÉÖÉbÅIÅIÅ@"
		int	0F0h		; used by BASIC	while in interpreter
		mov	al, damageDealt
		add	al, al		; critical hit - double	damage
		jnb	short loc_1EEA9
		mov	al, 255

loc_1EEA9:				; CODE XREF: sub_1E442+A63j
		mov	damageDealt, al
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aPlrDmgDealt1 ; "\x06Ç¢Ç¡ÇΩÇÌÅI\r\a\x1A\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	bh, 0
		mov	bl, byte_11C5D
		dec	bx
		shl	bx, 1
		add	bx, offset btlMonsterPtrs
		mov	si, [bx]
		pop	ax
		mov	damageDealt, al
		mov	bl, al
		mov	al, [si]
		sub	al, bl
		ja	short loc_1EEDB
		jmp	loc_1E571
; ---------------------------------------------------------------------------

loc_1EEDB:				; CODE XREF: sub_1E442+A94j
		mov	[si], al
		jmp	loc_1E464
; END OF FUNCTION CHUNK	FOR sub_1E442

; =============== S U B	R O U T	I N E =======================================


CalcPlrDamage	proc near		; CODE XREF: sub_1E442:loc_1E96Ap
		mov	si, word_10C8C
		mov	bx, 0
		mov	cx, bx
		mov	dx, bx
		mov	bl, [si+1Fh]
		mov	cl, [si+20h]
		mov	dl, [si+21h]
		mov	rngRolls, bx
		mov	rngRange, cx
		mov	rngBaseVal, dx
		mov	rngBitMask, 1Fh
		call	GetRandom_Range
		mov	bl, btlPlayerDef
		cmp	hasRingOfDef, 0
		jz	short loc_1EF1C
		add	bl, 20		; has Ring Of Defense -	increase defense by 20
		jnb	short loc_1EF1C
		call	ClampBL_high255

loc_1EF1C:				; CODE XREF: CalcPlrDamage+32j
					; CalcPlrDamage+37j
		sub	al, bl
		jbe	short loc_1EF3F
		sub	al, btlPlrGuardDef
		jbe	short loc_1EF3F
		mov	damageDealt, al
		call	ScrFlash_C2x3
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aDamageToPlr	; "\aÉ_ÉÅÅ[ÉWÅIÅI\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		clc
		retn
; ---------------------------------------------------------------------------

loc_1EF3F:				; CODE XREF: CalcPlrDamage+3Ej
					; CalcPlrDamage+44j
		stc
		retn
CalcPlrDamage	endp


; =============== S U B	R O U T	I N E =======================================


ClampBL_high255	proc near		; CODE XREF: CalcPlrDamage+39p
		mov	bl, 255
		retn
ClampBL_high255	endp


; =============== S U B	R O U T	I N E =======================================


GetWeaponProps	proc near		; CODE XREF: sub_1E442+59p
		mov	bx, equippedWeapon
		mov	bh, 0
		shl	bx, 1
		add	bx, offset weaponList
		mov	si, [bx]
		mov	di, word ptr weaponName	; [BUG]	should be "mov di, offset weaponName"

loc_1EF56:				; CODE XREF: GetWeaponProps+18j
		lodsw
		and	al, al
		jz	short loc_1EF5E
		stosw
		jmp	short loc_1EF56
; ---------------------------------------------------------------------------

loc_1EF5E:				; CODE XREF: GetWeaponProps+15j
		dec	si
		dec	di
		mov	byte ptr [di], 0Ah
		add	si, 3
		mov	di, offset weaponProps
		xor	bx, bx
		mov	cx, bx
		mov	dx, bx
		lodsb
		mov	bl, al		; BX = number or RNG rolls
		stosb
		lodsb
		mov	cl, al		; CX = weapon damage range
		stosb
		lodsb
		mov	dl, al		; DX = weapon base damage
		stosb
		retn
GetWeaponProps	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EF7C	proc near		; CODE XREF: sub_1E442+99p
		push	ax
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	dl, al
		pop	ax
		mul	dl
		mov	cx, ax
		mov	al, byte_11C5D
		dec	al
		jz	short loc_1EFAE
		mov	bx, cx
		shr	bx, 1
		shr	bx, 1
		sub	cx, bx

loc_1EFAE:				; CODE XREF: sub_1EF7C+28j
		mov	bh, 0
		mov	bl, byte_11C5D
		mov	al, byte_10D01[bx]
		push	ax
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	dl, al
		pop	ax
		mul	dl
		cmp	ax, cx
		retn
sub_1EF7C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1EFDC	proc near		; CODE XREF: sub_1E442+520p
		push	ax
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	dl, al
		pop	ax
		mul	dl
		mov	cx, ax
		mov	al, byte_10A32
		dec	al
		jz	short loc_1F00E
		mov	bx, cx
		shr	bx, 1
		shr	bx, 1
		sub	cx, bx

loc_1F00E:				; CODE XREF: sub_1EFDC+28j
		mov	bh, 0
		mov	bl, byte_10A32
		mov	al, byte_10D01[bx]
		push	ax
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		mov	dl, al
		pop	ax
		mul	dl
		cmp	ax, cx
		retn
sub_1EFDC	endp


; =============== S U B	R O U T	I N E =======================================


RollPlrAtkMode	proc near		; CODE XREF: sub_1E442:plrAct1_Attackp
					; sub_1E442+510p
		mov	rngRolls, 1
		mov	rngRange, 100
		mov	rngBaseVal, 0
		mov	rngBitMask, 127
		call	GetRandom_Range
		and	al, al
		jz	short loc_1F06B	; [0, RNG fail]	- mode 0
		cmp	al, 1
		jz	short loc_1F071	; [1] -	mode 1:	critical hit
		cmp	al, 5
		jbe	short loc_1F077	; [2..5] - mode	1: critical hit
		cmp	al, 99
		jb	short loc_1F06B	; [6..98] - mode 0: normal hit
		cmp	al, 100
		jbe	short loc_1F07D	; [99..100] - mode 3: miss

loc_1F06B:				; CODE XREF: RollPlrAtkMode+1Dj
					; RollPlrAtkMode+29j
		mov	plrAttackMode, 0
		retn
; ---------------------------------------------------------------------------

loc_1F071:				; CODE XREF: RollPlrAtkMode+21j
		mov	plrAttackMode, 1
		retn
; ---------------------------------------------------------------------------

loc_1F077:				; CODE XREF: RollPlrAtkMode+25j
		mov	plrAttackMode, 1
		retn
; ---------------------------------------------------------------------------

loc_1F07D:				; CODE XREF: RollPlrAtkMode+2Dj
		mov	plrAttackMode, 3
		retn
RollPlrAtkMode	endp

; ---------------------------------------------------------------------------
		mov	plrAttackMode, 0
		retn
; ---------------------------------------------------------------------------

locret_1F089:				; DATA XREF: start+13o	start+21o
		iret
		assume ss:seg002, ds:nothing

; =============== S U B	R O U T	I N E =======================================


start		proc near

; FUNCTION CHUNK AT 2ADA SIZE 00000021 BYTES

		cli
		mov	cs:word_1FC58, es
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		or	byte ptr ds:500h, 20h
		mov	si, 14h		; set Int05
		cld
		mov	word ptr [si], offset locret_1F089
		mov	ax, cs
		mov	[si+2],	ax
		mov	si, 18h		; set Int06
		mov	bx, [si]
		mov	word ptr [si], offset locret_1F089
		mov	ax, cs
		mov	cx, [si+2]
		mov	[si+2],	ax
		push	ds
		mov	ax, seg	seg000
		mov	ds, ax
		assume ds:seg000
		mov	word_11BCD, bx
		mov	word_11BCF, cx
		pop	ds
		assume ds:nothing
		sti
		mov	bx, 3000h
		mov	ah, 4Ah
		int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
					; ES = segment address of block	to change
					; BX = new size	in paragraphs
		jnb	short loc_1F0D3
		jmp	loc_1FDA3
; ---------------------------------------------------------------------------

loc_1F0D3:				; CODE XREF: start+44j
		mov	ax, seg	seg000
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	bx, 3000h
		mov	cl, 4
		shr	bx, cl
		inc	bx
		mov	ah, 48h
		int	21h		; DOS -	2+ - ALLOCATE MEMORY
					; BX = number of 16-byte paragraphs desired
		jnb	short loc_1F0EB
		jmp	loc_1FE3A
; ---------------------------------------------------------------------------

loc_1F0EB:				; CODE XREF: start+5Cj
		mov	word_12512, ax
		jmp	short loc_1F0FF
; ---------------------------------------------------------------------------
		std
		call	sub_228A0
		cmp	ax, 0D08h
		jz	short loc_1F0FF
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_1F0FF:				; CODE XREF: start+64j	start+6Fj
		mov	ah, 2
		mov	dl, 1Ah
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		mov	ax, 403h	; PC-98	Keyboard - get input (AH=4)
		int	18h		; AL = group number
		cmp	ah, 42h		; check	for P (AH=02h) and S (AH=40h)
		jnz	short loc_1F114
		mov	cheatMode, 1	; hold "P" and "S" at boot to enable a cheat mode

loc_1F114:				; CODE XREF: start+83j
		mov	byte_11001, 3
		mov	byte_11002, 2
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		call	sub_20272
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aDungeonLoadada ; "\\DUNGEON\\LOADADA4.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonPicWaku ; " \\DUNGEON\\PIC\\WAKU.ADA"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1F161
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1F161:				; CODE XREF: start+D2j
		mov	byte_11001, 3
		mov	byte_11002, 0
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		call	sub_1F217
		mov	cl, 0
		mov	al, 1
		mov	ah, 0
		int	0F5h
		call	sub_1F5C1
		call	SetInitialStats

loc_1F189:				; CODE XREF: sub_1DE2B+1D4j
		mov	ah, 3
		int	0F0h		; used by BASIC	while in interpreter
		call	LoadDungeonFiles
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aDungeonMusicMe ; " \\DUNGEON\\MUSIC\\MEI-Q.M"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1F1C3
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1F1C3:				; CODE XREF: start+134j
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe_0 ; "PLAY.EXE"
		mov	bx, offset word_10F5F
		mov	word_10F61, offset aStart ; " START"
		mov	word_10F63, ds
		mov	word_10F65, offset byte_1005C
		mov	word_10F67, es
		mov	word_10F69, offset byte_1006C
		mov	word_10F6B, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1F1F6
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1F1F6:				; CODE XREF: start+167j
		call	DrawPlayerStats
		call	sub_1F580

loc_1F1FC:				; CODE XREF: start+186j start+18Bj
		call	DrawPlayerStats
		call	sub_1F520
		call	sub_1F6AD
		call	sub_1F580
		call	sub_1F2E9
		jb	short loc_1F212
		call	sub_1DE2B
		jmp	short loc_1F1FC
; ---------------------------------------------------------------------------

loc_1F212:				; CODE XREF: start+181j
		call	ShowItemObtain
		jmp	short loc_1F1FC
start		endp


; =============== S U B	R O U T	I N E =======================================


sub_1F217	proc near		; CODE XREF: start+EEp
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		mov	cl, 0
		mov	dx, offset aDungeonPicMove ; "\\DUNGEON\\PIC\\MOVE.MDA"
		mov	ah, 2
		int	0F5h
		mov	cl, 0
		mov	dx, offset byte_10F9F
		mov	ah, 3
		int	0F5h
		retn
sub_1F217	endp


; =============== S U B	R O U T	I N E =======================================


SetInitialStats	proc near		; CODE XREF: start+FCp
		cmp	cheatMode, 0
		jnz	short loc_1F265
		mov	btlSpellStr, 1
		mov	curLvlExp, 0
		mov	equippedWeapon,	0
		mov	equippedArmor, 0
		mov	equippedShield,	0
		mov	curGold, 50

loc_1F25B:
		call	RunStartMES
		call	CalcStrAndDex
		call	DrawPlayerStats
		retn
; ---------------------------------------------------------------------------

loc_1F265:				; CODE XREF: SetInitialStats+5j
		mov	maxHP, 255
		mov	curHP, 255
		mov	curGold, 60000
		mov	curLevel, 1
		mov	btlSpellStr, 100
		mov	curLvlExp, 0
		mov	characterStr, 255
		mov	characterDex, 255
		mov	equippedWeapon,	9
		mov	equippedArmor, 9
		mov	equippedShield,	7
		call	RunStartMES
		mov	maxHP, 255
		mov	curHP, 255
		mov	curGold, 60000
		mov	curLevel, 1
		mov	curLvlExp, 0
		mov	characterStr, 255
		mov	characterDex, 255
		mov	equippedWeapon,	9
		mov	equippedArmor, 9
		mov	equippedShield,	7
		call	CalcStrAndDex
		call	DrawPlayerStats
		retn
SetInitialStats	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F2E9	proc near		; CODE XREF: start+17Ep
		mov	si, offset floorEvtData
		lodsw
		and	ax, ax
		jz	short loc_1F2FF
		mov	cx, ax
		mov	bx, word ptr byte_11BFD

loc_1F2F7:				; CODE XREF: sub_1F2E9+14j
		lodsw
		cmp	ax, bx
		jz	short loc_1F308
		inc	si
		loop	loc_1F2F7

loc_1F2FF:				; CODE XREF: sub_1F2E9+6j
		mov	byte_10FEC, 0
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_1F308:				; CODE XREF: sub_1F2E9+11j
		lodsb
		stc
		retn
sub_1F2E9	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F30B	proc near		; CODE XREF: ShowItemObtain:loc_1DDE4p
					; ShowItemObtain+A8Ap
		mov	si, offset floorEvtData
		lodsw
		and	ax, ax
		jz	short loc_1F321
		mov	cx, ax
		mov	bx, word ptr byte_11BFD

loc_1F319:				; CODE XREF: sub_1F30B+14j
		lodsw
		cmp	ax, bx
		jz	short loc_1F325
		inc	si
		loop	loc_1F319

loc_1F321:				; CODE XREF: sub_1F30B+6j
		xor	ax, ax
		clc
		retn
; ---------------------------------------------------------------------------

loc_1F325:				; CODE XREF: sub_1F30B+11j
		xor	ax, ax
		mov	[si], al
		stc
		retn
sub_1F30B	endp


; =============== S U B	R O U T	I N E =======================================


CheckLevelUp	proc near		; CODE XREF: DoBattle:loc_1E0BCp
					; CheckLevelUp+9Bj
		mov	ax, curLevel
		cmp	ax, 200
		jnz	short loc_1F334
		retn
; ---------------------------------------------------------------------------

loc_1F334:				; CODE XREF: CheckLevelUp+6j
		mov	cx, 20
		mul	cx
		mov	cx, ax
		mov	ax, curLvlExp	; current experience points (gained since this reaching	this level)
		sub	ax, cx
		jnb	short loc_1F343	; curLvlExp >= level*20	-> level up
		retn
; ---------------------------------------------------------------------------

loc_1F343:				; CODE XREF: CheckLevelUp+15j
		mov	curLvlExp, ax
		inc	curLevel
		xor	ax, ax
		mov	si, offset aLevelUp ; "\x03\x1AÉåÉxÉãÉAÉbÉvÅ@ÅI\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	ax, curLevel
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 7
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		mov	ah, 2
		mov	dl, 7
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		xor	ax, ax
		mov	si, offset aLevelNReached ; "\aÅ@ÉåÉxÉãÇ…è„Ç™Ç¡ÇΩ\x12\r\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	CalcStatIncrease
		mov	bh, 0
		mov	bl, al
		mov	ax, maxHP
		add	ax, bx
		cmp	ax, 999
		jbe	short loc_1F37F
		mov	ax, 999

loc_1F37F:				; CODE XREF: CheckLevelUp+4Fj
		mov	maxHP, ax
		push	ax
		xor	ax, ax
		mov	si, offset aMaxHP ; "ÇgÇoÇlÇ`ÇwÇÕÅA\n"
		int	0F0h		; used by BASIC	while in interpreter
		pop	ax
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 8
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
		xor	ax, ax
		mov	si, offset aHPHasReached ; "Ç…Ç»ÇËÇ‹ÇµÇΩ\r\x12\n"
		int	0F0h		; used by BASIC	while in interpreter
		call	CalcStatIncrease
		mov	bl, al
		mov	al, characterDex
		add	al, bl
		jnb	short loc_1F3AB
		call	StatInc_Clamp255

loc_1F3AB:				; CODE XREF: CheckLevelUp+7Bj
		mov	characterDex, al
		call	CalcStatIncrease
		mov	bl, al
		mov	al, characterStr
		add	al, bl
		jnb	short loc_1F3BD
		call	StatInc_Clamp255

loc_1F3BD:				; CODE XREF: CheckLevelUp+8Dj
		mov	characterStr, al
		call	CalcStrAndDex
		call	DrawPlayerStats
		jmp	CheckLevelUp
CheckLevelUp	endp


; =============== S U B	R O U T	I N E =======================================


StatInc_Clamp255 proc near		; CODE XREF: CheckLevelUp+7Dp
					; CheckLevelUp+8Fp
		mov	al, 255
		retn
StatInc_Clamp255 endp


; =============== S U B	R O U T	I N E =======================================


CalcStatIncrease proc near		; CODE XREF: sub_1E442+686p
					; sub_1E442+698p ...
		mov	rngRolls, 1
		mov	rngRange, 6
		mov	rngBaseVal, 4
		mov	rngBitMask, 7
		call	GetRandom_Range
		retn
CalcStatIncrease endp


; =============== S U B	R O U T	I N E =======================================


CalcStrAndDex	proc near		; CODE XREF: ShowItemObtain+92Fp
					; sub_1DDA7+9p	...

; FUNCTION CHUNK AT 211C SIZE 00000016 BYTES

		mov	si, equippedArmor
		mov	di, offset armorList
		call	GetItemProps
		mov	armorDef, ch
		mov	equipmentDex, cl
		mov	equipmentStr, bl
		mov	si, equippedShield
		mov	di, offset shieldList
		call	GetItemProps
		mov	al, armorDef
		add	al, ch
		jnb	short loc_1F412
		call	ClampAL_high255

loc_1F412:				; CODE XREF: CalcStrAndDex+25j
		mov	armorDef, al
		mov	al, equipmentDex
		add	al, cl
		jnb	short loc_1F41F
		call	ClampAL_high255

loc_1F41F:				; CODE XREF: CalcStrAndDex+32j
		mov	equipmentDex, al
		mov	al, equipmentStr
		add	al, bl
		jnb	short loc_1F42C
		call	ClampAL_high255

loc_1F42C:				; CODE XREF: CalcStrAndDex+3Fj
		mov	equipmentStr, al
		mov	si, equippedWeapon
		mov	di, offset weaponList
		call	GetItemProps
		mov	al, equipmentStr
		add	al, bl
		jnb	short loc_1F443
		call	ClampAL_high255

loc_1F443:				; CODE XREF: CalcStrAndDex+56j
		mov	equipmentStr, al
		mov	al, characterStr
		cmp	hasRingOfStr, 0
		jz	short loc_1F457
		add	al, 50		; has Ring Of Strength - increase strength by 50
		jnb	short loc_1F457
		call	ClampAL_high255

loc_1F457:				; CODE XREF: CalcStrAndDex+66j
					; CalcStrAndDex+6Aj
		mov	bl, equipmentStr
		cmp	al, bl
		jb	short loc_1F47C	; too weak (character STR < equipment STR) - jump
		sub	al, bl
		mov	curStrength, al

loc_1F464:				; CODE XREF: CalcStrAndDex+A8j
		mov	al, characterDex
		mov	bl, equipmentDex
		sub	al, bl
		jnb	short loc_1F472
		call	ClampAL_low0

loc_1F472:				; CODE XREF: CalcStrAndDex+85j
		mov	curDexterity, al
		retn
CalcStrAndDex	endp


; =============== S U B	R O U T	I N E =======================================


ClampAL_high255	proc near		; CODE XREF: CalcStrAndDex+27p
					; CalcStrAndDex+34p ...
		mov	al, 255
		retn
ClampAL_high255	endp


; =============== S U B	R O U T	I N E =======================================


ClampAL_low0	proc near		; CODE XREF: CalcStrAndDex+87p
		xor	al, al
		retn
ClampAL_low0	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR CalcStrAndDex

loc_1F47C:				; CODE XREF: CalcStrAndDex+75j
		mov	curStrength, 0
		sub	bl, al
		mov	al, equipmentDex
		add	al, bl		; equipDEX += (equipSTR	- charSTR)
		jnb	short loc_1F48D
		call	ClampAL_high255

loc_1F48D:				; CODE XREF: CalcStrAndDex+A0j
		mov	equipmentDex, al
		jmp	short loc_1F464
; END OF FUNCTION CHUNK	FOR CalcStrAndDex

; =============== S U B	R O U T	I N E =======================================


GetItemProps	proc near		; CODE XREF: CalcStrAndDex+7p
					; CalcStrAndDex+1Dp ...
		shl	si, 1
		add	si, di
		mov	si, [si]	; read item pointer
		cld

loc_1F499:				; CODE XREF: GetItemProps+Aj
		lodsw			; read item name until a 00 is found
		and	al, al		; note that we check only AL (low byte)
		jnz	short loc_1F499	; we terminate when AL = 00 (name end) and AH =	1st byte of item price
		inc	si		; skip 2nd byte	of item	price
		mov	bl, [si]	; BL = Strength
		mov	cx, [si+1]	; CL = Dexterity, CH = Defense
		retn
GetItemProps	endp


; =============== S U B	R O U T	I N E =======================================


Vars_MES2Dgn	proc near		; CODE XREF: RunMESScript+Bp
		mov	si, offset MESVars
		mov	di, offset curGold
		mov	cx, 99
		rep movsb
		retn
Vars_MES2Dgn	endp


; =============== S U B	R O U T	I N E =======================================


Vars_Dgn2MES	proc near		; CODE XREF: RunMESScript+2p
		mov	si, offset curGold
		mov	di, offset MESVars
		mov	cx, 99
		rep movsb
		retn
Vars_Dgn2MES	endp


; =============== S U B	R O U T	I N E =======================================


DrawPlayerStats	proc near		; CODE XREF: ShowItemObtain+932p
					; sub_1DDA7+Cp	...
		mov	di, 3BEFh
		mov	ax, curHP
		call	DrawNumberFW_3
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ax, 815Eh
		call	DrawSJISChar_C
		mov	ax, maxHP
		call	DrawNumberFW_3
		mov	di, 42D7h
		mov	al, curStrength
		call	DrawNumberFW_03
		mov	di, 49B7h
		mov	al, curDexterity
		call	DrawNumberFW_03
		mov	di, 5773h
		mov	ax, curGold
		call	DrawNumberFW_5
		retn
DrawPlayerStats	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F6DB

loc_1F4F3:				; CODE XREF: sub_1F6DB+56j
		mov	ah, 2
		mov	dl, 7
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		mov	al, byte_11005
		cmp	al, 0Ah
		jnb	short loc_1F506
		inc	al
		mov	byte_11005, al
		retn
; ---------------------------------------------------------------------------

loc_1F506:				; CODE XREF: sub_1F6DB-1DDj
		mov	byte_11005, 0Ah
		retn
; ---------------------------------------------------------------------------

loc_1F50C:				; CODE XREF: sub_1F6DB+48j
		mov	ah, 2
		mov	dl, 7
		int	21h		; DOS -	DISPLAY	OUTPUT
					; DL = character to send to standard output
		mov	al, byte_11005
		cmp	al, 0
		jnz	short loc_1F51A
		retn
; ---------------------------------------------------------------------------

loc_1F51A:				; CODE XREF: sub_1F6DB-1C4j
		dec	al
		mov	byte_11005, al
		retn
; END OF FUNCTION CHUNK	FOR sub_1F6DB

; =============== S U B	R O U T	I N E =======================================


sub_1F520	proc near		; CODE XREF: start+175p
		push	ax
		push	cx
		mov	al, byte_11005
		cmp	al, 0
		jz	short loc_1F536
		mov	cl, al
		mov	ch, 0

loc_1F52D:				; CODE XREF: sub_1F520+14j
		push	cx
		mov	cx, 4000h

loc_1F531:				; CODE XREF: sub_1F520:loc_1F531j
		loop	loc_1F531
		pop	cx
		loop	loc_1F52D

loc_1F536:				; CODE XREF: sub_1F520+7j
		pop	cx
		pop	ax
		retn
sub_1F520	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F539	proc near		; CODE XREF: sub_1DE2B+7Ap
					; sub_1DE2B+160p ...
		cmp	byte_11002, 0
		mov	ah, 40h	; '@'
		jz	short loc_1F544
		mov	ah, 41h	; 'A'

loc_1F544:				; CODE XREF: sub_1F539+7j
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		cmp	byte_11001, 3
		mov	al, 0C0h ; '¿'
		jz	short loc_1F55A
		cmp	byte_11001, 0
		mov	al, 40h	; '@'
		jnz	short loc_1F55A
		mov	al, 80h	; 'Ä'

loc_1F55A:				; CODE XREF: sub_1F539+14j
					; sub_1F539+1Dj
		cmp	byte_11004, 0
		mov	ah, 0
		jz	short loc_1F565
		mov	ah, 10h

loc_1F565:				; CODE XREF: sub_1F539+28j
		or	al, ah
		mov	ch, al
		mov	ah, 42h	; 'B'
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, byte_11003
		out	0A6h, al	; Interrupt Controller #2, 8259A
		retn
sub_1F539	endp

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		push	ax
		push	dx
		mov	dx, ax
		mov	ah, 8
		int	0F0h		; used by BASIC	while in interpreter
		pop	dx
		pop	ax
; ---------------------------------------------------------------------------
		dw 0

; =============== S U B	R O U T	I N E =======================================


sub_1F580	proc near		; CODE XREF: ShowItemObtain+F7p
					; ShowItemObtain+17Cp ...
		call	sub_1F5D9
		call	sub_1F640
		call	sub_1FEB4
		cmp	byte_1208D, 0
		jnz	short loc_1F591
		retn
; ---------------------------------------------------------------------------

loc_1F591:				; CODE XREF: sub_1F580+Ej
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		xor	ax, ax
		mov	si, offset aDoorLocked ; "\x06åÆÇ™ÅAÇ©Ç©Ç¡ÇƒÇ¢ÇÈÇÊÅ[\n"
		int	0F0h		; used by BASIC	while in interpreter
		mov	byte_10FEB, 1
		mov	byte_1208D, 0
		retn
sub_1F580	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F5C1	proc near		; CODE XREF: start+F9p
		call	ClearTRAM
		mov	byte_11C00, 1
		mov	byte_11BFD, 0Ah
		mov	byte_11BFE, 13h
		mov	byte_11BFF, 1
		retn
sub_1F5C1	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F5D9	proc near		; CODE XREF: sub_1F580p
		mov	al, byte_11BFF
		mov	bl, al
		xor	bh, bh
		shl	bx, 1
		add	bx, offset off_120DB
		mov	si, [bx]
		mov	di, 72BFh
		mov	cx, 0Ch

loc_1F5EE:				; CODE XREF: sub_1F5D9+26j
		lodsw
		call	sub_1F60B
		call	sub_1F626
		cmp	byte_1208C, 0
		jnz	short loc_1F602
		mov	al, [bx]

loc_1F5FE:				; CODE XREF: sub_1F5D9+30j
		stosb
		loop	loc_1F5EE
		retn
; ---------------------------------------------------------------------------

loc_1F602:				; CODE XREF: sub_1F5D9+21j
		xor	al, al
		mov	byte_1208C, al
		dec	al
		jmp	short loc_1F5FE
sub_1F5D9	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F60B	proc near		; CODE XREF: sub_1F5D9+16p
		mov	bx, word ptr byte_11BFD
		add	bl, ah
		cmp	bl, byte_11BFB
		ja	short loc_1F620
		add	bh, al
		cmp	bh, byte_11BFC
		ja	short loc_1F620
		retn
; ---------------------------------------------------------------------------

loc_1F620:				; CODE XREF: sub_1F60B+Aj
					; sub_1F60B+12j
		mov	byte_1208C, 1
		retn
sub_1F60B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F626	proc near		; CODE XREF: sub_1F5D9+19p
		mov	dl, byte_11BFB
		xor	ax, ax
		mov	dh, ah
		and	bh, bh
		jz	short loc_1F638

loc_1F632:				; CODE XREF: sub_1F626+10j
		add	ax, dx
		dec	bh
		jnz	short loc_1F632

loc_1F638:				; CODE XREF: sub_1F626+Aj
		add	ax, offset floorMapData
		add	ax, bx
		mov	bx, ax
		retn
sub_1F626	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F640	proc near		; CODE XREF: sub_1F580+3p
		mov	dl, byte_11BFF
		and	dl, dl
		jnz	short loc_1F64A
		mov	dl, 4

loc_1F64A:				; CODE XREF: sub_1F640+6j
		dec	dl
		mov	dh, 30h	; '0'
		mov	si, 72BFh
		mov	di, 72CBh
		mov	bx, 4
		xor	cx, cx

loc_1F659:				; CODE XREF: sub_1F640+3Bj
		call	sub_1F67E
		jz	short loc_1F660
		and	al, dh

loc_1F660:				; CODE XREF: sub_1F640+1Cj
		mov	es:[di+4], al
		call	sub_1F67E
		jz	short loc_1F66B
		and	al, 0FCh

loc_1F66B:				; CODE XREF: sub_1F640+27j
		mov	es:[di], al
		call	sub_1F67E
		jz	short loc_1F675
		and	al, dh

loc_1F675:				; CODE XREF: sub_1F640+31j
		mov	es:[di+8], al
		inc	di
		dec	bx
		jnz	short loc_1F659
		retn
sub_1F640	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F67E	proc near		; CODE XREF: sub_1F640:loc_1F659p
					; sub_1F640+24p ...
		lodsb
		cmp	al, 0FFh
		jnz	short loc_1F684
		retn
; ---------------------------------------------------------------------------

loc_1F684:				; CODE XREF: sub_1F67E+3j
		and	dl, dl
		jz	short locret_1F690
		mov	cl, dl

loc_1F68A:				; CODE XREF: sub_1F67E+10j
		rol	al, 1
		rol	al, 1
		loop	loc_1F68A

locret_1F690:				; CODE XREF: sub_1F67E+8j
		retn
sub_1F67E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F691	proc near		; CODE XREF: ShowItemObtain+E7p
					; ShowItemObtain+16Cp ...
		mov	al, 2
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 20h
		jnz	short loc_1F6A9
		mov	al, 5
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 40h
		jnz	short loc_1F6AB
		jmp	short sub_1F691
; ---------------------------------------------------------------------------

loc_1F6A9:				; CODE XREF: sub_1F691+9j
		clc
		retn
; ---------------------------------------------------------------------------

loc_1F6AB:				; CODE XREF: sub_1F691+14j
		stc
		retn
sub_1F691	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F6AD	proc near		; CODE XREF: start+178p
		call	sub_1F6DB
		cmp	byte_10FEB, 0
		jz	short locret_1F6DA
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		mov	byte_10FEB, 0

locret_1F6DA:				; CODE XREF: sub_1F6AD+8j
		retn
sub_1F6AD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F6DB	proc near		; CODE XREF: sub_1F6ADp sub_1F6DB+A3j	...

; FUNCTION CHUNK AT 2193 SIZE 0000002D BYTES
; FUNCTION CHUNK AT 2406 SIZE 00000052 BYTES
; FUNCTION CHUNK AT 246E SIZE 00000016 BYTES
; FUNCTION CHUNK AT 249F SIZE 00000006 BYTES

		mov	byte_120DA, 1

loc_1F6E0:				; CODE XREF: sub_1F6DB+5Ej
		mov	al, 8
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_1F6EE
		jmp	loc_1F76E
; ---------------------------------------------------------------------------

loc_1F6EE:				; CODE XREF: sub_1F6DB+Ej
		test	ah, 40h
		jz	short loc_1F6F6
		jmp	sub_1F7B8
; ---------------------------------------------------------------------------

loc_1F6F6:				; CODE XREF: sub_1F6DB+16j
		mov	al, 9
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_1F704
		jmp	loc_1F7CE
; ---------------------------------------------------------------------------

loc_1F704:				; CODE XREF: sub_1F6DB+24j
		test	ah, 8
		jnz	short loc_1F766
		test	ah, 40h
		jz	short loc_1F711
		jmp	loc_1F7FF
; ---------------------------------------------------------------------------

loc_1F711:				; CODE XREF: sub_1F6DB+31j
		cmp	byte_120DA, 0
		jnz	short loc_1F734
		mov	al, 7
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_1F726
		jmp	loc_1F50C
; ---------------------------------------------------------------------------

loc_1F726:				; CODE XREF: sub_1F6DB+46j
		mov	al, 7
		mov	ah, 4
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 2
		jz	short loc_1F734
		jmp	loc_1F4F3
; ---------------------------------------------------------------------------

loc_1F734:				; CODE XREF: sub_1F6DB+3Bj
					; sub_1F6DB+54j
		mov	byte_120DA, 0
		jmp	short loc_1F6E0
sub_1F6DB	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F73B	proc near		; CODE XREF: sub_1F6DB:loc_1F766p
					; sub_1F7B8p ...
		cmp	byte_10FEC, 0
		jz	short locret_1F765
		mov	si, offset word_10FED
		mov	word ptr [si], 1
		mov	word ptr [si+2], 14Ah
		mov	word ptr [si+4], 4Dh ; 'M'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	ah, 2
		int	0F0h		; used by BASIC	while in interpreter
		mov	byte_10FEC, 0

locret_1F765:				; CODE XREF: sub_1F73B+5j
		retn
sub_1F73B	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F6DB

loc_1F766:				; CODE XREF: sub_1F6DB+2Cj
		call	sub_1F73B
		call	sub_1F7B8
		jmp	short sub_1F7B8
; ---------------------------------------------------------------------------

loc_1F76E:				; CODE XREF: sub_1F6DB+10j
		mov	al, byte_172CB
		call	sub_20236
		jz	short loc_1F79A
		cmp	al, 2
		jz	short loc_1F781
		cmp	al, 3
		jz	short loc_1F79A
		jmp	sub_1F6DB
; ---------------------------------------------------------------------------

loc_1F781:				; CODE XREF: sub_1F6DB+9Dj
		cmp	byte_10FEC, 0
		jz	short loc_1F79A
		cmp	word_11BF9, 0
		jnz	short loc_1F79A
		mov	byte_1208D, 1
		mov	byte_10FEC, 0
		retn
; ---------------------------------------------------------------------------

loc_1F79A:				; CODE XREF: sub_1F6DB+99j
					; sub_1F6DB+A1j ...
		mov	al, byte_11BFF
		shl	al, 1
		shl	al, 1
		xor	ah, ah
		add	ax, offset byte_12143
		mov	si, ax
		mov	al, [si+1]
		shl	al, 1
		shl	al, 1
		xor	ah, ah
		add	ax, offset off_12153
		mov	bx, ax
		jmp	word ptr [bx]
; END OF FUNCTION CHUNK	FOR sub_1F6DB

; =============== S U B	R O U T	I N E =======================================


sub_1F7B8	proc near		; CODE XREF: sub_1F6DB+18j
					; sub_1F6DB+8Ep ...
		call	sub_1F73B
		mov	al, byte_11BFF
		inc	al
		cmp	al, 4
		jnb	short loc_1F7C8
		mov	byte_11BFF, al
		retn
; ---------------------------------------------------------------------------

loc_1F7C8:				; CODE XREF: sub_1F7B8+Aj
		mov	byte_11BFF, 0
		retn
sub_1F7B8	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F6DB

loc_1F7CE:				; CODE XREF: sub_1F6DB+26j
		call	sub_1F73B
		mov	al, byte_11BFF
		and	al, al
		jz	short loc_1F7DE
		dec	al
		mov	byte_11BFF, al
		retn
; ---------------------------------------------------------------------------

loc_1F7DE:				; CODE XREF: sub_1F6DB+FBj
		mov	byte_11BFF, 3
		retn
; END OF FUNCTION CHUNK	FOR sub_1F6DB
; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		cmp	byte_120DA, 0
		jnz	short locret_1F7F4
		call	sub_20484
		mov	byte_120DA, 1

locret_1F7F4:				; CODE XREF: seg001:248Aj
		retn
; ---------------------------------------------------------------------------
		mov	al, ah
		shr	al, 2
		cmp	al, 1
		jmp	sub_1F6DB
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_1F6DB

loc_1F7FF:				; CODE XREF: sub_1F6DB+33j
		call	sub_1DDA7
		jmp	sub_1F6DB
; END OF FUNCTION CHUNK	FOR sub_1F6DB
; ---------------------------------------------------------------------------

loc_1F805:				; DATA XREF: seg000:off_12153o
		mov	al, byte_11BFD
		inc	al
		cmp	al, byte_11BFB
		jz	short loc_1F851
		mov	byte_11BFD, al
		mov	byte_10FE9, 0
		retn
; ---------------------------------------------------------------------------

loc_1F819:				; DATA XREF: seg000:off_12153o
		mov	al, byte_11BFE
		and	al, al
		jz	short loc_1F851
		dec	al
		mov	byte_11BFE, al
		mov	byte_10FE9, 0
		retn
; ---------------------------------------------------------------------------

loc_1F82B:				; DATA XREF: seg000:off_12153o
		mov	al, byte_11BFD
		and	al, al
		jz	short loc_1F851
		dec	al
		mov	byte_11BFD, al
		mov	byte_10FE9, 0
		retn
; ---------------------------------------------------------------------------

loc_1F83D:				; DATA XREF: seg000:off_12153o
		mov	al, byte_11BFE
		inc	al
		cmp	al, byte_11BFC
		jz	short loc_1F851
		mov	byte_11BFE, al
		mov	byte_10FE9, 0
		retn
; ---------------------------------------------------------------------------

loc_1F851:				; CODE XREF: seg001:24AEj seg001:24BEj ...
		cmp	byte_10FEA, 0
		jnz	short loc_1F85B
		jmp	sub_1F6DB
; ---------------------------------------------------------------------------

loc_1F85B:				; CODE XREF: seg001:24F6j
		call	DoShop
		retn

; =============== S U B	R O U T	I N E =======================================


ClearTRAM	proc near		; CODE XREF: sub_1F5C1p
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		xor	ax, ax
		call	ClearTRAMPlane
		mov	ax, 0A200h
		mov	es, ax
		assume es:nothing
		mov	ax, 0E1h
		call	ClearTRAMPlane
		pop	es
		assume es:nothing
		retn
ClearTRAM	endp


; =============== S U B	R O U T	I N E =======================================


ClearTRAMPlane	proc near		; CODE XREF: ClearTRAM+8p
					; ClearTRAM+13p
		mov	cx, 800h
		xor	di, di
		rep stosw
		retn
ClearTRAMPlane	endp

; ---------------------------------------------------------------------------
		pusha
		push	ds
		push	es
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	ax, seg	seg000
		mov	ds, ax
		mov	di, 190h
		mov	si, offset aFloor ; "FLOOR="
		call	sub_1F92D
		mov	al, byte_11C00
		add	al, '0'
		stosw
		mov	di, 'P'
		mov	si, offset aDir	; "DIR="
		call	sub_1F92D
		mov	al, byte_11BFF
		add	al, '0'
		stosw
		mov	di, 0F0h
		mov	al, 'X'
		stosw
		mov	al, '='
		stosw
		mov	al, byte_11BFD
		call	atostr_3dig
		inc	di
		inc	di
		mov	al, 'Y'
		stosw
		mov	al, '='
		stosw
		mov	al, byte_11BFE
		call	atostr_3dig
		mov	si, offset byte_172BF
		mov	di, 0
		mov	cx, 0Ch
		call	sub_1F8E3
		mov	si, offset byte_172CB
		mov	di, 0A0h
		mov	cx, 0Ch
		call	sub_1F8E3
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		popa
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1F8E3	proc near		; CODE XREF: seg001:2570p seg001:257Cp
		xor	ah, ah

loc_1F8E5:				; CODE XREF: sub_1F8E3+6j
		lodsb
		call	sub_1F90E
		loop	loc_1F8E5
		retn
sub_1F8E3	endp


; =============== S U B	R O U T	I N E =======================================


atostr_3dig	proc near		; CODE XREF: seg001:2556p seg001:2564p
		push	ax
		push	bx
		push	cx
		mov	bl, 100
		call	sub_1F902
		mov	bl, 10
		call	sub_1F902
		mov	bl, 1
		call	sub_1F902
		pop	cx
		pop	bx
		pop	ax
		retn
atostr_3dig	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F902	proc near		; CODE XREF: atostr_3dig+5p
					; atostr_3dig+Ap ...
		div	bl
		mov	cl, ah
		add	al, '0'
		xor	ah, ah
		stosw
		mov	al, cl
		retn
sub_1F902	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F90E	proc near		; CODE XREF: sub_1F8E3+3p
		push	ax
		and	al, 0F0h
		shr	al, 4
		add	al, '0'
		cmp	al, ':'
		jb	short loc_1F91C
		add	al, 7

loc_1F91C:				; CODE XREF: sub_1F90E+Aj
		stosw
		pop	ax
		and	al, 0Fh
		add	al, '0'
		cmp	al, ':'
		jb	short loc_1F928
		add	al, 7

loc_1F928:				; CODE XREF: sub_1F90E+16j
		stosw
		mov	al, ' '
		stosw
		retn
sub_1F90E	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F92D	proc near		; CODE XREF: seg001:2532p seg001:2541p
		xor	ax, ax

loc_1F92F:				; CODE XREF: sub_1F92D+9j
		lodsb
		cmp	al, 0FFh
		jnz	short loc_1F935
		retn
; ---------------------------------------------------------------------------

loc_1F935:				; CODE XREF: sub_1F92D+5j
		stosw
		jmp	short loc_1F92F
sub_1F92D	endp

; ---------------------------------------------------------------------------
		mov	bl, ah
		xor	bh, bh
		shl	bx, 1
		mov	cl, 0A0h ; '†'
		mul	cl
		add	ax, bx
		mov	di, ax
		retn
; [00000001 BYTES: COLLAPSED FUNCTION nullsub_1. PRESS KEYPAD "+" TO EXPAND]
; ---------------------------------------------------------------------------
		push	es
		mov	bx, 0A000h
		mov	es, bx
		assume es:nothing
		mov	byte ptr ds:2163h, 0
		mov	cl, 64h	; 'd'
		call	sub_1F975
		mov	al, ah
		mov	cl, 0Ah
		call	sub_1F975
		mov	al, ah
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_A
		pop	es
		assume es:nothing
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1F96B	proc near		; CODE XREF: seg001:264Cp seg001:2654p ...
		xor	dx, dx
		div	cx
		and	ax, ax
		jz	short loc_1F98D
		jmp	short loc_1F97D
sub_1F96B	endp


; =============== S U B	R O U T	I N E =======================================


sub_1F975	proc near		; CODE XREF: seg001:25F5p seg001:25FCp
		xor	ah, ah
		div	cl
		and	al, al
		jz	short loc_1F98D

loc_1F97D:				; CODE XREF: sub_1F96B+8j
					; sub_1F975+1Dj
		push	ax
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_A
		pop	ax
		mov	byte ptr ds:2163h, 1
		retn
; ---------------------------------------------------------------------------

loc_1F98D:				; CODE XREF: sub_1F96B+6j sub_1F975+6j
		cmp	byte ptr ds:2163h, 0
		jnz	short loc_1F97D
		push	ax
		mov	ax, 8140h
		call	DrawSJISChar_A
		pop	ax
		retn
sub_1F975	endp

; ---------------------------------------------------------------------------
		retn
; ---------------------------------------------------------------------------
		push	es
		mov	bx, 0A000h
		mov	es, bx
		assume es:nothing
		mov	byte ptr ds:2163h, 0
		mov	cx, 2710h
		call	sub_1F96B
		mov	ax, dx
		mov	cx, 3E8h
		call	sub_1F96B
		mov	ax, dx
		mov	cx, 64h	; 'd'
		call	sub_1F96B
		mov	ax, dx
		mov	cx, 0Ah
		call	sub_1F96B
		mov	ax, dx
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_A
		pop	es
		assume es:nothing
		retn

; =============== S U B	R O U T	I N E =======================================


sub_1F9D3	proc near		; CODE XREF: DrawSJISChar_A+27p
		push	dx
		mov	dx, ax
		xchg	ah, al
		sub	al, 20h	; ' '
		stosw
		mov	ah, dl
		add	ah, 80h	; 'Ä'
		stosw
		pop	dx
		retn
sub_1F9D3	endp


; =============== S U B	R O U T	I N E =======================================


DrawSJISChar_A	proc near		; CODE XREF: seg001:2606p sub_1F975+Ep ...
		push	dx
		mov	dx, ax
		mov	al, dh
		sub	al, 70h	; 'p'
		cmp	al, 30h	; '0'
		jb	short loc_1F9F0
		sub	al, 40h	; '@'

loc_1F9F0:				; CODE XREF: DrawSJISChar_A+9j
		add	al, al
		mov	dh, al
		mov	al, dl
		cmp	al, 80h	; 'Ä'
		jb	short loc_1F9FC
		dec	al

loc_1F9FC:				; CODE XREF: DrawSJISChar_A+15j
		cmp	al, 9Eh	; 'û'
		jb	short loc_1FA04
		sub	al, 5Eh	; '^'
		inc	dh

loc_1FA04:				; CODE XREF: DrawSJISChar_A+1Bj
		dec	dh
		sub	al, 1Fh
		mov	ah, dh
		call	sub_1F9D3
		pop	dx
		retn
DrawSJISChar_A	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR fopen

loc_1FA0F:				; CODE XREF: fopen+48j	fopen+6Ej ...
		mov	ax, seg	seg000
		mov	ds, ax
		assume ds:seg000
		mov	es, ax
		assume es:seg000
		mov	ah, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 11h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	al, 0
		mov	ah, 0Ch
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	ax, ds
		mov	es, ax
		mov	dx, offset aPlay_exe ; "PLAY.EXE"
		mov	bx, (offset asc_120CB+1)
		mov	word_120CE, offset aStop_0 ; "\x05 STOP"
		mov	word_120D0, ds
		mov	word_120D2, offset byte_1005C
		mov	word_120D4, es
		mov	word_120D6, offset byte_1006C
		mov	word_120D8, es
		mov	al, 0
		mov	ah, 4Bh
		int	21h		; DOS -	2+ - LOAD OR EXECUTE (EXEC)
					; DS:DX	-> ASCIZ filename
					; ES:BX	-> parameter block
					; AL = subfunc:	load & execute program
		jnb	short loc_1FA57
		jmp	loc_1FDC9
; ---------------------------------------------------------------------------

loc_1FA57:				; CODE XREF: fopen-306j
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	bx, word_11BCD
		mov	cx, word_11BCF
		xor	ax, ax
		mov	ds, ax
		assume ds:nothing
		mov	si, 18h
		mov	[si], bx
		mov	[si+2],	cx
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR fopen	; AL = exit code

; =============== S U B	R O U T	I N E =======================================


sub_1FA7B	proc near		; CODE XREF: sub_1DE2B+164p
		sti

loc_1FA7C:				; CODE XREF: sub_1FA7B+9j
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		cmp	ah, 0
		jz	short loc_1FA7C
		retn
sub_1FA7B	endp

		assume ds:seg000

; =============== S U B	R O U T	I N E =======================================


DrawNumberFW_03	proc near		; CODE XREF: DrawPlayerStats+20p
					; DrawPlayerStats+29p
		mov	word_120B1, di
		mov	byte_120B0, 7
		push	ax
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		xor	ah, ah
		mov	byte_12163, 0
		mov	cl, 100
		call	DrawDigitFW_0
		mov	al, ah
		mov	cl, 0Ah
		call	DrawDigitFW_0
		mov	al, ah
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_B
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	di, word_120B1
		retn
DrawNumberFW_03	endp


; =============== S U B	R O U T	I N E =======================================


DrawDigitFW_0	proc near		; CODE XREF: DrawNumberFW_03+19p
					; DrawNumberFW_03+20p
		xor	ah, ah
		div	cl
		and	al, al
		jz	short loc_1FB25

loc_1FAC6:				; CODE XREF: DrawDigitFW_Spc+8j
					; DrawDigitFW_Spc+Fj
		push	ax
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_B
		pop	ax
		mov	byte_12163, 1
		retn
DrawDigitFW_0	endp


; =============== S U B	R O U T	I N E =======================================


DrawSJISChar_B	proc near		; CODE XREF: DrawNumberFW_03+2Ap
					; DrawDigitFW_0+Ep ...
		pusha
		mov	dx, ax
		mov	al, dh
		sub	al, 70h	; 'p'
		cmp	al, 30h	; '0'
		jb	short loc_1FAE3
		sub	al, 40h	; '@'

loc_1FAE3:				; CODE XREF: DrawSJISChar_B+9j
		add	al, al
		mov	dh, al
		mov	al, dl
		cmp	al, 80h	; 'Ä'
		jb	short loc_1FAEF
		dec	al

loc_1FAEF:				; CODE XREF: DrawSJISChar_B+15j
		cmp	al, 9Eh	; 'û'
		jb	short loc_1FAF7
		sub	al, 5Eh	; '^'
		inc	dh

loc_1FAF7:				; CODE XREF: DrawSJISChar_B+1Bj
		dec	dh
		sub	al, 1Fh
		mov	ah, dh
		mov	dx, ax
		mov	cx, 208Eh
		mov	bx, ds
		mov	ah, 14h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	di, word_120B1
		inc	word_120B1
		inc	word_120B1
		mov	dx, di
		call	sub_1FBCD
		popa
		retn
DrawSJISChar_B	endp


; =============== S U B	R O U T	I N E =======================================


DrawDigitFW_Spc	proc near		; CODE XREF: DrawNumberFW_5+18p
					; DrawNumberFW_5+20p ...
		xor	dx, dx
		div	cx
		and	ax, ax
		jz	short loc_1FB25
		jmp	short loc_1FAC6
; ---------------------------------------------------------------------------

loc_1FB25:				; CODE XREF: DrawDigitFW_0+6j
					; DrawDigitFW_Spc+6j
		cmp	byte_12163, 0
		jnz	short loc_1FAC6
		push	ax
		mov	ax, 824Fh
		call	DrawSJISChar_B
		pop	ax
		retn
DrawDigitFW_Spc	endp


; =============== S U B	R O U T	I N E =======================================


DivAXbyCX	proc near		; CODE XREF: DrawNumberFW_3+18p
					; DrawNumberFW_3+20p
		xor	dx, dx
		div	cx
		retn
DivAXbyCX	endp


; =============== S U B	R O U T	I N E =======================================


DrawNumberFW_5	proc near		; CODE XREF: DrawPlayerStats+32p
		mov	word_120B1, di
		mov	byte_120B0, 7
		push	ax
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		mov	byte_12163, 0
		mov	cx, 10000
		call	DrawDigitFW_Spc
		mov	ax, dx
		mov	cx, 1000
		call	DrawDigitFW_Spc
		mov	ax, dx
		mov	cx, 100
		call	DrawDigitFW_Spc
		mov	ax, dx
		mov	cx, 10
		call	DrawDigitFW_Spc
		mov	ax, dx
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_B
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	di, word_120B1
		retn
DrawNumberFW_5	endp


; =============== S U B	R O U T	I N E =======================================


DrawNumberFW_3	proc near		; CODE XREF: DrawPlayerStats+6p
					; DrawPlayerStats+17p
		mov	word_120B1, di
		mov	byte_120B0, 7
		push	ax
		mov	ax, 1B01h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	ax
		mov	byte_12163, 0
		mov	cx, 10000
		call	DivAXbyCX
		mov	ax, dx
		mov	cx, 1000
		call	DivAXbyCX
		mov	byte_12163, 1
		mov	ax, dx
		mov	cx, 100
		call	DrawDigitFW_Spc
		mov	ax, dx
		mov	cx, 10
		call	DrawDigitFW_Spc
		mov	ax, dx
		xor	ah, ah
		add	ax, 824Fh
		call	DrawSJISChar_B
		mov	ax, 1B00h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	di, word_120B1
		retn
DrawNumberFW_3	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FBCD	proc near		; CODE XREF: DrawSJISChar_B+40p
					; DrawSJISChar_C+44p
		test	byte_120B0, 1
		jz	short loc_1FBDA
		mov	ax, 0A800h
		call	sub_1FBF5

loc_1FBDA:				; CODE XREF: sub_1FBCD+5j
		test	byte_120B0, 2
		jz	short loc_1FBE7
		mov	ax, 0B000h
		call	sub_1FBF5

loc_1FBE7:				; CODE XREF: sub_1FBCD+12j
		test	byte_120B0, 4
		jz	short locret_1FBF4
		mov	ax, 0B800h
		call	sub_1FBF5

locret_1FBF4:				; CODE XREF: sub_1FBCD+1Fj
		retn
sub_1FBCD	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FBF5	proc near		; CODE XREF: sub_1FBCD+Ap
					; sub_1FBCD+17p ...
		push	es
		mov	es, ax
		assume es:nothing
		mov	di, dx
		mov	si, 2090h
		mov	cx, 10h
		mov	bx, 4Eh

loc_1FC03:				; CODE XREF: sub_1FBF5+11j
		movsw
		add	di, bx
		loop	loc_1FC03
		pop	es
		retn
sub_1FBF5	endp


; =============== S U B	R O U T	I N E =======================================


DrawSJISChar_C	proc near		; CODE XREF: DrawPlayerStats+11p
		mov	word_120B1, di
		pusha
		mov	dx, ax
		mov	al, dh
		sub	al, 70h	; 'p'
		cmp	al, 30h	; '0'
		jb	short loc_1FC1B
		sub	al, 40h	; '@'

loc_1FC1B:				; CODE XREF: DrawSJISChar_C+Dj
		add	al, al
		mov	dh, al
		mov	al, dl
		cmp	al, 80h	; 'Ä'
		jb	short loc_1FC27
		dec	al

loc_1FC27:				; CODE XREF: DrawSJISChar_C+19j
		cmp	al, 9Eh	; 'û'
		jb	short loc_1FC2F
		sub	al, 5Eh	; '^'
		inc	dh

loc_1FC2F:				; CODE XREF: DrawSJISChar_C+1Fj
		dec	dh
		sub	al, 1Fh
		mov	ah, dh
		mov	dx, ax
		mov	cx, 208Eh
		mov	bx, ds
		mov	ah, 14h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	di, word_120B1
		inc	word_120B1
		inc	word_120B1
		mov	dx, di
		call	sub_1FBCD
		popa
		mov	di, word_120B1
		retn
DrawSJISChar_C	endp

; ---------------------------------------------------------------------------
		align 2
word_1FC58	dw 0			; DATA XREF: start+1w

; =============== S U B	R O U T	I N E =======================================


LoadDungeonFiles proc near		; CODE XREF: ShowItemObtain+F4p
					; ShowItemObtain+175p ...
		call	ReadFileDMAP
		call	ReadFileDEVE
		call	ReadFileMDAT
		retn
LoadDungeonFiles endp

		assume es:seg000

; =============== S U B	R O U T	I N E =======================================


ReadFileDMAP	proc near		; CODE XREF: LoadDungeonFilesp
		xor	bx, bx
		mov	bl, byte_11C00
		dec	bl
		shl	bx, 1
		add	bx, offset off_12170
		mov	si, [bx]
		mov	di, offset fileReadBuffer
		mov	cx, 28h
		rep movsw
		call	fopen
		push	ds
		mov	ds, word_12512
		mov	cx, es:word_12510
		mov	dx, 0
		mov	bx, es:word_1250E
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_1FC9A
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

loc_1FC9A:				; CODE XREF: ReadFileDMAP+31j
		xor	si, si
		mov	di, offset byte_11BFB
		movsw
		mov	di, offset floorMapData
		mov	cx, 0C8h
		cld
		rep movsw
		pop	ds
		mov	bx, word_1250E
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jnb	short locret_1FCB7
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

locret_1FCB7:				; CODE XREF: ReadFileDMAP+4Ej
		retn
ReadFileDMAP	endp


; =============== S U B	R O U T	I N E =======================================


ReadFileDEVE	proc near		; CODE XREF: LoadDungeonFiles+3p
		xor	ax, ax
		mov	al, byte_11C00
		dec	al
		shl	ax, 1
		add	ax, offset off_121F2
		mov	bx, ax
		mov	si, [bx]
		mov	di, offset fileReadBuffer
		mov	cx, 40h
		rep movsw
		call	fopen
		push	ds
		mov	ds, word_12512
		mov	cx, es:word_12510
		mov	dx, 0
		mov	bx, es:word_1250E
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_1FCEE
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

loc_1FCEE:				; CODE XREF: ReadFileDEVE+31j
		xor	si, si
		mov	di, offset floorEvtData
		mov	cx, 0C8h
		rep movsw
		pop	ds
		mov	bx, word_1250E
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jnb	short locret_1FD06
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

locret_1FD06:				; CODE XREF: ReadFileDEVE+49j
		retn
ReadFileDEVE	endp


; =============== S U B	R O U T	I N E =======================================


ReadFileMDAT	proc near		; CODE XREF: LoadDungeonFiles+6p
		xor	bx, bx
		mov	bl, byte_11C00
		dec	bl
		shl	bx, 1
		add	bx, offset off_12274
		mov	si, [bx]
		mov	di, offset fileReadBuffer
		mov	cx, 40h
		rep movsw
		call	fopen
		push	ds
		mov	ds, word_12512
		mov	cx, es:word_12510
		mov	dx, 0
		mov	bx, es:word_1250E
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_1FD3D
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

loc_1FD3D:				; CODE XREF: ReadFileMDAT+31j
		xor	si, si
		mov	di, offset floorMDatData
		mov	cx, es:word_12510
		rep movsb
		pop	ds
		mov	bx, word_1250E
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		jnb	short locret_1FD57
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

locret_1FD57:				; CODE XREF: ReadFileMDAT+4Bj
		retn
ReadFileMDAT	endp


; =============== S U B	R O U T	I N E =======================================


fopen		proc near		; CODE XREF: ReadFileDMAP+18p
					; ReadFileDEVE+18p ...

; FUNCTION CHUNK AT 26AF SIZE 0000006C BYTES

		mov	al, 0
		mov	dx, offset fileReadBuffer
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_1FD66
		jmp	loc_1FDEA
; ---------------------------------------------------------------------------

loc_1FD66:				; CODE XREF: fopen+9j
		mov	word_1250E, ax
		mov	bx, word_1250E
		mov	cx, 0
		mov	dx, 0
		mov	al, 2
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from end of file
		jnb	short loc_1FD7E
		jmp	loc_1FE12
; ---------------------------------------------------------------------------

loc_1FD7E:				; CODE XREF: fopen+21j
		mov	word_12510, ax
		mov	bx, word_1250E
		mov	cx, 0
		mov	dx, 0
		mov	al, 0
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		jb	short loc_1FE12
		retn
; ---------------------------------------------------------------------------
		mov	ax, seg	seg000
		mov	ds, ax
		mov	dx, offset aDungeonPutMove ; "Dungeon Put & Move Routine\r\nDUNGEON\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
; ---------------------------------------------------------------------------

loc_1FDA3:				; CODE XREF: start+46j
		mov	bx, seg	seg000
		mov	ds, bx
		mov	bx, 0A000h
		mov	es, bx
		assume es:nothing
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset aGbgvgkbVkxNxvV ; "ÉÅÉÇÉäÅ|Ç™ïœçXÇ≈Ç´Ç‹ÇπÇÒÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
; ---------------------------------------------------------------------------

loc_1FDC9:				; CODE XREF: sub_1DE2B+B0j
					; sub_1DE2B+E3j ...
		mov	bx, seg	seg000
		mov	ds, bx
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset aVdvwvdvbvOFsvV ; "ÇdÇwÇdÇbÇ…é∏îsÇµÇ‹ÇµÇΩÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
; ---------------------------------------------------------------------------

loc_1FDEA:				; CODE XREF: fopen+Bj
		mov	bx, seg	seg000
		mov	ds, bx
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aGtg@gcglvkgibG ; "ÉtÉ@ÉCÉãÇ™ÉIÅ[ÉvÉìÇ≈Ç´Ç‹ÇπÇÒÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset fileReadBuffer
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
; ---------------------------------------------------------------------------

loc_1FE12:				; CODE XREF: ReadFileDMAP+33j
					; ReadFileDMAP+50j ...
		mov	bx, seg	seg000
		mov	ds, bx
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aGfbGVUVNuvTjvG ; "ÉfÅ[É^Çì«Ç›çûÇ›íÜÇ…ÉGÉâÅ[Ç™î≠ê∂ÇµÇ‹ÇµÇ"...
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset fileReadBuffer
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
fopen		endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR start

loc_1FE3A:				; CODE XREF: start+5Ej
		mov	bx, seg	seg000
		mov	ds, bx
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset aGbgvgkbVkkmxVV ; "ÉÅÉÇÉäÅ[Ç™ämï€Ç≈Ç´Ç‹ÇπÇÒÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F
; END OF FUNCTION CHUNK	FOR start
; ---------------------------------------------------------------------------
		mov	bx, seg	seg000
		mov	ds, bx
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aERROR+0Ch, ax
		mov	dx, offset aERROR ; "ÇdÇqÇqÇnÇqÅ@\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_1FE7C
		mov	dx, offset aGbgvgkbVIXVOFs ; "ÉÅÉÇÉäÅ[ÇÃâï˙Ç…é∏îsÇµÇ‹ÇµÇΩÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_1FA0F

; =============== S U B	R O U T	I N E =======================================


sub_1FE7C	proc near		; CODE XREF: fopen+64p	fopen+85p ...
		mov	ah, 59h
		int	21h		; DOS -	3+ - GET EXTENDED ERROR	CODE
					; BX = version code (0000h for DOS 3.x)
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aExtErrorCodes+12h, ax
		xor	ax, ax
		mov	al, bh
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aGggibGngigxb@+0Eh, ax
		xor	ax, ax
		mov	al, bl
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aIFVSPib@+0Ch,	ax
		xor	ax, ax
		mov	al, ch
		add	ax, 824Fh
		xchg	al, ah
		mov	word ptr aXtiPuxB@+0Ah,	ax
		mov	dx, offset aExtErrorCodes ; "ägí£ÉGÉâÅ|ÉRÅ|ÉhÅ@\r\n"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		retn
sub_1FE7C	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FEB4	proc near		; CODE XREF: sub_1F580+6p
		call	sub_1FED7
		xor	ax, ax
		mov	cx, 0Eh
		mov	di, 72A3h
		rep stosw
		call	sub_20065
		call	sub_1FF07
		call	sub_1FFD6
		call	sub_1FF47
		call	sub_20258
		call	sub_202EC
		call	sub_20295
		retn
sub_1FEB4	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FED7	proc near		; CODE XREF: sub_1FEB4p
		mov	si, 72CBh
		mov	dl, byte_172A2
		xor	cx, cx
		mov	byte_1729D, cl
		mov	cl, dl
		mov	ah, 30h	; '0'

loc_1FEE8:				; CODE XREF: sub_1FED7+16j
		lodsb
		and	al, ah
		jnz	short loc_1FEF4
		loop	loc_1FEE8
		mov	byte_172A1, dl
		retn
; ---------------------------------------------------------------------------

loc_1FEF4:				; CODE XREF: sub_1FED7+14j
		mov	al, dl
		sub	al, cl
		inc	al
		mov	byte_172A1, al
		cmp	al, 4
		jz	short locret_1FF06
		mov	byte_1729D, 1

locret_1FF06:				; CODE XREF: sub_1FED7+28j
		retn
sub_1FED7	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FF07	proc near		; CODE XREF: sub_1FEB4+10p
		mov	cl, byte_172A1
		xor	ch, ch
		mov	si, 72CBh

loc_1FF10:				; CODE XREF: sub_1FF07+3Dj
		mov	al, ch
		shl	al, 1
		add	al, ch
		xor	ah, ah
		add	ax, 72D7h
		mov	di, ax
		mov	al, [si]
		call	sub_2024E
		jz	short loc_1FF27
		call	sub_2007D

loc_1FF27:				; CODE XREF: sub_1FF07+1Bj
		inc	di
		mov	al, [si]
		call	sub_2022D
		jz	short loc_1FF32
		call	sub_2007D

loc_1FF32:				; CODE XREF: sub_1FF07+26j
		inc	di
		mov	al, [si]
		call	sub_20236
		jz	short loc_1FF3D
		call	sub_2007D

loc_1FF3D:				; CODE XREF: sub_1FF07+31j
		inc	ch
		cmp	ch, cl
		jz	short locret_1FF46
		inc	si
		jmp	short loc_1FF10
; ---------------------------------------------------------------------------

locret_1FF46:				; CODE XREF: sub_1FF07+3Aj
		retn
sub_1FF07	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FF47	proc near		; CODE XREF: sub_1FEB4+16p
		xor	cx, cx
		mov	cl, byte_172A1
		cmp	byte_1729D, 0
		jz	short loc_1FF56
		inc	cl

loc_1FF56:				; CODE XREF: sub_1FF47+Bj
		mov	si, 72CFh
		mov	bx, 72CBh

loc_1FF5C:				; CODE XREF: sub_1FF47+7Ej
		push	cx
		xor	ax, ax
		mov	byte_1729F, al
		mov	al, ch
		shl	al, 1
		add	ax, 72E3h
		mov	di, ax
		mov	al, [si]
		call	sub_20236
		jz	short loc_1FFBC
		mov	al, [bx]
		call	sub_2024E
		jz	short loc_1FF7E
		or	byte_1729F, 1

loc_1FF7E:				; CODE XREF: sub_1FF47+30j
		and	ch, ch
		jz	short loc_1FFC8
		mov	al, [bx-1]
		call	sub_20236
		jz	short loc_1FF8F
		or	byte_1729F, 1

loc_1FF8F:				; CODE XREF: sub_1FF47+41j
		mov	al, [bx-1]
		call	sub_2024E
		jz	short loc_1FF9C
		or	byte_1729F, 2

loc_1FF9C:				; CODE XREF: sub_1FF47+4Ej
		mov	al, [si-1]
		call	sub_20236
		jz	short loc_1FFA9
		or	byte_1729F, 2

loc_1FFA9:				; CODE XREF: sub_1FF47+5Bj
		mov	al, byte_1729F
		ror	al, 1
		push	ax
		jb	short loc_1FFB4
		call	sub_20071

loc_1FFB4:				; CODE XREF: sub_1FF47+68j
		pop	ax
		ror	al, 1
		jb	short loc_1FFBC
		call	sub_2007A

loc_1FFBC:				; CODE XREF: sub_1FF47+29j
					; sub_1FF47+70j ...
		pop	cx
		inc	ch
		cmp	ch, cl
		jz	short locret_1FFC7
		inc	bx
		inc	si
		jmp	short loc_1FF5C
; ---------------------------------------------------------------------------

locret_1FFC7:				; CODE XREF: sub_1FF47+7Aj
		retn
; ---------------------------------------------------------------------------

loc_1FFC8:				; CODE XREF: sub_1FF47+39j
		cmp	byte_1729F, 0
		jnz	short loc_1FFBC
		mov	al, [si]
		call	sub_20088
		jmp	short loc_1FFBC
sub_1FF47	endp


; =============== S U B	R O U T	I N E =======================================


sub_1FFD6	proc near		; CODE XREF: sub_1FEB4+13p
		xor	cx, cx
		mov	cl, byte_172A1
		cmp	byte_1729D, 0
		jz	short loc_1FFE5
		inc	cl

loc_1FFE5:				; CODE XREF: sub_1FFD6+Bj
		mov	si, 72D3h
		mov	bx, 72CBh

loc_1FFEB:				; CODE XREF: sub_1FFD6+7Ej
		push	cx
		xor	ax, ax
		mov	byte_1729F, al
		mov	al, ch
		shl	al, 1
		add	ax, 72EBh
		mov	di, ax
		mov	al, [si]
		call	sub_20236
		jz	short loc_2004B
		mov	al, [bx]
		call	sub_2022D
		jz	short loc_2000D
		or	byte_1729F, 1

loc_2000D:				; CODE XREF: sub_1FFD6+30j
		and	ch, ch
		jz	short loc_20057
		mov	al, [bx-1]
		call	sub_20236
		jz	short loc_2001E
		or	byte_1729F, 1

loc_2001E:				; CODE XREF: sub_1FFD6+41j
		mov	al, [bx-1]
		call	sub_2022D
		jz	short loc_2002B
		or	byte_1729F, 2

loc_2002B:				; CODE XREF: sub_1FFD6+4Ej
		mov	al, [si-1]
		call	sub_20236
		jz	short loc_20038
		or	byte_1729F, 2

loc_20038:				; CODE XREF: sub_1FFD6+5Bj
		mov	al, byte_1729F
		ror	al, 1
		push	ax
		jb	short loc_20043
		call	sub_20071

loc_20043:				; CODE XREF: sub_1FFD6+68j
		pop	ax
		ror	al, 1
		jb	short loc_2004B
		call	sub_2007A

loc_2004B:				; CODE XREF: sub_1FFD6+29j
					; sub_1FFD6+70j ...
		pop	cx
		inc	ch
		cmp	ch, cl
		jz	short locret_20056
		inc	bx
		inc	si
		jmp	short loc_1FFEB
; ---------------------------------------------------------------------------

locret_20056:				; CODE XREF: sub_1FFD6+7Aj
		retn
; ---------------------------------------------------------------------------

loc_20057:				; CODE XREF: sub_1FFD6+39j
		cmp	byte_1729F, 0
		jnz	short loc_2004B
		mov	al, [si]
		call	sub_20088
		jmp	short loc_2004B
sub_1FFD6	endp


; =============== S U B	R O U T	I N E =======================================


sub_20065	proc near		; CODE XREF: sub_1FEB4+Dp
		cld
		xor	ax, ax
		mov	di, 2666h
		mov	cx, 2440h
		rep stosw
		retn
sub_20065	endp


; =============== S U B	R O U T	I N E =======================================


sub_20071	proc near		; CODE XREF: sub_1FF47+6Ap
					; sub_1FFD6+6Ap
		push	di
		inc	di

loc_20073:				; CODE XREF: sub_2007A+1j
		mov	al, [si]
		call	sub_20088
		pop	di
		retn
sub_20071	endp


; =============== S U B	R O U T	I N E =======================================


sub_2007A	proc near		; CODE XREF: sub_1FF47+72p
					; sub_1FFD6+72p
		push	di
		jmp	short loc_20073
sub_2007A	endp


; =============== S U B	R O U T	I N E =======================================


sub_2007D	proc near		; CODE XREF: sub_1FF07+1Dp
					; sub_1FF07+28p ...
		pusha
		call	sub_20096
		mov	al, [di]
		call	sub_200BA
		popa
		retn
sub_2007D	endp


; =============== S U B	R O U T	I N E =======================================


sub_20088	proc near		; CODE XREF: sub_1FF47+8Ap
					; sub_1FFD6+8Ap ...
		pusha
		call	sub_20243
		call	sub_20096
		mov	al, [di]
		call	sub_200BA
		popa
		retn
sub_20088	endp


; =============== S U B	R O U T	I N E =======================================


sub_20096	proc near		; CODE XREF: sub_2007D+1p sub_20088+4p
		cmp	al, 2
		jz	short loc_200A0
		cmp	al, 3
		jz	short locret_200B9
		jmp	short locret_200B9
; ---------------------------------------------------------------------------

loc_200A0:				; CODE XREF: sub_20096+2j
		push	bx
		push	ax
		mov	dl, [di]
		xor	bx, bx
		mov	bl, byte_172A3
		mov	al, bl
		add	bx, 72A4h
		mov	[bx], dl
		inc	al
		mov	byte_172A3, al
		pop	ax
		pop	bx

locret_200B9:				; CODE XREF: sub_20096+6j sub_20096+8j
		retn
sub_20096	endp


; =============== S U B	R O U T	I N E =======================================


sub_200BA	proc near		; CODE XREF: sub_2007D+6p sub_20088+9p
		mov	cx, 72F3h
		call	sub_200CA
		call	sub_200D9
		call	sub_20141
		call	sub_2019F
		retn
sub_200BA	endp


; =============== S U B	R O U T	I N E =======================================


sub_200CA	proc near		; CODE XREF: sub_200BA+3p
		dec	al
		shl	al, 1
		xor	ah, ah
		add	ax, cx
		mov	bx, ax
		mov	ax, [bx]
		mov	bx, ax
		retn
sub_200CA	endp


; =============== S U B	R O U T	I N E =======================================


sub_200D9	proc near		; CODE XREF: sub_200BA+6p
					; sub_200D9+1Cj
		mov	al, [bx]
		inc	bx
		cmp	al, 0FFh
		jz	short locret_200F7
		push	bx
		dec	al
		shl	al, 1
		xor	ah, ah
		add	ax, 73B3h
		mov	bx, ax
		mov	ax, [bx]
		call	sub_200F8
		call	sub_20131
		pop	bx
		jmp	short sub_200D9
; ---------------------------------------------------------------------------

locret_200F7:				; CODE XREF: sub_200D9+5j
		retn
sub_200D9	endp


; =============== S U B	R O U T	I N E =======================================


sub_200F8	proc near		; CODE XREF: sub_200D9+15p
		push	ax
		mov	dl, al
		mov	al, ah
		xor	dh, dh
		mov	ah, dh
		shl	ax, 1
		mov	bx, ax
		shl	ax, 1
		mov	cx, ax
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		shl	ax, 1
		sub	ax, bx
		sub	ax, cx
		add	ax, dx
		add	ax, 2666h
		mov	di, ax
		pop	ax
		jmp	short $+2
		xor	dx, dx
		cmp	al, 28h	; '('
		jb	short loc_20127
		inc	dl

loc_20127:				; CODE XREF: sub_200F8+2Bj
		mov	cx, 0A0h ; '†'
		mov	bl, ah
		xor	bh, bh
		sub	cx, bx
		retn
sub_200F8	endp


; =============== S U B	R O U T	I N E =======================================


sub_20131	proc near		; CODE XREF: sub_200D9+18p
					; sub_20324+31p
		push	cx
		push	di
		mov	al, 0C0h ; '¿'
		mov	bx, 3Ah	; ':'

loc_20138:				; CODE XREF: sub_20131+Bj
		or	[di], al
		add	di, bx
		loop	loc_20138
		pop	di
		pop	cx
		retn
sub_20131	endp


; =============== S U B	R O U T	I N E =======================================


sub_20141	proc near		; CODE XREF: sub_200BA+9p
					; sub_20141+27j
		mov	al, [bx]
		inc	bx
		cmp	al, 0FFh
		jnz	short loc_20149
		retn
; ---------------------------------------------------------------------------

loc_20149:				; CODE XREF: sub_20141+5j
		push	bx
		dec	al
		mov	ah, al
		shl	al, 1
		add	al, ah
		xor	ah, ah
		add	ax, 73D3h
		mov	si, ax
		lodsw
		xor	cx, cx
		mov	cl, [si]
		mov	di, ax
		add	di, 2666h
		call	sub_2016A
		pop	bx
		jmp	short sub_20141
sub_20141	endp


; =============== S U B	R O U T	I N E =======================================


sub_2016A	proc near		; CODE XREF: sub_20141+23p
					; sub_2035B+21p
		push	cx
		push	di
		mov	bx, di
		mov	si, bx
		test	cx, 1
		jz	short loc_20189
		mov	al, 0FFh
		mov	dx, cx
		rep stosb
		mov	di, bx
		add	di, 3Ah	; ':'
		mov	cx, dx
		nop
		rep stosb
		pop	di
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_20189:				; CODE XREF: sub_2016A+Aj
		mov	ax, 0FFFFh
		shr	cx, 1
		mov	dx, cx
		rep stosw
		mov	di, bx
		add	di, 3Ah	; ':'
		mov	cx, dx
		nop
		rep stosw
		pop	di
		pop	cx
		retn
sub_2016A	endp


; =============== S U B	R O U T	I N E =======================================


sub_2019F	proc near		; CODE XREF: sub_200BA+Cp
					; sub_2019F+1Aj
		mov	al, [bx]
		cmp	al, 0FFh
		jnz	short loc_201A6
		retn
; ---------------------------------------------------------------------------

loc_201A6:				; CODE XREF: sub_2019F+4j
		inc	bx
		push	bx
		dec	al
		shl	al, 1
		xor	ah, ah
		add	ax, 7409h
		mov	bx, ax
		mov	ax, [bx]
		call	sub_201BB
		pop	bx
		jmp	short sub_2019F
sub_2019F	endp


; =============== S U B	R O U T	I N E =======================================


sub_201BB	proc near		; CODE XREF: sub_2019F+16p
		xor	cx, cx
		mov	cl, ah
		push	ax

loc_201C0:				; CODE XREF: sub_201BB+Ej
		push	cx
		push	ax
		call	sub_201CD
		pop	ax
		pop	cx
		inc	al
		loop	loc_201C0
		pop	ax
		retn
sub_201BB	endp


; =============== S U B	R O U T	I N E =======================================


sub_201CD	proc near		; CODE XREF: sub_201BB+7p
		cmp	al, 14h
		jnb	short loc_201EF
		xor	ah, ah
		mov	di, ax
		call	sub_20212

loc_201D8:				; CODE XREF: sub_203BF:loc_203E9j
		mov	al, 0C0h ; '¿'
		mov	dx, 3Ah	; ':'
		mov	cx, 4

loc_201E0:				; CODE XREF: sub_201CD+1Fj
		or	[di], al
		add	di, dx
		or	[di], al
		add	di, dx
		ror	al, 1
		ror	al, 1
		loop	loc_201E0
		retn
; ---------------------------------------------------------------------------

loc_201EF:				; CODE XREF: sub_201CD+2j
		xor	ah, ah
		mov	di, ax
		sub	al, 27h	; '''
		neg	al
		call	sub_20212
		inc	di

loc_201FB:				; CODE XREF: sub_203BF+27j
		mov	al, 0C0h ; '¿'
		mov	dx, 3Ah	; ':'
		mov	cx, 4

loc_20203:				; CODE XREF: sub_201CD+42j
		or	[di], al
		sub	di, dx
		or	[di], al
		sub	di, dx
		ror	al, 1
		ror	al, 1
		loop	loc_20203
		retn
sub_201CD	endp


; =============== S U B	R O U T	I N E =======================================


sub_20212	proc near		; CODE XREF: sub_201CD+8p
					; sub_201CD+2Ap
		xor	dx, dx
		mov	dh, al
		shl	dx, 1
		shl	ax, 4
		mov	bx, ax
		shl	ax, 1
		add	bx, ax
		sub	dx, bx
		mov	ax, dx
		add	ax, di
		add	ax, 266Fh
		mov	di, ax
		retn
sub_20212	endp


; =============== S U B	R O U T	I N E =======================================


sub_2022D	proc near		; CODE XREF: sub_1FF07+23p
					; sub_1FFD6+2Dp ...
		and	al, 0C0h
		jz	short locret_20257
		rol	al, 1
		rol	al, 1
		retn
sub_2022D	endp


; =============== S U B	R O U T	I N E =======================================


sub_20236	proc near		; CODE XREF: sub_1F6DB+96p
					; sub_1FF07+2Ep ...
		and	al, 30h
		jz	short locret_20257
		ror	al, 1
		ror	al, 1
		ror	al, 1
		ror	al, 1
		retn
sub_20236	endp


; =============== S U B	R O U T	I N E =======================================


sub_20243	proc near		; CODE XREF: sub_20088+1p
		and	al, 30h
		ror	al, 1
		ror	al, 1
		ror	al, 1
		ror	al, 1
		retn
sub_20243	endp


; =============== S U B	R O U T	I N E =======================================


sub_2024E	proc near		; CODE XREF: sub_1FF07+18p
					; sub_1FF47+2Dp ...
		and	al, 0Ch
		jz	short locret_20257
		ror	al, 1
		ror	al, 1
		retn
; ---------------------------------------------------------------------------

locret_20257:				; CODE XREF: sub_2022D+2j sub_20236+2j ...
		retn
sub_2024E	endp


; =============== S U B	R O U T	I N E =======================================


sub_20258	proc near		; CODE XREF: sub_1FEB4+19p
		mov	si, 4A6Ch
		mov	di, 4AA6h
		mov	dx, 1Dh
		mov	ax, 0A0h ; '†'
		mov	bx, 74h	; 't'
		cld

loc_20268:				; CODE XREF: sub_20258+17j
		mov	cx, dx
		rep movsw
		sub	si, bx
		dec	ax
		jnz	short loc_20268
		retn
sub_20258	endp


; =============== S U B	R O U T	I N E =======================================


sub_20272	proc near		; CODE XREF: sub_1DE2B+7Dp
					; sub_1DE2B+167p ...
		push	es
		mov	es, word_17295
		assume es:nothing
		call	sub_2028A
		mov	es, word_17297
		assume es:nothing
		call	sub_2028A
		mov	es, word_17299
		assume es:nothing
		call	sub_2028A
		pop	es
		assume es:nothing
		retn
sub_20272	endp


; =============== S U B	R O U T	I N E =======================================


sub_2028A	proc near		; CODE XREF: sub_20272+5p sub_20272+Cp ...
		xor	ax, ax
		mov	di, ax
		mov	cx, 3E80h
		cld
		rep stosw
		retn
sub_2028A	endp


; =============== S U B	R O U T	I N E =======================================


sub_20295	proc near		; CODE XREF: ShowItemObtain+4EDp
					; ShowItemObtain+519p ...
		push	es
		mov	es, word_17295
		assume es:nothing

loc_2029A:				; CODE XREF: sub_20295+9j
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 20h
		jnz	short loc_2029A

loc_202A0:				; CODE XREF: sub_20295+Fj
		in	al, 0A0h	; PIC 2	 same as 0020 for PIC 1
		and	al, 20h
		jz	short loc_202A0
		mov	si, 2666h
		mov	di, 142h
		mov	bx, 1Dh
		mov	dx, 16h
		mov	bp, 140h

loc_202B5:				; CODE XREF: sub_20295+53j
		mov	al, 80h	; 'Ä'
		cli
		out	7Ch, al
		xor	ax, ax
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		xor	ax, ax
		push	di
		mov	cx, bx
		rep stosw
		pop	di
		xor	ax, ax
		out	7Ch, al
		sti
		mov	al, 0C0h ; '¿'
		cli
		out	7Ch, al
		mov	al, 0FFh
		out	7Eh, al
		out	7Eh, al
		out	7Eh, al
		mov	cx, bx
		rep movsw
		xor	ax, ax
		out	7Ch, al
		sti
		add	di, dx
		dec	bp
		jnz	short loc_202B5
		pop	es
		assume es:nothing
		retn
sub_20295	endp


; =============== S U B	R O U T	I N E =======================================


sub_202EC	proc near		; CODE XREF: sub_1FEB4+1Cp
		mov	al, byte_172A3
		and	al, al
		jz	short locret_20323
		xor	cx, cx
		mov	cl, al
		mov	bx, 72A4h

loc_202FA:				; CODE XREF: sub_202EC+35j
		push	cx
		xor	ax, ax
		mov	byte_1729E, al
		mov	al, [bx]
		push	bx
		dec	al
		shl	al, 1
		add	ax, 7419h
		mov	bx, ax
		mov	si, [bx]
		call	sub_20324
		cmp	byte_1729E, 0
		jnz	short loc_2031E
		call	sub_2035B
		call	sub_20382

loc_2031E:				; CODE XREF: sub_202EC+2Aj
		pop	bx
		pop	cx
		inc	bx
		loop	loc_202FA

locret_20323:				; CODE XREF: sub_202EC+5j
		retn
sub_202EC	endp


; =============== S U B	R O U T	I N E =======================================


sub_20324	proc near		; CODE XREF: sub_202EC+22p
					; sub_20324+35j

; FUNCTION CHUNK AT 308C SIZE 00000016 BYTES
; FUNCTION CHUNK AT 30B4 SIZE 0000000B BYTES

		lodsb
		cmp	al, 0FFh
		jnz	short loc_2032A
		retn
; ---------------------------------------------------------------------------

loc_2032A:				; CODE XREF: sub_20324+3j
		cmp	al, 80h	; 'Ä'
		jb	short loc_20331
		jmp	loc_203EC
; ---------------------------------------------------------------------------

loc_20331:				; CODE XREF: sub_20324+8j
		push	si
		dec	al
		xor	bx, bx
		mov	bl, al
		shl	bl, 1
		shl	bl, 1
		add	bx, 74D5h
		mov	di, [bx]
		add	di, 2666h
		inc	bx
		inc	bx
		xor	cx, cx
		mov	cl, [bx]
		shl	cx, 1
		shl	cx, 1
		inc	bx
		xor	dx, dx
		mov	dl, [bx]
		call	sub_20131
		pop	si
		jmp	short sub_20324
sub_20324	endp


; =============== S U B	R O U T	I N E =======================================


sub_2035B	proc near		; CODE XREF: sub_202EC+2Cp
					; sub_2035B+25j
		lodsb
		cmp	al, 0FFh
		jnz	short loc_20361
		retn
; ---------------------------------------------------------------------------

loc_20361:				; CODE XREF: sub_2035B+3j
		push	si
		dec	al
		mov	ah, al
		shl	al, 1
		add	al, ah
		xor	ah, ah
		add	ax, offset byte_1755D
		mov	si, ax
		lodsw
		xor	cx, cx
		mov	cl, [si]
		mov	di, ax
		add	di, offset byte_12666
		call	sub_2016A
		pop	si
		jmp	short sub_2035B
sub_2035B	endp


; =============== S U B	R O U T	I N E =======================================


sub_20382	proc near		; CODE XREF: sub_202EC+2Fp
					; sub_20382+21j
		lodsb
		cmp	al, 0FFh
		jnz	short loc_20388
		retn
; ---------------------------------------------------------------------------

loc_20388:				; CODE XREF: sub_20382+3j
		push	si
		dec	al
		mov	bl, al
		shl	al, 1
		add	bl, al
		xor	bh, bh
		add	bx, offset byte_17593
		mov	ax, [bx]
		inc	bx
		inc	bx
		xor	cx, cx
		mov	cl, [bx]
		call	sub_203A5
		pop	si
		jmp	short sub_20382
sub_20382	endp


; =============== S U B	R O U T	I N E =======================================


sub_203A5	proc near		; CODE XREF: sub_20382+1Dp
		pusha

loc_203A6:				; CODE XREF: sub_203A5+10j
					; sub_203A5+16j
		push	cx
		push	ax
		call	sub_203BF
		pop	ax
		pop	cx
		inc	al
		cmp	al, 1Dh
		jnb	short loc_203B9
		inc	ah
		loop	loc_203A6
		popa
		retn
; ---------------------------------------------------------------------------

loc_203B9:				; CODE XREF: sub_203A5+Cj
		dec	ah
		loop	loc_203A6
		popa
		retn
sub_203A5	endp


; =============== S U B	R O U T	I N E =======================================


sub_203BF	proc near		; CODE XREF: sub_203A5+3p
		push	ax
		xor	cx, cx
		mov	bx, cx
		mov	dx, cx
		mov	cl, al
		mov	bh, ah
		mov	dl, ah
		shl	dx, 4
		mov	ax, dx
		shl	dx, 1
		add	dx, ax
		shl	bx, 1
		sub	bx, dx
		add	bx, cx
		mov	di, bx
		add	di, offset byte_12666
		pop	ax
		cmp	al, 1Dh
		jb	short loc_203E9
		jmp	loc_201FB
; ---------------------------------------------------------------------------

loc_203E9:				; CODE XREF: sub_203BF+25j
		jmp	loc_201D8
sub_203BF	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_20324

loc_203EC:				; CODE XREF: sub_20324+Aj
		mov	di, [si]
		add	di, offset byte_12666
		mov	bx, 3Ah	; ':'
		cmp	al, 81h	; 'Å'
		jz	short loc_20414
		call	sub_20402
		mov	byte_1729E, 1
		retn
; END OF FUNCTION CHUNK	FOR sub_20324

; =============== S U B	R O U T	I N E =======================================


sub_20402	proc near		; CODE XREF: sub_20324+D5p
		mov	dx, di
		mov	si, offset byte_175AB
		mov	cx, 34h	; '4'

loc_2040A:				; CODE XREF: sub_20402+Dj sub_2041F+8j
		lodsw
		or	[di], ax
		add	di, bx
		loop	loc_2040A
		mov	di, dx
		retn
sub_20402	endp

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_20324

loc_20414:				; CODE XREF: sub_20324+D3j
		push	es
		call	sub_2041F
		pop	es
		mov	byte_1729E, 1
		retn
; END OF FUNCTION CHUNK	FOR sub_20324

; =============== S U B	R O U T	I N E =======================================


sub_2041F	proc near		; CODE XREF: sub_20324+F1p
		mov	dx, di
		mov	si, offset byte_17615
		mov	cx, 32h	; '2'
		jmp	short loc_2040A
sub_2041F	endp

; ---------------------------------------------------------------------------
		mov	byte_11001, 3
		mov	byte_11002, 0
		mov	byte_11003, 0
		mov	byte_11004, 0
		call	sub_1F539
		mov	al, 37h
		out	0A8h, al	; Interrupt Controller #2, 8259A
		mov	al, 15h
		out	0AAh, al	; Interrupt Controller #2, 8259A
		mov	al, 26h
		out	0ACh, al	; Interrupt Controller #2, 8259A
		mov	al, 4
		out	0AEh, al	; Interrupt Controller #2, 8259A
		push	es
		mov	ax, 0E000h
		mov	es, ax
		assume es:nothing
		cld
		xor	di, di
		mov	cx, 3E80h
		xor	ax, ax
		rep stosw
		pop	es
		assume es:nothing
		retn
; ---------------------------------------------------------------------------
		mov	si, 0FEDh
		mov	word ptr [si], 1
		mov	word ptr [si+2], 17Ch
		mov	word ptr [si+4], 4Eh ; 'N'
		mov	word ptr [si+6], 18Ch
		mov	ah, 1
		int	0F0h		; used by BASIC	while in interpreter
		mov	si, offset asc_171FC ; "ÉRÉ}ÉìÉhÅ@ÇPÅ@\x1C"
		mov	ah, 4
		int	0F0h		; used by BASIC	while in interpreter
		retn

; =============== S U B	R O U T	I N E =======================================


sub_20484	proc near		; CODE XREF: seg001:248Cp
		mov	ax, 500h
		int	0F0h		; used by BASIC	while in interpreter
		retn
sub_20484	endp


; =============== S U B	R O U T	I N E =======================================


GetRandom_Range	proc near		; CODE XREF: ShowItemObtain+1DDp
					; ShowItemObtain+22Ep ...
		push	bx
		push	cx
		push	dx
		xor	ah, ah
		mov	bx, offset byte_17699
		int	1Ch		; CLOCK	TICK
		xor	dx, dx
		mov	cx, rngRolls
		mov	bx, rngRange
		mov	bp, rngBitMask
		cmp	cx, 0
		jz	short loc_204B5

loc_204A7:				; CODE XREF: GetRandom_Range+24j
					; GetRandom_Range+29j
		call	RNG_GetNext
		and	ax, bp
		cmp	ax, bx
		jnb	short loc_204A7	; try again, if	the result is >= rngRang
		inc	ax		; result is [1..N]
		add	dx, ax		; accumulate multiple rolls
		loop	loc_204A7	; roll CX times

loc_204B5:				; CODE XREF: GetRandom_Range+1Bj
		mov	ax, dx
		add	ax, rngBaseVal
		pop	dx
		pop	cx
		pop	bx
		retn
GetRandom_Range	endp


; =============== S U B	R O U T	I N E =======================================


RNG_GetNext	proc near		; CODE XREF: GetRandom_Range:loc_204A7p
		call	RNG_Advance
		add	ax, word_1769D
		add	ax, word_1769D+1
		add	ax, word_1769F
		mov	word_1769F, ax
		add	ax, bx
		add	ax, word_176A3
		add	ax, word_176A5
		add	ax, word_176A7
		add	ax, word_176A9
		add	word_176A1, ax
		add	ax, word_176A1
		call	RNG_Advance
		retn
RNG_GetNext	endp


; =============== S U B	R O U T	I N E =======================================


RNG_Advance	proc near		; CODE XREF: RNG_GetNextp
					; RNG_GetNext+2Cp
		add	word_176A9, ax
		add	word_176A9, 7558h
		mov	ax, word_176A9
		add	ax, word_176A7
		add	ax, 8164h
		mov	word_176A7, ax
		add	ax, word_176A5
		add	ax, 495Dh
		mov	word_176A5, ax
		add	ax, word_176A3
		add	ax, 0FD46h
		mov	word_176A3, ax
		retn
RNG_Advance	endp

; ---------------------------------------------------------------------------
		db 5 dup(0)

; =============== S U B	R O U T	I N E =======================================


ExecMESFile	proc near		; CODE XREF: RunMESScript+7p
		push	es
		mov	cx, seg	seg000
		mov	ds, cx
		mov	es, cx
		assume es:seg000
		mov	word_1798E, ax
		push	bx
		mov	di, offset mesFilePath

loc_2052F:				; CODE XREF: ExecMESFile+17j
		mov	al, [bx]
		mov	[di], al
		inc	bx
		inc	di
		cmp	al, 0
		jnz	short loc_2052F
		pop	bx
		mov	dx, bx
		mov	bx, off_1799E
		call	ReadMESFile
		mov	ax, seg	seg000
		mov	word ptr dword_1CBCE+2,	ax
		mov	si, off_1799E
		mov	ah, 0Ah
		mov	al, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 1Bh
		mov	al, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		call	ClearTRAM2
		pop	es
		assume es:nothing
		pop	ds
		assume ds:nothing
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		call	sub_2058F
		mov	ah, 1Bh
		mov	al, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	cx, seg	seg000
		mov	ds, cx
		assume ds:seg000
		mov	byte_1CCDB, 9
		mov	byte_1CCDC, 9
		pop	es
		mov	ax, off_17968+14h
		retn
ExecMESFile	endp


; =============== S U B	R O U T	I N E =======================================


sub_2058F	proc near		; CODE XREF: ExecMESFile+52p
		mov	ax, sp
		mov	word_1CAC0, ax
sub_2058F	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


DrawDialogText	proc near		; CODE XREF: DrawDialogText+49j
					; DrawDialogText+92j ...
		call	PushPopAllRegs	; draw text to the dialog box at the bottom of the screen
		cmp	byte_1CBD2, 0
		jz	short loc_205AD
		mov	byte_1CBD2, 0
		mov	dx, 7940h
		mov	bx, off_1799E
		call	ReadMESFile

loc_205AD:				; CODE XREF: DrawDialogText+8j
					; seg001:3943j
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_205DF
		cmp	word_1CB10, 0
		jnz	short loc_205DF
		cmp	word_1CB12, 0
		jz	short loc_205DF
		push	si
		mov	word_1CB10, 0FFFFh
		mov	si, word_1CB12
		call	sub_2103B
		mov	word_1CB10, 0
		pop	si
		call	sub_21040
		jmp	short DrawDialogText
; ---------------------------------------------------------------------------

loc_205DF:				; CODE XREF: DrawDialogText+21j
					; DrawDialogText+28j ...
		call	sub_20FE3
		cmp	al, 0
		jz	short loc_20606
		cmp	al, 1
		jz	short loc_20617
		cmp	al, 2
		jnz	short loc_205F1
		jmp	loc_20687
; ---------------------------------------------------------------------------

loc_205F1:				; CODE XREF: DrawDialogText+58j
		mov	al, [si]
		cmp	al, ','
		jz	short loc_20602
		cmp	al, '{'
		jnz	short loc_205FE
		jmp	loc_206B4
; ---------------------------------------------------------------------------

loc_205FE:				; CODE XREF: DrawDialogText+65j
		cmp	al, '}'
		jz	short $+2

loc_20602:				; CODE XREF: DrawDialogText+61j
		inc	si
		mov	al, 0
		retn
; ---------------------------------------------------------------------------

loc_20606:				; CODE XREF: DrawDialogText+50j
		mov	al, [si]
		inc	si
		mov	ah, 0
		sub	al, 99h
		mov	bx, ax
		add	bx, bx
		add	bx, offset off_1D312
		jmp	word ptr [bx]
; ---------------------------------------------------------------------------

loc_20617:				; CODE XREF: DrawDialogText+54j
		mov	ah, [si]
		mov	al, [si+1]
		cmp	ax, 8193h
		jnz	short loc_20629
		inc	si
		inc	si
		call	sub_2101D
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20629:				; CODE XREF: DrawDialogText+8Bj
		cmp	ax, 8197h
		jnz	short loc_20631
		jmp	loc_207A6
; ---------------------------------------------------------------------------

loc_20631:				; CODE XREF: DrawDialogText+98j
		cmp	ax, 8194h
		jnz	short loc_20639
		jmp	loc_207A9
; ---------------------------------------------------------------------------

loc_20639:				; CODE XREF: DrawDialogText+A0j
		mov	bx, word_1CACD
		mov	dx, word_1CACF
		call	sub_213AA
		mov	ah, [si]
		inc	si
		mov	al, [si]
		inc	si
		mov	dh, byte_1CAD1
		mov	dl, byte_1CAD2
		call	DrawSJISChar_D
		mov	cx, word_179AE
		call	sub_21068
		call	sub_2100F
		call	sub_2100F
		mov	al, byte_1CAD1
		cmp	byte_1CCDB, al
		jnz	short loc_20673
		mov	cl, 0
		mov	al, 1
		mov	ah, 1
		int	0F5h

loc_20673:				; CODE XREF: DrawDialogText+D5j
		mov	al, byte_1CAD1
		cmp	byte_1CCDC, al
		jnz	short loc_20684
		mov	cl, 1
		mov	al, 1
		mov	ah, 1
		int	0F5h

loc_20684:				; CODE XREF: DrawDialogText+E6j
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20687:				; CODE XREF: DrawDialogText+5Aj
		inc	si

loc_20688:				; CODE XREF: DrawDialogText+11Ej
		lodsb
		cmp	al, 22h	; '"'
		jnz	short loc_20690
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20690:				; CODE XREF: DrawDialogText+F7j
		push	ax
		mov	bx, word_1CACD
		mov	dx, word_1CACF
		call	sub_213AA
		mov	dh, byte_1CAD1
		mov	dl, byte_1CAD2
		pop	ax
		call	DrawJISChar
		mov	cx, word_179AE
		call	sub_21068
		call	sub_2100F
		jmp	short loc_20688
; ---------------------------------------------------------------------------

loc_206B4:				; CODE XREF: DrawDialogText+67j
		push	si
		call	sub_2103B
		pop	si
		call	sub_21040
		jmp	DrawDialogText
; ---------------------------------------------------------------------------
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_206C2:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		inc	si
		push	ax
		call	sub_2108E
		mov	dx, ax
		pop	ax
		call	sub_211E8
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_206D3:				; DATA XREF: seg000:off_1D312o
		mov	bl, [si]
		inc	si
		mov	bh, 0
		sub	bl, 40h	; '@'
		add	bx, bx
		add	bx, offset off_17968
		push	bx
		inc	si
		call	sub_2108E
		pop	bx
		mov	[bx], ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_206EC:				; DATA XREF: seg000:off_1D312o
		mov	bl, [si]
		inc	si
		mov	bh, 0
		sub	bl, 40h	; '@'
		add	bx, bx
		add	bx, offset off_17968
		mov	ax, [bx]
		push	ax
		inc	si
		call	sub_2108E
		pop	bx
		add	ax, ax
		add	bx, ax
		push	bx
		inc	si
		call	sub_2108E
		pop	bx
		mov	[bx], ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20711:				; DATA XREF: seg000:off_1D312o
		mov	bl, [si]
		inc	si
		mov	bh, 0
		sub	bl, 40h	; '@'
		add	bx, bx
		add	bx, offset off_17968
		mov	ax, [bx]
		push	ax
		inc	si
		call	sub_2108E
		pop	bx
		add	bx, ax
		push	bx
		inc	si
		call	sub_2108E
		pop	bx
		mov	[bx], al
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20734:				; CODE XREF: DrawDialogText+1E2j
					; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		cmp	ax, 0
		jz	short loc_20762
		call	sub_2103B
		push	ax

loc_20740:				; CODE XREF: DrawDialogText:loc_20757j
		cmp	byte ptr [si], 2Ch ; ','
		jnz	short loc_20759
		inc	si
		cmp	byte ptr [si], 9Dh ; 'ù'
		jnz	short loc_2074F
		inc	si
		call	sub_2108E

loc_2074F:				; CODE XREF: DrawDialogText+1B5j
		cmp	byte ptr [si], 7Bh ; '{'
		jnz	short loc_20757
		call	sub_21040

loc_20757:				; CODE XREF: DrawDialogText+1BEj
		jmp	short loc_20740
; ---------------------------------------------------------------------------

loc_20759:				; CODE XREF: DrawDialogText+1AFj
		pop	ax
		cmp	al, 0
		jnz	short locret_20761
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

locret_20761:				; CODE XREF: DrawDialogText+1C8j
		retn
; ---------------------------------------------------------------------------

loc_20762:				; CODE XREF: DrawDialogText+1A6j
		call	sub_21040
		cmp	byte ptr [si], 2Ch ; ','
		mov	al, 0
		jz	short loc_2076F
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_2076F:				; CODE XREF: DrawDialogText+1D6j
		inc	si
		cmp	byte ptr [si], 9Dh ; 'ù'
		jnz	short loc_20778
		inc	si
		jmp	short loc_20734
; ---------------------------------------------------------------------------

loc_20778:				; CODE XREF: DrawDialogText+1DFj
		call	sub_2103B
		cmp	al, 0
		jnz	short locret_20782
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

locret_20782:				; CODE XREF: DrawDialogText+1E9j
		retn
; ---------------------------------------------------------------------------

loc_20783:				; CODE XREF: DrawDialogText+1FFj
					; DATA XREF: seg000:off_1D312o
		push	si
		inc	si
		call	sub_2108E
		cmp	ax, 0
		jz	short loc_2079F
		call	sub_2103B
		pop	si
		cmp	al, 2
		jnz	short loc_20783
		inc	si
		call	sub_2108E
		call	sub_21040
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_2079F:				; CODE XREF: DrawDialogText+1F7j
		call	sub_21040
		pop	ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_207A6:				; CODE XREF: DrawDialogText+9Aj
					; DATA XREF: seg000:off_1D312o
		mov	al, 1
		retn
; ---------------------------------------------------------------------------

loc_207A9:				; CODE XREF: DrawDialogText+A2j
					; DATA XREF: seg000:off_1D312o
		mov	al, 2
		retn
DrawDialogText	endp

; ---------------------------------------------------------------------------

loc_207AC:				; DATA XREF: seg000:off_1D312o
		mov	word_1CB08, 0Ah
		call	sub_20914
		mov	ah, 0
		mov	al, dh
		mov	dx, 0
		mov	bh, 0
		mov	bl, byte_179B0
		div	bx
		cmp	dx, 0
		jz	short loc_207CA
		inc	ax

loc_207CA:				; CODE XREF: seg001:3467j
		mov	word_1CB06, ax
		mov	word_1CB08, 0
		call	sub_207DF
		mov	word_1798E, ax
		call	sub_21040
		jmp	DrawDialogText

; =============== S U B	R O U T	I N E =======================================


sub_207DF	proc near		; CODE XREF: seg001:3473p
					; sub_207DF+88j ...
		call	sub_20914
		mov	word_1CB0A, 0
		call	sub_208CC

loc_207EB:				; CODE XREF: sub_207DF+2Fj
					; sub_207DF+3Bj ...
		call	PushPopAllRegs
		mov	ax, 409h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_2081C

loc_207F8:				; CODE XREF: sub_207DF+21j
		mov	ax, 409h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jnz	short loc_207F8
		mov	bx, word_1CB0A
		inc	bx
		add	bx, 0CAFBh
		cmp	byte ptr [bx], 0FFh
		jz	short loc_207EB
		call	sub_208CC
		inc	word_1CB0A
		call	sub_208CC
		jmp	short loc_207EB
; ---------------------------------------------------------------------------

loc_2081C:				; CODE XREF: sub_207DF+17j
		mov	ax, 408h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_20845

loc_20826:				; CODE XREF: sub_207DF+4Fj
		mov	ax, 408h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jnz	short loc_20826
		mov	bx, word_1CB0A
		cmp	bx, 0
		jz	short loc_207EB
		call	sub_208CC
		dec	word_1CB0A
		call	sub_208CC
		jmp	short loc_207EB
; ---------------------------------------------------------------------------

loc_20845:				; CODE XREF: sub_207DF+45j
		mov	ax, 409h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_2086A

loc_2084F:				; CODE XREF: sub_207DF+78j
		mov	ax, 409h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_2084F
		mov	ax, word_1CB08
		inc	ax
		cmp	ax, word_1CB06
		jz	short loc_207EB
		inc	word_1CB08
		jmp	sub_207DF
; ---------------------------------------------------------------------------

loc_2086A:				; CODE XREF: sub_207DF+6Ej
		mov	ax, 408h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 40h
		jz	short loc_20890

loc_20874:				; CODE XREF: sub_207DF+9Dj
		mov	ax, 408h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 40h
		jnz	short loc_20874
		mov	ax, word_1CB08
		cmp	ax, 0
		jnz	short loc_20889
		jmp	loc_207EB
; ---------------------------------------------------------------------------

loc_20889:				; CODE XREF: sub_207DF+A5j
		dec	word_1CB08
		jmp	sub_207DF
; ---------------------------------------------------------------------------

loc_20890:				; CODE XREF: sub_207DF+93j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_208B1

loc_2089A:				; CODE XREF: sub_207DF+C3j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_2089A
		mov	bx, word_1CB0A
		add	bx, 0CAFBh
		mov	al, [bx]
		mov	ah, 0
		retn
; ---------------------------------------------------------------------------

loc_208B1:				; CODE XREF: sub_207DF+B9j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_208BE
		jmp	loc_207EB
; ---------------------------------------------------------------------------

loc_208BE:				; CODE XREF: sub_207DF+DAj
					; sub_207DF+E7j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_208BE
		mov	ax, 0
		retn
sub_207DF	endp


; =============== S U B	R O U T	I N E =======================================


sub_208CC	proc near		; CODE XREF: sub_207DF+9p
					; sub_207DF+31p ...
		mov	bx, word_1CB0A
		add	bx, bx
		add	bx, bx
		add	bx, offset word_179B2
		mov	cx, [bx]
		mov	dx, [bx+2]
		mov	ax, 50h	; 'P'
		mul	dx
		add	ax, cx
		mov	di, ax
		mov	cx, 10h

loc_208E9:				; CODE XREF: sub_208CC+45j
		push	cx
		push	di
		mov	ch, 0
		mov	cl, byte_179B1

loc_208F1:				; CODE XREF: sub_208CC+3Ej
		mov	es, word_1D30C
		assume es:nothing
		xor	byte ptr es:[di], 0FFh
		mov	es, word_1D30E
		assume es:nothing
		xor	byte ptr es:[di], 0FFh
		mov	es, word_1D310
		assume es:nothing
		xor	byte ptr es:[di], 0FFh
		inc	di
		loop	loc_208F1
		pop	di
		add	di, 50h	; 'P'
		pop	cx
		loop	loc_208E9
		retn
sub_208CC	endp


; =============== S U B	R O U T	I N E =======================================


sub_20914	proc near		; CODE XREF: seg001:3452p sub_207DFp
		push	si
		inc	si
		call	sub_2091B
		pop	si
		retn
sub_20914	endp


; =============== S U B	R O U T	I N E =======================================


sub_2091B	proc near		; CODE XREF: sub_20914+2p
		mov	bx, offset byte_1CAFB
		mov	cx, 0Ah

loc_20921:				; CODE XREF: sub_2091B+Aj
		mov	byte ptr [bx], 0FFh
		inc	bx
		loop	loc_20921
		mov	dl, 0
		mov	dh, 0
		mov	ax, word_1CB08
		mov	bh, 0
		mov	bl, byte_179B0
		mul	bx
		mov	cx, ax
		cmp	cx, 0
		jz	short loc_2096E

loc_2093D:				; CODE XREF: sub_2091B+37j
					; sub_2091B+4Dj ...
		cmp	byte ptr [si-1], 7Dh ; '}'
		jnz	short loc_20944
		retn
; ---------------------------------------------------------------------------

loc_20944:				; CODE XREF: sub_2091B+26j
		inc	dl
		cmp	byte ptr [si], 9Dh ; 'ù'
		jz	short loc_20956
		inc	dh
		push	cx
		call	sub_209F8
		pop	cx
		loop	loc_2093D
		jmp	short loc_2096E
; ---------------------------------------------------------------------------

loc_20956:				; CODE XREF: sub_2091B+2Ej
		inc	si
		push	cx
		push	dx
		call	sub_2108E
		pop	dx
		pop	cx
		push	ax
		push	cx
		call	sub_209F8
		pop	cx
		pop	ax
		cmp	ax, 0
		jz	short loc_2093D
		inc	dh
		loop	loc_2093D

loc_2096E:				; CODE XREF: sub_2091B+20j
					; sub_2091B+39j
		mov	ch, 0
		mov	cl, byte_179B0
		mov	di, offset byte_1CAFB
		mov	bx, offset word_179B2

loc_2097A:				; CODE XREF: sub_2091B+8Bj
					; sub_2091B+A8j
		cmp	byte ptr [si-1], 7Dh ; '}'
		jz	short loc_209C5
		inc	dl
		cmp	byte ptr [si], 9Dh ; 'ù'
		jz	short loc_209A9

loc_20987:				; CODE XREF: sub_2091B+9Fj
		mov	[di], dl
		mov	ax, [bx]
		mov	word_1CACD, ax
		mov	ax, [bx+2]
		mov	word_1CACF, ax
		push	bx
		push	cx
		push	dx
		push	di
		call	sub_209D2
		call	DrawDialogText
		pop	di
		pop	dx
		pop	cx
		pop	bx
		inc	di
		add	bx, 4
		loop	loc_2097A
		retn
; ---------------------------------------------------------------------------

loc_209A9:				; CODE XREF: sub_2091B+6Aj
		inc	si
		push	cx
		push	dx
		push	di
		push	bx
		call	sub_2108E
		cmp	ax, 0
		jz	short loc_209BC
		pop	bx
		pop	di
		pop	dx
		pop	cx
		jmp	short loc_20987
; ---------------------------------------------------------------------------

loc_209BC:				; CODE XREF: sub_2091B+99j
		call	sub_209F8
		pop	bx
		pop	di
		pop	dx
		pop	cx
		jmp	short loc_2097A
; ---------------------------------------------------------------------------

loc_209C5:				; CODE XREF: sub_2091B+63j
					; sub_2091B+B4j
		push	bx
		push	cx
		call	sub_209D2
		pop	cx
		pop	bx
		add	bx, 4
		loop	loc_209C5
		retn
sub_2091B	endp


; =============== S U B	R O U T	I N E =======================================


sub_209D2	proc near		; CODE XREF: sub_2091B+7Dp
					; sub_2091B+ACp
		push	bx
		push	cx
		push	dx
		push	di
		mov	ax, [bx+2]
		mov	dx, 50h	; 'P'
		mul	dx
		add	ax, [bx]
		mov	di, ax
		mov	bh, 0
		mov	bl, byte_179B1
		mov	cx, word_179A8
		mov	dh, byte_1CAD2
		call	sub_213B6
		pop	di
		pop	dx
		pop	cx
		pop	bx
		retn
sub_209D2	endp


; =============== S U B	R O U T	I N E =======================================


sub_209F8	proc near		; CODE XREF: sub_2091B+33p
					; sub_2091B+45p ...
		mov	ch, 1

loc_209FA:				; CODE XREF: sub_209F8+29j
		mov	al, [si]
		cmp	al, 7Bh	; '{'
		jnz	short loc_20A04
		inc	ch
		jmp	short loc_20A1C
; ---------------------------------------------------------------------------

loc_20A04:				; CODE XREF: sub_209F8+6j
		cmp	al, 7Dh	; '}'
		jnz	short loc_20A11
		dec	ch
		cmp	ch, 0
		jnz	short loc_20A1C
		inc	si
		retn
; ---------------------------------------------------------------------------

loc_20A11:				; CODE XREF: sub_209F8+Ej
		cmp	al, 2Ch	; ','
		jnz	short loc_20A1C
		cmp	ch, 1
		jnz	short loc_20A1C
		inc	si
		retn
; ---------------------------------------------------------------------------

loc_20A1C:				; CODE XREF: sub_209F8+Aj
					; sub_209F8+15j ...
		push	cx
		call	sub_20F97
		pop	cx
		jmp	short loc_209FA
sub_209F8	endp

; ---------------------------------------------------------------------------

loc_20A23:				; DATA XREF: seg000:off_1D312o
		call	sub_21311
		mov	bx, 0CB46h
		mov	di, 7940h

loc_20A2C:				; CODE XREF: seg001:36D4j
		mov	al, [bx]
		mov	[di], al
		inc	bx
		inc	di
		cmp	al, 0
		jnz	short loc_20A2C

loc_20A36:				; CODE XREF: seg001:3A06j
		mov	dx, 7940h
		mov	bx, off_1799E
		call	ReadMESFile
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		mov	word_1CB0E, 0
		mov	word_1CB0C, 0
		mov	word_1CB12, 0
		mov	word_1CB10, 0
		mov	byte_1CBD2, 0
		mov	ax, word_1CAC0
		mov	sp, ax
		mov	si, off_1799E
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20A75:				; DATA XREF: seg000:off_1D312o
		call	sub_21311
		push	si
		mov	bx, 7940h
		mov	di, 0CBD3h

loc_20A7F:				; CODE XREF: seg001:3727j
		mov	al, [bx]
		mov	[di], al
		inc	bx
		inc	di
		cmp	al, 0
		jnz	short loc_20A7F
		mov	bx, 0CB46h
		mov	di, 7940h

loc_20A8F:				; CODE XREF: seg001:3737j
		mov	al, [bx]
		mov	[di], al
		inc	bx
		inc	di
		cmp	al, 0
		jnz	short loc_20A8F
		mov	dx, 7940h
		mov	bx, off_1799E
		call	ReadMESFile
		mov	ax, word_1CB0E
		push	ax
		mov	word_1CB0E, 0
		mov	ax, word_1CB0C
		push	ax
		mov	word_1CB0C, 0
		mov	ax, word_1CB12
		push	ax
		mov	word_1CB12, 0
		mov	ax, word_1CB10
		push	ax
		mov	word_1CB10, 0
		mov	byte_1CBD2, 0
		mov	si, off_1799E
		call	DrawDialogText
		pop	ax
		mov	word_1CB10, ax
		pop	ax
		mov	word_1CB12, ax
		pop	ax
		mov	word_1CB0C, ax
		pop	ax
		mov	word_1CB0E, ax
		mov	bx, 0CBD3h
		mov	di, 7940h

loc_20AED:				; CODE XREF: seg001:3795j
		mov	al, [bx]
		mov	[di], al
		inc	bx
		inc	di
		cmp	al, 0
		jnz	short loc_20AED
		mov	dx, 7940h
		mov	bx, off_1799E
		call	ReadMESFile
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B05:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		inc	si
		add	ax, ax
		add	ax, 0CAD3h
		mov	bx, ax
		mov	[bx], si
		call	sub_21040
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B18:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		add	ax, ax
		add	ax, 0CAD3h
		mov	bx, ax
		push	si
		mov	si, [bx]
		call	sub_2103B
		pop	si
		cmp	al, 0
		jnz	short locret_20B30
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

locret_20B30:				; CODE XREF: seg001:37CBj
		retn
; ---------------------------------------------------------------------------
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B34:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		mov	word_1CAC5, ax
		inc	si
		call	sub_2108E
		mov	word_1CAC7, ax
		inc	si
		call	sub_2108E
		mov	word_1CAC9, ax
		inc	si
		call	sub_2108E
		mov	word_1CACB, ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B52:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		mov	word_1CACD, ax
		inc	si
		call	sub_2108E
		mov	word_1CACF, ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B62:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	ax
		and	al, 0Fh
		mov	byte_1CAD1, al
		pop	ax
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		mov	byte_1CAD2, al
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20B7A:				; DATA XREF: seg000:off_1D312o
		call	sub_20FE3
		cmp	al, 3
		jz	short loc_20B87
		mov	dh, byte_1CAD2
		jmp	short loc_20B8C
; ---------------------------------------------------------------------------

loc_20B87:				; CODE XREF: seg001:381Fj
		call	sub_2108E
		mov	dh, al

loc_20B8C:				; CODE XREF: seg001:3825j
		push	dx
		mov	bx, word_1CAC5
		mov	dx, word_1CAC7
		call	sub_213AA
		pop	dx
		mov	bx, word_1CAC9
		sub	bx, word_1CAC5
		inc	bx
		mov	cx, word_1CACB
		sub	cx, word_1CAC7
		inc	cx
		call	sub_213B6
		mov	ax, word_1CAC5
		mov	word_1CACD, ax
		mov	ax, word_1CAC7
		mov	word_1CACF, ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20BBD:				; DATA XREF: seg000:off_1D312o
		call	sub_20FE3
		cmp	al, 3
		jz	short loc_20BEA

loc_20BC4:				; CODE XREF: seg001:386Fj
		call	PushPopAllRegs
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_20BC4

loc_20BD1:				; CODE XREF: seg001:3879j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_20BD1
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20BEA:				; CODE XREF: seg001:3862j
		call	sub_2108E
		mov	cx, ax
		call	sub_21068
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20C01:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	ax
		mov	ax, word_179AC
		mov	dl, al
		and	dl, 0Fh
		mov	dh, al
		shr	dh, 1
		shr	dh, 1
		shr	dh, 1
		shr	dh, 1
		mov	di, offset byte_1CB14
		cmp	dh, 0
		jnz	short loc_20C23
		mov	byte ptr [di], 22h ; '"'
		inc	di

loc_20C23:				; CODE XREF: seg001:38BDj
		pop	ax
		call	SomeDrawNumber
		cmp	dh, 0
		jnz	short loc_20C30
		mov	byte ptr [di], 22h ; '"'
		inc	di

loc_20C30:				; CODE XREF: seg001:38CAj
		mov	byte ptr [di], 7Dh ; '}'
		push	si
		mov	si, offset byte_1CB14
		call	DrawDialogText
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20C3E:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	si
		mov	si, ax
		call	DrawDialogText
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20C4B:				; DATA XREF: seg000:off_1D312o
		call	sub_21311
		inc	si
		call	sub_2108E
		mov	bx, ax
		mov	dx, offset byte_1CB46
		call	ReadMESFile
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20C5D:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		mov	word ptr dword_1CBCE, ax
		mov	di, offset word_1CBFB

loc_20C66:				; CODE XREF: seg001:391Aj
		cmp	byte ptr [si], 2Ch ; ','
		jnz	short loc_20C7C
		inc	si
		call	sub_20FE3
		cmp	al, 3
		jnz	short loc_20C7C
		call	sub_2108E
		mov	[di], ax
		inc	di
		inc	di
		jmp	short loc_20C66
; ---------------------------------------------------------------------------

loc_20C7C:				; CODE XREF: seg001:3909j seg001:3911j
		push	si
		push	ds
		mov	cx, word_1CBFB
		mov	dx, word_1CBFD
		mov	bx, word_1CBFF
		mov	si, word_1CC01
		mov	di, word_1CC03
		call	dword_1CBCE
		pop	ds
		pop	si
		mov	word_1798E, ax
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20C9E:				; DATA XREF: seg000:off_1D312o
		mov	byte_1CBD2, 0FFh
		jmp	loc_205AD
; ---------------------------------------------------------------------------

loc_20CA6:				; DATA XREF: seg000:off_1D312o
		call	sub_20FE3
		cmp	al, 2
		jz	short loc_20CB3
		cmp	al, 3
		jz	short loc_20CB3
		jmp	short loc_20CC0
; ---------------------------------------------------------------------------

loc_20CB3:				; CODE XREF: seg001:394Bj seg001:394Fj
		call	sub_21311
		mov	dx, 0CB46h
		mov	bx, off_179A2
		call	ReadMESFile

loc_20CC0:				; CODE XREF: seg001:3951j
		mov	di, off_179A2
		call	sub_2171E
		jmp	DrawDialogText
; ---------------------------------------------------------------------------
		call	sub_2108E
		mov	di, ax
		call	sub_2171E
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20CD5:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		mov	di, ax
		inc	si
		inc	si

loc_20CDC:				; CODE XREF: seg001:399Fj seg001:39A9j ...
		cmp	byte ptr [si], 7Dh ; '}'
		jnz	short loc_20CE5
		inc	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20CE5:				; CODE XREF: seg001:397Fj seg001:3995j
		call	sub_20FE3
		cmp	al, 1
		jz	short loc_20CF7
		cmp	al, 2
		jz	short loc_20D01
		cmp	al, 3
		jz	short loc_20D10
		inc	si
		jmp	short loc_20CE5
; ---------------------------------------------------------------------------

loc_20CF7:				; CODE XREF: seg001:398Aj
		mov	ax, [si]
		mov	[di], ax
		inc	si
		inc	si
		inc	di
		inc	di
		jmp	short loc_20CDC
; ---------------------------------------------------------------------------

loc_20D01:				; CODE XREF: seg001:398Ej
		inc	si

loc_20D02:				; CODE XREF: seg001:39AEj
		mov	al, [si]
		inc	si
		cmp	al, 22h	; '"'
		jnz	short loc_20D0B
		jmp	short loc_20CDC
; ---------------------------------------------------------------------------

loc_20D0B:				; CODE XREF: seg001:39A7j
		mov	[di], al
		inc	di
		jmp	short loc_20D02
; ---------------------------------------------------------------------------

loc_20D10:				; CODE XREF: seg001:3992j
		call	sub_2108E
		mov	[di], al
		inc	di
		jmp	short loc_20CDC
; ---------------------------------------------------------------------------

loc_20D18:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		mov	cx, ax
		inc	si
		mov	di, si

loc_20D20:				; CODE XREF: seg001:39C9j
		mov	si, di
		push	cx
		push	di
		call	sub_2103B
		pop	di
		pop	cx
		loop	loc_20D20
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20D2E:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	ax
		inc	si
		call	sub_2108E
		mov	cx, ax
		pop	ax
		sub	cx, ax
		inc	cx

loc_20D3C:				; CODE XREF: seg001:39E6j
		push	cx
		push	ax
		mov	dl, 0
		call	sub_211E8
		pop	ax
		inc	ax
		pop	cx
		loop	loc_20D3C
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20D4B:				; DATA XREF: seg000:off_1D312o
		mov	word_1CB12, si
		call	sub_21040
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20D55:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		add	al, '0'
		mov	byte ptr aFlag0+4, al
		mov	dx, offset aFlag0 ; "FLAG0"
		mov	bx, offset byte_176C0
		call	ReadMESFile
		jmp	loc_20A36
; ---------------------------------------------------------------------------

loc_20D69:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		add	al, '0'
		mov	byte ptr aFlag0+4, al
		push	si
		mov	cx, 0
		mov	dx, offset aFlag0 ; "FLAG0"
		mov	ah, 3Ch
		int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
					; CX = attributes for file
					; DS:DX	-> ASCIZ filename (may include drive and path)
		mov	word_1CBC6, ax
		mov	bx, word_1CBC6
		mov	cx, 400h
		mov	dx, offset byte_176C0
		mov	ah, 40h
		int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
					; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
		mov	bx, word_1CBC6
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20D99:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		inc	si
		mov	word_1CC11, ax
		call	sub_2108E
		inc	si
		mov	word_1CC05, ax
		call	sub_2108E
		inc	si
		mov	word_1CC09, ax
		call	sub_2108E
		inc	si
		mov	word_1CC07, ax
		call	sub_2108E
		mov	word_1CC0B, ax
		push	si
		call	sub_20DC3
		pop	si
		jmp	DrawDialogText

; =============== S U B	R O U T	I N E =======================================


sub_20DC3	proc near		; CODE XREF: seg001:3A5Cp
		push	si
		push	ds
		mov	ax, 0A000h
		mov	es, ax
		assume es:nothing
		mov	si, offset byte_1CC1B

loc_20DCD:				; CODE XREF: sub_20DC3+43j
		mov	cl, [si]
		inc	si
		mov	ch, [si]
		inc	si
		mov	al, ch
		and	al, cl
		cmp	al, 0FFh
		jnz	short loc_20DDE
		pop	ds
		assume ds:nothing
		pop	si
		retn
; ---------------------------------------------------------------------------

loc_20DDE:				; CODE XREF: sub_20DC3+16j
		dec	ch
		dec	cl
		mov	dh, 14h

loc_20DE4:				; CODE XREF: sub_20DC3+41j
		push	dx
		call	sub_20E08
		push	cx
		mov	dh, 8

loc_20DEB:				; CODE XREF: sub_20DC3+35j
		mov	al, 12h
		add	al, cl
		mov	cl, al
		push	dx
		call	sub_20E08
		pop	dx
		dec	dh
		jnz	short loc_20DEB
		pop	cx
		pop	dx
		mov	al, 5
		add	al, ch
		mov	ch, al
		dec	dh
		jnz	short loc_20DE4
		jmp	short loc_20DCD
sub_20DC3	endp

		assume ds:seg000

; =============== S U B	R O U T	I N E =======================================


sub_20E08	proc near		; CODE XREF: sub_20DC3+22p
					; sub_20DC3+2Fp
		mov	ah, 0
		mov	al, cl
		cmp	ax, word_1CC05
		jnb	short loc_20E13
		retn
; ---------------------------------------------------------------------------

loc_20E13:				; CODE XREF: sub_20E08+8j
		cmp	ax, word_1CC07
		jz	short loc_20E1C
		jb	short loc_20E1C
		retn
; ---------------------------------------------------------------------------

loc_20E1C:				; CODE XREF: sub_20E08+Fj
					; sub_20E08+11j
		mov	ah, 0
		mov	al, ch
		cmp	ax, word_1CC09
		jnb	short loc_20E27
		retn
; ---------------------------------------------------------------------------

loc_20E27:				; CODE XREF: sub_20E08+1Cj
		cmp	ax, word_1CC0B
		jz	short loc_20E30
		jb	short loc_20E30
		retn
; ---------------------------------------------------------------------------

loc_20E30:				; CODE XREF: sub_20E08+23j
					; sub_20E08+25j
		push	cx
		push	bx
		push	cx
		shr	ch, 1
		shr	ch, 1
		mov	bl, ch
		mov	bh, 0
		add	bx, bx
		add	bx, bx
		add	bx, bx
		add	bx, bx
		mov	dx, bx
		add	bx, bx
		add	bx, bx
		add	bx, dx
		add	bx, bx
		mov	ch, 0
		and	cl, 0FEh
		add	bx, cx
		pop	cx
		push	bx
		mov	al, ch
		and	al, 3
		mov	bl, al
		mov	bh, 0
		mov	al, cl
		test	al, 1
		jz	short loc_20E68
		inc	bx
		inc	bx
		inc	bx
		inc	bx

loc_20E68:				; CODE XREF: sub_20E08+5Aj
		mov	dx, 0CC13h
		add	bx, dx
		mov	al, [bx]
		pop	bx
		push	ax
		cmp	word_1CC11, 0
		jz	short loc_20E82
		pop	ax
		or	al, es:[bx]
		mov	es:[bx], al
		pop	bx
		pop	cx
		retn
; ---------------------------------------------------------------------------

loc_20E82:				; CODE XREF: sub_20E08+6Ej
		pop	ax
		not	al
		and	al, es:[bx]
		mov	es:[bx], al
		pop	bx
		pop	cx
		retn
sub_20E08	endp

; ---------------------------------------------------------------------------

loc_20E8E:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		cmp	ax, 0
		jz	short loc_20EAA
		inc	si
		call	sub_21311
		push	si
		mov	bx, offset byte_1CB46
		mov	al, 0
		int	0F1h		; reserved for user interrupt
		mov	al, 1
		int	0F1h		; reserved for user interrupt
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20EAA:				; CODE XREF: seg001:3B34j
		push	si
		mov	al, 2
		int	0F1h		; reserved for user interrupt
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20EB3:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		inc	si
		push	ax
		call	sub_2108E
		mov	cl, al
		pop	ax
		mov	ch, al
		cmp	ch, 0
		jz	short loc_20EDC
		cmp	ch, 1
		jz	short loc_20EE9
		cmp	ch, 2
		jz	short loc_20EF2
		cmp	ch, 3
		jz	short loc_20F02
		cmp	ch, 4
		jz	short loc_20F12
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20EDC:				; CODE XREF: seg001:3B63j
		push	cx
		inc	si
		call	sub_2108E
		pop	cx
		mov	ah, 0
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20EE9:				; CODE XREF: seg001:3B68j
		mov	ah, 1
		mov	al, 1
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20EF2:				; CODE XREF: seg001:3B6Dj
		push	cx
		inc	si
		call	sub_21311
		mov	dx, offset byte_1CB46
		pop	cx
		mov	ah, 2
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F02:				; CODE XREF: seg001:3B72j
		push	cx
		inc	si
		call	sub_21311
		mov	dx, offset byte_1CB46
		pop	cx
		mov	ah, 3
		int	0F5h
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F12:				; CODE XREF: seg001:3B77j
		push	cx
		mov	cl, 1
		mov	ah, 5
		int	0F5h
		mov	cl, 0
		mov	ah, 5
		int	0F5h
		inc	si
		call	sub_2108E
		pop	cx
		mov	bx, offset byte_1CCDB
		cmp	cl, 0
		jz	short loc_20F2F
		mov	bx, offset byte_1CCDC

loc_20F2F:				; CODE XREF: seg001:3BCAj
		mov	[bx], al
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F34:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	si
		mov	al, al
		cmp	al, 0
		mov	ah, 40h	; '@'
		jz	short loc_20F42
		mov	ah, 41h	; 'A'

loc_20F42:				; CODE XREF: seg001:3BDEj
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F48:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	ax
		inc	si
		call	sub_21311
		mov	dx, offset byte_1CB46
		mov	bx, off_179A2
		call	ReadMESFile
		pop	ax
		mov	di, off_179A2
		call	sub_21568
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F65:				; DATA XREF: seg000:off_1D312o
		call	sub_2108E
		push	si
		mov	al, al
		out	0A6h, al	; Interrupt Controller #2, 8259A
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F71:				; DATA XREF: seg000:off_1D312o
		mov	ax, 0A000h
		mov	word ptr dword_1CBCE, ax
		push	si
		push	ds
		mov	al, 3
		call	dword_1CBCE
		pop	ds
		pop	si
		jmp	DrawDialogText
; ---------------------------------------------------------------------------

loc_20F84:				; DATA XREF: seg000:off_1D312o
		mov	ax, 0A000h
		mov	word ptr dword_1CBCE, ax
		push	si
		push	ds
		mov	al, 4
		call	dword_1CBCE
		pop	ds
		pop	si
		jmp	DrawDialogText

; =============== S U B	R O U T	I N E =======================================


sub_20F97	proc near		; CODE XREF: sub_209F8+25p
					; sub_21040:loc_21063p
		call	sub_20FE3
		cmp	al, 1
		jz	short loc_20FAB
		cmp	al, 2
		jz	short loc_20FB5
		call	sub_21210
		cmp	al, 5
		jnz	short loc_20FBE
		inc	si
		retn
; ---------------------------------------------------------------------------

loc_20FAB:				; CODE XREF: sub_20F97+5j
					; sub_20F97+1Bj
		inc	si
		inc	si
		call	sub_20FE3
		cmp	al, 1
		jz	short loc_20FAB
		retn
; ---------------------------------------------------------------------------

loc_20FB5:				; CODE XREF: sub_20F97+9j
		inc	si

loc_20FB6:				; CODE XREF: sub_20F97+24j
		inc	si
		cmp	byte ptr [si-1], 22h ; '"'
		jnz	short loc_20FB6
		retn
; ---------------------------------------------------------------------------

loc_20FBE:				; CODE XREF: sub_20F97+10j
					; sub_20F97+38j ...
		call	sub_21210
		cmp	al, 5
		jnz	short loc_20FC6
		retn
; ---------------------------------------------------------------------------

loc_20FC6:				; CODE XREF: sub_20F97+2Cj
		cmp	al, 2
		jz	short loc_20FD1
		cmp	al, 3
		jz	short loc_20FD1
		inc	si
		jmp	short loc_20FBE
; ---------------------------------------------------------------------------

loc_20FD1:				; CODE XREF: sub_20F97+31j
					; sub_20F97+35j
		mov	al, [si]
		inc	si
		mov	ch, al
		and	al, 7
		jnz	short loc_20FBE
		inc	si
		test	ch, 8
		jz	short loc_20FBE
		inc	si
		jmp	short loc_20FBE
sub_20F97	endp


; =============== S U B	R O U T	I N E =======================================


sub_20FE3	proc near		; CODE XREF: DrawDialogText:loc_205DFp
					; seg001:loc_20B7Ap ...
		mov	al, [si]
		cmp	al, 99h	; 'ô'
		jb	short loc_20FF0
		cmp	al, 0C0h ; '¿'
		jnb	short loc_20FF0
		mov	al, 0
		retn
; ---------------------------------------------------------------------------

loc_20FF0:				; CODE XREF: sub_20FE3+4j sub_20FE3+8j
		cmp	al, 81h	; 'Å'
		jb	short loc_20FFB
		cmp	al, 99h	; 'ô'
		jnb	short loc_20FFB
		mov	al, 1
		retn
; ---------------------------------------------------------------------------

loc_20FFB:				; CODE XREF: sub_20FE3+Fj
					; sub_20FE3+13j
		cmp	al, 22h	; '"'
		jnz	short loc_21002
		mov	al, 2
		retn
; ---------------------------------------------------------------------------

loc_21002:				; CODE XREF: sub_20FE3+1Aj
		call	sub_21210
		cmp	al, 5
		jz	short loc_2100C
		mov	al, 3
		retn
; ---------------------------------------------------------------------------

loc_2100C:				; CODE XREF: sub_20FE3+24j
		mov	al, 4
		retn
sub_20FE3	endp


; =============== S U B	R O U T	I N E =======================================


sub_2100F	proc near		; CODE XREF: DrawDialogText+C8p
					; DrawDialogText+CBp ...
		mov	ax, word_1CACD
		cmp	ax, word_1CAC9
		jz	short sub_2101D
		inc	ax
		mov	word_1CACD, ax
		retn
sub_2100F	endp


; =============== S U B	R O U T	I N E =======================================


sub_2101D	proc near		; CODE XREF: DrawDialogText+8Fp
					; sub_2100F+7j
		mov	ax, word_1CAC5
		mov	word_1CACD, ax
		mov	ax, word_1CACF
		add	ax, word_179A8
		cmp	ax, word_1CACB
		jnb	short loc_21034
		mov	word_1CACF, ax
		retn
; ---------------------------------------------------------------------------

loc_21034:				; CODE XREF: sub_2101D+11j
		mov	ax, word_1CAC7
		mov	word_1CACF, ax
		retn
sub_2101D	endp


; =============== S U B	R O U T	I N E =======================================


sub_2103B	proc near		; CODE XREF: DrawDialogText+3Cp
					; DrawDialogText+121p ...
		inc	si
		call	DrawDialogText
		retn
sub_2103B	endp


; =============== S U B	R O U T	I N E =======================================


sub_21040	proc near		; CODE XREF: DrawDialogText+46p
					; DrawDialogText+125p ...
		inc	si
		mov	byte_1CAC4, 1

loc_21046:				; CODE XREF: sub_21040+26j
		mov	al, [si]
		cmp	al, 7Bh	; '{'
		jnz	short loc_21052
		inc	byte_1CAC4
		jmp	short loc_21063
; ---------------------------------------------------------------------------

loc_21052:				; CODE XREF: sub_21040+Aj
		cmp	al, 7Dh	; '}'
		jnz	short loc_21063
		dec	byte_1CAC4
		cmp	byte_1CAC4, 0
		jnz	short loc_21063
		inc	si
		retn
; ---------------------------------------------------------------------------

loc_21063:				; CODE XREF: sub_21040+10j
					; sub_21040+14j ...
		call	sub_20F97
		jmp	short loc_21046
sub_21040	endp


; =============== S U B	R O U T	I N E =======================================


sub_21068	proc near		; CODE XREF: DrawDialogText+C5p
					; DrawDialogText+118p ...
		cmp	cx, 0
		jnz	short loc_2106E
		retn
; ---------------------------------------------------------------------------

loc_2106E:				; CODE XREF: sub_21068+3j sub_21068+Dj
		push	cx
		mov	cx, 8000

loc_21072:				; CODE XREF: sub_21068:loc_21072j
		loop	loc_21072
		pop	cx
		loop	loc_2106E
		retn
sub_21068	endp


; =============== S U B	R O U T	I N E =======================================


sub_21078	proc near		; CODE XREF: sub_2108E+Bp
		mov	bx, ax
		in	al, 71h		; CMOS Memory
		mov	ah, al
		in	al, 71h		; CMOS Memory
		add	ax, word_1CAC2
		mov	word_1CAC2, ax
		xor	dx, dx
		div	bx
		mov	ax, dx
		retn
sub_21078	endp


; =============== S U B	R O U T	I N E =======================================


sub_2108E	proc near		; CODE XREF: DrawDialogText:loc_206C2p
					; DrawDialogText+133p ...
		call	sub_21210
		cmp	al, 0
		jnz	short loc_2109F
		inc	si
		call	sub_211A0
		call	sub_21078
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_2109F:				; CODE XREF: sub_2108E+5j
		cmp	al, 1
		jnz	short loc_210B6
		mov	bl, [si]
		inc	si
		mov	bh, 0
		sub	bl, 40h	; '@'
		add	bx, bx
		add	bx, offset off_17968
		mov	ax, [bx]
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210B6:				; CODE XREF: sub_2108E+13j
		cmp	al, 2
		jnz	short loc_210C3
		call	sub_211A0
		call	sub_211C0
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210C3:				; CODE XREF: sub_2108E+2Aj
		cmp	al, 3
		jnz	short loc_210CD
		call	sub_211A0
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210CD:				; CODE XREF: sub_2108E+37j
		cmp	al, 4
		jz	short loc_210D4
		jmp	loc_2119E
; ---------------------------------------------------------------------------

loc_210D4:				; CODE XREF: sub_2108E+41j
		mov	cl, [si]
		inc	si
		pop	ax
		pop	bx
		cmp	cl, 2Bh	; '+'
		jnz	short loc_210E3
		add	ax, bx
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210E3:				; CODE XREF: sub_2108E+4Ej
		cmp	cl, 2Dh	; '-'
		jnz	short loc_210F2
		sub	bx, ax
		jnb	short loc_210EF
		mov	bx, 0

loc_210EF:				; CODE XREF: sub_2108E+5Cj
		push	bx
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210F2:				; CODE XREF: sub_2108E+58j
		cmp	cl, 2Ah	; '*'
		jnz	short loc_210FC
		mul	bx
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_210FC:				; CODE XREF: sub_2108E+67j
		cmp	cl, 2Fh	; '/'
		jnz	short loc_2110A
		xchg	ax, bx
		mov	dx, 0
		div	bx
		push	ax
		jmp	short sub_2108E
; ---------------------------------------------------------------------------

loc_2110A:				; CODE XREF: sub_2108E+71j
		cmp	cl, 25h	; '%'
		jnz	short loc_21119
		xchg	ax, bx
		mov	dx, 0
		div	bx
		push	dx
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_21119:				; CODE XREF: sub_2108E+7Fj
		cmp	cl, 26h	; '&'
		jnz	short loc_21124
		and	ax, bx
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_21124:				; CODE XREF: sub_2108E+8Ej
		cmp	cl, 7Ch	; '|'
		jnz	short loc_2112F
		or	ax, bx
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_2112F:				; CODE XREF: sub_2108E+99j
		cmp	cl, 5Eh	; '^'
		jnz	short loc_2113A
		xor	ax, bx
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_2113A:				; CODE XREF: sub_2108E+A4j
		cmp	cl, 3Eh	; '>'
		jnz	short loc_21149
		cmp	ax, bx
		jb	short loc_21190
		jmp	short loc_21197
; ---------------------------------------------------------------------------
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_21149:				; CODE XREF: sub_2108E+AFj
		cmp	cl, 3Ch	; '<'
		jnz	short loc_21158
		cmp	bx, ax
		jb	short loc_21190
		jmp	short loc_21197
; ---------------------------------------------------------------------------
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_21158:				; CODE XREF: sub_2108E+BEj
		cmp	cl, 21h	; '!'
		jnz	short loc_21163
		cmp	bx, ax
		jnz	short loc_21190
		jmp	short loc_21197
; ---------------------------------------------------------------------------

loc_21163:				; CODE XREF: sub_2108E+CDj
		cmp	cl, 3Dh	; '='
		jnz	short loc_2116E
		cmp	bx, ax
		jz	short loc_21190
		jmp	short loc_21197
; ---------------------------------------------------------------------------

loc_2116E:				; CODE XREF: sub_2108E+D8j
		cmp	cl, 5Ch	; '\'
		jnz	short loc_2117D
		add	ax, ax
		add	bx, ax
		mov	ax, [bx]
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_2117D:				; CODE XREF: sub_2108E+E3j
		cmp	cl, 23h	; '#'
		jnz	short loc_2118C
		add	bx, ax
		mov	al, [bx]
		mov	ah, 0
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_2118C:				; CODE XREF: sub_2108E+F2j
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_21190:				; CODE XREF: sub_2108E+B3j
					; sub_2108E+C2j ...
		mov	ax, 1
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_21197:				; CODE XREF: sub_2108E+B5j
					; sub_2108E+C4j ...
		mov	ax, 0
		push	ax
		jmp	sub_2108E
; ---------------------------------------------------------------------------

loc_2119E:				; CODE XREF: sub_2108E+43j
		pop	ax
		retn
sub_2108E	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_211A0	proc near		; CODE XREF: sub_2108E+8p
					; sub_2108E+2Cp ...
		mov	al, [si]
		and	al, 7
		jz	short loc_211AC
		inc	si
		dec	al
		mov	ah, 0
		retn
; ---------------------------------------------------------------------------

loc_211AC:				; CODE XREF: sub_211A0+4j
		mov	al, [si]
		inc	si
		test	al, 8
		jnz	short loc_211B9
		mov	ah, 0
		mov	al, [si]
		inc	si
		retn
; ---------------------------------------------------------------------------

loc_211B9:				; CODE XREF: sub_211A0+11j
		mov	ah, [si]
		inc	si
		mov	al, [si]
		inc	si
		retn
sub_211A0	endp


; =============== S U B	R O U T	I N E =======================================


sub_211C0	proc near		; CODE XREF: sub_2108E+2Fp
		call	sub_211C8
		mov	ah, 0
		mov	al, dl
		retn
sub_211C0	endp


; =============== S U B	R O U T	I N E =======================================


sub_211C8	proc near		; CODE XREF: sub_211C0p seg001:460Dp ...
		mov	bx, ax
		shr	bx, 1
		jb	short loc_211D7
		add	bx, offset byte_176C0
		mov	dl, 0Fh
		and	dl, [bx]
		retn
; ---------------------------------------------------------------------------

loc_211D7:				; CODE XREF: sub_211C8+4j
		add	bx, offset byte_176C0
		mov	dl, 0F0h
		and	dl, [bx]
		shr	dl, 1
		shr	dl, 1
		shr	dl, 1
		shr	dl, 1
		retn
sub_211C8	endp


; =============== S U B	R O U T	I N E =======================================


sub_211E8	proc near		; CODE XREF: DrawDialogText+139p
					; seg001:39E0p	...
		mov	bx, ax
		shr	bx, 1
		jb	short loc_211FB
		add	bx, offset byte_176C0
		and	byte ptr [bx], 0F0h
		and	dl, 0Fh
		or	[bx], dl
		retn
; ---------------------------------------------------------------------------

loc_211FB:				; CODE XREF: sub_211E8+4j
		add	bx, offset byte_176C0
		and	byte ptr [bx], 0Fh
		and	dl, 0Fh
		shl	dl, 1
		shl	dl, 1
		shl	dl, 1
		shl	dl, 1
		or	[bx], dl
		retn
sub_211E8	endp


; =============== S U B	R O U T	I N E =======================================


sub_21210	proc near		; CODE XREF: sub_20F97+Bp
					; sub_20F97:loc_20FBEp	...
		mov	al, [si]
		cmp	al, 3Fh	; '?'
		jnz	short loc_21219
		mov	al, 0
		retn
; ---------------------------------------------------------------------------

loc_21219:				; CODE XREF: sub_21210+4j
		cmp	al, 40h	; '@'
		jb	short loc_21224
		cmp	al, 5Bh	; '['
		jnb	short loc_21224
		mov	al, 1
		retn
; ---------------------------------------------------------------------------

loc_21224:				; CODE XREF: sub_21210+Bj sub_21210+Fj
		cmp	al, 10h
		jnb	short loc_2122B
		mov	al, 2
		retn
; ---------------------------------------------------------------------------

loc_2122B:				; CODE XREF: sub_21210+16j
		cmp	al, 20h	; ' '
		jnb	short loc_21232
		mov	al, 3
		retn
; ---------------------------------------------------------------------------

loc_21232:				; CODE XREF: sub_21210+1Dj
		cmp	al, 7Ch	; '|'
		jz	short loc_2126D
		cmp	al, 5Ch	; '\'
		jz	short loc_2126D
		cmp	al, 5Eh	; '^'
		jz	short loc_2126D
		cmp	al, 3Ch	; '<'
		jz	short loc_2126D
		cmp	al, 3Dh	; '='
		jz	short loc_2126D
		cmp	al, 3Eh	; '>'
		jz	short loc_2126D
		cmp	al, 21h	; '!'
		jz	short loc_2126D
		cmp	al, 23h	; '#'
		jz	short loc_2126D
		cmp	al, 25h	; '%'
		jz	short loc_2126D
		cmp	al, 26h	; '&'
		jz	short loc_2126D
		cmp	al, 2Ah	; '*'
		jz	short loc_2126D
		cmp	al, 2Bh	; '+'
		jz	short loc_2126D
		cmp	al, 2Dh	; '-'
		jz	short loc_2126D
		cmp	al, 2Fh	; '/'
		jz	short loc_2126D
		mov	al, 5
		retn
; ---------------------------------------------------------------------------

loc_2126D:				; CODE XREF: sub_21210+24j
					; sub_21210+28j ...
		mov	al, 4
		retn
sub_21210	endp


; =============== S U B	R O U T	I N E =======================================


SomeDrawNumber	proc near		; CODE XREF: seg001:38C4p
		cmp	dl, 0Fh
		jnz	short loc_2128B
		cmp	ax, 10000
		jnb	short loc_2129F
		cmp	ax, 1000
		jnb	short loc_212A5
		cmp	ax, 100
		jnb	short loc_212AB
		cmp	ax, 10
		jnb	short loc_212B1
		jmp	short loc_212B7
; ---------------------------------------------------------------------------

loc_2128B:				; CODE XREF: SomeDrawNumber+3j
		cmp	dl, 1
		jz	short loc_212B7
		cmp	dl, 2
		jz	short loc_212B1
		cmp	dl, 3
		jz	short loc_212AB
		cmp	dl, 4
		jz	short loc_212A5

loc_2129F:				; CODE XREF: SomeDrawNumber+8j
		mov	cx, 10000
		call	SomeDrawDigit

loc_212A5:				; CODE XREF: SomeDrawNumber+Dj
					; SomeDrawNumber+2Dj
		mov	cx, 1000
		call	SomeDrawDigit

loc_212AB:				; CODE XREF: SomeDrawNumber+12j
					; SomeDrawNumber+28j
		mov	cx, 100
		call	SomeDrawDigit

loc_212B1:				; CODE XREF: SomeDrawNumber+17j
					; SomeDrawNumber+23j
		mov	cx, 10
		call	SomeDrawDigit

loc_212B7:				; CODE XREF: SomeDrawNumber+19j
					; SomeDrawNumber+1Ej
		mov	cx, 1
SomeDrawNumber	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


SomeDrawDigit	proc near		; CODE XREF: SomeDrawNumber+32p
					; SomeDrawNumber+38p ...
		mov	bx, 0

loc_212BD:				; CODE XREF: SomeDrawDigit+8j
		sub	ax, cx
		jb	short loc_212C4
		inc	bx
		jmp	short loc_212BD
; ---------------------------------------------------------------------------

loc_212C4:				; CODE XREF: SomeDrawDigit+5j
		add	ax, cx
		cmp	dh, 0		; DH = 0 -> draw ASCII,	DH = 1 -> draw Full-Width
		jz	short loc_212D7
		add	bx, 824Fh
		mov	[di], bh
		mov	[di+1],	bl
		inc	di
		inc	di
		retn
; ---------------------------------------------------------------------------

loc_212D7:				; CODE XREF: SomeDrawDigit+Fj
		add	bl, '0'
		mov	[di], bl
		inc	di
		retn
SomeDrawDigit	endp


; =============== S U B	R O U T	I N E =======================================


ClearTRAM2	proc near		; CODE XREF: ExecMESFile+46p
					; seg001:463Ep	...
		mov	ax, 0A000h
		mov	es, ax
		mov	cx, 25
		mov	di, 0

loc_212E9:				; CODE XREF: ClearTRAM2+1Aj
		push	cx
		mov	cx, 80
		mov	ax, 0

loc_212F0:				; CODE XREF: ClearTRAM2+17j
		mov	es:[di], ax
		inc	di
		inc	di
		loop	loc_212F0
		pop	cx
		loop	loc_212E9
		mov	di, 2000h
		mov	cx, 25

loc_21300:				; CODE XREF: ClearTRAM2+30j
		push	cx
		mov	cx, 80
		mov	al, 11h

loc_21306:				; CODE XREF: ClearTRAM2+2Dj
		mov	es:[di], al
		inc	di
		inc	di
		loop	loc_21306
		pop	cx
		loop	loc_21300
		retn
ClearTRAM2	endp


; =============== S U B	R O U T	I N E =======================================


sub_21311	proc near		; CODE XREF: seg001:loc_20A23p
					; seg001:loc_20A75p ...
		call	sub_20FE3
		cmp	al, 3
		jz	short loc_2132D
		inc	si
		mov	ax, seg	seg000
		mov	es, ax
		assume es:seg000
		mov	di, offset byte_1CB46

loc_21321:				; CODE XREF: sub_21311+16j
		lodsb
		cmp	al, 22h	; '"'
		jz	short loc_21329
		stosb
		jmp	short loc_21321
; ---------------------------------------------------------------------------

loc_21329:				; CODE XREF: sub_21311+13j
		mov	al, 0
		stosb
		retn
; ---------------------------------------------------------------------------

loc_2132D:				; CODE XREF: sub_21311+5j
		call	sub_2108E
		mov	bx, ax
		mov	di, offset byte_1CB46

loc_21335:				; CODE XREF: sub_21311+2Cj
		mov	al, [bx]
		inc	bx
		mov	[di], al
		inc	di
		cmp	al, 0
		jnz	short loc_21335
		retn
sub_21311	endp


; =============== S U B	R O U T	I N E =======================================


ReadMESFile	proc near		; CODE XREF: ExecMESFile+20p
					; DrawDialogText+16p ...
		push	ds
		push	bx
		mov	ax, seg	seg000
		mov	es, ax
		mov	al, 0
		mov	ah, 3Dh
		int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
					; DS:DX	-> ASCIZ filename
					; AL = access mode
					; 0 - read
		jnb	short loc_21360
		push	dx
		mov	dx, offset aGtg@gcglvUVNuv ; "ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		pop	dx
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_21360:				; CODE XREF: ReadMESFile+Dj
		mov	es:hFileMES, ax
		mov	bx, es:hFileMES
		mov	cx, 0
		mov	dx, 0
		mov	al, 2
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from end of file
		push	ax
		mov	bx, es:hFileMES
		mov	cx, 0
		mov	dx, 0
		mov	al, 0
		mov	ah, 42h
		int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
					; AL = method: offset from beginning of	file
		pop	cx
		mov	bx, es:hFileMES
		pop	dx
		mov	ah, 3Fh
		int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
					; BX = file handle, CX = number	of bytes to read
					; DS:DX	-> buffer
		jnb	short loc_2139F
		mov	dx, offset aGtg@gcglvUVNuv ; "ÉtÉ@ÉCÉãÇÃì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩÅB\r\n$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ah, 4Ch
		int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
					; AL = exit code
; ---------------------------------------------------------------------------

loc_2139F:				; CODE XREF: ReadMESFile+52j
		mov	bx, es:hFileMES
		mov	ah, 3Eh
		int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
					; BX = file handle
		pop	ds
		retn
ReadMESFile	endp


; =============== S U B	R O U T	I N E =======================================


sub_213AA	proc near		; CODE XREF: DrawDialogText+ADp
					; DrawDialogText+105p ...
		mov	ax, dx
		mov	dx, 50h
		mul	dx
		add	ax, bx
		mov	di, ax
		retn
sub_213AA	endp


; =============== S U B	R O U T	I N E =======================================


sub_213B6	proc near		; CODE XREF: sub_209D2+1Ep
					; seg001:384Bp	...
		push	cx
		push	bx
		push	di
		mov	cx, bx

loc_213BB:				; CODE XREF: sub_213B6+2Fj
		push	dx
		mov	es, word_1D30C
		assume es:nothing
		mov	al, 0
		shr	dh, 1
		sbb	al, 0
		mov	es:[di], al
		mov	es, word_1D30E
		assume es:nothing
		mov	al, 0
		shr	dh, 1
		sbb	al, 0
		mov	es:[di], al
		mov	es, word_1D310
		assume es:nothing
		mov	al, 0
		shr	dh, 1
		sbb	al, 0
		mov	es:[di], al
		pop	dx
		inc	di
		loop	loc_213BB
		pop	di
		add	di, 50h
		pop	bx
		pop	cx
		loop	sub_213B6
		retn
sub_213B6	endp


; =============== S U B	R O U T	I N E =======================================


DrawSJISChar_D	proc near		; CODE XREF: DrawDialogText+BEp
		push	si
		push	dx
		sub	ah, 70h	; 'p'
		cmp	ah, 30h	; '0'
		jb	short loc_213FD
		sub	ah, 40h	; '@'

loc_213FD:				; CODE XREF: DrawSJISChar_D+8j
		shl	ah, 1
		dec	ah
		mov	bl, 1Fh
		and	al, al
		jns	short loc_21411
		dec	al
		cmp	al, 9Eh	; 'û'
		jb	short loc_21411
		mov	bl, 7Dh	; '}'
		inc	ah

loc_21411:				; CODE XREF: DrawSJISChar_D+15j
					; DrawSJISChar_D+1Bj
		sub	al, bl
		pop	dx
		sub	ax, 2000h
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	bx, word_179AA
		mov	cx, 10h

loc_21424:				; CODE XREF: DrawSJISChar_D:loc_214CCj
		push	dx
		push	cx
		mov	al, 10h
		sub	al, cl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		mov	al, 10h
		sub	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		rcl	bx, 1
		jnb	short loc_2145B
		pop	cx
		dec	cx
		push	cx
		push	bx
		mov	bx, ax
		mov	al, 10h
		sub	al, cl
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		mov	al, 10h
		sub	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		or	ax, bx
		pop	bx

loc_2145B:				; CODE XREF: DrawSJISChar_D+4Cj
		push	bx
		mov	es, word_1D30C
		assume es:nothing
		mov	bx, 0
		rcr	dl, 1
		sbb	bx, 0
		not	ax
		and	bx, ax
		not	ax
		mov	es:[di], bx
		mov	bx, 0
		rcr	dh, 1
		sbb	bx, 0
		and	bx, ax
		or	es:[di], bx
		mov	es, word_1D30E
		assume es:nothing
		mov	bx, 0
		rcr	dl, 1
		sbb	bx, 0
		not	ax
		and	bx, ax
		not	ax
		mov	es:[di], bx
		mov	bx, 0
		rcr	dh, 1
		sbb	bx, 0
		and	bx, ax
		or	es:[di], bx
		mov	es, word_1D310
		assume es:nothing
		mov	bx, 0
		rcr	dl, 1
		sbb	bx, 0
		not	ax
		and	bx, ax
		not	ax
		mov	es:[di], bx
		mov	bx, 0
		rcr	dh, 1
		sbb	bx, 0
		and	bx, ax
		or	es:[di], bx
		pop	bx
		add	di, 50h	; 'P'
		pop	cx
		pop	dx
		loop	loc_214CC
		jmp	short loc_214CF
; ---------------------------------------------------------------------------

loc_214CC:				; CODE XREF: DrawSJISChar_D+D8j
		jmp	loc_21424
; ---------------------------------------------------------------------------

loc_214CF:				; CODE XREF: DrawSJISChar_D+DAj
		pop	si
		retn
DrawSJISChar_D	endp


; =============== S U B	R O U T	I N E =======================================


DrawJISChar	proc near		; CODE XREF: DrawDialogText+111p
		mov	ah, 9
		out	0A1h, al	; Interrupt Controller #2, 8259A
		mov	al, ah
		out	0A3h, al	; Interrupt Controller #2, 8259A
		mov	bx, word_179AA
		mov	cx, 10h

loc_214E0:				; CODE XREF: DrawJISChar:loc_21564j
		push	dx
		push	cx
		mov	al, 10h
		sub	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		mov	ah, al
		rcl	bx, 1
		jnb	short loc_21501
		pop	cx
		dec	cx
		push	cx
		mov	al, 10h
		sub	al, cl
		or	al, 20h
		out	0A5h, al	; Interrupt Controller #2, 8259A
		in	al, 0A9h	; Interrupt Controller #2, 8259A
		or	ah, al

loc_21501:				; CODE XREF: DrawJISChar+1Fj
		mov	es, word_1D30C
		assume es:nothing
		mov	al, 0
		rcr	dl, 1
		sbb	al, 0
		not	ah
		and	al, ah
		not	ah
		mov	es:[di], al
		mov	al, 0
		rcr	dh, 1
		sbb	al, 0
		and	al, ah
		or	es:[di], al
		mov	es, word_1D30E
		assume es:nothing
		mov	al, 0
		rcr	dl, 1
		sbb	al, 0
		not	ah
		and	al, ah
		not	ah
		mov	es:[di], al
		mov	al, 0
		rcr	dh, 1
		sbb	al, 0
		and	al, ah
		or	es:[di], al
		mov	es, word_1D310
		assume es:nothing
		mov	al, 0
		rcr	dl, 1
		sbb	al, 0
		not	ah
		and	al, ah
		not	ah
		mov	es:[di], al
		mov	al, 0
		rcr	dh, 1
		sbb	al, 0
		and	al, ah
		or	es:[di], al
		add	di, 50h
		pop	cx
		pop	dx
		loop	loc_21564
		jmp	short locret_21567
; ---------------------------------------------------------------------------

loc_21564:				; CODE XREF: DrawJISChar+8Fj
		jmp	loc_214E0
; ---------------------------------------------------------------------------

locret_21567:				; CODE XREF: DrawJISChar+91j
		retn
DrawJISChar	endp


; =============== S U B	R O U T	I N E =======================================


sub_21568	proc near		; CODE XREF: seg001:3BFFp
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	byte_1CCF1, al
		call	sub_21581
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn
sub_21568	endp


; =============== S U B	R O U T	I N E =======================================


sub_21581	proc near		; CODE XREF: sub_21568+Cp
		mov	word_1CCED, 0
		mov	word_1CCEF, 0
		call	sub_21872
		mov	bh, 0
		mov	bl, al
		mov	word_1CCDD, bx
		call	sub_21872
		mov	dh, 0
		mov	dl, al
		mov	word_1CCDF, dx
		call	sub_21872
		mov	ah, 0
		mov	word_1CCE5, ax
		call	sub_21872
		mov	ah, 0
		mov	word_1CCE7, ax
		mov	si, 0CCF2h

loc_215B6:				; CODE XREF: sub_21581+50j
					; sub_21581+A4j
		call	sub_21872
		cmp	al, 0E9h ; 'È'
		jz	short loc_215D4

loc_215BD:				; CODE XREF: sub_21581+58j
		mov	[si], al
		inc	si
		call	sub_21872
		mov	[si], al
		inc	si
		call	sub_21872
		mov	[si], al
		inc	si
		call	sub_2162A
		cmp	al, 0
		jz	short loc_215B6
		retn
; ---------------------------------------------------------------------------

loc_215D4:				; CODE XREF: sub_21581+3Aj
		call	sub_21872
		cmp	al, 0E9h ; 'È'
		jz	short loc_215BD
		mov	bh, 0
		mov	bl, al
		call	sub_21872
		mov	ch, 0
		mov	cl, al
		and	cl, 3Fh
		inc	cx
		push	di
		push	es
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		shr	al, 1
		mov	di, 0CCF2h
		cmp	al, 0
		jz	short loc_21602
		mov	di, 0CF4Ah

loc_21602:				; CODE XREF: sub_21581+7Cj
		add	di, bx
		add	di, bx
		add	di, bx

loc_21608:				; CODE XREF: sub_21581+A0j
		mov	al, [di]
		mov	[si], al
		inc	si
		inc	di
		mov	al, [di]
		mov	[si], al
		inc	si
		inc	di
		mov	al, [di]
		mov	[si], al
		inc	si
		inc	di
		call	sub_2162A
		cmp	al, 0
		jnz	short loc_21627
		loop	loc_21608
		pop	es
		pop	di
		jmp	short loc_215B6
; ---------------------------------------------------------------------------

loc_21627:				; CODE XREF: sub_21581+9Ej
		pop	es
		pop	di
		retn
sub_21581	endp


; =============== S U B	R O U T	I N E =======================================


sub_2162A	proc near		; CODE XREF: sub_21581+4Bp
					; sub_21581+99p
		mov	ax, word_1CCEF
		inc	ax
		mov	word_1CCEF, ax
		cmp	ax, word_1CCE7
		mov	al, 0
		jz	short loc_2163A
		retn
; ---------------------------------------------------------------------------

loc_2163A:				; CODE XREF: sub_2162A+Dj
		mov	ax, word_1CCE3
		mov	word_1CCEF, ax
		mov	ax, word_1CCED
		inc	ax
		mov	word_1CCED, ax
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	dx, word_1CCED
		dec	dx
		mov	bx, 0
		call	sub_2185E
		mov	di, si
		mov	si, offset byte_1CCF2
		mov	cx, word_1CCE7

loc_21664:				; CODE XREF: sub_2162A:loc_216F3j
		push	cx
		mov	dh, byte_1CCF1
		mov	al, 0FFh
		shr	dh, 1
		adc	al, 0
		xor	al, [si]
		mov	dl, al
		mov	al, 0FFh
		shr	dh, 1
		adc	al, 0
		xor	al, [si+1]
		and	dl, al
		mov	al, 0FFh
		shr	dh, 1
		adc	al, 0
		xor	al, [si+2]
		and	dl, al
		mov	dh, dl
		not	dh
		mov	es, word_1D30C
		assume es:nothing
		mov	al, dl
		and	es:[di], al
		mov	al, [si]
		and	al, dh
		or	es:[di], al
		mov	al, dl
		and	es:[di+50h], al
		mov	al, [si]
		and	al, dh
		or	es:[di+50h], al
		inc	si
		mov	es, word_1D30E
		assume es:nothing
		mov	al, dl
		and	es:[di], al
		mov	al, [si]
		and	al, dh
		or	es:[di], al
		mov	al, dl
		and	es:[di+50h], al
		mov	al, [si]
		and	al, dh
		or	es:[di+50h], al
		inc	si
		mov	es, word_1D310
		assume es:nothing
		mov	al, dl
		and	es:[di], al
		mov	al, [si]
		and	al, dh
		or	es:[di], al
		mov	al, dl
		and	es:[di+50h], al
		mov	al, [si]
		and	al, dh
		or	es:[di+50h], al
		inc	si
		add	di, 0A0h ; '†'
		pop	cx
		loop	loc_216F3
		jmp	short loc_216F6
; ---------------------------------------------------------------------------

loc_216F3:				; CODE XREF: sub_2162A+C5j
		jmp	loc_21664
; ---------------------------------------------------------------------------

loc_216F6:				; CODE XREF: sub_2162A+C7j
		push	ds
		pop	es
		assume es:seg000
		mov	si, offset byte_1CCF2
		mov	di, offset byte_1CF4A
		mov	cx, 258h
		rep movsb
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		mov	si, offset byte_1CCF2
		mov	ax, word_1CCED
		cmp	ax, word_1CCE5
		mov	al, 0
		jz	short loc_2171B
		retn
; ---------------------------------------------------------------------------

loc_2171B:				; CODE XREF: sub_2162A+EEj
		mov	al, 0FFh
		retn
sub_2162A	endp


; =============== S U B	R O U T	I N E =======================================


sub_2171E	proc near		; CODE XREF: seg001:3964p seg001:396Fp
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		call	sub_21734
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn
sub_2171E	endp


; =============== S U B	R O U T	I N E =======================================


sub_21734	proc near		; CODE XREF: sub_2171E+9p
		mov	word_1CCED, 0
		mov	word_1CCEF, 0
		call	sub_21872
		mov	bh, 0
		mov	bl, al
		mov	word_1CCDD, bx
		call	sub_21872
		mov	dh, 0
		mov	dl, al
		mov	word_1CCDF, dx
		call	sub_21872
		mov	ah, 0
		mov	word_1CCE5, ax
		call	sub_21872
		mov	ah, 0
		mov	word_1CCE7, ax
		mov	dx, word_1CCED
		mov	bx, word_1CCEF
		call	sub_2185E
		call	sub_21775
		retn
sub_21734	endp


; =============== S U B	R O U T	I N E =======================================


sub_21775	proc near		; CODE XREF: sub_21734+3Dp
					; sub_21775+32j ...
		call	sub_21872
		cmp	al, 0E9h ; 'È'
		jz	short loc_217AA

loc_2177C:				; CODE XREF: sub_21775+3Aj
		mov	es, word_1D30C
		assume es:nothing
		mov	es:[si], al
		mov	es:[si+50h], al
		call	sub_21872
		mov	es:[si+8000h], al
		mov	es:[si+8050h], al
		call	sub_21872
		mov	es, word_1D310
		assume es:nothing
		mov	es:[si], al
		mov	es:[si+50h], al
		call	sub_21823
		cmp	al, 0
		jz	short sub_21775
		retn
; ---------------------------------------------------------------------------

loc_217AA:				; CODE XREF: sub_21775+5j
		call	sub_21872
		cmp	al, 0E9h ; 'È'
		jz	short loc_2177C
		mov	bh, 0
		mov	bl, al
		call	sub_21872
		mov	ch, 0
		mov	cl, al
		and	cl, 3Fh
		inc	cx
		push	bx
		mov	bh, 0
		mov	bl, al
		shr	bl, 1
		shr	bl, 1
		shr	bl, 1
		shr	bl, 1
		shr	bl, 1
		shr	bl, 1
		mov	dx, word_1CCED
		sub	dx, bx
		pop	bx
		push	di
		push	es
		push	si
		call	sub_2185E
		mov	di, si
		pop	si

loc_217E1:				; CODE XREF: sub_21775+A4j
		mov	es, word_1D30C
		assume es:nothing
		mov	al, es:[di]
		mov	es:[si], al
		mov	es:[si+50h], al
		mov	al, es:[di+8000h]
		mov	es:[si+8000h], al
		mov	es:[si+8050h], al
		mov	es, word_1D310
		assume es:nothing
		mov	al, es:[di]
		mov	es:[si], al
		mov	es:[si+50h], al
		call	sub_21823
		cmp	al, 0
		jnz	short loc_21820
		add	di, 50h
		add	di, 50h
		loop	loc_217E1
		pop	es
		assume es:nothing
		pop	di
		jmp	sub_21775
; ---------------------------------------------------------------------------

loc_21820:				; CODE XREF: sub_21775+9Cj
		pop	es
		pop	di
		retn
sub_21775	endp


; =============== S U B	R O U T	I N E =======================================


sub_21823	proc near		; CODE XREF: sub_21775+2Dp
					; sub_21775+97p
		add	si, 0A0h ; '†'
		mov	ax, word_1CCEF
		inc	ax
		mov	word_1CCEF, ax
		cmp	ax, word_1CCE7
		mov	al, 0
		jz	short loc_21837
		retn
; ---------------------------------------------------------------------------

loc_21837:				; CODE XREF: sub_21823+11j
		mov	ax, word_1CCE3
		mov	word_1CCEF, ax
		mov	ax, word_1CCED
		inc	ax
		mov	word_1CCED, ax
		mov	dx, word_1CCED
		mov	bx, word_1CCEF
		call	sub_2185E
		mov	ax, word_1CCED
		cmp	ax, word_1CCE5
		mov	al, 0
		jz	short loc_2185B
		retn
; ---------------------------------------------------------------------------

loc_2185B:				; CODE XREF: sub_21823+35j
		mov	al, 0FFh
		retn
sub_21823	endp


; =============== S U B	R O U T	I N E =======================================


sub_2185E	proc near		; CODE XREF: sub_2162A+2Ep
					; sub_21734+3Ap ...
		add	dx, word_1CCDD
		add	bx, word_1CCDF
		mov	ax, 0A0h ; '†'
		push	dx
		mul	bx
		pop	dx
		add	ax, dx
		mov	si, ax
		retn
sub_2185E	endp


; =============== S U B	R O U T	I N E =======================================


sub_21872	proc near		; CODE XREF: sub_21581+Cp
					; sub_21581+17p ...
		mov	al, [di]
		inc	di
		retn
sub_21872	endp


; =============== S U B	R O U T	I N E =======================================


PushPopAllRegs	proc near		; CODE XREF: DrawDialogTextp
					; sub_207DF:loc_207EBp	...
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn
PushPopAllRegs	endp

; ---------------------------------------------------------------------------
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	al, 1
		cmp	al, 0
		mov	ah, 40h	; '@'
		jz	short loc_2189C
		mov	ah, 41h	; 'A'

loc_2189C:				; CODE XREF: seg001:4538j
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 0Ah
		mov	al, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 1Bh
		mov	al, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 13h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all

loc_218AE:				; CODE XREF: seg001:4937j
		mov	al, 1
		xor	ah, ah
		mov	cl, 64h	; 'd'
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 0Ah
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, 30h	; '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 1Ah
		xor	ah, ah
		mov	cl, 64h	; 'd'
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 0Ah
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, 30h	; '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, 0D1A2h
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, 0D269h
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"

loc_218FE:				; CODE XREF: seg001:464Ej
		mov	cx, 0Ah
		call	sub_21068
		call	sub_219E4
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 4
		jz	short loc_2191C
		mov	ax, word_1D295
		sub	ax, 32h	; '2'
		jb	short loc_2191C
		mov	word_1D295, ax

loc_2191C:				; CODE XREF: seg001:45AFj seg001:45B7j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_21932
		mov	ax, word_1D295
		cmp	ax, 0
		jz	short loc_21932
		dec	ax
		mov	word_1D295, ax

loc_21932:				; CODE XREF: seg001:45C4j seg001:45CCj
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_21948
		mov	ax, word_1D295
		cmp	ax, 3FFh
		jz	short loc_21948
		inc	ax
		mov	word_1D295, ax

loc_21948:				; CODE XREF: seg001:45DAj seg001:45E2j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 20h
		jz	short loc_21960
		mov	ax, word_1D295
		add	ax, 32h	; '2'
		cmp	ax, 400h
		jnb	short loc_21960
		mov	word_1D295, ax

loc_21960:				; CODE XREF: seg001:45F0j seg001:45FBj
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 40h
		jz	short loc_21975
		mov	ax, word_1D295
		call	sub_211C8
		inc	dl
		call	sub_211E8

loc_21975:				; CODE XREF: seg001:4608j
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 80h
		jz	short loc_2198A
		mov	ax, word_1D295
		call	sub_211C8
		dec	dl
		call	sub_211E8

loc_2198A:				; CODE XREF: seg001:461Dj
		mov	ax, 40Eh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_219A4

loc_21994:				; CODE XREF: seg001:463Cj
		mov	ax, 40Eh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21994
		call	ClearTRAM2
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_219A4:				; CODE XREF: seg001:4632j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_219B1
		jmp	loc_218FE
; ---------------------------------------------------------------------------

loc_219B1:				; CODE XREF: seg001:464Cj seg001:4659j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_219B1
		mov	ah, 0Ah
		mov	al, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 1Bh
		mov	al, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	ClearTRAM2
		mov	al, 0
		cmp	al, 0
		mov	ah, 40h	; '@'
		jz	short loc_219D8
		mov	ah, 41h	; 'A'

loc_219D8:				; CODE XREF: seg001:4674j
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn

; =============== S U B	R O U T	I N E =======================================


sub_219E4	proc near		; CODE XREF: seg001:45A4p
		mov	dh, 2Ch	; ','
		mov	dl, 1
		mov	ax, word_1D295
		call	sub_21A52
		mov	ax, 0
		mov	dh, 0Ah
		mov	dl, 2
		mov	cx, 15h

loc_219F8:				; CODE XREF: sub_219E4+6Bj
		push	cx
		push	dx
		call	sub_21A52
		mov	byte ptr es:[bx], 3Ah ;	':'
		mov	byte ptr es:[bx+2000h],	21h ; '!'
		inc	bx
		inc	bx
		mov	cx, 5

loc_21A0C:				; CODE XREF: sub_219E4+65j
		push	cx
		mov	cx, 0Ah

loc_21A10:				; CODE XREF: sub_219E4:loc_21A44j
		cmp	ax, 400h
		jz	short loc_21A44
		push	ax
		push	bx
		push	cx
		push	dx
		call	sub_211C8
		cmp	dl, 0Ah
		jb	short loc_21A24
		add	dl, 7

loc_21A24:				; CODE XREF: sub_219E4+3Bj
		add	dl, 30h	; '0'
		mov	ah, dl
		pop	dx
		pop	cx
		pop	bx
		mov	es:[bx], ah
		pop	ax
		cmp	ax, word_1D295
		push	ax
		mov	ah, 0E1h ; '·'
		jnz	short loc_21A3B
		mov	ah, 0E5h ; 'Â'

loc_21A3B:				; CODE XREF: sub_219E4+53j
		mov	es:[bx+2000h], ah
		inc	bx
		inc	bx
		pop	ax
		inc	ax

loc_21A44:				; CODE XREF: sub_219E4+2Fj
		loop	loc_21A10
		inc	bx
		inc	bx
		pop	cx
		loop	loc_21A0C
		pop	dx
		pop	cx
		inc	dl
		loop	loc_219F8
		retn
sub_219E4	endp


; =============== S U B	R O U T	I N E =======================================


sub_21A52	proc near		; CODE XREF: sub_219E4+7p
					; sub_219E4+16p ...
		push	ax
		push	dx
		push	ax
		push	dx
		mov	ah, 0
		mov	al, dl
		mov	dx, 0A0h
		mul	dx
		pop	dx
		mov	dl, dh
		mov	dh, 0
		add	dx, dx
		add	ax, dx
		mov	bx, ax
		mov	es, word_1D30A
		assume es:nothing
		pop	dx
		mov	ax, dx
		mov	cx, 1000
		call	Digit2TRAM
		mov	cx, 100
		call	Digit2TRAM
		mov	cx, 0Ah
		call	Digit2TRAM
		add	al, '0'
		mov	es:[bx], al
		mov	byte ptr es:[bx+2000h],	0C1h
		inc	bx
		inc	bx
		pop	dx
		pop	ax
		retn
sub_21A52	endp


; =============== S U B	R O U T	I N E =======================================


Digit2TRAM	proc near		; CODE XREF: sub_21A52+22p
					; sub_21A52+28p ...
		mov	dh, 0

loc_21A95:				; CODE XREF: Digit2TRAM+8j
		sub	ax, cx
		jb	short loc_21A9D
		inc	dh
		jmp	short loc_21A95
; ---------------------------------------------------------------------------

loc_21A9D:				; CODE XREF: Digit2TRAM+4j
		add	ax, cx
		add	dh, '0'
		mov	es:[bx], dh
		mov	byte ptr es:[bx+2000h],	0C1h
		inc	bx
		inc	bx
		retn
Digit2TRAM	endp

; ---------------------------------------------------------------------------
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		mov	al, 1
		cmp	al, 0
		mov	ah, 40h	; '@'
		jz	short loc_21AC1
		mov	ah, 41h	; 'A'

loc_21AC1:				; CODE XREF: seg001:475Dj
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 0Ah
		mov	al, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 1Bh
		mov	al, 0
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 13h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all

loc_21AD3:				; CODE XREF: seg001:4641j seg001:47E1j ...
		mov	al, 1
		xor	ah, ah
		mov	cl, 64h	; 'd'
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 0Ah
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, 30h	; '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 1Ah
		xor	ah, ah
		mov	cl, 64h	; 'd'
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 0Ah
		div	cl
		add	al, 30h	; '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, 30h	; '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aVVVVVVjvVbvVVV ; "ÇÍÇ∂Ç∑ÇΩÇÃÇ¶Ç≈Ç°Ç¡Ç∆ÇﬁÇßÅ[Ç«$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_21CDA

loc_21B26:				; CODE XREF: seg001:4944j
		mov	cx, 0Ah
		call	sub_21068
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 4
		jz	short loc_21B43
		mov	ax, word_1D2D2
		sub	ax, 5
		jb	short loc_21B43
		mov	word_1D2D2, ax
		jmp	short loc_21AD3
; ---------------------------------------------------------------------------

loc_21B43:				; CODE XREF: seg001:47D4j seg001:47DCj
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_21B5C
		mov	ax, word_1D2D2
		cmp	ax, 0
		jz	short loc_21B5C
		dec	ax
		mov	word_1D2D2, ax
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_21B5C:				; CODE XREF: seg001:47EBj seg001:47F3j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_21B75
		mov	ax, word_1D2D2
		cmp	ax, 1Ah
		jz	short loc_21B75
		inc	ax
		mov	word_1D2D2, ax
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_21B75:				; CODE XREF: seg001:4804j seg001:480Cj
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 20h
		jz	short loc_21B90
		mov	ax, word_1D2D2
		add	ax, 5
		cmp	ax, 1Bh
		jnb	short loc_21B90
		mov	word_1D2D2, ax
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_21B90:				; CODE XREF: seg001:481Dj seg001:4828j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21B9D
		jmp	loc_21C60
; ---------------------------------------------------------------------------

loc_21B9D:				; CODE XREF: seg001:4838j seg001:4845j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21B9D
		mov	al, 2
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, '.'
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, word_1D2D2
		add	bx, bx
		add	bx, offset off_17968
		mov	ax, [bx]
		push	bx
		call	sub_21FF3
		pop	bx
		mov	[bx], ax

loc_21C03:				; CODE XREF: seg001:48ABj
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21C03
		mov	al, 2
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 35
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aEditReg_0 ;	"edit reg *:	 $"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_21C60:				; CODE XREF: seg001:483Aj
		mov	ax, 406h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_21C80
		call	ClearTRAM2
		call	sub_21DB6

loc_21C70:				; CODE XREF: seg001:4918j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21C70
		call	ClearTRAM2
		jmp	loc_21AD3
; ---------------------------------------------------------------------------

loc_21C80:				; CODE XREF: seg001:4908j
		mov	ax, 40Eh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jz	short loc_21C9A

loc_21C8A:				; CODE XREF: seg001:4932j
		mov	ax, 40Eh
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21C8A
		call	ClearTRAM2
		jmp	loc_218AE
; ---------------------------------------------------------------------------

loc_21C9A:				; CODE XREF: seg001:4928j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21CA7
		jmp	loc_21B26
; ---------------------------------------------------------------------------

loc_21CA7:				; CODE XREF: seg001:4942j seg001:494Fj
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21CA7
		mov	ah, 0Ah
		mov	al, 0Ch
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 1Bh
		mov	al, 1
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		mov	ah, 12h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		call	ClearTRAM2
		mov	al, 0
		cmp	al, 0
		mov	ah, 40h	; '@'
		jz	short loc_21CCE
		mov	ah, 41h	; 'A'

loc_21CCE:				; CODE XREF: seg001:496Aj
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn

; =============== S U B	R O U T	I N E =======================================


sub_21CDA	proc near		; CODE XREF: seg001:47C3p
		mov	al, 2
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 35
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 0Ah
		div	cl
		add	al, 48
		mov	byte ptr a000000h_0+7, al
		add	ah, 48
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aEditReg_0 ;	"edit reg *:	 $"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, word_1D2D2
		add	ax, '@'
		mov	es, word_1D30A
		assume es:nothing
		mov	es:0F6h, ax
		mov	byte ptr es:20F6h, 0E1h
		mov	ax, 0
		mov	dh, 14h
		mov	dl, 2
		mov	cx, 6

loc_21D48:				; CODE XREF: sub_21CDA+D6j
		push	cx
		push	dx
		mov	cx, 5

loc_21D4D:				; CODE XREF: sub_21CDA+D0j
		push	ax
		push	cx
		push	dx
		push	ax
		push	dx
		push	dx
		mov	ah, 0
		mov	al, dl
		mov	dx, 0A0h ; '†'
		mul	dx
		pop	dx
		mov	dl, dh
		mov	dh, 0
		add	dx, dx
		add	ax, dx
		mov	bx, ax
		mov	es, word_1D30A
		pop	dx
		pop	ax
		mov	di, ax
		add	al, '@'
		mov	es:[bx], al
		mov	byte ptr es:[bx+2000h],	0E1h
		mov	byte ptr es:[bx+2], ':'
		mov	byte ptr es:[bx+2002h],	0E1h
		cmp	di, word_1D2D2
		mov	cl, 0E1h ; '·'
		jnz	short loc_21D8F
		mov	cl, 0E5h ; 'Â'

loc_21D8F:				; CODE XREF: sub_21CDA+B1j
		add	di, di
		add	di, offset off_17968
		mov	ax, [di]
		inc	dh
		inc	dh
		call	DrawHexNumber
		pop	dx
		add	dh, 8
		pop	cx
		pop	ax
		inc	ax
		cmp	ax, 1Bh
		jz	short loc_21DB3
		loop	loc_21D4D
		pop	dx
		inc	dl
		pop	cx
		loop	loc_21D48
		retn
; ---------------------------------------------------------------------------

loc_21DB3:				; CODE XREF: sub_21CDA+CEj
		pop	dx
		pop	cx
		retn
sub_21CDA	endp


; =============== S U B	R O U T	I N E =======================================


sub_21DB6	proc near		; CODE XREF: seg001:490Dp
		pushf
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es

loc_21DBF:				; CODE XREF: sub_21DB6+77j
					; sub_21DB6+8Fj ...
		mov	al, 1
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 26
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aVabVFzcVVjvVbv ; "ÇÌÅ[Ç«îzóÒÇÃÇ¶Ç≈Ç°Ç¡Ç∆Ç‡ÇßÇ«$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		call	sub_21F2F

loc_21E12:				; CODE XREF: sub_21DB6+162j
		mov	cx, 0Ah
		call	sub_21068
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 4
		jz	short loc_21E2F
		mov	ax, word_1D308
		sub	ax, 5
		jb	short loc_21E2F
		mov	word_1D308, ax
		jmp	short loc_21DBF
; ---------------------------------------------------------------------------

loc_21E2F:				; CODE XREF: sub_21DB6+6Aj
					; sub_21DB6+72j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 8
		jz	short loc_21E48
		mov	ax, word_1D308
		cmp	ax, 0
		jz	short loc_21E48
		dec	ax
		mov	word_1D308, ax
		jmp	loc_21DBF
; ---------------------------------------------------------------------------

loc_21E48:				; CODE XREF: sub_21DB6+81j
					; sub_21DB6+89j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jz	short loc_21E61
		mov	ax, word_1D308
		cmp	ax, 63h	; 'c'
		jz	short loc_21E61
		inc	ax
		mov	word_1D308, ax
		jmp	loc_21DBF
; ---------------------------------------------------------------------------

loc_21E61:				; CODE XREF: sub_21DB6+9Aj
					; sub_21DB6+A2j
		mov	ax, 407h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 20h
		jz	short loc_21E7C
		mov	ax, word_1D308
		add	ax, 5
		cmp	ax, 64h	; 'd'
		jnb	short loc_21E7C
		mov	word_1D308, ax
		jmp	loc_21DBF
; ---------------------------------------------------------------------------

loc_21E7C:				; CODE XREF: sub_21DB6+B3j
					; sub_21DB6+BEj
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21E89
		jmp	loc_21F0E
; ---------------------------------------------------------------------------

loc_21E89:				; CODE XREF: sub_21DB6+CEj
					; sub_21DB6+DBj
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21E89
		mov	dh, 2Dh	; '-'
		mov	dl, 1
		mov	ax, word_1D308
		call	sub_21A52
		mov	al, 2
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 52
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	bx, word_1D2D2
		add	bx, bx
		add	bx, offset off_17968
		mov	ax, word_1D308
		add	ax, ax
		add	ax, [bx]
		xchg	ax, bx
		mov	ax, [bx]
		push	bx
		call	sub_21FF3
		pop	bx
		mov	[bx], ax

loc_21F01:				; CODE XREF: sub_21DB6+153j
		mov	ax, 403h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 10h
		jnz	short loc_21F01
		jmp	loc_21DBF
; ---------------------------------------------------------------------------

loc_21F0E:				; CODE XREF: sub_21DB6+D0j
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21F1B
		jmp	loc_21E12
; ---------------------------------------------------------------------------

loc_21F1B:				; CODE XREF: sub_21DB6+160j
					; sub_21DB6+16Dj
		mov	ax, 400h
		int	18h		; TRANSFER TO ROM BASIC
					; causes transfer to ROM-based BASIC (IBM-PC)
					; often	reboots	a compatible; often has	no effect at all
		test	ah, 1
		jnz	short loc_21F1B
		pop	es
		assume es:nothing
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf
		retn
sub_21DB6	endp


; =============== S U B	R O U T	I N E =======================================


sub_21F2F	proc near		; CODE XREF: sub_21DB6+59p
		mov	al, 2
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+2, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+3, al
		add	ah, '0'
		mov	byte ptr a000000h_0+4, ah
		mov	al, 35
		xor	ah, ah
		mov	cl, 100
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+6, al
		mov	al, ah
		xor	ah, ah
		mov	cl, 10
		div	cl
		add	al, '0'
		mov	byte ptr a000000h_0+7, al
		add	ah, '0'
		mov	byte ptr a000000h_0+8, ah
		mov	dx, offset a000000h_0 ;	"\x1B[000;000H$"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	dx, offset aEditReg ; "edit reg	*[    ]:     $"
		mov	ah, 9
		int	21h		; DOS -	PRINT STRING
					; DS:DX	-> string terminated by	"$"
		mov	ax, word_1D2D2
		add	ax, '@'
		mov	es, word_1D30A
		assume es:nothing
		mov	es:0F6h, ax
		mov	byte ptr es:20F6h, 0E1h
		mov	dh, 2Dh
		mov	dl, 1
		mov	ax, word_1D308
		call	sub_21A52
		mov	ax, 0
		mov	dh, 0Ch
		mov	dl, 2
		mov	cx, 14h

loc_21FA7:				; CODE XREF: sub_21F2F+C1j
		push	cx
		push	dx
		mov	cx, 5

loc_21FAC:				; CODE XREF: sub_21F2F+BBj
		push	ax
		push	cx
		push	ax
		push	dx
		call	sub_21A52
		mov	byte ptr es:[bx], ':'
		mov	byte ptr es:[bx+2000h],	0E1h
		pop	dx
		add	dh, 5
		pop	ax
		push	dx
		cmp	ax, word_1D308
		mov	cx, 0E1h ; '·'
		jnz	short loc_21FCF
		mov	cx, 0E5h ; 'Â'

loc_21FCF:				; CODE XREF: sub_21F2F+9Bj
		mov	bx, word_1D2D2
		add	bx, bx
		add	bx, offset off_17968
		add	ax, ax
		add	ax, [bx]
		xchg	ax, bx
		mov	ax, [bx]
		call	DrawHexNumber
		pop	dx
		add	dh, 6
		pop	cx
		pop	ax
		inc	ax
		loop	loc_21FAC
		pop	dx
		inc	dl
		pop	cx
		loop	loc_21FA7
		retn
sub_21F2F	endp


; =============== S U B	R O U T	I N E =======================================


sub_21FF3	proc near		; CODE XREF: seg001:489Dp
					; sub_21DB6+145p
		push	ax
		mov	ax, 0C00h
		int	21h		; DOS -	CLEAR KEYBOARD BUFFER
					; AL must be 01h, 06h, 07h, 08h, or 0Ah.
		mov	dx, offset unk_1D2C5
		mov	ah, 0Ah
		int	21h		; DOS -	BUFFERED KEYBOARD INPUT
					; DS:DX	-> buffer
		mov	ch, 0
		mov	cl, byte_1D2C6
		cmp	cl, 0
		pop	ax
		jnz	short loc_2200D
		retn
; ---------------------------------------------------------------------------

loc_2200D:				; CODE XREF: sub_21FF3+17j
		mov	ax, 0
		mov	bx, offset asc_1D2C7 ; "	  $"

loc_22013:				; CODE XREF: sub_21FF3+3Aj
		mov	dh, 0
		mov	dl, [bx]
		inc	bx
		sub	dl, '0'
		cmp	dl, 10
		jb	short loc_22023
		sub	dl, 7

loc_22023:				; CODE XREF: sub_21FF3+2Bj
		add	ax, ax
		add	ax, ax
		add	ax, ax
		add	ax, ax
		add	ax, dx
		loop	loc_22013
		retn
sub_21FF3	endp


; =============== S U B	R O U T	I N E =======================================


DrawHexNumber	proc near		; CODE XREF: sub_21CDA+C1p
					; sub_21F2F+B1p
		push	ax
		push	dx
		mov	ch, 0
		mov	di, cx
		push	ax
		push	dx
		mov	ah, 0
		mov	al, dl
		mov	dx, 0A0h ; '†'
		mul	dx
		pop	dx
		mov	dl, dh
		mov	dh, 0
		add	dx, dx
		add	ax, dx
		mov	bx, ax
		mov	es, word_1D30A
		pop	dx
		mov	ax, dx
		mov	cx, 1000h
		call	DrawHexDigit
		mov	cx, 100h
		call	DrawHexDigit
		mov	cx, 10h
		call	DrawHexDigit
		add	al, '0'
		cmp	al, ':'
		jb	short loc_2206D
		add	al, 7

loc_2206D:				; CODE XREF: DrawHexNumber+39j
		mov	es:[bx], al
		mov	es:[bx+2000h], di
		inc	bx
		inc	bx
		pop	dx
		pop	ax
		retn
DrawHexNumber	endp


; =============== S U B	R O U T	I N E =======================================


DrawHexDigit	proc near		; CODE XREF: DrawHexNumber+26p
					; DrawHexNumber+2Cp ...
		mov	dh, 0

loc_2207C:				; CODE XREF: DrawHexDigit+8j
		sub	ax, cx
		jb	short loc_22084
		inc	dh
		jmp	short loc_2207C
; ---------------------------------------------------------------------------

loc_22084:				; CODE XREF: DrawHexDigit+4j
		add	ax, cx
		add	dh, '0'
		cmp	dh, ':'
		jb	short loc_22091
		add	dh, 7

loc_22091:				; CODE XREF: DrawHexDigit+12j
		mov	es:[bx], dh
		mov	es:[bx+2000h], di
		inc	bx
		inc	bx
		retn
DrawHexDigit	endp

; ---------------------------------------------------------------------------
		align 8
seg001		ends

; ===========================================================================

; Segment type:	Uninitialized
seg002		segment	byte stack 'STACK' use16
		assume cs:seg002
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
		db 7FBh	dup(0),	1, 80h,	23h, 2,	72h
seg002		ends

; ===========================================================================

; Segment type:	Pure code
seg003		segment	byte public 'CODE' use16
		assume cs:seg003
		assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


sub_228A0	proc far		; CODE XREF: start+67P
		pushf
		mov	cs:word_22904, ax
		mov	ax, 470h
		add	ax, 0Fh
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		shr	ax, 1
		mov	cs:word_22908, ax
		mov	ax, cs
		add	ax, cs:word_22908
		mov	cs:word_2290A, ax
		cli
		mov	cs:word_22908, ss
		mov	cs:word_22906, sp
		mov	ss, ax
		mov	sp, 9E0h
		sti
		mov	ax, cs:word_22904
		call	sub_2290C
		mov	ds, cs:word_2290A
		cld
		call	sub_22952
		push	cs:word_22902
		push	si
		push	ax
		call	near ptr byte_2297C
		call	sub_22968
		call	sub_2291E
		cli
		mov	ss, cs:word_22908
		mov	sp, cs:word_22906
		sti
		popf
		retf
sub_228A0	endp

; ---------------------------------------------------------------------------
		align 2
word_22902	dw 7F31h		; DATA XREF: sub_228A0+43r
word_22904	dw 0			; DATA XREF: sub_228A0+1w
					; sub_228A0+33r ...
word_22906	dw 0			; DATA XREF: sub_228A0+28w
					; sub_228A0+59r
word_22908	dw 0			; DATA XREF: sub_228A0+13w
					; sub_228A0+19r ...
word_2290A	dw 0			; DATA XREF: sub_228A0+1Ew
					; sub_228A0+3Ar

; =============== S U B	R O U T	I N E =======================================


sub_2290C	proc near		; CODE XREF: sub_228A0+37p
		pop	cs:word_22904
		push	bp
		push	di
		push	si
		push	ds
		push	es
		push	bx
		push	cx
		push	dx
		jmp	cs:word_22904
sub_2290C	endp


; =============== S U B	R O U T	I N E =======================================


sub_2291E	proc near		; CODE XREF: sub_228A0+50p
		pop	cs:word_22904
		pop	dx
		pop	cx
		pop	bx
		pop	es
		pop	ds
		pop	si
		pop	di
		pop	bp
		jmp	cs:word_22904
sub_2291E	endp ; sp-analysis failed


; =============== S U B	R O U T	I N E =======================================


sub_22930	proc near		; CODE XREF: sub_22952+2p sub_22968+5p
		push	ds
		pop	es
		mov	di, 24h	; '$'
		mov	cx, 40h
		sub	cx, di
		shr	cx, 1
		sub	ax, ax
		jcxz	short loc_22942
		rep stosw

loc_22942:				; CODE XREF: sub_22930+Ej
		push	cs
		pop	ds
		assume ds:seg003
		mov	cx, 494h
		mov	bx, offset byte_2297C
		sub	si, si
		sub	cx, bx
		shr	cx, 1
		retn
sub_22930	endp

; ---------------------------------------------------------------------------
		align 2

; =============== S U B	R O U T	I N E =======================================


sub_22952	proc near		; CODE XREF: sub_228A0+40p
		push	ax
		push	ds
		call	sub_22930

loc_22957:				; CODE XREF: sub_22952+Ej
		xor	[bx], cx
		rol	word ptr [bx], 1
		add	si, [bx]
		lea	bx, [bx+2]
		loop	loc_22957
		pop	ds
		assume ds:seg000
		call	near ptr byte_22B06
		pop	ax
		retn
sub_22952	endp


; =============== S U B	R O U T	I N E =======================================


sub_22968	proc near		; CODE XREF: sub_228A0+4Dp
		push	ax
		push	ds
		call	near ptr byte_22B06
		call	sub_22930

loc_22970:				; CODE XREF: sub_22968+Fj
		ror	word ptr [bx], 1
		xor	[bx], cx
		lea	bx, [bx+2]
		loop	loc_22970
		pop	ds
		pop	ax
		retn
sub_22968	endp

; ---------------------------------------------------------------------------
byte_2297C	db 76h,	0C4h, 0ADh, 5Dh, 0FAh, 81h, 0F1h, 5Dh, 0F8h, 1
					; CODE XREF: sub_228A0+4Ap
					; DATA XREF: sub_22930+17o
		db 0D8h, 29h, 22h, 28h,	55h, 0FEh, 0EFh, 5, 0ACh, 0BAh
		db 0D1h, 29h, 0AEh, 0BAh, 0D2h,	75h, 30h, 1, 0Bh, 0F3h
		db 0E3h, 0E0h, 0CFh, 1,	61h, 0C4h, 3Ch,	40h, 0BFh, 5, 0E3h
		db 0AAh, 9Bh, 0, 0C4h, 29h, 0BAh, 9Ah, 0DEh, 1,	0BCh, 9Ah
		db 0DBh, 1, 35h, 8, 41h, 0C0h, 0DDh, 2,	0FBh, 0F9h, 9Eh
		db 41h,	2, 7Eh,	9Ch, 3Bh, 0BBh,	0F5h, 0FCh, 0, 9Bh, 44h
		db 0B5h, 45h, 95h, 7Eh,	0B0h, 61h, 0Eh,	80h, 47h, 3Fh
		db 33h,	5Eh, 0B4h, 81h,	0F4h, 0BEh, 0D3h, 22h, 0EBh, 3
		db 0B1h, 22h, 0D3h, 3Bh, 0AAh, 0F5h, 9Ch, 0, 0D6h, 0A6h
		db 54h,	3Bh, 0DFh, 75h,	94h, 0,	0E0h, 23h, 0DEh, 14h, 0D1h
		db 2Eh,	0Dh, 0C4h, 53h,	0AFh, 0C1h, 0C9h, 35h, 0C4h, 0E8h
		db 2Ah,	0D8h, 0BAh, 9Fh, 44h, 0B8h, 3, 0DEh, 23h, 9Bh
		db 5Dh,	99h, 81h, 0BFh,	5Dh, 0EDh, 1, 0BDh, 2Ah, 60h, 36h
		db 12h,	40h, 0F0h, 2, 94h, 0E1h, 2Ah, 8Fh, 0D3h, 3, 8Eh
		db 29h,	0D1h, 78h, 8Ch,	29h, 0A0h, 75h,	0A4h, 0, 0C8h
		db 0E3h, 0Bh, 4, 67h, 3Bh, 83h,	75h, 3Ch, 7Eh, 0ACh, 75h
		db 70h,	1, 0C3h, 0E3h, 80h, 2Eh, 2Eh, 0E0h, 0D5h, 0C4h
		db 88h,	40h, 0Bh, 3, 57h, 0AAh,	3Eh, 0BAh, 0F8h, 7Eh, 43h
		db 4, 7, 0BBh, 73h, 75h, 2Bh, 0, 34h, 0E3h, 0F6h, 50h
		db 6Ah,	1, 36h,	8Ah, 6Bh, 1, 13h, 3, 0A7h, 14h,	11h, 0AAh
		db 99h,	63h, 0ECh, 40h,	9, 0, 6Fh, 0E1h, 53h, 16h, 0Bh
		db 82h,	7Fh, 1,	5Dh, 4Dh, 0BAh,	80h, 64h, 2Ah, 0A5h, 0A3h
		db 67h,	29h, 95h, 41h, 9Fh, 0C0h, 3Dh, 3, 0F9h,	0BDh, 24h
		db 75h,	0B4h, 1, 1Fh, 0A2h, 24h, 75h, 0BCh, 1, 41h, 0A2h
		db 0A9h, 0, 55h, 19h, 55h, 2Eh,	0FBh, 0C4h, 0A1h, 0AFh
		db 33h,	0C9h, 2Eh, 3, 15h, 3, 0DDh, 6, 50h, 3, 0F4h, 0
		db 2Fh,	3, 0B3h, 22h, 8Bh, 0FEh, 0CAh, 0BEh, 0A3h, 74h
		db 1Eh,	49h, 0ECh, 0C4h, 0B3h, 44h, 6Bh, 3, 86h, 82h, 0BDh
		db 0BAh, 0C0h, 44h, 67h, 83h, 0FAh, 0AAh, 3Dh, 46h, 1Eh
		db 85h,	0F9h, 0B6h, 0BEh, 2Ch, 0F4h, 7Eh, 36h, 13h, 38h
		db 44h,	55h, 14h, 0C4h,	2Fh, 54h, 0C9h,	9Eh, 0C4h, 0C5h
		db 2Ah,	50h, 26h, 0B3h,	14h, 0CFh, 94h,	0CFh, 78h, 0FBh
		db 0AEh, 3, 0E0h, 2Eh, 1, 81h, 0C4h, 0DCh, 44h,	0Ah, 3
		db 70h,	83h, 4Eh, 0F5h,	27h, 0A2h, 0A6h, 44h, 48h, 44h
		db 49h,	41h, 53h, 79h, 20h, 0A2h, 0A4h,	44h, 7Bh, 41h
		db 6Ch,	79h, 0,	70h, 26h, 0, 0DEh, 0EDh, 0DFh, 0E0h, 37h
		db 0E0h, 1Ah, 1
byte_22B06	db 18h,	5Dh, 9Bh, 9Bh, 0F3h, 91h, 50h, 8Eh, 1, 1, 54h
					; CODE XREF: sub_22952+11p
					; sub_22968+2p
		db 2, 2, 1, 0CCh, 7Eh, 70h, 0C6h, 0E2h,	14h, 64h, 5Dh
		db 8Dh,	93h, 0EDh, 91h,	85h, 0E0h, 0A3h, 0C4h, 7Eh, 2Ah
		db 0ACh, 0C4h, 3Dh, 3, 40h, 0BFh, 7, 62h, 21h, 3, 2, 62h
		db 23h,	2, 3, 44h, 0FDh, 15h, 8Ch, 28h,	9, 1Eh,	7Ch, 41h
		db 99h,	1, 0FFh, 0E0h, 43h, 16h, 24h, 1, 0F7h, 28h, 0AAh
		db 7Bh,	0F5h, 28h, 0DFh, 74h, 64h, 0, 0B3h, 0E2h, 72h
		db 5, 10h, 3Ah,	0E2h, 47h, 0CCh, 4, 0A8h, 0AEh,	0E9h, 13h
		db 2Bh,	9Fh, 0C8h, 39h,	53h, 86h, 7Bh, 40h, 0D8h, 84h
		db 0C7h, 10h, 5Fh, 82h,	38h, 0,	63h, 75h, 63h, 15h, 1
		db 44h,	0DEh, 3, 0F0h, 0AFh, 70h, 0E1h,	77h, 0C5h, 0AAh
		db 45h,	0F8h, 2, 80h, 2, 3Fh, 8Dh, 9Dh,	62h, 45h, 78h
		db 9Ah,	1Eh, 0DDh, 0BAh, 0D7h, 1Eh, 0D3h, 0BAh,	53h, 15h
		db 31h,	2Eh, 0B1h, 0C8h, 65h, 0C5h, 38h, 41h, 0BBh, 7
		db 0E7h, 0ABh, 8Dh, 0A3h, 33h, 45h, 0B1h, 2Bh, 0B7h, 0BBh
		db 45h,	7Fh, 0FDh, 5, 0BAh, 0BBh, 0C0h,	74h, 0D2h, 0, 83h
		db 0E2h, 45h, 45h, 0E3h, 3, 0FBh, 0A2h,	3Ah, 63h, 9Fh
		db 5, 0BCh, 0, 90h, 74h, 80h, 7Fh, 0F8h, 0E2h, 39h, 45h
		db 0CBh, 74h, 26h, 0, 34h, 0E3h, 1Bh, 2Fh, 76h,	0F2h, 1Ch
		db 0E1h, 1Bh, 0C5h, 0C6h, 2Bh, 0EAh, 0BBh, 0ABh, 74h, 38h
		db 7Fh,	0E9h, 0A3h, 28h, 1Ch, 89h, 2, 93h, 3, 0BDh, 0E0h
		db 0Fh,	75h, 0A4h, 48h,	0DAh, 0BBh, 0A0h, 74h, 85h, 0
		db 0E3h, 0E2h, 0A0h, 5Ch, 0A8h,	2, 0DBh, 0A2h, 1Fh, 44h
		db 0BFh, 2, 0FFh, 0A2h,	18h, 0,	1Ah, 15h, 0F9h,	28h, 0B0h
		db 74h,	0E9h, 0, 0D7h, 0E2h, 17h, 51h, 8Fh, 0, 0D7h, 8Bh
		db 8Eh,	0, 3Eh,	2Eh, 0F1h, 0C8h, 25h, 0C5h, 78h, 50h, 95h
		db 0, 0F7h, 0B3h, 9, 45h, 66h, 41h, 78h, 87h, 0B2h, 88h
		db 0EFh, 0F5h, 0EEh, 0ECh, 0EDh, 0F5h, 0ECh, 0ECh, 0EBh
		db 0F5h, 0EAh, 0ECh, 0E9h, 0F5h, 0E8h, 0ECh, 2Eh, 98h
		db 0FEh, 2Eh, 1Ch, 0C8h, 0D6h, 0C5h, 8Dh, 45h, 59h, 2
		db 28h,	94h, 0F8h, 63h,	74h, 15h, 76h, 0, 0F5h,	2Eh, 15h
		db 0C8h, 0D8h, 2Bh, 2Eh, 88h, 0C8h, 0DDh, 0DEh,	0E2h, 3Fh
		db 95h,	0EEh, 7Bh, 9Ch,	0C5h, 94h, 50h,	7Fh, 0,	2Fh, 0FCh
		db 92h,	0F0h, 69h, 0F8h, 0A2h, 0E3h, 9Dh, 0F1h,	64h, 0EBh
		db 0E6h, 0D5h, 0B6h, 41h, 0Bh, 15h, 30h, 94h, 0E0h, 44h
		db 54h,	15h, 0DEh, 45h,	0BCh, 2Fh, 0F3h, 61h, 0F1h, 0C5h
		db 0ACh, 41h, 2Fh, 2, 73h, 0ABh, 12h, 0BBh, 54h, 45h, 76h
		db 4, 10h, 22h,	0D1h, 95h, 2Dh,	0C5h, 72h, 3, 14h, 22h
		db 4Fh,	0ABh, 0BAh, 6, 0B2h, 41h, 2Eh, 1, 0Fh, 0A3h, 0B5h
		db 5, 0A9h, 3Ah, 0CCh, 0C5h, 64h, 7Fh, 0E9h, 2Fh, 80h
		db 0F2h, 0EAh, 0E1h, 2,	0BFh, 3Dh, 30h,	0FBh, 78h, 23h
		db 22h,	0BFh, 81h, 15h,	74h, 0CBh, 7Eh,	7Dh, 0E2h, 0BAh
		db 23h,	0FBh, 0FFh, 0BBh, 3Fh, 0C8h, 75h, 52h, 48h, 9Ch
		db 0C5h, 0C3h, 45h, 17h, 2, 6Bh, 82h, 5Bh, 0E4h, 74h, 76h
		db 70h,	72h, 0A8h, 81h,	0Dh, 3,	0EBh, 6Dh, 0B9h, 0E1h
		db 0EBh, 72h, 52h, 5, 0DBh, 0E9h, 0C8h,	1, 4, 4, 88h, 0E1h
		db 47h,	0Fh, 3Fh, 0, 0B0h, 41h,	1Dh, 86h, 0A1h,	3Ah, 23h
		db 93h,	0DEh, 0BFh, 99h, 7Fh, 27h, 2, 0C0h, 0, 9Bh, 61h
		db 0Fh,	0E0h, 78h, 0C8h, 0B2h, 0C5h, 0E1h, 45h,	3Dh, 2
		db 50h,	0A3h, 97h, 2Eh,	72h, 0C8h, 12h,	0, 11h,	0, 10h
		db 0, 0Fh, 0, 0A8h, 0A9h, 2Ch, 90h, 16h, 97h, 13h, 98h
		db 1Ah,	39h, 33h, 0B7h,	0B2h, 34h, 0B1h, 0B2h, 11h, 0
		db 0AFh, 3Ah, 0B3h, 32h, 39h, 0B8h, 15h, 0, 0FEh, 0FFh
		db 1Ch dup(0)
		db 410h	dup(42h), 410h dup(54h), 17Eh dup(53h),	2 dup(0FFh)
seg003		ends


		end start
