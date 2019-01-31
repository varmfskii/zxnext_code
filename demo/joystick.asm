	defc fire=$482d
	defc up=$482f
	defc left=$486d
	defc right=$4871
	defc down=$48af
_main:
	ld bc,$243b
	ld a,$05
	out (c),a
	ld b,$25
	ld a,$41
	out (c),a
	ld c,$1f
loop:
	in e,(c)
	ld hl,right
	rr e
	call draw
	ld hl,left
	rr e
	call draw
	ld hl,down
	rr e
	call draw
	ld hl,up
	rr e
	call draw
	ld hl,fire
	rr e
	call draw
	halt
	jp loop
draw:
	exx
	ld b,$08
	jp c,seton
	ld hl,off
	jp drawlp
seton:	
	ld hl,on
drawlp:	
	ld a,(hl)
	inc hl
	exx
	ld (hl),a
	inc h
	exx
	djnz drawlp
	exx
	ret
on:
	defb $3c,$7e,$ff,$ff,$ff,$ff,$7e,$3c
off:
	defb $3c,$42,$81,$81,$81,$81,$42,$3c
