	device zxspectrumnext
	org $8000
start:
	im 1
	ei
	xor a
	out ($fe),a	; set border to color 0
	;; set transparent to black 000o & 001o
	nextreg $14,$00
	;; enable lores
	nextreg $15,$84
	;; first half
	ld hl,$4000
	ld a,$01
	ld bc,$8030
patt1:
	ld (hl),a
	inc hl
	inc a
	djnz patt1
	ld b,$80
	ld a,$01
	dec c
	jp NZ,patt1
	;; second half
	ld hl,$6000
	ld a,$ff
	ld bc,$8030
patt2:
	ld (hl),a
	inc hl
	dec a
	djnz patt2
	ld b,$80
	ld a,$ff
	dec c
	jp NZ,patt2
	nextreg $43,$00	; write ULA1, ULA1, Layer21, Sprite1, flash
palette:
	halt	; wait for retrace
	nextreg $40,$01	; start at palette index 1
	ld b,$ff
pal1:
	;; set palette to a/0 
	nextreg $41,a
	nextreg $44,$00
	inc a
	djnz pal1
	jp palette
	savenex open "lores_palette_demo.nex",start
	savenex auto
	savenex close
