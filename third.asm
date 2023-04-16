section .data
msg db "Count OF POSITIVE No. are",10
msg_len equ $-msg

msg1 db "Count OF NEGATIVE No. are",10
msg_len1 equ $-msg1

msg3 db "COUNT OF POSITIVE NEGATIVE NUMBER",10
msg_len3 equ $-msg3

array dq -10h,20h,30h,-40h,-50h,60h,-70h,23h,45h,-39h,67h,-12h,52h,-78h,25h,67h,14h,-98h,-43h,-49h
 n equ 20

section .bss
p_count resq 1

n_count resq 1

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

	mov rsi,array
	mov rcx,n
	mov rbx,0
	mov rdx,0

next_num:
	mov rax,[rsi]
	shl rax,1
	jc negative
positive:
	inc rbx
	jmp next
negative:
	inc rdx
next:
	add rsi,8
	dec rcx
	jnz next_num
	
	mov [p_count],rbx ;+ve no
	mov [n_count],rdx ;-ve no
	
	print msg,msg_len
	mov rax,[p_count]
	call display
	
	print msg1,msg_len1
	mov rax,[n_count]
	call display
Exit

display:
	mov rbx,10
	mov rcx,2
	mov rsi,char_ans+1


cnt:
	mov rdx,0
	div rbx

	cmp dl,09h
	jbe add30
	add dl,07h

add30:
	add dl,30h 
	mov [rsi],dl
	dec rsi	
	dec rcx
	jnz cnt
	print char_ans,2
ret