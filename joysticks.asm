;;; read joysticks as Kempston and show which switches are closed
	device zxspectrumnext
	org $8000-(end-start)
start:
	ei
	im 1
	nextreg $05,$43
	ld hl,$4000
	ld bc,$000c
	ld a,$55
scr_loop1:	
	ld (hl),a
	inc hl
	djnz scr_loop1
	cpl
scr_loop2:	
	ld (hl),a
	inc hl
	djnz scr_loop2
	cpl
	dec c
	jp nz,scr_loop1
	ld a,$07
	ld c,$03
attr_loop:
	ld (hl),a
	inc hl
	djnz attr_loop
	dec c
	jp nz,attr_loop
loop:
	in a,($1f)
	ld hl,$58ec
	call patt
	in a,($37)
	ld hl,$5a0c
	call patt
	halt
	jp loop
patt:
	ld (hl),a
	inc hl
	ld b,$08
	ld e,a
patt_loop:
	xor a
	sll e
	jp nc,skip
	cpl
skip:	
	ld (hl),a
	inc hl
	djnz patt_loop
	ret
end:	
	savenex open "joysticks.nex",start
	savenex auto
	savenex close
	
