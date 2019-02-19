	org 33000
main:	
	di
	ld hl, 22537 ;initialise road
	push hl  ;save road posn
	xor a
	ld b,24
fillscreen:	
	ld (hl),a
	inc hl
	ld (hl),a
	ld de,9
	add hl,de
	ld (hl),a
	inc hl
	ld (hl),a
	ld de,21
	add hl,de
	djnz fillscreen
	ld c,b  ;initialise score
	push bc  ;save score
	ld hl,23278 ;initialise car
	ld a,8
	ld (hl),a
	ld (32900),hl ;save car posn
principalloop:	
	ld hl,(32900) ;retrieve car posn
	ld a,56  ;erase car
	ld (hl),a
	ei
	ld bc,65278 ;read keyboard caps to v
	in a,(c)
	cp 191
	jr nz, moveright
	inc l
moveright:	
	ld bc,32766 ;read keyboard space to b
	in a,(c)
	cp 191
	jr nz, dontmove
	dec l
dontmove:	
	di
	ld (32900),hl ;store car posn
	ld de, 32 ;new carposn
	xor a  ;set carry flag to 0
	sbc hl,de
	ld a,(hl) ;crash?
	or a
	jr z,gameover
	ld a,8  ;print car
	ld (hl),a
	ld hl,23263 ;scroll road
	ld de,23295
	ld bc,736
	lddr
	pop bc  ;retrieve score
	pop hl  ;retrieve road posn
	push hl  ;save road posn
	ld a,56  ;delete old road
	ld (hl),a
	inc hl
	ld (hl),a
	ld de,9
	add hl,de
	ld (hl),a
	inc hl
	ld (hl),a
	;random road left or right
	ld hl,14000 ;source of random bytes in ROM
	ld d,0
	ld e,c
	add hl, de
	ld a,(hl)
	pop hl  ;retrieve road posn
	dec hl  ;move road posn 1 left
	and 1
	jr z, roadleft
	inc hl
	inc hl
roadleft:	
	ld a,l  ;check left
	cp 255
	jr nz, checkright
	inc hl
	inc hl
checkright:	
	ld a,l
	cp 21
	jr nz, newroadposn
	dec hl
	dec hl
newroadposn:	
	push hl  ;save road posn
	xor a  ;print new road
	ld (hl),a
	inc hl
	ld (hl),a
	ld de,9
	add hl,de
	ld (hl),a
	inc hl
	ld (hl),a
	inc bc  ;add 1 to score
	push bc  ;save score
	;wait routine
	ld bc,$1fff ;max waiting time
wait:	
	dec bc
	ld a,b
	or c
	jr nz, wait
	jp principalloop
gameover:	
	pop bc  ;retrieve score
	pop hl  ;empty stack
	ei
	ret; game and tutorial written by Jon Kingsman ('bigjon', 'bj'). electronic mail gmail.com - atsign - jon.kingsman (reversed)
