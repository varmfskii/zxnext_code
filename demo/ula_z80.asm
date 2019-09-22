	;; opt sna=32768:32000
	;; opt z80
	;; opt zxnext
	org $8000
start:
	xor a
	out ($fe),a	; set border to color 0
	;; nextreg $14,$00 ; set transparent to black 000o & 001o
	ld a,$14
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
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
	;; nextreg $43,$01	; write ULA1, ULA1, Layer21, Sprite1, noflash
	ld a,$43
	ld bc,$243b
	out (c),a
	ld a,$01
	ld bc,$253b
	out (c),a
	;; nextreg $42,$ff	; 256 foreground colors
	ld a,$42
	ld bc,$243b
	out (c),a
	ld a,$ff
	ld bc,$253b
	out (c),a
palette:
	halt	; wait for retrace
	;; nextreg $40,$00	; start at palette index 0
	exx
	ex af,af'
	ld a,$40
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
	ld b,$80
pal1:
	;; set palette to a/0
	;; nextreg $41,a
	exx
	ex af,af'
	ld a,$41
	ld bc,$243b
	out (c),a
	ex af,af'
	ld bc,$253b
	out (c),a
	ex af,af'
	;; nextreg $44,$00
	ld a,$44
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
	inc a
	djnz pal1
	;; nextreg $40,$81 ; start at palette index 129
	exx
	ex af,af'
	ld a,$40
	ld bc,$243b
	out (c),a
	ld a,$81
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
	ld b,$7f
pal2:	
	;; set palette to a/0
	;; nextreg $41,a
	exx
	ex af,af'
	ld a,$41
	ld bc,$243b
	out (c),a
	ex af,af'
	ld bc,$253b
	out (c),a
	ex af,af'
	;; nextreg $44,$00
	ld a,$44
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
	inc a
	djnz pal2
	jp palette
