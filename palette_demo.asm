;;
;; TBBlue / ZX Spectrum Next project
;; Copyright (c) 2013-2017 - Fabio Belavenuto & Victor Trucco
;;
;; All rights reserved
;;
;; Redistribution and use in source and synthezised forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; Redistributions of source code must retain the above copyright notice,
;; this list of conditions and the following disclaimer.
;;
;; Redistributions in synthesized form must reproduce the above copyright
;; notice, this list of conditions and the following disclaimer in the
;; documentation and/or other materials provided with the distribution.
;;
;; Neither the name of the author nor the names of other contributors may
;; be used to endorse or promote products derived from this software without
;; specific prior written permission.
;;
;; THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
;; THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;; PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;; You are responsible for any legal issues arising from your use of this code.
;;

	;; device zxspectrum48	
	
	org 30000




start1:	
	ld HL,04301h; turn on the extra colours
	call set_reg
	
	ld HL,042FFh; reg 42 (palette format) full ink
	call set_reg
			
			
	ld HL,04000h; point to first index
	call set_reg
			
			
	ld HL,04100h; write the first colour
	ld d,128
	call lp_palette ; set the first palette
			
	ld HL,04303h; turn on the second palette
	call set_reg
			
	ld HL,04000h; point to first index again
	call set_reg
			
	ld HL,04180h; write the first colour on second palette
	ld d,128
	call lp_palette
			

wait_loop:	
	LD d,63
	call WaitYLine
			
	ld HL,04303h; turn on the second palette
	call set_reg

	ld d,0
	call WaitYLine
	
	ld HL,04301h; turn on the first palette
	call set_reg

	jr wait_loop
			
			
		
lp_palette:
	call set_reg
			
	push hl
	ld HL, 04400h ; lower B with 0
	call set_reg
	pop hl
			
	;inc l

	call set_reg
			
	push hl
	ld HL, 04401h ; lower B with 1
	call set_reg
	pop hl
			
			
	inc L
	dec d
	jr nz,lp_palette
			
			
			
	ld HL,04080h; point to paper index
	call set_reg
	ld HL,04100h; black as paper
	call set_reg
			
	ret
			
			


WaitYLine:
	ld bc,$243b
	ld a,30
	out (c),a
	inc b
lp:
	in a,(c)
	and 1
	jr nz,lp
	ld bc,$243b
	ld a,31
	out (c),a
	inc b
lp2:
	in a,(c)
	cp d
	jr nz,lp2
	ret			


			
;;-----------
set_reg:	
;; H = port
;; L = value
	LD a,h
	LD BC,0243bh
	OUT(c),a

	ld a,l
set_val:	
	LD BC,0253bh
	OUT(c),a
	ret




last:
	;; SAVESNA "screen.sna",start1	

;;-------------------------------
