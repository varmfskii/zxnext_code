	;; decompress run length encoded file
	;; stack has address for compressed data
	;; c-call rld(input)
	;; data starts with address of decode location and ends with $00
	;; counts are 1-127
	;; for run: pair of count value
	;; for non-run data we have count+128 value .. value
	public _rld
	section code_compiler
	;; get source address off stack and restore stack
	pop hl
	pop de
	push de
	push hl
	;; get destination address
	ld a,(de)
	ld l,a
	ld a,(de)
	ld h,a
	ld a,(de)
	cp $00
main_lp:
	inc de
	jr MI,nonrun
run:				; run data pair
	ld b,a
	ld a,(de)
	inc de
run_lp:
	ld (hl),a
	inc hl
	djnz run_lp
	ld a,(de)
	cp $00
	jr NZ,main_lp
	ret
nonrun:				; non-run data
	and $7f
	ld b,a
non_lp:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz non_lp
	ld a,(de)
	cp $00
	jr NZ,main_lp
	ret
	section ignore
	
