_main:
	ld bc,$243b
	ld a,$15
	out (c),a
	ld bc,$253b
	ld a,$81
	out (c),a
loop:
	jp loop
	
