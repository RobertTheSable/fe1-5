incsrc eventHelpers/eventing.exp

ORG $F0EC70
ExampleEscapeMap:
	incbin binaries/maps/TestEscape.bin
ExampleEscapeChange:
	incbin binaries/maps/ExampleEscapeChanges.bin
LastFreeSpace:

ORG $B1F5BC
ExampleSpawnPoints:
	db 8, 10
	db 7, 11
	db 6, 10
	db 9, 11
	db 10, 10
	db $FF

ORG $84807E
; Tileset Address 1
	dl $F7AC25
; ?
	db $00, $00, $00, $00, $00, $00 
; Tilemap Address
	dl $FB8059
; Palette Address
	dl $F68300
; Map Address
	dl ExampleEscapeMap
; Map Changes
	dl ExampleEscapeChange
; Starting coordinates for player characters
	dl ExampleSpawnPoints
; Player Escape Points
	dl ExampleEscapePoints
; ?
	db $00, $00, $07, $00, $00, $00, $07, $00
; Enable Fog of War
	db !DisableFog
; prep screen
	db !EnablePrepScreen
; Minimum limit
	db 2 
; Maximum Limit
	db 5
; Phase controls
; 0 = no phase, 2 = player controlled, 4 = AI controlled
; Player Phase Control
	db !PlayerControl
; CPU Phase Control
	db !AIControl
; NPC Phase Control
	db !NoControl
; Controls targets
; if bit 1 is set, enemy and player will target each other
; if bit 2 is set, enemy and npc will target each other
; if bit 4 is set, player and NPC can target each other (like in Chapter 14)
	db !PlayerVsEnemy
; Player phase music
	db !Leaf_Army_Base
; Enemy Phase Units
	db !Menace_BaseA
; 
	db !Leaf_Army_Base
; Tileset Address 2
	dl 0
; Tilemap Address 2?
	dl 0
; print pc

ORG $8CC9FC
	; Fading colors fix
	dl $EFF559
	
ORG $8CD57F
; Chapter Event Header
	dl OpeningEventHeader, ChapterTurnEvents, ChapterTalkEvents, ChapterVillageEvents, ChapterEscapeEvents
	dl ChapterShops, ChapterBossEvents, ChapterEndingEvent, ChapterAreaEvents, PrepUnits
	
ORG $9981B4
OpeningEventHeader: 
	%OPEN(0, OpeningEvent)
	dw $FFFF
ChapterTurnEvents:
	dw $FFFF
ChapterTalkEvents:
	dw $FFFF
ChapterVillageEvents:
	;print pc
	%DOOR($25, Door, 8, 5)
	%CHES($23, LeftChest)
	%CHES($24, RightChest)
	dw $FFFF
ChapterEscapeEvents:
	%StandardEscape(8, EscapeEvent, !Leif)
	dw $FFFF
ChapterShops:
	dw $FFFF
ChapterBossEvents:
	dw $FFFF
ChapterAreaEvents:
	%LORDESCAPED(0, ChapterEndingEvent, 8)
	dw $FFFF
PrepUnits:
	dw $0000
ORG LastFreeSpace
OpeningEvent:
	%CAM2(2, 2) 
	db $FC 
	%FADEIN()
	%SOUNDCOMMAND($00E0)
	%WAIT($0020)
	%LOU(LoadPahn)
	%_45FC()
	%ENDEV()
LeftChest:
	db 5, 2
	db !Steel_Sword, 0
	%MapChange(1)
	%GiveChestItem(LeftChest)
	%ENDEV()
RightChest:
	db 11, 2
	db !Iron_Sword, 0
	%MapChange(2)
	%GiveChestItem(RightChest)
	%ENDEV()
Door:
	%SFX(!OpenDoor)
	%MapChange(0)
	%ENDEV()
EscapeEvent:
	%WAIT($000F)
	db $FC
	%Escape(MovPointer)
	%ENDEV()
MovPointer:
	db 3, 3, 0
ChapterEndingEvent:
	%SOUNDCOMMAND(!Fade_Out)
	%LeaveBehindUnits()
	%EndChapter()
	%NXCH()
	%ENDCH()
ExampleEscapePoints:
	db 1
	db 8, 1, $04
	db 0
LoadPahn:
	%UNIT2(!Pahn, !Player, 8, 4, 8, 4, !Leif, !Iron_Sword, !Lockpick, 1, !NoAI)
	dw $0000