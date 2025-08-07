	device zxspectrumnext
	org $7e00
start:
	;; clear screen attributes - paper and ink gray
	ld a,$3f
	ld hl,$5800
l1:
	ld (hl),a
	inc l
	jp nz,l1
	inc h
l2:
	ld (hl),a
	inc l
	jp nz,l2
	inc h
l3:
	ld (hl),a
	inc l
	jp nz,l3

	ld bc,nreg		; next register select
	ld a,peri1		; joystick control
	out (c),a		; select next register 5
	ld bc,ndat		; next register data
	in a,(c)		; read next register 5
	and %00000101		; keep 50/60 and scandouble value
	or %01101010		; md 1 and md 2
	out (c),a		; configure joysticks
	ld bc,nreg		; set next reg to supplemental joystick reg
	ld a,joyx
	out (c),a
	ld bc,ndat
	ld d,bup		; d=up attribute
	ld e,bdn		; e=down attribute
loop:
	call read1		; handle joystick 1
	call read2		; handle joystick 2
	call readx		; handle x, y, and z buttons
	in a,(joy1)		; check for both start buttons pressed
	bit 7,a			; if so exit
	jp z,loop
	in a,(joy2)
	bit 7,a
	jp z,loop
	ret

read1:
	in a,(joy1)
	;; right 1
	ld hl,rt+j1
	call button
	;; left 1
	ld hl,lt+j1
	call button
	;; down 1
	ld hl,dn+j1
	call button
	;; up 1
	ld hl,up+j1
	call button
	;; b/fire 1
	ld hl,fb+j1
	call button
	;; c 1
	ld hl,fc+j1
	call button
	;; a 1
	ld hl,fa+j1
	call button
	;; start 1
	ld hl,st+j1
	jp button

read2:
	in a,(joy2)
	;; right 2
	ld hl,rt+j2
	call button
	;; left 2
	ld hl,lt+j2
	call button
	;; down 2
	ld hl,dn+j2
	call button
	;; up 2
	ld hl,up+j2
	call button
	;; b/fire 2
	ld hl,fb+j2
	call button
	;; c 2
	ld hl,fc+j2
	call button
	;; a 2
	ld hl,fa+j2
	call button
	;; start 2
	ld hl,st+j2
	jp button

readx:
	in a,(c)
	;; start 1 - appears to not actually be used here
	ld hl,sb+j1
	call button
	;; y 1
	ld hl,fy+j1
	call button
	;; z 1
	ld hl,fz+j1
	call button
	;; x 1
	ld hl,fx+j1
	call button
	;; start 2 - appears to not actually be used here
	ld hl,sb+j2
	call button
	;; y 2
	ld hl,fy+j2
	call button
	;; z 2
	ld hl,fz+j2
	call button
	;; x 2
	ld hl,fx+j2
	jp button

button:
	rra
	jp c,skip
	ld (hl),d
	ret
skip:
	ld (hl),e
	ret
	
nreg:	equ $243b	       	; next register select port
ndat:	equ $253b	       	; next registed data port
screen:	equ $4000	       	; screen start address
attr:	equ screen+$1800       	; attributes start address
j1:	equ attr+3*$20+8	; base address for joystick 1 on screen
j2:	equ attr+14*$20+8	; base address for joystick 2 on screen
peri1:	equ $05			; peripheral register 1
joy1:	equ $1f			; kempston/megadrive 1 port
joy2:	equ $37			; kempston/megadrive 2 port
joyx:	equ $b2			; supplemental joystick register
bup:	equ $00			; paper and ink black
bdn:	equ $7f			; paper and ink white
	;; locations for buttons on screen
up:	equ $23
dn:	equ $a3
lt:	equ $61
rt:	equ $65
st:	equ $48
fa:	equ $ab
fb:	equ $8d
fc:	equ $6f
sb:	equ $88
fx:	equ $6b
fy:	equ $4d
fz:	equ $2f
	savenex open "megadrive.nex",start
	savenex auto
	savenex close
	
