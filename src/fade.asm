
SECTION "Fade Routines", ROM0

; --------------
; | ROUTINE    |
; --------------
; FadeOutToBlack
; fades screen out with
; method dependant on the
; hardware

FadeOutToBlack::
	ldh a, [hConsoleType]
	and a
	jr nz, .dmg
	
	; now the fun begins lol
	ld d, 8
.outerloop:
	ld hl, wBGP
.innerloop:
	ld a, [hli]
	ld c, [hl]
	ld b, a
	dec hl
	; now BC holds a copy of the pal
	and %00111110 ; extract BLUE part
	add a
	and %00111110
	push bc
	ld c, a
	ld a, b
	and ~%00111110
	or c
	pop bc
	ld b, a
	and %11000000
	add a
	and %11000000
	push bc
	ld c, a
	ld a, b
	and ~%11000000
	or c
	pop bc
	ld b, a
	ld a, c
	and %00000111
	add a
	and %00000111
	push bc
	ld b, a
	ld a, c
	and ~%00000111
	or b
	pop bc
	ld c, a
	and %11111000
	add a
	and %11111000
	push bc
	ld b, a
	ld a, c
	and ~%11111000
	or b
	pop bc
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, l
	cp LOW(wOBP+64)
	jr nz, .innerloop
	ld c, 3
	call DelayFrames
	dec d
	jr nz, .outerloop
	ret
	
.dmg:
	ld a, %11100100
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %10010000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %01000000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	xor a
	call ApplyDMGPal
	ld c, 3
	jp DelayFrames
	
; --------------
; | ROUTINE    |
; --------------
; FadeInFromBlack
; fades screen in with
; method dependant on the
; hardware

FadeInFromBlack::
	ldh a, [hConsoleType]
	and a
	ret z ; don't fade in on cgb
	xor a
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %01000000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %10010000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %11100100
	call ApplyDMGPal
	ld c, 3
	jp DelayFrames
	
; --------------
; | SUBROUTINE |
; --------------
; ApplyDMGPal
; applies the palettes
; in the DMG way
	
ApplyDMGPal:
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	