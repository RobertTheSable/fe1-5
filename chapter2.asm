lorom

ORG $8CD99E
	;disable overworld text
	dl 0

ORG $95B93B
OgmaText:
	incbin binaries/text/ogma.bin
CastorText:
	incbin binaries/text/castor.bin
	incbin binaries/text/castorquote.bin
	
	incbin binaries/text/gomerquote.bin
	incbin binaries/text/gomerdeath.bin
Chapter2EndingText:
	incbin binaries/text/ending2.bin
Chapter2VillageText:
	incbin binaries/text/village2.bin
Chapter2VillageTextMarth:
	incbin binaries/text/village2marth.bin
DarrosExcuseText:
	incbin binaries/text/darrosexcuse.bin
ClericsText:
	incbin binaries/text/obvious.bin
HammerText:
	incbin binaries/text/hammers.bin
	incbin binaries/text/release.bin

ORG $B1DE66
Chapter2Coords:
	db 20, 10
	db 21, 11
	db 23, 10
	db 24, 10
	db 22, 10
	db 23, 9
	db 21, 10
	db 24, 11
	db $FF

ORG $84807E
; Tileset Address 1
	dl $F6A500
; ?
	db $00, $00, $00, $00, $00, $00 
; Tilemap Address
	dl $FAD82F
; Palette Address
	dl $F68100
; Map Address
	dl $F0EEBD
; Map Changes
	dl $FCEC1B
; Starting coordinates for prep screen chapters
	dl Chapter2Coords
; Player Escape Points
	dl $000000
; ?
	db $00, $00, $07, $00, $00, $00, $07, $00
; Enable Fog of War
	db !DisableFog
; Prep Screen
	db !EnablePrepScreen
; Minimum limit
	db 4 
; Maximum Limit
	db 8
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
	dl $848831
; print pc
	
ORG $8CC9FC
	; Fading Colors Fix
	dl $EFF42A
	
ORG $8CD57F
	; Chapter Event Header
	dl OpeningEventHeader2, Chapter2TurnEvents, Chapter2TalkEvents, Chapter2VillageEvents, Chapter2EscapeEvents
	dl Chapter2Shops, Chapter2BossEvents, Chapter2EndingEvent, Chapter2AreaEvents, PrepUnits2
	
ORG $9981B4
OpeningEventHeader2:
	%OPEN(0, openingEvent)
	dw $FFFF
Chapter2TurnEvents:
	;print pc
	%TURN(0, Turn1Event, 1, 0)
	dw $FFFF
Chapter2TalkEvents:
	%TALK1(0, RecruitCastor, !Sheeda, !Castor)
	dw $FFFF
Chapter2VillageEvents:
	%DestroyVillage($21, DestroyRedHouse, 11, 3)
	%VILL($25, ItemVillage, 11, 3)
	%DestroyVillage($22, DestroyHouse1, 17, 7)
	%VILL(0, House1, 17, 7)
	%DestroyVillage($23, DestroyHouse2, 23, 13)
	%VILL(0, House2, 23, 13)
	%DestroyVillage($24, DestroyHouse3, 4, 12)
	%VILL(0, House3, 4, 12)
	
	%SEIZE(0, Chapter2EndingEvent, 2, 3)
	dw $FFFF
Chapter2AreaEvents:
	%AREA($26, IslandEvent, 28, 7, 30, 8)
	dw $FFFF
Chapter2Shops:
	%SHOP(0, Chapter2Shop)
	dw $FFFF
Chapter2BossEvents:
	%BossQuote(5, !Gomer)
	%BossQuote(6, !Castor)
	dw $FFFF
Chapter2EscapeEvents:
	dw $FFFF
	
ORG $9985CA
openingEvent:
	%CAM2(2, 2)
	db $FC
	%MUSI(!Charge)
	%LOU1(LoadTalys)
	%WaitUntilFinished()
	%FADEIN()
	%ShowTitle(Title2)
	
	%CAM(Grust)
	%_45FC()
	%TEX1(OgmaText)
	%ENDEV()
Turn1Event:
	%LOU1(Galder2)
	%_45FC()
	%ENDEV()
RecruitCastor:
	%SCOM(!Fade_Out)
	%WAIT($0020)
	%MUSI(!Joining_A_Group)
	%TEX1(CastorText)
	%ChangeAlign(!Castor)
	%SetStat(!Castor, !Leader, !Marth)
	%ENDEV()
ItemVillage:
	%IfCharacter(!Marth, MarthVillage)
	%SCOM(!Dim)
	%WAIT($0020)
	%TEX1(Chapter2VillageText)
	%GiveItem(!Vulnerary)
	%ChangeTile(11, 3, $3F0)
	%ENDEV()
