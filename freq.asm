	device zxspectrumnext
screen:		defl $4000
ulaattr:	defl $5800
tilemap:	defl $5b00
	org screen
	include "tilemap.bin"
tiles:
	include "tiles.asm"
	org $8000
.257	equ $90
start:	
	di
	im 2
	ld a,$80
	ld i,a
	ei
loop:
	ld hl,store+6
loop2:	
	ld a,(hl)
	inc a
	cp $0a
	jp nz, break
	xor a
	ld (hl),a
	dec hl
	jp loop2
break:
	ld (hl), a
	jp loop
	org $9090
int:
	ld de,screen
	ld hl,store
	ld bc,7
	ldir
	xor a
	ld hl,store
	ld c,7
intlp:	
	ld (hl),a
	inc hl
	djnz intlp
	ei
	reti
	savenex open "freq.nex",start
	savenex auto
	savenex close
