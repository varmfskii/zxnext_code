	;; update a memory location
	public __set
	section code_compiler
__set:
	push ix
	ld ix,$00
	add ix,sp
	ld l,(ix+4)
	ld h,(ix+5)
	ld a,(ix+6)
	and a,$03
	cp a,SET
	jr Z,set
	cp a,UNSET
	jr Z,unset
xset:
	ld a,(ix+7)
	xor (hl)
	ld (hl),a
	pop ix
	ret
set:
	ld a,(ix+7)
	or (hl)
	ld (hl),a
	pop ix
	ret
unset:
	ld a,(ix+7)
	xor $ff
	and (hl)
	ld (hl),a
	pop ix
	ret
	defc UNSET=1
	defc SET=2
	defc XSET=3
	section ignore
