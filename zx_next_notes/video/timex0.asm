	;; from any other Timex mode:
	ld a,$00
	ld c,$ff
	out (c),a

	;; from LoRes mode:
	ld bc,$243B ; next register select port
	ld a,$15
	out (c),a
	ld bc,$253B ; next register r/w port
	in a,(c)
	and $7f
	out (c),a
