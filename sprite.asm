	org $8000
	defc p_s_palette=$0053 	; sprite palette port
	defc p_s_attrib=$0057 	; sprite attribute port
	defc p_s_data=$0055 	; sprite data port
	;; defc p_s_data=$005B 	; sprite data port
	defc p_r_select=$243b 	; port to select register
	defc p_r_write=$253b 	; port to write to register
	defc p_s_select=$303b 	; sprite select port
	defc r_sprite=21
start:
	;; enable sprites
	ld bc,p_r_select	; select register
	ld a,r_sprite 		; register 21=sprite
	out (c),a
	ld bc,p_r_write		; register in
	ld a,$03		; enable sprites
	out (c),a
	;; select sprite 0
	ld bc,p_s_select	; sprite select
	xor a			; sprite 0
	out (c),a
	;; write 256 bytes of sprite data to sprite data port
	;; ld hl,sprite0
	;; ld c,p_s_data
	;; ld b,0
	;; otir
	ld hl,sprite0
	ld bc,p_s_data
	exx
	ld b,$0
loop:
	exx
	ld a,(hl)
	out (c),a
	inc hl
	exx
	djnz loop
	exx
	;; set sprite position and make sprite visible
	xor a
	ld bc,p_s_attrib	; sprite attibutes (location, rotation)
	out (c),a		; xlsb=0
	out (c),a		; y=0
	out (c),a 		; paloff=0, no mirror, xmsb=0
	ld a,$80 		; visible, pattern=0
	out (c),a
	ret
sprite0:
	defb $04,$04,$04,$04,$04,$04,$04,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$FF,$FF,$FF,$FF,$FF,$04,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$FF,$FB,$FB,$FB,$FF,$04,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$FF,$FB,$F5,$F5,$FB,$FF,$04,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$FF,$FB,$F5,$A8,$A8,$FB,$FF,$04,$E3,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$FF,$FF,$FB,$A8,$44,$A8,$FB,$FF,$04,$E3,$E3,$E3,$E3,$E3,$E3
	defb $04,$04,$04,$FF,$FB,$A8,$44,$A8,$FB,$FF,$04,$E3,$E3,$E3,$E3,$E3
	defb $E3,$E3,$E3,$04,$FF,$FB,$A8,$44,$44,$FB,$FF,$04,$E3,$04,$E3,$E3
	defb $E3,$E3,$E3,$E3,$04,$FF,$FB,$44,$44,$44,$FB,$FF,$04,$4D,$04,$E3
	defb $E3,$E3,$E3,$E3,$E3,$04,$FF,$FB,$44,$44,$44,$44,$FA,$4D,$04,$E3
	defb $E3,$E3,$E3,$E3,$E3,$E3,$04,$FF,$FB,$44,$FF,$F5,$44,$04,$E3,$E3
	defb $E3,$E3,$E3,$E3,$E3,$E3,$E3,$04,$FF,$44,$F5,$A8,$04,$E3,$E3,$E3
	defb $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$04,$FA,$44,$04,$A8,$04,$E3,$E3
	defb $E3,$E3,$E3,$E3,$E3,$E3,$E3,$04,$4D,$4D,$04,$E3,$04,$F5,$04,$E3
	defb $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$04,$04,$E3,$E3,$E3,$04,$FA,$04
	defb $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$04,$04
