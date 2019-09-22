	device zxspectrumnext
;;; a silly dma example that fills a dma screen with a checkerboard
dma_port:	defl $6b
dma_disable:	defl $83
dma_enable:	defl $87
dma_reinit_sb:	defl $8b
dma_reset_di:	defl $a3
dma_start_rsq:	defl $a7
dma_ei:	defl $ab
dma_di:	defl $af
dma_force_rdy:	defl $b3
dma_enable_rti:	defl $b7
dma_wrc:	defl $bb
dma_rsb:	defl $bf
dma_reset:	defl $c3
dma_reset_a:	defl $c7
dma_reset_b:	defl $cb
dma_load:	defl $cf
dma_cont:	defl $d3
dma_burst:	defl $cd
dma_continuous:	defl $ad
screen:	defl $4000
	org $8000
start:
	ei
	ld c,dma_port
	ld a,$63
	ld (patt),a
	ld hl,$5800
	ld (dest),hl
	ld h,$03
	ld (count),hl
	ld b,dmaend-dmadata
	ld hl,dmadata
	otir
	ld a,$01
	ld (count+1),a
	ld a,$55
	ex af,af'
	ld a,$40
loop:	
	ld (dest+1),a
	ex af,af'
	cpl
	ld (patt),a
	ex af,af'
	ld b,dmaend-dmadata
	ld hl,dmadata
	otir
	inc a
	cp $58
	jp m,loop
	ex af,af'
	cpl
	ex af,af'
	ld a,$40
	halt
	jp loop
patt:	defb $aa
dmadata:
	defb dma_disable
	;; wr0
	defb $7d 		
src:	defw patt
count:	defw $0100
	;; wr1
	defb $64,$02
	;; wr2
	defb $50,$02
	;; wr4
	defb dma_continuous
dest:	
	defw screen
	;; wr5
	defb $82
	;; wr6
	defb dma_load,dma_enable
dmaend:	
	savenex open "dma.nex",start
	savenex auto
	savenex close
	
