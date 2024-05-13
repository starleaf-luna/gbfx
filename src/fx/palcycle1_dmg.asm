
INCLUDE "src/macros/code.asm"

SECTION "Waterfall (DMG)", ROMX

WaterfallDMG::
	ld a, [hConsoleType]
	and a
	jr z, .cgb
	ld c, 5
	call DelayFrames
	ld hl, $9000
	ld de, WaterfallGFX
	ld bc, WaterfallGFX_End - WaterfallGFX
	call LCDMemcpy
	ld hl, $9807
	ld b, 18
.draw_outloop:
	ld c, 6
	ld de, SCRN_VX_B
	push hl
.drawloop:
:	ldh a, [rSTAT]
	and STATF_BUSY
	jr nz, :-
	ld a, 1
	ld [hli], a
	dec c
	jr nz, .drawloop
	pop hl
	add hl, de
	dec b
	jr nz, .draw_outloop
.pal_outloop:
	ld b, 3
	ld hl, hBGP
	ld de, WaterfallPaletteTable
.palloop:
	ld a, [de]
	ld [hl], a
	inc de
	ld c, 5
	call DelayFrames
	dec b
	jr z, .pal_outloop
	jr .palloop

.cgb:
	halt
	jr .cgb
	
WaterfallGFX: INCBIN "assets/waterfall.2bpp"
WaterfallGFX_End:

WaterfallPaletteTable:
	db %11100100
	db %01111000
	db %10011100
