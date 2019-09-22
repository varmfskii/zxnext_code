	device zxspectrumnext
	org $8000
start:	
	ld hl,$4000
	xor a
	ld bc,$0018
loop:
	ld (hl),b
	inc hl
	djnz loop
	dec c
	jp NZ,loop
	ret
	savenex open "screen.nex",start
	savenex auto
	savenex close
