	public rand1
	org 32768
rand1:	ld  hl,0xA280   	; xz -> yw
	ld  de,0xC0DE		; yw -> zt
	ld  (rnd+1),de  ; x = y, z = w
	ld  a,e	; w = w ^ ( w << 3 )
	add a,a
	add a,a
	add a,a
	xor e
	ld  e,a
	ld  a,h         ; t = x ^ (x << 1)
	add a,a
	xor h
	ld  d,a
	rra             ; t = t ^ (t >> 1) ^ w
	xor d
	xor e
	ld  h,l         ; y = z
	ld  l,a	; w = t
	ld  (rnd+4),hl
	ret
