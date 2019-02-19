	org $8000
	defc REG_NO=$243b
	defc REG_IO=$253b
	defc PAL_IDX=$40
	defc PAL_VAL=$41
	defc PAL_FMT=$42
	defc PAL_CTL=$43
	defc PAL_LOB=$44
	;; set pixels
	ld hl,$4000
	ld a,$0c
pixel_lp:
	ld b,$00
	ld d,$55
in1:
	ld (hl),d
	inc hl
	djnz in1
	ld d,$aa
in2:
	ld (hl),d
	inc hl
	djnz in2
	dec a
	jp NZ,pixel_lp
	;; set attributes
	ld a,$3
	ld d,$00
attr_lp:
	ld b,$00
in3:
	ld (hl),d
	inc d
	inc hl
	djnz in3
	dec a
	jp NZ,attr_lp
	;; set palette values
	;; select palette index 0
	ld bc,REG_NO
	ld a,PAL_IDX
	out (c),a
	ld bc,REG_IO
	xor a
	out (c),a
	;; select pallet value register
	ld bc,REG_NO
	ld a,PAL_VAL
	out (c),a
	ld bc,REG_IO
	xor a
palhi_lp:
	out (c),a
	inc a
	jp NZ,palhi_lp
	;;  select palette low register
	ld bc,REG_NO
	ld a,PAL_LOB
	out (c),a
	ld bc,REG_IO
pallo_lp:
	out (c),0
	inc a
	jp NZ,pallo_lp
	;; set palette format
	ld bc,REG_NO
	ld a,PAL_FMT
	out (c),a
	ld bc,REG_IO
	ld a,$ff
	out (c),a
	;; disable flash
	ld bc,REG_NO
	ld a,PAL_CTL
	out (c),a
	ld bc,REG_IO
	ld a,$01
	out (c),a
idle:
	jp idle
	ret
	
