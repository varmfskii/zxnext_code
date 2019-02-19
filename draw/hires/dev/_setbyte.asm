	;; update a memory location
	public __setbyte
	section code_compiler
__setbyte:
	push ix
	ld ix,$00
	add ix,sp
	ld l,(ix+4)
	ld h,(ix+5)
	ld a,(ix+6)
	and a,$03
	cp a,SET
	jr Z,setb
	cp a,UNSET
	jr Z,unsetb
xsetb:
	ld a,(hl)
	xor $ff
	ld (hl),a
	pop ix
	ret
setb:
	ld (hl),$ff
	pop ix
	ret
unsetb:
	ld (hl),$00
	pop ix
	ret
	defc UNSET=1
	defc SET=2
	defc XSET=3
	section ignore
