	device zxspectrumnext
	org $8000
start:
	ld bc,$123b
	ld a,$03
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$43
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$83
	out (c),a
	call wrtpage
	ret
wrtpage:	
	ld hl,$0000
	ld bc,$0040
loop:	
	ld (hl),b
	inc hl
	djnz loop
	dec c
	jr nz,loop
	ret
	savenex open "layer2_f.nex",start
	savenex auto
	savenex close
	
