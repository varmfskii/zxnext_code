	public rand2
	org 40000
rand2:	call rnd      	; BASIC driver
	ld   c,a
	ld   b,0
	ret

rnd:	ld   de,0     	; c,i

	ld   b,0
	ld   c,e
	ld   hl,table
	add  hl,bc

	ld   c,(hl)   	; y = q[i]

	push hl

	ld   a,e      	; i = ( i + 1 ) & 7
	inc  a
	and  7
	ld   e,a

	ld   h,c      	; t = 256 * y
	ld   l,b

	sbc  hl,bc    	; t = 255 * y
	sbc  hl,bc	; t = 254 * y
	sbc  hl,bc	; t = 253 * y

	ld   c,d
	add  hl,bc    	; t = 253 * y + c

	ld   d,h      	; c = t / 256

	ld   (rnd+1),de

	ld   a,l      	; x = t % 256
	cpl		; x = (b-1) - x = -x - 1 = ~x + 1 - 1 = ~x

	pop  hl

	ld   (hl),a   	; q[i] = x

	ret

table:	
	db   82,97,120,111,102,116,20,12
	
