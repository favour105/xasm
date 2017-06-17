
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
	

		call init_reg
	

testA:		mov ax,1000H
		jmp testA

		mov ax,4C00H
		int 21H

;==================================================
clear_screen:	mov bx,0
		mov dx,0700H
		mov cx,2000
				
clearScreen:	mov es:[bx],dx
		add bx,2
		loop clearScreen
		ret



;==================================================
init_reg:	
		mov bx,0B800H
		mov es,bx

		mov bx,cs
		mov ds,bx
		ret
;==================================================

		
code ends
end




























