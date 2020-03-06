	device zxspectrumnext
	org $8000
r_l2_ram:	defl $12
r_clip_l2:	defl $18
r_clip_ctl:	defl $1c
r_mmu_7:	defl $57
r_disp1:	defl $69
r_layer2:	defl $70
start:
	nextreg r_disp1, $80 	; enable layer 2
	nextreg r_layer2, $10	; 320x256x256
	nextreg r_clip_ctl, $01	; reset layer2 clip-window register index
	nextreg r_clip_l2, $00	; X1=0
	nextreg r_clip_l2, $A0	; X2=320 (160*2)
	nextreg r_clip_l2, $00	; Y1=0
	nextreg r_clip_l2, $FF	; Y2=255
	ld a, $12		; page 18=bank 9
	
loop1:
	nextreg r_mmu_7, a	; map page into slot 7
	ld bc, $0020		; 20*256 = 8k
	ld hl, $E000		; start of slot 7
loop2:
	ld (hl), b
	inc hl
	djnz loop2
	dec c
	jp NZ, loop2
	inc a
	cp $1C			; stop at page 28
	jp NZ, loop1
loop3:
	jp loop3
	savenex open "layer2_320x256.nex", start
	savenex auto
	savenex close
