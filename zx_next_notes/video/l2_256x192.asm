r_mmu_7:  defl $57
r_disp1:  defl $69
r_layer2: defl $70
start:
	nextreg r_disp1,$80  ; enable layer 2
	nextreg r_layer2,$00 ; 256x192x256
	ld a,$12             ; page 18=bank 9
loop1:
	nextreg r_mmu_7,a    ; map page into slot 7
	ld bc,$0020          ; 20*256 = 8k
	ld hl,$E000          ; address of slot 7
loop2:
	ld (hl),b
	inc hl
	djnz loop2
	dec c
	jp NZ,loop2
	inc a
	cp $18               ; stop at page 24
	jp NZ,loop1
