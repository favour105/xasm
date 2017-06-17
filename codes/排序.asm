data segment
mess1 db 'Input character:','$'
sbuf db 51,?,51 dup('$'),'$'
mess2 db 'Output character:','$'
mess3 db 0dH,0AH,'$'
data ends

stack segment stack
	dw 20 dup(?)
stack ends
code segment
	assume cs:code,ds:data,ss:stack
input macro buf
	lea dx,buf
	mov ah,0AH
	int 21H
	endm
disply macro string
	lea dx,string
	mov ah,9
	int 21h
	endm
main 	proc far
	push ds
	xor ax,ax
	push ax
	mov ax,data
	mov ds,ax
	disply mess1
	input sbuf
	lea bx,sbuf+2
	add bl,sbuf+1
	adc bh,0
	mov byte ptr [bx],'$'
	disply mess3
	mov cl,sbuf+1
	mov ch,0
	dec cx
l0:	lea si,sbuf+2
	mov dx,cx
l1:	mov al,[si]
	cmp al,[si+1]
	jna l2
	xchg al,[si+1]
	mov [si],al
l2:	inc si
	dec dx
	jnz l1
	loop l0
	disply mess2
	disply sbuf+2
	ret
main endp
	code ends
	end main
	
	