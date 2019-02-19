	;; opt sna=32768:32000
	;; opt z80
	;; opt zxnext
	org $8000
start:
	xor a
	out ($fe),a	; set border to color 0
	nextreg $14,$00	; set transparent to black 000o & 001o
	;; write fine checkerboard to screen
	ld hl,$4000
	ld a,$0c
	ld b,$0
cheq_o:
	ld c,$55
cheq_i1:	
	ld (hl),c
	inc hl
	djnz cheq_i1
	ld c,$aa
cheq_i2:	
	ld (hl),c
	inc hl
	djnz cheq_i2
	dec a
	jp NZ,cheq_o
	;; initialize attributes from 0-255, 3x
	ld a,3
attr:
	ld (hl),b
	inc hl
	djnz attr
	dec a
	jp NZ,attr
	nextreg $43,$01	; write ULA1, ULA1, Layer21, Sprite1, noflash
	nextreg $42,$ff	; 256 foreground colors
palette:
	halt	; wait for retrace
	nextreg $40,$00	; start at palette index 0
	ld b,$80
pal1:
	;; set palette to a/0 
	nextreg $41,a
	nextreg $44,$00
	inc a
	djnz pal1
	nextreg $40,$81 ; start at palette index 129
	ld b,$7f
pal2:	
	;; set palette to a/0 
	nextreg $41,a
	nextreg $44,$00
	inc a
	djnz pal2
	jp palette
