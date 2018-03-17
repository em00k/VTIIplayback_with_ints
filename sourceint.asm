	
		device zxspectrum48
		output sourceint.bin
		org 32768
		; sjasm requires us to dump as a bin file first
		; bits for interrupts 

ijump 	equ $faff				; we will put two bytes her $6060
isr		equ $6060 				; then we set out isr to $6060
		
start	
											
		
		jp startprog						; jumpt to main prog
		include "vt1-mfx.asm"				; this is the vt2 playroutine 
	
startprog: 	
		; set up im2 stuff 
		ld hl,isr 							; load hl with isr value $6060
		ld (ijump),hl 						; load $faff with $6060
		ld hl,ints							; start at ints
		ld de,isr							; dest at $6060
		ld bc,intsend-ints 					; length 
		ldir								; copy interrupt routine

		ld hl,tune							; to init the play routine we need to ld hl with the address of the tune 
											; that is incbin'd at the end 
		call musicplay+3					; init the musicplay + 3 
		
		call setupim2 						; set up im 2
		
		;your stuff 
lp:		
		ld a,3
		out (254),a
		halt 
		halt 
		halt 
		halt 
		halt 
		halt 
		halt 
		halt 
		ld a,5
		out(254),a
		halt 
		halt 
		halt 
		halt 
		halt 
		halt 
		halt 
		jp lp
		
setupim2:
		di 
		ld a, ijump/256
		ld i, a
		im 2
		ei
		ret       

ints:	; this copied to $6060 and then ran every 50th/s
		di                  ; disable interrupts
		push af             ; save all std regs
		push bc
		push de
		push hl
		push ix             
		push iy
		ex af, af'			;'
		push af             ;' save all std regs'
		call musicplay+5       	; play the current tune
		pop af 
		ex af, af' ;'
		pop iy
		pop ix              
		pop hl
		pop de
		pop bc
		pop af              
		ei      
		jp 56				; set for use in basic 
intsend:

tune:
	incbin "music.pt3"				; this is out track to play 
	
	;savetap "tapefile.tap",startprog	; this doest work 
	