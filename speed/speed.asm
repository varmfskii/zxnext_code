	device zxspectrumnext
	org $4000
screen:	
	.40 byte 10
	byte 3,11,5,13,12,14
	.30 byte 10
	.4 byte 0
	byte 7,13,12,14
	.32 byte 10
	.4 byte 0
	byte 1,4,13,12,14 
	.31 byte 10
	.4 byte 0
	byte 2,8,13,12,14
	.31 byte 10
	.4 byte 0
	.36 byte 10
	.4 byte 0
	.26 .40 byte 10
	org $4500
patt:
	byte $3c,$66,$6e,$76,$66,$66,$3c,$00 ;0
	byte $18,$38,$18,$18,$18,$18,$3c,$00 ;1
	byte $3c,$66,$0c,$18,$30,$60,$7e,$00 ;2
	byte $3c,$66,$06,$1c,$06,$66,$3c,$00 ;3
	byte $1c,$3c,$6c,$cc,$fe,$0c,$0c,$00 ;4
	byte $7e,$60,$7c,$06,$06,$66,$3c,$00 ;5
	byte $1c,$30,$60,$7c,$66,$66,$3c,$00 ;6
	byte $7e,$06,$06,$0c,$18,$18,$18,$00 ;7
	byte $3c,$66,$66,$3c,$66,$66,$3c,$00 ;8
	byte $3c,$66,$66,$3e,$06,$0c,$38,$00 ;9
	byte $00,$00,$00,$00,$00,$00,$00,$00 ;blank
	byte $00,$00,$00,$00,$00,$18,$18,$00 ;.
	byte $66,$66,$66,$7e,$66,$66,$66,$00 ;H
	byte $c6,$ee,$fe,$d6,$c6,$c6,$c6,$00 ;M
	byte $00,$00,$7e,$0c,$18,$30,$7e,$00 ;z
palette:
	byte $00,$00,$ff,$01,$38,$00,$3f,$00
	byte $c0,$01,$c7,$01,$f8,$01,$ff,$01
	byte $49,$00,$03,$00,$18,$00,$3b,$00
	byte $c0,$00,$c3,$00,$d8,$00,$92,$01
	org $8000
start:
	di
	ld a,$81
	ld i,a
	im 2
	ei
	nextreg $6b,$a8 	; set tilemap w/textmode, 40x32, no attr
	nextreg $6c,$00		; default attr
	nextreg $6e,(screen-$4000)/256 ; tilemap address
	nextreg $6f,(patt-$4000)/256   ; tilepatt address
	nextreg $43,$30		       ; select palette
	nextreg $40,$00		       ; palette index 0
	;; write palette
	ld b,$20
	ld hl,palette
pal:
	ld a,(hl)
	inc hl
	nextreg $44,a
	djnz pal
	;; loop counter
loop:
	ld hl,screen+5*40+39
	;; increment digit
loop2:
	ld a,(hl)
	inc a
	cp 10
	jp nz,break 		; good digit
	;;  write 0 and move to next digit
	xor a
	ld (hl),a
	dec hl
	jp loop2
	;; write digit
break:
	ld (hl),a
	jp loop
	;;  interrupt routine
	org $8080
int:
	nextreg $07,$00		; 3.5MHz for constant time
	pop hl			; ignore return address
	ld hl,screen+5*40+36
	ld bc,4
branch:	
	jp s35
s35:
	;; change branch
	ld de,s70
	ld (branch+1),de
	ld de,screen+1*40+36 	; 3.5MHz field
	call copy_clr
	nextreg $07,$01		; 7MHz
	jp loop
s70:
	;; change branch
	ld de,s14
	ld (branch+1),de
	ld de,screen+2*40+36	; 7MHz field
	call copy_clr
	nextreg $07,$02		; 14MHz
	jp loop
s14:
	;; change branch
	ld de,s28
	ld (branch+1),de
	ld de,screen+3*40+36	; 14MHz field
	call copy_clr
	nextreg $07,$03		; 28MHz
	jp loop
s28:
	;; change branch
	ld de,s35
	ld (branch+1),de
	ld de,screen+4*40+36	; 28MHz field
	call copy_clr
	nextreg $07,$00		; 3.5 MHz
	jp loop
copy_clr:	
	ldir			; copy
	;; reset counter to 0000
	xor a
	ld (screen+5*40+36),a
	ld (screen+5*40+37),a
	ld (screen+5*40+38),a
	ld (screen+5*40+39),a
	ei
	ret
	;; im 2 table
	org $8100
	.257 byte $80
	savenex open "speed.nex",start
	savenex auto
	savenex close
