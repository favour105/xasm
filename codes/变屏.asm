assume cs:code,ds:data,ss:stack




data segment
	db 128 dup(0)
data ends


stack segment stack
	db 128 dup(0)
stack ends

code segment 

	start:  mov ax,stack
		mov es,ax
		mov sp,128
		



		call clean_blue



		mov ax,4c00H
		int 21H



;===========================================

clean_blue :	mov bx,0B800H
		mov es,bx
		mov bx,1
		mov dh,30
		mov cx,2000


blue:		mov es:[bx],dh
		add bx,2
		loop blue


		
		ret








code ends
end start
