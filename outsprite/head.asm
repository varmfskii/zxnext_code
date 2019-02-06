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
;;  write sprite patterns
	ld hl,outlands
	ld bc,spr_pat
	ld d,$40
writespr:
	otir
	dec d
	jp NZ,writespr
;;; place sprites
	nextreg $15,$01	; lores, 00, SLU, not over border, sprites visible
	ld bc,spr_sel
	xor a
	out (c),a
	ld hl,data
	ld bc,spr_ctl
	otir
	ret
data:
	defb $60,$40,$00,$80
	defb $70,$40,$00,$81
	defb $80,$40,$00,$82
	defb $90,$40,$00,$83
	defb $a0,$40,$00,$84
	defb $b0,$40,$00,$85
	defb $c0,$40,$00,$86
	defb $d0,$40,$00,$87
	defb $60,$50,$00,$88
	defb $70,$50,$00,$89
	defb $80,$50,$00,$8a
	defb $90,$50,$00,$8b
	defb $a0,$50,$00,$8c
	defb $b0,$50,$00,$8d
	defb $c0,$50,$00,$8e
	defb $d0,$50,$00,$8f
	defb $60,$60,$00,$90
	defb $70,$60,$00,$91
	defb $80,$60,$00,$92
	defb $90,$60,$00,$93
	defb $a0,$60,$00,$94
	defb $b0,$60,$00,$95
	defb $c0,$60,$00,$96
	defb $d0,$60,$00,$97
	defb $60,$70,$00,$98
	defb $70,$70,$00,$99
	defb $80,$70,$00,$9a
	defb $90,$70,$00,$9b
	defb $a0,$70,$00,$9c
	defb $b0,$70,$00,$9d
	defb $c0,$70,$00,$9e
	defb $d0,$70,$00,$9f
	defb $60,$80,$00,$a0
	defb $70,$80,$00,$a1
	defb $80,$80,$00,$a2
	defb $90,$80,$00,$a3
	defb $a0,$80,$00,$a4
	defb $b0,$80,$00,$a5
	defb $c0,$80,$00,$a6
	defb $d0,$80,$00,$a7
	defb $60,$90,$00,$a8
	defb $70,$90,$00,$a9
	defb $80,$90,$00,$aa
	defb $90,$90,$00,$ab
	defb $a0,$90,$00,$ac
	defb $b0,$90,$00,$ad
	defb $c0,$90,$00,$ae
	defb $d0,$90,$00,$af
	defb $60,$a0,$00,$b0
	defb $70,$a0,$00,$b1
	defb $80,$a0,$00,$b2
	defb $90,$a0,$00,$b3
	defb $a0,$a0,$00,$b4
	defb $b0,$a0,$00,$b5
	defb $c0,$a0,$00,$b6
	defb $d0,$a0,$00,$b7
	defb $60,$b0,$00,$b8
	defb $70,$b0,$00,$b9
	defb $80,$b0,$00,$ba
	defb $90,$b0,$00,$bb
	defb $a0,$b0,$00,$bc
	defb $b0,$b0,$00,$bd
	defb $c0,$b0,$00,$be
	defb $d0,$b0,$00,$bf
