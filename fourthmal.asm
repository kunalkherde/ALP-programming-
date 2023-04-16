section .data
msg db "Enter the bcd number",10
msg_len equ $-msg

msg1 db "The value of the hexadecimal number is :"
msg1_len equ $-msg1
section .bss

ans resb 1

buf resb 2

char_ans resb 2


%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro


%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:

	print msg3,msg_len3

	mov rsi,
	mov rcx,ans
	mov rbx,0
	mov rdx,0

Bcd_hex:
	print msg,msg_len
	read buf,6

	mov rsi , buf
	xor ax,ax
	mov rbp,5
	mov rbx,10

next :
	xor cx,cx
	mul bx
	mov cl[rsi]
	sub cl,30h
	add ax,cx

	inc rsi
	dec rbp
	jnz next

	mov [ans],ax
	print msg1,msg1_len

	mov ax[ans]
	call display
