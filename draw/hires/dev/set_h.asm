	public _set_h
	extern __set
	section code_compiler
_set_h:
	pop bc
	exx
	pop bc
	pop de
	ld a,e
	cp $c0
	jr NC,end		; y>=192
	bit 7,b
	jr NZ,end		; x<0
	ld a,b	 		; x msb
	cp $02
	jr NC,end 		; x>=512
start:
	ld h,$40		; calculate msb
	bit 3,c
	jr Z,even
	set 5,h
even:
	ld a,e
	sra a
	sra a
	sra a
	and $18
	or h
	ld h,a
	ld a,e
	and $07
	or h
	ld h,a
	ld a,e 			; calculate lsb
	and $38
	add a,a
	add a,a
	ld l,a
	ld a,c
	sra a
	sra a
	sra a
	sra a
	and $0f
	bit 0,b
	jr Z,low
	or $10
low:
	or l
	ld l,a
	;; set function
	ld e,d
	;; set mask
	ld a,c
	and $07
	ld b,a
	ld a,$07
	sub b
	jr NZ,shift
	ld d,$01
	jr done
shift:	
	ld b,a
	ld a,$01
loop:
	add a,a
	djnz loop
	ld d,a
done:	
	push de
	push hl
	exx
	push bc
	jp __set
end:
	push de
	push bc
	exx
	push bc
	ret
