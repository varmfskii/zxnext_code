	GLOBAL _main
_main:
	;; write pattern to sprite pattern 0
	ld bc,$303b
	ld a,$00
	out (c),a
	ld b,$00
	ld hl,circle
loop1:
	ld a,(hl)
	out ($5b),a
	inc hl
	djnz loop1
	nextreg $15,$01	; lores, 00, SLU, not over border, sprites visible
	ld de,$0001
	ld hl,$4000
	exx
	ld de,$0001
	ld hl,$4001
	exx
loop2:	
	ld bc,$303b
	out (c),0
	ld a,d
	add a,e
	ld d,a
	cp $e0
	jp C,skipx
	xor a
	sub a,e
	ld e,a
	ld a,d
	add a,e
	ld d,a
skipx:
	ld (hl),a
	add a,$20
	out ($57),a
	exx
	ld a,d
	add a,e
	ld d,a
	cp $b0
	jp C,skipy
	xor a
	sub a,e
	ld e,a
	ld a,d
	add a,e
	ld d,a
skipy:
	ld (hl),a
	add a,$20
	out ($57),a
	exx
	ld a,$00
	out ($57),a
	ld a,$80
	out ($57),a
	halt			
	jp loop2
circle:	
	defb $e3,$e3,$e3,$e3,$db,$6d,$00,$00,$00,$00,$6d,$db,$e3,$e3,$e3,$e3
	defb $e3,$e3,$e3,$6d,$00,$00,$00,$00,$00,$00,$00,$00,$6d,$e3,$e3,$e3
	defb $e3,$e3,$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$24,$e3,$e3
	defb $e3,$6d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6d,$e3
	defb $db,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$db
	defb $6d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6d
	defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	defb $6d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6d
	defb $db,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$db
	defb $e3,$6d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6d,$e3
	defb $e3,$e3,$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$24,$e3,$e3
	defb $e3,$e3,$e3,$6d,$00,$00,$00,$00,$00,$00,$00,$00,$6d,$e3,$e3,$e3
	defb $e3,$e3,$e3,$e3,$db,$6d,$00,$00,$00,$00,$6d,$db,$e3,$e3,$e3,$e3
