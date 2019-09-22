	section code
	org $8000
	ld hl,$4000
	xor a
	ld b,a
	ld a,$18
loop:
	ld (hl),b
	djnz loop
	dec a
	cp $0
	jp NZ,loop
	ret
