;animation changes

; Stuff for Lance Knight Animations
ORG $8AE516
	incbin binaries/armoranims.bin ; battle animation
ORG $96E51D
	db $1d ; This fixes the distance
ORG $84F126
	dl $A6BE98 ; map battle animation
	
; Animation Associations
ORG $8ADFF6
	incbin binaries/animation/animatioassociation.bin
; Shields
ORG $898E58
	incbin binaries/animation/shields.bin