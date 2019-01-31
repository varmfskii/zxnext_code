	GLOBAL _main
	defc screen=$4000
	defc next_sel=$243b
	defc next_ctl=$253b
	defc spr_sel=$303b
	defc spr_ctl=$57
	defc spr_pat=$5b
	defc sprx=screen
	defc spry=screen+$0100
_main:
	;; draw checkerboard background
	ld hl,screen
	ld bc,$000c
screen_loop0:
	ld a,$aa
screen_loop1:
	ld (hl),a
	inc hl
	djnz screen_loop1
	ld a,$55
screen_loop2:
	ld (hl),a
	inc hl
	djnz screen_loop2
	dec c
	jp nz,screen_loop0
	;; set screen ink and paper
	ld a,$1e
	ld c,$03
screen_loop3:
	ld (hl),a
	inc hl
	djnz screen_loop3
	dec c
	jp nz,screen_loop3
	nextreg $05,$41 ; setup joystick1 kempton1
	;; setup sprites		
	;; write pattern to sprite pattern 0
	ld bc,spr_sel
	xor a
	out (c),a
	ld bc,spr_pat
	ld hl,circle
	otir
	nextreg $15,$01	; lores, 00, SLU, not over border, sprites visible
	;; set initial sprite position data
	ld a,(xpos)
	add a,$20
	ld (sprx),a
	ld a,(ypos)
	add a,$20
	ld (spry),a
	xor a
	ld (sprx+1),a
	ld (spry+1),a
	ld bc,spr_sel
	out (c),a
	ld hl,sprdat
	ld bc,$2000+spr_ctl
	otir
mainlp:
	ld c,$1f
	in e,(c)
	bit 0,e
	jp z,noright
	;; move right
	ld a,(xpos)
	cp a,$f0
	jp z,noleft
	ld a,$00
	ld (sprx+1),a
	ld a,(xpos)
	inc a
	ld (xpos),a
	jp setx
noright:
	bit 1,e
	jp z,noleft
	;; move left
	ld a,(xpos)
	cp a,$00
	jp z,noleft
	ld a,$08
	ld (sprx+1),a
	ld a,(xpos)
	dec a
	ld (xpos),a
setx:
	add a,$20
	ld (sprx),a
	ld a,(sprx+1)
	adc a,$00
	ld (sprx+1),a
noleft:
	bit 2,e
	jp z,nodown
	;; move down
	ld a,(sprx+1)
	and a,$01
	or a,$02
	ld (sprx+1),a
	ld a,(ypos)
	cp a,$b0
	jp z,noup
	inc a
	ld (ypos),a
	jp sety
nodown:
	bit 3,e
	jp z,noup
	;; move up
	ld a,(sprx+1)
	and a,$01
	or a,$06
	ld (sprx+1),a
	ld a,(ypos)
	cp a,$00
	jp z,noup
	dec a
	ld (ypos),a
sety:
	add a,$20
	ld (spry),a
noup:
	bit 4,e
	jp z,place
	ld bc,spr_sel
	xor a
	out (c),a
	ld b,$24
quitlp:
	out (spr_ctl),a
	djnz quitlp
	ret
place:
	;; place sprite
	ld bc,spr_sel
	ld a,$08
	out (c),a
	ld a,(sprx)
	out (spr_ctl),a
	ld a,(spry)
	out (spr_ctl),a
	ld a,(sprx+1)
	out (spr_ctl),a
	ld a,$80
	out (spr_ctl),a
	halt
	jp mainlp
circle:
	defb $e3,$e3,$e3,$e3,$e3,$e3,$00,$00,$00,$00,$e3,$e3,$e3,$e3,$e3,$e3
	defb $e3,$e3,$e3,$e3,$00,$00,$e0,$e0,$e0,$e0,$00,$00,$e3,$e3,$e3,$e3
	defb $e3,$e3,$e3,$00,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$00,$e3,$e3,$e3
	defb $e3,$e3,$00,$1c,$00,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$00,$e3,$e3
	defb $e3,$00,$1c,$1c,$1c,$00,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$00,$e3
	defb $e3,$00,$1c,$1c,$1c,$1c,$e3,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$00,$e3
	defb $00,$1c,$1c,$1c,$1c,$1c,$1c,$e3,$e0,$e0,$e0,$e0,$e0,$e0,$e0,$00
	defb $00,$1c,$1c,$1c,$1c,$1c,$1c,$1c,$e3,$e3,$e3,$e3,$e3,$e3,$e3,$e3
	defb $00,$1c,$1c,$1c,$1c,$1c,$1c,$1c,$e3,$e3,$e3,$e3,$e3,$e3,$e3,$e3
	defb $00,$1c,$1c,$1c,$1c,$1c,$1c,$e3,$03,$03,$03,$03,$03,$03,$03,$00
	defb $e3,$00,$1c,$1c,$1c,$1c,$e3,$03,$03,$03,$03,$03,$03,$03,$00,$e3
	defb $e3,$00,$1c,$1c,$1c,$00,$03,$03,$03,$03,$03,$03,$03,$03,$00,$e3
	defb $e3,$e3,$00,$1c,$00,$03,$03,$03,$03,$03,$03,$03,$03,$00,$e3,$e3
	defb $e3,$e3,$e3,$00,$03,$03,$03,$03,$03,$03,$03,$03,$00,$e3,$e3,$e3
	defb $e3,$e3,$e3,$e3,$00,$00,$03,$03,$03,$03,$00,$00,$e3,$e3,$e3,$e3
	defb $e3,$e3,$e3,$e3,$e3,$e3,$00,$00,$00,$00,$e3,$e3,$e3,$e3,$e3,$e3
xpos:
	defb $78
ypos:
	defb $58
sprdat:
	defb $28,$28,$00,$80
	defb $48,$28,$02,$80
	defb $68,$28,$04,$80
	defb $88,$28,$06,$80
	defb $a8,$28,$08,$80
	defb $c8,$28,$0a,$80
	defb $e8,$28,$0c,$80
	defb $08,$28,$0f,$80
