	di
;;; set up interrupt routine
	im 2
	ld bc,$183B     ; CTC 0
	ld hl,$FFFA     ; address pointing to start of interrupt
	;; routine		
	ld de,interrupt ; start of interrupt routine
	ld (hl),de
	ld i,$FF
	ld a,l          ; Vector to address at on this interrupt
	out (c),a
;;; set up CTC 5
	ld b,$1D        ; CTC 5
	ld a,$87
	out (c),a       ; Interrupt mode, timer mode, time constant,
	;; soft, control
	ld a,$05
	out (c),a       ; once every 5 times 
;;; set up CTC 6
	inc b           ; CTC 6
	ld a,$47
	out (c),a       ; 16x, counter mode, time constant, soft,
	;; control
	ld a,$7D        ; 125 = once every 2000 times
	out (c),a
;;; set up CTC 7
	inc b           ; CTC 7
	ld a,$47
	out (c),a       ; 16x, counter mode, time constant, soft,
	;; control
	ld a,$AF        ; 175 = once every 2800 times
	ei
