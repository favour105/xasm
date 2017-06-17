;1，数据在哪里？  ds(段地址)    [bx](偏移地址)组成的ds:[bx]实际地址所指的内存中   物理地址=段地址*10+偏移地址,   地址信息 ds:[0]
;2, 数据长度    字节数据  1byte    字型数据  2byte   
;3, 处理数据
;4, 数据存在哪里


assume cs:code

code segment
;loop  循环指令   cx = cx -1 检测cx是不是等于0
;寄存器cx 存放循环次数 
;loop 转移指令
;按p直接执行完
;g指令跳转想要执行的指令
;		mov ax,0
;		mov cx,236
;addNumber:	add ax,123	;循环体
;		mov bx,1111H	;循环体
;		loop addNumber   ;标号  地址

;数据不允许字母开头，要在前面加0
;start: 自己想要开始执行代码的部分start
;dw word 定义字型数据
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
