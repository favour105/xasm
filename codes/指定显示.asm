
;andָ�� �� orָ��

;andָ�� :�߼�����ָ�� ��λ���� �� ���㣻

;λ=bit �����㣬ͬʱΪ��ʱ��Ϊ�档
;mov al,FF
;mov al,0F
;or ָ������㡣



;ASCII��
;db:�����ֽ����ݡ�
;db '����д�ַ�'
assume cs:code,ds:data,ss:stack
data segment
	db 'welcome to mams!',0
data ends
stack segment
		db 128 dup(0)
stack ends
code segment 
	
	start:	mov ax,stack
		mov ss,ax
		mov sp,128



		mov dh,23
		mov dl,15
		mov cl,8
		
		call init_reg

		mov si,0

		call show_str
		

		mov ax,4C00H
		int 21H


init_reg:	mov bx,data
		mov ds,bx
		
		mov bx,0B800H
		mov es,bx
		ret
;===============================================================
get_col:	mov al,2
		mov bl,dl
		mul bl

		add di,ax	

		ret

;===============================================================

get_row:	mov al,160	
		mov bl,dh	;����160
		
		mul bl 

		mov di,ax 


		ret



;=================================================================
show_str:

		call get_row
		call get_col

		mov dh,cl
		
		call show_string


		ret
;==========================================================
show_string:
		push cx
		push dx
		push ds
		push es
		push di
		push si


		mov cx,0

showString:	mov cl,ds:[si]
		jcxz showStringRet
		mov dl,cl
		mov es:[di],dx
		add di,2
		inc si
		jmp showString


showStringRet:	pop si
		pop di
		pop es
		pop ds
		pop dx
		pop cx

		ret

code ends
end start





;��Сдת�����⣺

;   A     41H    0100 0001B  	or  0010 0000Bת��ΪСд
;   B     42H    0100 0010B
;   C     43H    0100 0011B
;   D     44H    0100 0100B

;   a     61H    0110 0001B     and  1101 1111ת��Ϊ��д
;
;



; ds:[bx+5]    ƫ�Ƶ�ַ����ϡ� 
;si��di ��ַƫ�ƼĴ�����
;�÷���bxһ����
;���ݴ���������ds:[si]��                                  

;ds:[bx+si]
;ds:[bx+di]

;div 
;������
;15/2=7.....1
;2  �ǳ�����
;1  ������
;15 ������

;1.������ 8bit 16bit �����ڴ浥Ԫ��Ĵ����С�

;2,������������AX �� AX��DX�С�
;	  �������Ϊ8bit ��������Ϊ16bit ����AX�С�
;	  �������Ϊ16bit ��������Ϊ32bit AX��ŵ�16bit��DX��Ÿ�16bit

;3�������  �������Ϊ8bit����AL���̣�AH���������
;	   �������16bit����Ax����̣�DX���������

;div bx/bl
;div byte ptr ds:[0]
;div word ptr ds:[0]





;div bx(�Ĵ���)/bl



;data segment
;		db 256 dup (0) ���ڴ��ж���256��0��

 
;;data ends


;������dx ax bx cx ���������ݣ���Ϊ��Ĵ��������޵�,��ϣ���ƻ�ax bx �е�����
;opyData:	mov dx,ds:[si]
;		mov es:[di],dx
;		add si,2 
;		add di,2
;		loop copyData
;һ����ջ���������ݡ�





























