	;; enable internal speaker
	ld bc,$243B
	ld a,$08
	out (c),a
	ld bc,$253B
	in a,(c)
	or $10
	out (c),a
