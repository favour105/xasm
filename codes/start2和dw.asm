;1�����������  ds(�ε�ַ)    [bx](ƫ�Ƶ�ַ)��ɵ�ds:[bx]ʵ�ʵ�ַ��ָ���ڴ���   �����ַ=�ε�ַ*10+ƫ�Ƶ�ַ,   ��ַ��Ϣ ds:[0]
;2, ���ݳ���    �ֽ�����  1byte    ��������  2byte   
;3, ��������
;4, ���ݴ�������


assume cs:code

code segment
;loop  ѭ��ָ��   cx = cx -1 ���cx�ǲ��ǵ���0
;�Ĵ���cx ���ѭ������ 
;loop ת��ָ��
;��pֱ��ִ����
;gָ����ת��Ҫִ�е�ָ��
;		mov ax,0
;		mov cx,236
;addNumber:	add ax,123	;ѭ����
;		mov bx,1111H	;ѭ����
;		loop addNumber   ;���  ��ַ

;���ݲ�������ĸ��ͷ��Ҫ��ǰ���0
;start: �Լ���Ҫ��ʼִ�д���Ĳ���start
;dw word ������������
		mov ax,cs
		mov ds,ax

		mov ax,0020H
		mov es,ax
		mov bx,0

		mov cx,23

copyData:	mov al,ds:[bx]
		mov es:[bx],al
		inc bx
		loop copyData 

      
 

		mov ax,4C00H
		int 21H

code ends
end
