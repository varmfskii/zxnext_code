	device zxspectrumnext
	org $8000
p_s_palette:	defl $0053 	; sprite palette port
p_s_attrib:	defl $0057 	; sprite attribute port
p_s_data:	defl $005b 	; sprite data port
p_r_select:	defl $243b 	; port to select register
p_r_write:	defl $253b 	; port to write to register
p_s_select:	defl $303b 	; sprite select port
r_sprite:	defl 21
start:
	;; enable sprites
	nextreg r_sprite, $03	; enable sprites
	;; select sprite 0
	ld bc,p_s_select	; sprite select
	xor a			; sprite 0
	out (c),a
	;; write 256 bytes of sprite data to sprite data port
	ld hl,sprite0
	ld c,p_s_data
	ld b,0
	otir
	;; select sprite
	ld bc,p_s_select	; sprite select
	xor a			; sprite 0
	out (c),a
	;; set sprite position and make sprite visible
	ld bc,p_s_attrib	; sprite attibutes (location, rotation)
	ld a,$98
	out (c),a		; xlsb=152
	ld a,$78
	out (c),a		; y=129
	xor a
	out (c),a 		; paloff=0, no mirror, xmsb=0
	ld a,$80		; visible, pattern=0
	out (c),a
loop:	
	jp loop
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
	savenex open "sprite.nex",start
	savenex auto
	savenex close
	
