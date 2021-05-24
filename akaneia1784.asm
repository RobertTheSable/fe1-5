lorom

incsrc names.asm
incsrc anims.asm

incsrc eventHelpers/eventing.exp
incsrc FE1helpers.exp

;include maps
ORG $F0EC70
Map1:
	incbin binaries/maps/map.bin
Map2:
	incbin binaries/maps/map2.bin
LastFreeSpace:

ORG $9AB7EF
Title1:
	incbin binaries/text/title1.bin
Title2:
	incbin binaries/text/title2.bin

ORG $FCEC1B
	incbin binaries/maps/map2changes.bin

; include changed stats
ORG $868000
	incbin binaries/stats/classes.bin
ORG $869A2D
	incbin binaries/stats/characters.bin
	
ORG $8880CD
	incbin binaries/stats/supports.bin
	
ORG $8CDBC9
	incbin binaries/stats/DeathQuotes.bin
ORG $8CDA07
	incbin binaries/stats/bossquotes.bin
ORG $8CDF60
	incbin binaries/stats/escapequotes.bin
	
ORG $B080C2
	;incbin binaries/stats/items.bin


	
; palettes
ORG $C09396 ; abel
	incbin binaries/palettes/abelpal.bin
ORG $C0AB4A ; sheeda
	incbin binaries/palettes/sheedapal.bin
ORG $C09412
	incbin binaries/palettes/cainpal.bin
ORG $C09956
	incbin binaries/palettes/gordinpal.bin

incsrc chapter1.asm
incsrc chapter2.asm