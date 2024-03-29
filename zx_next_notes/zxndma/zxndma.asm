;;;--------------------------------------------------------
	device zxspectrum48
;;;--------------------------------------------------------
;;; DEFINE testing
;;;--------------------------------------------------------
;;; DMA (Register 6)
;;;
;;;--------------------------------------------------------
;;;zxnDMA programming example
;;;--------------------------------------------------------
;;;(c) Jim Bagley
;;;--------------------------------------------------------
DMA_RESET equ $c3
DMA_RESET_PORT_A_TIMING equ $c7
DMA_RESET_PORT_B_TIMING equ $cb
DMA_LOAD equ $cf ; %11001111
DMA_CONTINUE equ $d3
DMA_DISABLE_INTERUPTS equ $af
DMA_ENABLE_INTERUPTS equ $ab
DMA_RESET_DISABLE_INTERUPTS equ $a3
DMA_ENABLE_AFTER_RETI equ $b7
DMA_READ_STATUS_BYTE equ $bf
DMA_REINIT_STATUS_BYTE equ $8b
DMA_START_READ_SEQUENCE equ $a7
DMA_FORCE_READY equ $b3
DMA_DISABLE equ $83
DMA_ENABLE equ $87
DMA_WRITE_REGISTER_COMMAND equ $bb
DMA_BURST equ %11001101
DMA_CONTINUOUS equ %10101101
ZXN_DMA_PORT equ $6b
SPRITE_STATUS_SLOT_SELECT equ $303B
SPRITE_IMAGE_PORT equ $5b
SPRITE_INFO_PORT equ $57
;;;--------------------------------------------------------

	IFDEF testing
	org $6000
	ELSE
	org $2000
	ENDIF

