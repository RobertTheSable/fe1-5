ORG $E7E010
;Disable chapter 1 map text without breaking the game
	%CALL_LW($1D, $8CAc98, 0)
	db $FC 
	db $FF

; Chapter Header
 ORG $84804A
; Tileset Address 1
	dl $F6E885
	db $00, $00, $00, $00, $00, $00 
; Tilemap Address
	dl $FAEB21
; Palette Address
	dl $F69500
; Map Address
	dl Map1;$F0EC70
; Map Changes
	dl $FCEBF5
; Starting coordinates for prep screen chapters
	dl $000000
;Escape Points
	dl $000000
;
	db $00, $00, $07, $00, $00, $00, $07, $00
; Enable Fog of War
	db !DisableFog
; Prep Screen
	db !DisablePrepScreen
; Minimum limit
	db 10 
; Maximum Limit
	db 20
; Phase controls
; 0 = no phase, 2 = player controlled, 4 = AI controlled
; Player Phase Control
	db !PlayerControl
; CPU Phase Control
	db !AIControl
; NPC Phase Control
	db !NoControl
; NPC/Player/Enemy Alignment 
	db !PlayerVsEnemy
; Player Phase Music
	db !Leaf_Army_Base
; Enemy Phase Music
	db !Menace_BaseA
; ?
	db !Leaf_Army_Base
; Tileset Address 2
	dl $000000
; Tilemap Address 2
	dl $8487CE

	
; Fading colors palette
ORG $8CC9F9
	dl $EFFFE9
	
ORG $8CD561
; Chapter Event Header
	dl OpeningEventHeader, TurnEvents, TalkEvents, VillageEvents, EscapeEvents
	dl ShopEvents, BossQuotes, EndingEvent, AreaEvents, PrepUnits
	
ORG $95A493
OpeningText:
	incbin binaries/text/openingtext.bin
VillageText:
	incbin binaries/text/village.bin
VillageTextMarth:
	incbin binaries/text/marthvillage.bin
WrysText:
	incbin binaries/text/wrys.bin
EndText:
	incbin binaries/text/ending.bin
	incbin binaries/text/Gazzack1.bin
GazzackDeath:
	incbin binaries/text/Gazzack2.bin
	
ORG $FD8000
OpeningEventHeader:
	%OPEN(0, OpeningEvent)
	dw $FFFF
TurnEvents:
	dw $FFFF
ORG $FD8027
TalkEvents:
	dw $FFFF
ORG $FD803D
VillageEvents:
	%VILL($22, village1, 26, 4)
	%VILL($23, village3, 3, 9)
	%DestroyVillage($24, DestroyVillage1, 26, 4)
	%DestroyVillage($25, DestroyVillage2, 3, 9)
	%SEIZE($00, $FD8536, 5, 6)
	dw $FFFF
ORG $FD80E5
AreaEvents:
	dw $FFFF
EscapeEvents:
	dw $FFFF
BossQuotes:
	%BossQuote(7, !Gazzack)
	dw $FFFF

ORG $FD80F3
ShopEvents:
	%SHOP(0, shop1)
	
ORG $FD8396
PrepUnits:
	dw $0000
	
ORG $FD8398
OpeningEvent:
	%CAM2(2, 2) 
	db $FC 
	%FADEIN()
	%SCOM(!Fade_Out)
	%WAIT($0020)
	
	%MUSI(!Crisis)
	
	%ShowTitle(Title1)
	
	%LOU1(LoadEnemy)
	%WaitUntilFinished()
	
	%CAM(coord1)
	%_45FC()
	
	%LOU1(Pirate2)
	
	%MOV2(!GenericThief, 22, 10, 2)
	%_45FC()
	%SFX($45)
	
	%ChangeTile(22, 10, 35)
	%WAIT($001E)
	
	%CAM(coord2)
	%_45FC()
	%LOU1(Sheeda)
	%CAM(coord1)
	%_45FC()
	%Hide(!Sheeda)
	
	%TEX1(OpeningText)
	
	%LOU1(LoadKnights)
	%_45FC()
	
	%LOU1(LoadLord)
	%MOV2(!Marth, 25, 6, 2)
	%_45FC()
	
	%ENDEV()

	
ORG $FD8108
village1:
	%IfCharacter(!Marth, village2)
	%SCOM(!Dim)
	%TEX1(VillageText)
	%GiveItem(!Steel_Sword)
	%ChangeTile(26, 4, 33)
	%ENDEV()
