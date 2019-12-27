	org 100h
bdos:	equ 0005h
start:	mvi c,9
	lxi d,hello
	call bdos
	ret
hello:
	db "Hello, world!"
	
