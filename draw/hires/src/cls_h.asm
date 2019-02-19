	;;  clear screen (hires version)
	public _cls_h
	defc B_PIXEL=$4000
	defc B_ALTP=$6000
	section code_compiler
_cls_h:
	ld a,$18		; $18 iterations
	ex af,af'
	xor a
	ld b,a
	ld hl,B_PIXEL		; start address for default map
	ld de,B_ALTP		; start address for alternate map
	ex af,af'
loop_o:
	ex af,af'
loop_i:
	ld (hl),a
	inc hl
	ld (de),a
	inc de
	djnz loop_i		; inner loop 256 times
	ex af,af'
	dec a
	jr NZ,loop_o
	ret
	section ignore
