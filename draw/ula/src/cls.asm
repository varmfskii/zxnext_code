	public _cls
	defc B_PIXEL=$4000
	defc B_COLOR=$5800
	defc B_ALTP=$6000
	defc B_ALTC=$7800
	defc ULA=$00
	defc ALT=$01
	defc HICOLOR=$02
	extern _ula_color
	extern _screen_mode
	extern _pixel_base
	extern _color_base
	section code_compiler
_cls:
	;; clear pixels
	ld a,$18
	ex af,af'
	ld a,(_pixel_base)
	ld h,a
	xor a
	ld l,a
	ld b,a
	ex af,af'
loop_op:
	ex af,af'
loop_ip:
	ld (hl),a
	inc hl
	djnz loop_ip
	ex af,af'
	dec a
	jr NZ,loop_op
	;; clear color
	ld a,(_screen_mode)
	cp HICOLOR
	ld a,$03
	jr Z,color
	ld a,$18
color:
	ex af,af'
	ld a,(_color_base)
	ld h,a
	ld a,(_ula_color)
	ex af,af'
loop_oc:
	ex af,af'
loop_ic:	
	ld (hl),a
	inc hl
	djnz loop_ic
	ex af,af'
	dec a
	jr NZ,loop_oc
	ret
	section ignore