MarthVillage:
	%SCOM(!Dim)
	%WAIT($0020)
	%TEX1(Chapter2VillageTextMarth)
	%GiveItem(!Vulnerary)
	%ChangeTile(11, 3, $3F0)
	%ENDEV()
House1:
	; Clerics Text
	%SCOM(!Dim)
	%WAIT($0020)
	%TEX1(ClericsText)
	%ENDEV()
House2:
	; Darros Text
	%SCOM(!Dim)
	%WAIT($0020)
	%TEX1(DarrosExcuseText)
	%ENDEV()
House3:
	; Hammer Text
	%SCOM(!Dim)
	%WAIT($0020)
	%TEX1(HammerText)
	%ENDEV()

DestroyHouse1:
	%SFX($45)
	%MapChange(1)
	%ENDEV()
DestroyHouse2:
	%SFX($45)
	%MapChange(2)
	%ENDEV()
DestroyHouse3:
	%SFX($45)
	%MapChange(3)
	%ENDEV()
DestroyRedHouse:
	%SFX($45)
	%MapChange(0)
	%ENDEV()
Chapter2EndingEvent:
	%SCOM(!Fade_Out)
	%WAIT($0020)
	%MUSI(!Victory)
	%PrepBackgroundText(Chapter2EndingText, !BGTown)
	%ShowBackgroundText1()
	%GameOver()
	%ENDCH()
IslandEvent:
	%GiveItem2(!Killer_Sword)
	%ENDEV()


ORG $99c294
	PrepUnits2:
	dl Grust
	dw 0
ORG $B1FAFE
LoadTalys: 
	%UNIT2(!Ogma, !Player, 22, 7, 22, 7, !Marth, !Short_Sword, !Iron_Broadsword, $03, !NoAI)
	%UNIT2(!Barst, !Player, 22, 8, 22, 8, !Marth, !Iron_Axe, !Steel_Axe, $03, !NoAI)
	%UNIT3(!Bord, !Player, 23, 7, 23, 7, !Marth, !Iron_Axe, !Hammer, !Hand_Axe, $05, !NoAI)
	%UNIT1(!Cord, !Player, 24, 8, 24, 8, !Marth, !Iron_Axe, $03, !NoAI)
	dw 0
Grust:
	db 25, 2
	%UNIT1(!GrustCavalier, !Enemy, 0, 5, 1, 5, 0, !Iron_Lance, 1, !NoAI)
	%UNIT1(!GrustCavalier, !Enemy, 0, 6, 1, 6, 0, !Iron_Lance, 1, !NoAI)
Galder1:
	%UNIT2(!Gomer, !Enemy, 2, 3, 2, 3, !Gomer, !Hand_Axe, !Steel_Axe, 3, !BossAI)
	%UNIT1(!Galder_Pirate, !Enemy, 3, 4, 3, 4, !Gomer, !Iron_Axe, 1, $00000802)
	%UNIT1(!Galder_Pirate, !Enemy, 4, 4, 4, 4, !Gomer, !Iron_Axe, 1, $00000802)
	%UNIT1(!Galder_Pirate, !Enemy, 4, 5, 4, 5, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 5, 5, 5, 5, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Hunter, !Enemy, 6, 7, 6, 7, !Gomer, !Iron_Bow, 1, $00000802)
	%UNIT1(!Castor, !Enemy, 7, 4, 7, 4, !Gomer, !Iron_Bow, 1, $00000802)
	dw 0
Galder2:
	%UNIT1(!Galder_Pirate, !Enemy, 25, 2, 23, 3, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 25, 2, 23, 4, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 25, 2, 24, 4, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 25, 2, 25, 3, !Gomer, !Hand_Axe, 1, !NoAI)
	%UNIT1(!Galder_Pirate, !Enemy, 25, 2, 26, 4, !Gomer, !Iron_Axe, 1, !NoAI)
	%UNIT1(!Galder_Hunter, !Enemy, 25, 2, 27, 3, !Gomer, !Iron_Bow, 1, !NoAI)
	%UNIT1(!GenericThief, !Enemy, 25, 2, 26, 3, !Gomer, !Iron_Sword, 1, !TargetVillages)
	%UNIT1(!GenericThief, !Enemy, 25, 2, 24, 3, !Gomer, !Iron_Sword, 1, !TargetVillages)
	dw 0
	
Chapter2Shop:
	%SHOP6(8, 12, !Iron_Sword, !Iron_Bow, !Iron_Axe, !Steel_Axe, !Hand_Axe, !Hammer)
	;print pc
	