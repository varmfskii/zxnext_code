	public _cls_h
	defc B_PIXEL=$4000
	defc B_ALTP=$6000
	section code_compiler
_cls_h:
	ld a,$18
	ex af,af'
	xor a
	ld b,a
	ld hl,B_PIXEL
	ld de,B_ALTP
	ex af,af'
loop_o:
	ex af,af'
loop_i:
	ld (hl),a
	inc hl
	ld (de),a
	inc de
	djnz loop_i
	ex af,af'
	dec a
	jr NZ,loop_o
	ret
	section ignore
