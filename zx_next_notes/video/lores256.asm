	;; enable LoRes mode:
	nextreg $15,$80
	;; 256-colour mode
	ld bc,$243B ; next register select port
	ld a,$6A
	out (c),a
	ld bc,$253B ; next register r/w port
	in a,(c)
	and $EF ; lores radistan control
	out (c),a
