assume cs:code,ds:data,ss:stack


data segment
	db 128 dup(0)
data ends


stack segment stack
	db 128 dup(0)
stack ends

code segment
	start:	mov ax,stack
		mov ss,ax
		mov sp,128
		

		call init_reg
		call show_sin



		mov ax,4C00H
		int 21H
;=======================================
show_sin:	jmp showsin
;**********************************************************

degree0		db	'0',0
degree30	db	'0.5',0
degree60	db	'0.866',0
degree90	db	'1',0
degree120	db	'0.866',0
degree150	db	'0.5',0
degree180	db	'0',0


Address_degree		dw OFFSET degree0
			dw OFFSET degree30
			dw OFFSET degree60
			dw OFFSET degree90
			dw OFFSET degree120
			dw OFFSET degree150
			dw OFFSET degree180
;**********************************************************		
;**********************************************************
;**********************************************************
showsin:	push dx
		push ds
		push si
		push es
		push di	


		mov dx,0
		mov ax,120
		mov bx,30
		div bx
		
		mov bx,ax
		add bx,bx

		mov si,cs:Address_degree[bx]
		mov di,160*10+40*2
		call show_string

		pop di
		pop es
		pop si
		pop ds
		pop dx

		ret

;=======================================
show_string:	push dx
		push ds
		push si
		push es
		push di


showString:	mov dl,ds:[si]
		cmp dl,0
		je showstringret
		mov es:[di],dl
		add di,2
		inc si
		jmp showString


showstringret:	pop di
		pop es
		pop si
		pop ds
		pop dx
		
		ret

		

;=======================================
init_reg:	mov bx,0B800H
		mov es,bx
		

		mov bx,cs
		mov ds,bx		

		ret

;=======================================

code ends
end start





























