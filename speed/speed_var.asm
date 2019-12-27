	device zxspectrumnext
	org $4000
cntr:	equ screen+2*40+36
field:	equ screen+1*40+36
screen:	
	.40 byte 10
	IFDEF S35
	byte 3,11,5,13,12,14
	.30 byte 10
	ELSE : IFDEF S70
	byte 7,13,12,14
	.32 byte 10
	ELSE : IFDEF S14
	byte 1,4,13,12,14
	.31 byte 10
	ELSE : IFDEF S28
	byte 2,8,13,12,14
	.31 byte 10
	ELSE
	.36 byte 10
	ENDIF : ENDIF : ENDIF : ENDIF
	.4 byte 0
	.36 byte 10
	.4 byte 0
	.29 .40 byte 10
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
	IFDEF S35
	nextreg $07,$00		; 3.5MHz
	ELSE : IFDEF S70
	nextreg $07,$01		; 7MHz
	ELSE : IFDEF S14
	nextreg $07,$02		; 14MHz
	ELSE : IFDEF S28
	nextreg $07,$03		; 28MHz
	ENDIF : ENDIF : ENDIF : ENDIF
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
	ld hl,cntr+3
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
	pop hl
	;; copy
	ld bc,4
	ld hl,cntr
	ld de,field
	ldir
	;; reset counter
	ld a,0
	ld (cntr),a
	ld a,0
	ld (cntr+1),a
	ld a,9
	ld (cntr+2),a
	ld a,6
	ld (cntr+3),a
	ei
	jp loop
	;; im 2 table
	org $8100
	.257 byte $80
	IFDEF S35
	savenex open "speed35.nex",start
	ELSE : IFDEF S70
	savenex open "speed70.nex",start
	ELSE : IFDEF S14
	savenex open "speed14.nex",start
	ELSE : IFDEF S28
	savenex open "speed28.nex",start
	ELSE
	savenex open "speed_def.nex",start
	ENDIF : ENDIF : ENDIF : ENDIF
	savenex auto
	savenex close
