	device zxspectrumnext
	org $8000
start:
	ld hl,$4000
	ld bc,$0018
patt:	
	ld (hl),b
	inc hl
	djnz patt
	dec c
	jr nz,patt
	ld a,$07
	ld c,$03
attr:
	ld (hl),a
	inc hl
	djnz attr
	dec c
	jp nz,attr
	ret
	savenex open "layer1.nex",start
	savenex auto
	savenex close
	
	
