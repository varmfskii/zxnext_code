	device zxspectrumnext
screen:		defl $4000
ulaattr:	defl $5800
tilemap:	defl $5b00
	org $8000
start:	
	di
	ld hl,tilemap
	ld bc,$0005
	xor a
cls:
	ld (hl),a
	inc hl
	;; inc a
	djnz cls
	dec c
	jp NZ,cls
	ld de,tilemap+$0500
	ld hl,tiles
	ld bc,tiles_end-tiles
	ldir
	nextreg $4c,$00		; tile transparency index 0
	nextreg $6b,$a0		; enable tilemap 40x32, no attributes, palette 0
	nextreg $6c,$00 	; default attr, tilemap over ula
	nextreg $6e,$1b		; tilemap starts at $5b00
	nextreg $6f,$20		; tile definition start at $6000
	nextreg $43,$30		; set select tilemap palette and primary palette
	nextreg $40,$00		; palette index 0
	ld hl,palette
	ld b,$20
pal:
	ld a,(hl)
	inc hl
	nextreg $44,a
	djnz pal
	ld bc,$1010
	ld hl,tilemap+12+8*40
	xor a
draw:	
	ld (hl),a
	inc hl
	inc a
	djnz draw
	add hl,40-16
	ld b,$10
	dec c
	jp NZ,draw
	ld hl,ulaattr+11+6*32
	ld a,$78
	ld bc,$0a09
bg:
	ld (hl),a
	inc hl
	djnz bg
	ld b,$0a 
	add hl,32-10
	dec c
	jp NZ,bg
endlp:
	jp endlp
tiles:
	include "tiles.asm"
tiles_end:	
	include "palette.asm"
	savenex open "outlands_tile.nex",start
	savenex auto
	savenex close
