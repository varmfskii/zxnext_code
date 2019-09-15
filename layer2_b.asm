	device zxspectrumnext
	org $8000
start:
	ld bc,$123b
	ld a,$13
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$53
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$93
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
	savenex open "layer2_b.nex",start
	savenex auto
	savenex close
