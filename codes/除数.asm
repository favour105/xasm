
;andָ�� �� orָ��

;andָ�� :�߼�����ָ�� ��λ���� �� ���㣻

;λ=bit �����㣬ͬʱΪ��ʱ��Ϊ�档
;mov al,FF
;mov al,0F
;or ָ������㡣



;ASCII��
;db:�����ֽ����ݡ�
;db '����д�ַ�'
assume cs:code,ds:data
data segment
	db 'welcome to mams!'
	db '..........'
data ends
stack segment
	dw 0,0,0,0,0,0,0,0
	dw 0,0,0,0,0,0,0,0
stack ends
code segment 
	
	start:  mov ax,stack
		mov ss,ax
		mov sp,32
		mov ax,data
		mov ds,ax
		mov es,ax

		mov si,0
		mov di,16
	
		mov cx,8
		
copyData	push ds:[si]
		pop es:[di]
		add si,2
		add di,2
		loop copyData
		

;������dx ax bx cx ���������ݣ���Ϊ��Ĵ��������޵�,��ϣ���ƻ�ax bx �е�����
;opyData:	mov dx,ds:[si]
;		mov es:[di],dx
;		add si,2 
;		add di,2
;		loop copyData
;һ����ջ���������ݡ�

		mov ax,4C00H
		int 21H


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

ds:[bx+si]
ds:[bx+di]

;div 
;������
;15/2=7.....1
;2  �ǳ�����
;1  ������
;15 ������

1.������ 8bit 16bit �����ڴ浥Ԫ��Ĵ����С�

2,������������AX �� AX��DX�С�
	  �������Ϊ8bit ��������Ϊ16bit ����AX�С�
	  �������Ϊ16bit ��������Ϊ32bit AX��ŵ�16bit��DX��Ÿ�16bit

3�������  �������Ϊ8bit����AL���̣�AH���������
	   �������16bit����Ax����̣�DX���������

;div bx/bl
;div byte ptr ds:[0]
;div word ptr ds:[0]





;div bx(�Ĵ���)/bl



data segment
		db 256 dup (0) ���ڴ��ж���256��0��

 
data ends
































