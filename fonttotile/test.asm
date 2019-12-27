	device zxspectrumnext
start:
	ld hl,$4000
	ld a,$aa
patt:
	ld (hl),a
	inc hl
	djnz patt
	cpl
	dec c
	jp nz,patt
	ld c,$03
	ld a,$78
attr:
	ld (hl),a
	inc hl
	djnz attr
	dec c
	jp nz,attr
	ld hl,font
	ld bc,$0003
	exx
	ld hl,$4000
	ld b,$04
	exx
tile:
	ld d,(hl)
	inc hl
	exx
tile1:	
	sl d
	rla
	sla
	sla
	sla
	sl d
	rla
	sla
	sla
	sla
	ld (hl),a
	djnz tile1
	ld b,$04
	exx
	djnz tile
	dec c
	jp nz,tile
idle:
	jp idle
font:
	incbin "font.bin"
	savenex open "test.nex",start
	savenex auto
	savenex close
	
