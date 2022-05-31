	;; disable LoRes mode:
	ld bc,$243B ; next register select port
	ld a,$15
	out (c),a
	ld bc,$253B ; next register r/w port
	in a,(c)
	and $7f
	out (c),a
	;; set Timex mode
	ld bc,$243B ; next register select port
	ld a,$08
	out (c),a
	ld bc,$253B ; next register r/w port
	in a,(c)
	or $04
	out (c),a
	;; set hi-res mode, black on white
	ld c,$ff
	ld a,$06
	out (c),a
