
SECTION "String Tools", ROM0

; ----------------
; | ROUTINE      |
; ----------------
; PlaceString
; [in]   hl   where
; [in]   de   what
; [out]  hl   destroyed
; [out]  de   destroyed
; [out]  bc   destroyed
; [out]  a    destroyed

PlaceString::
	push hl
.loop:
:	ldh a, [rSTAT]
	and STATF_BUSY
	jr nz, :-
	ld a, [de]
	and a
	jr z, .end
	cp 255
	jr z, .newln
	ld [hli], a
	inc de
	jr .loop
	
.newln:
	pop hl
	ld bc, SCRN_VX_B
	add hl, bc
	inc de
	jr PlaceString
	
.end:
	pop hl
	ret
