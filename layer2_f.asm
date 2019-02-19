	org $8000
start:
	ld bc,$123b
	ld a,$03
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$43
	out (c),a
	call wrtpage
	ld bc,$123b
	ld a,$83
	out (c),a
	call wrtpage
	ret
wrtpage:	
	ld hl,$0000
	ld a,$40
loopblk:	
	ld b,$00
loop256:
	ld (hl),b
	inc hl
	djnz loop256
	dec a
	jr nz,loopblk
	ret
	
