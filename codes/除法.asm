
assume cs:code
data segment
	db	"overflow!!!!",0
data ends

code segment
	
start: 	mov ax,cs
	mov ds,ax
	mov si,OFFSET do   ;设置ds:si 指向源地址

	mov ax,0
	mov es,ax
	mov bx,200H
	mov di,bx

	mov cx,OFFSET end_do - OFFSET do
	
	cld 
	rep movsb

	mov ax,4c00H
	int 21H


do:	jmp short doStart
	db  "overflow!!!!",0



doStart:mov ax,data
	mov ds,ax
	mov si,0
	
	mov bx,0B800H
	mov es,bx

	mov di,160*16+36*2

	mov cx,12

s:	mov al,ds:[si]
	mov es:[di],al
	inc si
	add di,2
	loop s


	





	mov ax,4c00H
	int 21H

end_do:	nop

code ends
end start


















