	org $8000
	ld hl,$4000
	xor a
	ld a,$18
looppg:
	ld b,$00
loop:
	ld (hl),b
	inc hl
	djnz loop
	dec a
	jp NZ,looppg
	ret
