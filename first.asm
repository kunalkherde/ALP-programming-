section .data
msg db "hello world",10
msg_len equ $-msg

msg1 db "welcome to pccoe",10
msg_len1 equ $-msg1

msg2 db ""

section .text
global _start
_start:
mov rax,1  
mov rdi,1 
mov rsi,msg  
mov rdx,msg_len
syscall  
mov rax,1  
mov rdi,1 
mov rsi,msg1  
mov rdx,msg_len1
syscall 
mov rax,60
mov rdx,0
syscall
 


