
assume cs:code,ds:data,ss:stack
data segment
	db 128 dup(0)
data ends
stack segment stack
	db 128 dup(0)
stack ends
code segment
	start:  mov ax,stack
		mov ss,ax
		mov sp,128
	
		call cpy_Boot ;将Boot:到Boot_end中所有代码复制到0:7E00开始的代码段 
		call save_old_int9
		
		mov bx,0
		push bx 
		mov bx,7E00H
		push bx
		retf		;pop ip 	pop cs		即执行完retf后 cs:ip  =  0:7E00  



		mov ax,4C00H
		int 21H
;=====================================================	
Boot:		jmp BOOt_START                        



;*****************************************************************
OPTION_1		db	'1) restart pc ',0
OPTION_2		db	'2) start system ',0
OPTION_3		db	'3) show clock ',0
OPTION_4		db	'4) set clock ',0


ADDRESS_OPTION		dw	OFFSET OPTION_1 - OFFSET Boot + 7E00H
			dw	OFFSET OPTION_2 - OFFSET Boot + 7E00H
			dw	OFFSET OPTION_3 - OFFSET Boot + 7E00H
			dw	OFFSET OPTION_4 - OFFSET Boot + 7E00H

TIME_cmos		db	9,8,7,4,2,0
TIME_style		db	'YY-MM-DD HH:MM:SS',0
;*****************************************************************



BOOT_START: 	call init_reg
		call clear_screen
		call show_option

		jmp choose_option




		mov ax,4C00H
		int 21H
;=====================================================
choose_option:	call clear_buff


		mov ah,0
		int 16H
		cmp al,'1'
		je isChooseOne
		cmp al,'2'
		je isChooseTwo
		cmp al,'3'
		je isChooseStree
		cmp al,'4'
		je isChooseFort


	
		jmp choose_option

isChooseOne:
		mov di,160*5
		mov byte ptr es:[di],'1'
		jmp choose_option
isChooseTwo:
		mov di,160*5
		mov byte ptr es:[di],'2'
		jmp choose_option
isChooseStree:
		mov di,160*5
		mov byte ptr es:[di],'3'
		call show_clock
		jmp BOOT_START
isChooseFort:
		mov di,160*5
		mov byte ptr es:[di],'4'
		jmp choose_option

;=====================================================
show_clock:	call show_style

		call set_new_int9
		mov bx,OFFSET TIME_cmos - OFFSET Boot +7E00H
		
showTime:	mov si,bx
		mov di,160*20
		mov cx,6
showDate:	mov al,ds:[si]
		out 70H,al
		in al,71H
		
		mov ah,al
		shr ah,1
		shr ah,1
		shr ah,1
		shr ah,1
		and al,00001111B

		add ah,30H
		add al,30H

		mov es:[di],ah
		mov es:[di+2],al

		add di,6
		inc si
		loop showDate
		jmp showTime
showTimeRet:	call set_old_int9

		ret

;=====================================================
set_old_int9:	push bx
		push es
	 
		

		mov bx,0
		mov es,bx
		
		cli
		push es:[200H]
		pop es:[9*4]
		push es:[202H]
		pop es:[9*4+2]
		sti

		pop es
		pop bx
		ret

;=====================================================
set_new_int9:
		push bx
		push es
		
		mov bx,0
		mov es,bx
		
		cli 
		mov word ptr es:[9*4],OFFSET new_int9- OFFSET Boot+7E00H
		mov word ptr es:[9*4+2],0
		sti
		
		pop es
		pop bx
		
		ret


 ;=====================================================
new_int9:	push ax
		in al,60H
		pushf
		call dword ptr cs:[200H]

		cmp al,01H
		je isEsc

		cmp al,3BH
		jne int9Ret
		call change_time_color
		
int9Ret:	pop ax
		iret

;=====================================================
isEsc:		pop ax
		add sp,4
		popf
		jmp showTimeRet



;=====================================================
change_time_color:
		push bx
		push es
		push di	
		push cx
		
		mov bx,0B800H
		mov es,bx
		mov di,160*20+1
		mov cx,17
		
changeTimeColor:
		inc byte ptr es:[di]
		add di,2
		loop changeTimeColor

		pop cx
		pop di
		pop es
		pop bx

		ret
;=====================================================

show_style:	mov si,OFFSET TIME_style - OFFSET Boot + 7E00H
		mov di,160*20

		call show_String

		ret
;=====================================================


clear_buff:
		mov ah,1
		int 16H
		jz clearBuffRet
		mov ah,0
		int 16H
		jmp clear_buff
 clearBuffRet:
		ret
;=====================================================
show_option:	mov bx,OFFSET ADDRESS_OPTION - OFFSET Boot + 7E00H
		mov di,160*10+40*2
		mov cx,4
			

showOption:	mov si,ds:[bx]
		call show_String
		add bx,2
		add di,160
		loop showOption

		ret

;=====================================================
show_String:	push dx
		push ds
		push es
		push si
		push di

showString:	mov dl,ds:[si]
		cmp dl,0
		je showStringRet
		mov es:[di],dl
		add di,2
		inc si
		jmp showString

showStringRet:	pop di
		pop si
		pop es
		pop ds
		pop dx
		ret
;=====================================================
clear_screen:	mov bx,0
		
		mov dx,0700H
		mov cx,4000
		
clearScreen:	mov es:[bx],dx
		add bx,2
		loop clearScreen
		ret		

;=====================================================	
init_reg:	mov bx,0B800H
		mov es,bx
		
		mov bx,0
		mov ds,bx
		ret


Boot_end:	nop

;=====================================================

save_old_int9:
		mov bx,0
		mov es,bx
		
		push es:[9*4]
		pop es:[200H]
		push es:[9*4+2]
		pop es:[202H]
		
		ret;=====================================================

;=====================================================	
cpy_Boot:
		mov bx,cs
		mov ds,bx
		mov si,OFFSET Boot
		
		mov bx,0
		mov es,bx
		mov di,7E00H
		
		mov cx,OFFSET Boot_end - OFFSET Boot
		cld
		rep movsb



		ret
;=====================================================		
code ends
end start




























