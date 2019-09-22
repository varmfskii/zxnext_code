	device zxspectrumnext
screen:		defl $4000
ulaattr:	defl $5800
tilemap:	defl $5b00
tiledef:	defl $6500
	org $8000
start:	
	di
	ld hl,tilemap
	ld bc,$0005
	xor a
cls:
	ld (hl),a
	inc hl
	djnz cls
	dec c
	jp NZ,cls
	nextreg $4c,$00		; tile transparency index 0
	nextreg $6b,$e0		; enable tilemap 80x32, no attributes, palette 0
	nextreg $6c,$00 	; default attr, tilemap over ula
	nextreg $6e,tilemap/$100-$40	; tilemap starts
	nextreg $6f,tiledef/$100-$40	; tile definition start
	nextreg $43,$30		; set select tilemap palette and primary palette
	nextreg $40,$00		; palette index 0
	ld hl,palette
	ld b,$20
pal:
	ld a,(hl)
	inc hl
	nextreg $44,a
	djnz pal
	ld bc,$000a
	ld hl,tilemap
	ld a,$20
draw:	
	ld (hl),a
	inc hl
	inc a
	cp $80
	jp m,skip
	ld a,$20
skip:	
	djnz draw
	dec c
	jp NZ,draw
	ld hl,screen
	ld bc,$000c
	ld a,$aa
ula:
	cpl
ula1:	
	ld (hl),a
	inc hl
	djnz ula1
	cpl
ula2:	
	ld (hl),a
	inc hl
	djnz ula2
	dec c
	jp nz,ula
	ld a,$11
	ld bc,$0003
bg:
	ld (hl),a
	inc hl
	djnz bg
	dec c
	jp NZ,bg
endlp:
	jp endlp
	include "palette.asm"
	org tiledef
tiles:
	incbin "tiles.bin"
tiles_end:	
	savenex open "z88tile.nex",start
	savenex auto
	savenex close
