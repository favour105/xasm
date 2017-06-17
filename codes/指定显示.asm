
;and指令 和 or指令

;and指令 :逻辑运算指令 按位进行 与 运算；

;位=bit 与运算，同时为真时才为真。
;mov al,FF
;mov al,0F
;or 指令：或运算。



;ASCII码
;db:声明字节数据。
;db '里面写字符'
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
		mov bl,dh	;行数160
		
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





;大小写转换问题：

;   A     41H    0100 0001B  	or  0010 0000B转换为小写
;   B     42H    0100 0010B
;   C     43H    0100 0011B
;   D     44H    0100 0100B

;   a     61H    0110 0001B     and  1101 1111转换为大写
;
;



; ds:[bx+5]    偏移地址的组合。 
;si和di 地址偏移寄存器。
;用法和bx一样的
;数据从哪里来用ds:[si]。                                  

;ds:[bx+si]
;ds:[bx+di]

;div 
;除法：
;15/2=7.....1
;2  是除数；
;1  是余数
;15 被除数

;1.除数： 8bit 16bit 存在内存单元或寄存器中。

;2,被除数：存在AX 或 AX和DX中。
;	  如果除数为8bit 被除数则为16bit 存在AX中。
;	  如果除数为16bit 被除数则为32bit AX存放低16bit，DX存放高16bit

;3，结果：  如果除数为8bit，则AL存商，AH存放余数。
;	   如果除数16bit。则Ax存放商，DX存放余数。

;div bx/bl
;div byte ptr ds:[0]
;div word ptr ds:[0]





;div bx(寄存器)/bl



;data segment
;		db 256 dup (0) 在内存中定义256个0。

 
;;data ends


;不常用dx ax bx cx 来传递数据，因为其寄存器是有限的,不希望破坏ax bx 中的数据
;opyData:	mov dx,ds:[si]
;		mov es:[di],dx
;		add si,2 
;		add di,2
;		loop copyData
;一般用栈来传递数据。





























