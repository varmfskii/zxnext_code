	device zxspectrumnext
screen:	defl $4000
	org $8000
start:
;;; fill screen with pattern
	ld hl,screen
	ld bc,$000c
	ld a,$55
clslp:
	ld (hl),a
	inc hl
	djnz clslp
	cpl
clslp1:
	ld (hl),a
	inc hl
	djnz clslp1
	cpl
	dec c
	jp nz,clslp
;;; set attributes
	ld a,$78
	ld bc,$0003
attrlp:
	ld (hl),a
	inc hl
	djnz attrlp
	dec c
	jp nz,attrlp
;;; add fake font data
	ld hl,screen+$1500
	ld bc,$0003
fontlp:
	ld (hl),b
	inc hl
	djnz fontlp
	dec c
	jp nz,fontlp
	ld hl,screen
	ld de,screen+$1500
	ld bc,$0003
	ld a,$a0
	call convert3
idle:
	jp idle
;;; expand from 1-bpp to 4-bpp using 0->0000 and 1->1111
convert1:
	push de
	exx
	pop hl
	exx
lp3:
	exx
	ld d,(hl)
	inc hl
	ld b,$04
lp4:
	xor a
	sla d
	jp nc,skip1
	or $f0
skip1:	
	sla d
	jp nc,skip2
	or $0f
skip2:	
	exx
	ld (hl),a
	inc hl
	exx
	djnz lp4
	exx
	djnz lp3
	dec c
	jp nz,lp3
	ret
;;; expand from 1-bpp to 4-bpp using 1->upper niibble of a
;;; and 0->lower nibble of a [self modifying code]
convert2:
	push af
	and $f0
	ld (m1+1),a
	;; srl a
	;; srl a
	;; srl a
	;; srl a
	swapnib
	ld (m2+1),a
	pop af
	and $0f
	ld (s3+1),a
	;; sla a
	;; sla a
	;; sla a
	;; sla a
	swapnib
	ld (s1+1),a
	push de
	exx
	pop hl
	exx
lp5:
	exx
	ld d,(hl)
	inc hl
	ld b,$04
lp6:
	xor a
	sla d
	jp nc,s1
m1:	
	or $f0
	jp s2
s1:
	or $00
s2:	
	sla d
	jp nc,s3
m2:	
	or $0f
	jp s4
s3:
	or $00
s4:	
	exx
	ld (hl),a
	inc hl
	exx
	djnz lp6
	exx
	djnz lp5
	dec c
	jp nz,lp5
	ret
	savenex open "test.nex",start
	savenex auto
	savenex close
	
