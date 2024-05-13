
INCLUDE "charmap.asm"

SECTION "Menu", ROMX

Menu::
	call ClearScreen
	ld hl, $8800
	ld de, MenuGFX
	ld bc, MenuGFX_End - MenuGFX
	call LCDMemcpy
	ld hl, $9828
	ld de, MenuText
	call PlaceString
	ld hl, $9862
	ld de, MenuListText
	call PlaceString
	ld hl, hLCDC
	set 1, [hl]
	
	; init cursor sprite
	ld hl, wShadowOAM
	ld de, SelSpriteData
	ld c, 3
.spr_initloop:
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .spr_initloop
	
.loop:
	ld a, HIGH(wShadowOAM)
	ldh [hOAMHigh], a
	ld a, [wShadowOAM+3]
	inc a
	cp $ab
	jr nz, .skip
	ld a, $a8
.skip:
	ld c, 5
	call DelayFrames
	jr .loop
	
LoadErrorBox:
	push de
	ld hl, hLCDC
	res 1, [hl]
	ld hl, ErrorTilemap
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld d, h
	ld e, l
	ld hl, $98c0
	call LoadTilemap
	ld hl, $9901
	pop de
	call PlaceString
	xor a
	ldh [hPressedKeys], a
.joyloop:
	ld a, 1
	ldh [hVBlankFlag], a
	ldh a, [hPressedKeys]
	and PADF_A | PADF_B
	jr nz, .end
	jr .joyloop
.end:
	ld hl, hLCDC
	set 1, [hl]
	jp Menu

SelSpriteData:
	; Y, X, tile
	db 40, 16, $a8
	
ErrorTilemap:
	db 20, 7 ; width, height
.tilemap:
     ; 1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20
	db $b9, $ba, $bb, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bc, $bd, $be
	db $bf, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $c0
	db $bf, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $c0
	db $bf, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $c0
	db $bf, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $c0
	db $bf, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $b8, $c0
	db $c1, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c2, $c3
	
MenuGFX:
	INCBIN "assets/menu1.2bpp"
	INCBIN "assets/menu2.2bpp"
	INCBIN "assets/menu3.2bpp"
MenuGFX_End:

MenuText:
	db "MENU", 0
	
MenuListText:
	db "1.waterfall", $ab, $ac, $ad, $ae, $af, 255
	db "2.waterfall", $b0, $b1, $b2, $b3, 0
	
IncompatibleDMGText:
	db "this gbfx is not", 255
	db "optimised for the", 255
	db "game boy!", 255
	db "please understand.", 0
	
IncompatibleGBCText:
	db "this gbfx is not", 255
	db "optimised for the", 255
	db "game boy color!", 255
	db "please understand.", 0
	
NonexistentText:
	db "this gbfx is not", 255
	db "programmed in yet!", 255
	db "please understand.", 0

SECTION "Jumpthrough 1", ROM0

MenuToWaterfallDMG::
	ld a, BANK(WaterfallDMG)
	ldh [hCurROMBank], a
	ld [rROMB0], a
	jp WaterfallDMG
