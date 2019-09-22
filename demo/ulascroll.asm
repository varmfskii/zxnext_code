;;; read joysticks as Kempston and show which switches are closed
	device zxspectrumnext
per1: 	defl $05
ulax:	defl $32
ulay:	defl $33
joy1:	defl $1f
joy2:	defl $37
	org $8000-(end-start)
start:
	ei
	im 1
	nextreg per1,$43
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
	xor a
	ld (xpos),a
	ld (ypos),a
loop:
	call draw
	call scroll
	halt
	jp loop
;;; draw patterns according to both joysticks
draw:	
	in a,(joy1)
	ld hl,$58ec
	call patt
	in a,(joy2)
	ld hl,$5a0c
	call patt
	ret
;;; scroll according to joystick 1
scroll:
	in a,(joy1)
	ld d,a
button:
	ld e,$01
	bit 4,d
	jp z,right
	ld e,$08
right:
	bit 0,d
	jp z,left
	ld a,(xpos)
	sub e
	ld (xpos),a
left:	
	bit 1,d
	jp z,down
	ld a,(xpos)
	add a,e
	ld (xpos),a
down:
	bit 2,d
	jp z,up
	ld a,(ypos)
	sub e
	cp $c0
	jp c,dskip
	sub $40
dskip:	
	ld (ypos),a
up:	
	bit 3,d
	jp z,move
	ld a,(ypos)
	add a,e
	cp $c0
	jp c,uskip
	add a,$40
uskip:	
	ld (ypos),a
move:
	ld a,(xpos)
	nextreg ulax,a
	ld a,(ypos)
	nextreg ulay,a
	ret
;;; draw a pattern based on the value in a
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
xpos:	defl $4000
ypos:	defl $4100
end:	
	savenex open "ulascroll.nex",start,start-2
	savenex auto
	savenex close
	
