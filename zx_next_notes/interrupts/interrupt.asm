	;; my program
	org $8000
	;; enable interrupt mode im2
	ld i,$fe
	im2
	ei
	;; program body
	;; interrupt routine
handler:
	;; preserve registers used
	;; handle interrupt
	;; restore registers
	ei
	reti
	;; jump to interrupt routine
	org $fdfd
	jp handler
	;; im2 jump table
	org $fe00 ; not actually legal
	defs $101,$fd
