	org $8000
start:
	ld hl,$4000
	ld a,$18
looppg:	
	ld b,$00
loop256:
	ld (hl),b
	inc hl
	djnz loop256
	dec a
	jr nz,looppg
	ret
	
