	device zxspectrumnext
p_layer2:	defl $123b
	org $8000
start:
	ld bc,p_layer2
	ld a,$03		; enable, wo, 1st 16k
	out (c),a
	call wrtpage
	ld bc,p_layer2
	ld a,$43		; enable, wo, 2nd 16k
	out (c),a
	call wrtpage
	ld bc,p_layer2
	ld a,$83		; enable, wo, 3rd 16k
	out (c),a
	call wrtpage
	ret
wrtpage:	
	ld hl,$0000
	ld bc,$0040 		; 40*256 writes
loop:
	ld (hl),b
	inc hl
	djnz loop
	dec c
	jr nz,loop
	ret
	savenex open "layer2.nex", start
	savenex auto
	savenex close
