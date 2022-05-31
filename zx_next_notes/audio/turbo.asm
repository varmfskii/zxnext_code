	;; enable TurboSound audio
	ld bc,$243B
	ld a,$08
	out (c),a
	ld bc,$253B
	in a,(c)
	or $02
	out (c),a
