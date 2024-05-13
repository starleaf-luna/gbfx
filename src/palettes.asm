
INCLUDE "src/macros/palettes.asm"

SECTION "Palette Tools", ROM0

BlackOutPalettes::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	ld a, %00000000
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	
.cgb:
	ld hl, BlackCGBPals
	ld c, 32
	call LoadBGPals.cgb
	ld c, 32
	ld hl, BlackCGBPals
	jr LoadOBJPalsCGB

WhiteOutPalettes::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	ld a, %11111111
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	
.cgb:
	ld hl, WhiteCGBPals
	ld c, 32
	call LoadBGPals.cgb
	ld c, 32
	ld hl, WhiteCGBPals
	jr LoadOBJPalsCGB

SetDefaultPalettes::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	; if we're here, we're not on CGB
	ld a, %11100100
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	
.cgb:
	ld hl, DefaultCGBPals
	ld c, 32
	call LoadBGPals.cgb ; skip checking console type
	ld c, 32
	ld hl, DefaultCGBPals.obj
	jr LoadOBJPalsCGB ; skip checking console type
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadBGPals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadBGPals::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	ld a, d
	ldh [hBGP], a
	ret
	
.cgb:
	; double the palette slot amount (1 slot = 2 bytes)
	ld a, c
	add c
	ld c, a
	
	ld de, wBGP
.loop:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadOBJ0Pals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadOBJ0Pals::
	; failsafe!
	; you're meant to call LoadOBJPalsCGB 
	; on CGB systems instead
	ldh a, [hConsoleType]
	and a
	jr z, LoadOBJPalsCGB
	
	ld a, d
	ldh [hOBP0], a
	ret
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadOBJ1Pals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadOBJ1Pals::
	; failsafe!
	; you're meant to call LoadOBJPalsCGB 
	; on CGB systems instead
	ldh a, [hConsoleType]
	and a
	jr z, LoadOBJPalsCGB
	
	ld a, d
	ldh [hOBP1], a
	ret
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadOBJPalsCGB
; this routine is meant only
; for the GBC.

; args:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadOBJPalsCGB::
	; double the palette slot amount (1 slot = 2 bytes)
	sla c
	
	ld de, wOBP
.loop:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

; data
DefaultCGBPals::
	; BG 0
	rgb 31, 31, 31
	rgb 22, 22, 22
	rgb 16, 16, 16
	rgb 00, 00, 00
	; BG 1
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 2
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 3
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 4
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 5
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 6
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 7
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
.obj:
	; OBJ 0
	rgb 31, 31, 31
	rgb 22, 22, 22
	rgb 16, 16, 16
	rgb 00, 00, 00
	; OBJ 1
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 2
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 3
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 4
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 5
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 6
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OBJ 7
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	
WhiteCGBPals::
	; BG 0
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 1
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 2
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 3
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 4
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 5
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 6
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	; BG 7
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31
	rgb 31, 31, 31

BlackCGBPals::
	; BG 0
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 1
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 2
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 3
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 4
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 5
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 6
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG 7
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
