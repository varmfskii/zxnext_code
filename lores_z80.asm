	;; opt sna=32768:32000
	;; opt z80
	;; opt zxnext
	org $8000
start:
	xor a
	out ($fe),a	; set border to color 0
	;; set transparent to black 000o & 001o
	;; nextreg $14,$00
	ld a,$14
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
	;; enable lores
	;; nextreg $15,$84
	ld bc,$243b
	ld a,$15
	out (c),a
	ld bc,$253b
	ld a,$84
	out (c),a
	;; first half
	ld hl,$4000
	ld a,$30
patt_o1:
	ld c,$01
	ld b,$80
patt_i1:	
	ld (hl),c
	inc hl
	inc c
	djnz patt_i1
	dec a
	jp NZ,patt_o1
	;; second half
	ld hl,$6000
	ld a,$30
patt_o2:
	ld c,$ff
	ld b,$80
patt_i2:	
	ld (hl),c
	inc hl
	dec c
	djnz patt_i2
	dec a
	jp NZ,patt_o2
	;; nextreg $43,$00	; write ULA1, ULA1, Layer21, Sprite1, flash
	ex af,af'
	exx
	ld a,$43
	ld bc,$243b
	out (c),a
	xor a
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
palette:
	halt	; wait for retrace
	;; nextreg $40,$01	; start at palette index 0
	ex af,af'
	exx
	ld a,$40
	ld bc,$243b
	out (c),a
	ld a,$01
	ld bc,$253b
	out (c),a
	ex af,af'
	exx
	ld b,$ff
pal1:
	;; set palette to a/0 
	;; nextreg $41,a
	;; nextreg $44,$00
	ex af,af'
	exx
	ld a,$41
	ld bc,$243b
	out (c),a
	ex af,af'
	ld bc,$253b
	out (c),a
	ex af,af'
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
	jp palette
