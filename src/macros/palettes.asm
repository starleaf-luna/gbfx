
; defines a 15-bit RGB palette slot entry
; for use with GBC only!
; \1 - R   \2 - G   \3 - B

MACRO rgb
	REPT _NARG / 3
		dw (1 << 0) * (\1) + (1 << 5) * (\2) + (1 << 10) * (\3)
		SHIFT 3
	ENDR
ENDM