village2:
	%SCOM(!Dim)
	%TEX1(VillageTextMarth)
	%GiveItem(!Steel_Sword)
	%ChangeTile(26, 4, 33)
	%ENDEV()

village3:	
	%SCOM(!Fade_Out)
	%WAIT($0020)
	%MUSI(!Joining_A_Group)
	%TEX1(WrysText)
	%LOU3(Wrys)
	%ChangeTile(3, 9, 33)
	%ENDEV()
DestroyVillage1:
	%SFX($45)
	%ChangeTile(26, 4, 35)
	%ENDEV()
DestroyVillage2:
	%SFX($45)
	%ChangeTile(3, 9, 35)
	%ENDEV()
ORG $B1FCBC
coord1:
	db 20, 7 
coord2:
	db 2, 2
LoadLord:
	%UNIT2(!Doga, !Player, 25, 7, 23, 4, !Marth, !Short_Sword, !Long_Lance, $01, !NoAI)
	%UNIT2(!Gordin, !Player, 25, 7, 24, 4, !Marth, !Iron_Bow, !Long_Bow, $01, !NoAI)
	%UNIT3(!Sheeda, !Player, 25, 7, 26, 6, !Marth, !Thin_Lance, !Dragon_Lance, !Iron_Sword, $01, !NoAI)
	dw $0000
LoadKnights:
	%UNIT3(!Marth, !Player, 25, 7, 25, 7, !Marth, !Rapier, !Iron_Sword, !Vulnerary, $01, !NoAI)
	%UNIT2(!Jagen, !Player, 25, 7, 24, 5, !Marth, !Silver_Lance, !Iron_Sword, $01, !NoAI)
	%UNIT2(!Cain, !Player, 25, 7, 23, 8, !Marth, !Short_Sword, !Long_Sword, $01, !NoAI)
	%UNIT3(!Abel, !Player, 25, 7, 24, 8, !Marth, !Iron_Lance, !Javelin, !Iron_Sword, $01, !NoAI)
	dw $0000
LoadEnemy:
	%UNIT1(!Gazzack, !Enemy, 7, 1, 5, 6, !Gazzack, !Steel_Axe, 5, !BossAI)
	%UNIT1(!Galder_Pirate, !Enemy, 1, 7, 4, 7, !Gazzack, !Iron_Axe, $02, $00000802)
	%UNIT1(!Galder_Pirate, !Enemy, 1, 8, 6, 7, !Gazzack, !Iron_Axe, $02, $00000802)
	%UNIT1(!Galder_Pirate, !Enemy, 14, 1, 14, 5, !Gazzack, !Iron_Axe, $02, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 12, 13, 14, 8, !Gazzack, !Steel_Axe, $03, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 14, 11, 16, 9, !Gazzack, !Steel_Axe, $03, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 5, 1, 7, 2, !Gazzack, !Iron_Axe, $02, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 6, 13, 6, 10, !Gazzack, !Iron_Axe, $02, $00000802)
	%UNIT1(!Galder_Hunter, !Enemy, 6, 12, 7, 8, !Gazzack, !Iron_Bow, $03, $00000802)
	%UNIT1(!GenericThief, !Enemy, 25, 13, 25, 13, !Gazzack, !Short_Sword, 3, !TargetVillages)
	dw $0000
Pirate2:
	%UNIT1(!Galder_Pirate, !Enemy, 11, 1, 11, 1, !Gazzack, !Iron_Axe, $02, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 12, 1, 12, 1, !Gazzack, !Steel_Axe, $03, !NoAI)
	dw $0000
Sheeda:
	%UNIT3(!Sheeda, !Player, 5, 6, 25, 7, !Marth, !Thin_Lance, !Hero_Lance, !Iron_Sword, $01, !NoAI)
	dw $0000
Wrys:
	%UNIT2(!Wrys, !Player, 3, 8, 3, 8, !Marth, !Live, !Vulnerary, $01, !NoAI)
	dw $0000
shop1:
	%SHOP4(25, 2, !Iron_Sword, !Iron_Lance, !Iron_Bow, !Javelin)
	
ORG $FD8536
EndingEvent:
	%SCOM(!Fade_Out)
	%WAIT($0020)
	%MUSI(!Victory)
	%PrepBackgroundText(EndText, 3)
	%ShowBackgroundText1()
	%STOB($00007B, 0)
	%CALL_LB($0f, $00007B, 0)
	%SCOM(!Fade_Out)
	%NXCH()
	%ENDCH()
	
ORG $FD851A
	db $05, $00