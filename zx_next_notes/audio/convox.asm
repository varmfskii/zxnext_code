	;; enable SpecDrum/Convox audio
	ld bc,$243B
	ld a,$08
	out (c),a
	ld bc,$253B
	in a,(c)
	or $08
	out (c),a
