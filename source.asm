	
		device zxspectrum48
		output source.bin
		org 32768
		
lastkey EQU 23560
		
start	
					; sjasm requires us to dump as a bin file first
		
		jp startprog
		include "vt1-mfx.asm"				; this is the vt2 playroutine 
	
startprog: 	

		ld hl,tune					; to init the play routine we need to ld hl with the address of the tune 
									; that is incbin'd at the end 
		call musicplay+3			; call the musicplay + 3 
		
		ld hl,lastkey				; load hl with lastkey address 
		ld (hl),0					; load lastkey = 0 
	
loop:								; start loop 
		halt 						; wait for timing 
		push hl 					; save hl as it contains lastkey 
		call musicplay+5			; call the player 
		pop hl 						; restore hl which was lastkey
		ld a,(hl)					; check lastkey and load into a 
		cp 32						; was it space though?
		jr z,pressed 				; if zero then a key was pressed so jump to pressed
		jp loop 					; got back to loop 
		
pressed:

		call musicplay+7			; mute music 
		jp 56						; fuck off to basic 
		


tune:
	incbin "music.pt3"				; this is out track to play 
	
	;savetap "tapefile.tap",startprog	; this doest work 
	