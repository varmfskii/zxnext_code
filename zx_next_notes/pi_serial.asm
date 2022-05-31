;;; enable UART connection with Pi Zero
	ld c,$3b
	ld b,$15 ; UART control
;;; select Pi on UART control
	in a,(c)
	or $40
	out (c),a
	ld b,$24 ; Next Register Select
	ld a,$a0
	out (c),a
	inc b ; Next Register Data
;;; Enable UART on GPIO and select Pi
	in a,(c)
	or $30
	out (c),a
