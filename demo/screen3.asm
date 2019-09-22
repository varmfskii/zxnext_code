	device zxspectrumnext
	org $8000
REG_NO:	defl $243b
REG_IO:	defl $253b
PAL_IDX:	defl $40
PAL_V8:	defl $41
PAL_FMT:	defl $42
PAL_CTL:	defl $43
PAL_V9:	defl $44
start:	
	;; set pixels
	ld hl,$4000
	ld bc,$000c
	ld a,$55
pixel1:
	ld (hl),a
	inc hl
	djnz pixel1
	ld a,$aa
pixel2:
	ld (hl),a
	inc hl
	djnz pixel2
	ld a,$55
	dec c
	jp NZ,pixel1
	;; set attributes
	ld bc,$0003
	xor a
attr:
	ld (hl),a
	inc a
	inc hl
	djnz attr
	dec c
	jp NZ,attr
	;; set palette values
	nextreg PAL_IDX,0	; select palette index 0
	;; select pallet value (8-bit)
	xor a
pal_lp:
	nextreg PAL_V8,a
	inc a
	jp NZ,pal_lp
	;; set palette format
	nextreg PAL_FMT,$ff
	;; disable flash
	nextreg PAL_CTL,$01
idle:
	jp idle
	ret
	savenex open "screen3.nex", start
	savenex auto
	savenex close