start 
	ld hl,$0000
	ld de,$4000
	ld bc,$800

	call TransferDMA ; copy some random data to the screen
	;; pointing to ROM for now, for the purpose of showing
	;; how to do a DMA copy.
	ld a,0 ; sprite image number we want to update
	ld bc,SPRITE_STATUS_SLOT_SELECT
	out (c),a ; set the sprite image number
	ld bc,1*256 ; number to transfer (1)
	ld hl,testsprite ; from
	call TransferDMASprite ; transfer to sprite ram

	nextreg 21,1 ; turn sprite on. for more info on this
	;; check out
	;; https://www.specnext.com/tbblue-io-port-system/
	ld de,0
	ld (xpos),de ; set initial X position ( doesn't need it
	;; for this demo, but if you run the .loop again it will
	;; continue from where it was
	ld a,$20
	ld (ypos),a ; set initial Y position

.loop 
	ld a,0 ; sprite number we want to position
	ld bc,SPRITE_STATUS_SLOT_SELECT
	out (c),a
	ld de,(xpos)
	ld hl,(ypos) ; ignores H so doing this rather than
	;; ld a,(ypos):ld l,a
	ld bc,(image) ; not flipped or palette shifted
	call SetSprite

	halt

	ld de,(xpos)
	inc de
	ld (xpos),de
	ld a,d
	cp $01
	jr nz,.loop ; if high byte of xpos is not 1 (right of
	;; screen )
	ld a,e
	cp $20+1
	jr nz,.loop ; if low byte is not $21 just off the right
	;; of the screen, $20 is off screen but as the INC DE is
	;; just above and not updated sprite after it, it needs
	;; to be $21
	xor a
	ret ; return back to basic with OK

xpos dw 0 ; x position
ypos db 0 ; y position
;;; these next two BITS and IMAGE are swapped as bits needs
;;; to go into B register image db 0+$80 ; use image 0 (for
;;; the image we transfered)+$80 to set the sprite to active
bits db 0 ; not flipped or palette shifted

	c1 = %11100000
	c2 = %11000000
	c3 = %10100000
	c4 = %10000000
	c5 = %01100000
	c6 = %01000000
	c7 = %00100000
	c8 = %00000000

testsprite 
	db c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1
	db c1,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c1
	db c1,c2,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c2,c1
	db c1,c2,c3,c4,c4,c4,c4,c4,c4,c4,c4,c4,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c5,c5,c5,c5,c5,c5,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c6,c6,c6,c6,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c7,c7,c7,c7,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c7,c8,c8,c7,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c7,c8,c8,c7,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c7,c7,c7,c7,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c6,c6,c6,c6,c6,c6,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c5,c5,c5,c5,c5,c5,c5,c5,c4,c3,c2,c1
	db c1,c2,c3,c4,c4,c4,c4,c4,c4,c4,c4,c4,c4,c3,c2,c1
	db c1,c2,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c3,c2,c1
	db c1,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c2,c1
	db c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1,c1

;;;-------------------------------------------------
;;; de = X
;;; l = Y
;;; b = bits
;;; c = sprite image
SetSprite 
	push bc
	ld bc,SPRITE_INFO_PORT
	out (c),e ; Xpos
	out (c),l ; Ypos
	pop hl
	ld a,d
	and 1
	or h
	out (c),a
	ld a,l:or $80
	out (c),a ; image
	ret

;;;--------------------------------
;;; hl = source
;;; de = destination
;;; bc = length
;;;--------------------------------
TransferDMA 
	di
	ld (DMASource),hl
	ld (DMADest),de
	ld (DMALength),bc
	ld hl,DMACode
	ld b,DMACode_Len
	ld c,ZXN_DMA_PORT
	otir
	ei
	ret

DMACode db DMA_DISABLE
	db %01111101 ; R0-Transfer mode, A -> B, write adress
	;; + block length
DMASource dw 0 ; R0-Port A, Start address
	;; (source address)
DMALength dw 0 ; R0-Block length (length in bytes)
	db %01010100 ; R1-write A time byte, increment, to
	;; memory, bitmask
	db %00000010 ; 2t
	db %01010000 ; R2-write B time byte, increment, to
	;; memory, bitmask
	db %00000010 ; R2-Cycle length port B
	db DMA_CONTINUOUS ; R4-Continuous mode (use this for
	;; block transfer), write dest adress
DMADest dw 0 ; R4-Dest address (destination address)
	db %10000010 ; R5-Restart on end of block, RDY active
	;; LOW
	db DMA_LOAD ; R6-Load
	db DMA_ENABLE ; R6-Enable DMA

DMACode_Len equ $-DMACode

;;;--------------------------------------------------------
;;; hl = source
;;; bc = length
;;; set port to write to with TBBLUE_REGISTER_SELECT
;;; prior to call
;;;--------------------------------------------------------
TransferDMAPort 
	di
	ld (DMASourceP),hl
	ld (DMALengthP),bc
	ld hl,DMACodeP
	ld b,DMACode_LenP
	ld c,ZXN_DMA_PORT
	otir
	ei
	ret

DMACodeP db DMA_DISABLE
	db %01111101 ; R0-Transfer mode, A -> B, write adress
	;; + block length
DMASourceP dw 0 ; R0-Port A, Start address (source address)
DMALengthP dw 0 ; R0-Block length (length in bytes)
	db %01010100 ; R1-read A time byte, increment, to
	;; memory, bitmask
	db %00000010 ; R1-Cycle length port A
	db %01101000 ; R2-write B time byte, increment, to
	;; memory, bitmask
	db %00000010 ; R2-Cycle length port B
	db %10101101 ; R4-Continuous mode (use this for block
	;; transfer), write dest adress
	dw $253b ; R4-Dest address (destination address)
	db %10000010 ; R5-Restart on end of block, RDY active
	;; LOW
	db DMA_LOAD ; R6-Load
	db DMA_ENABLE ; R6-Enable DMA

DMACode_LenP equ $-DMACodeP
;;;--------------------------------------------------------
;;; hl = source
;;; bc = length
;;;--------------------------------------------------------
TransferDMASprite 
	di
	ld (DMASourceS),hl
	ld (DMALengthS),bc
	ld hl,DMACodeS
	ld b,DMACode_LenS
	ld c,ZXN_DMA_PORT
	otir
	ei
	ret

DMACodeS db DMA_DISABLE
	db %01111101 ; R0-Transfer mode, A -> B, write adress
	;; + block length
DMASourceS dw 0 ; R0-Port A, Start address (source address)
DMALengthS dw 0 ; R0-Block length (length in bytes)
	db %01010100 ; R1-read A time byte, increment, to
	;; memory, bitmask
	db %00000010 ; R1-Cycle length port A
	db %01101000 ; R2-write B time byte, increment, to
	;; memory, bitmask
	db %00000010 ; R2-Cycle length port B
	db %10101101 ; R4-Continuous mode (use this for block
	;; transfer), write dest adress
	dw SPRITE_IMAGE_PORT ; R4-Dest address (destination address)
	db %10000010 ; R5-Restart on end of block, RDY active
	;; LOW
	db DMA_LOAD ; R6-Load
	db DMA_ENABLE ; R6-Enable DMA
DMACode_LenS equ $-DMACodeS
;;;--------------------------------------------------------
;;; de = dest, a = fill value, bc = lenth
;;;--------------------------------------------------------
	DMAFill
	di
	ld (FillValue),a
	ld (DMACDest),de
	ld (DMACLength),bc
	ld hl,DMACCode
	ld b,DMACCode_Len
	ld c,ZXN_DMA_PORT
	otir
	ei
	ret

FillValue db 22
DMACCode db DMA_DISABLE
	db %01111101
DMACSource dw FillValue
DMACLength dw 0
	db %00100100,%00010000,%10101101
DMACDest dw 0
	db DMA_LOAD,DMA_ENABLE
DMACCode_Len equ $-DMACCode

;;;--------------------------------------------------------
;;; End of file
;;;--------------------------------------------------------

	IFDEF testing
	savesna "dmatest.sna",start
	ELSE
	fin
	savebin "DMATEST",start,fin-start
	ENDIF
