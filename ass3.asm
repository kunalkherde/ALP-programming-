section .data
	msg1 db "Count of positive num: "
	msg1_len equ $-msg1
	msg2 db 10,"Count of negative num: "
	msg2_len equ $-msg2
	msg3 db "",10
	msg3_len equ $-msg3
	
	array dq -12h, 0012h,-234h, 77h, -222h, -111h, -3h, -450h, 3320h
	n equ 9

section .bss
	char_ans  resb 2
	p_c resq 1 ;we can also use "resb 8"
	n_c resq 1
	
%macro print 2
  	mov rax,1
  	mov rdi,1
  	mov rsi,%1
  	mov rdx,%2
  	syscall
%endmacro  

%macro exit 0
  	mov rax,60
  	mov rdi,00
  	syscall
%endmacro
	
section .text
	global _start
	
_start:
	mov rsi, array
	mov rcx, n
	mov rbx, 0 ;+ve no. count, also write "xor rbx, rbx"
	mov rdx, 0 ;-ve no. count, also write "xor rdx, rdx"
	
next_num:
	mov rax, [rsi]
	shl rax, 1 ;shift left
	jc negative ;jump if carry
	
positive:
	inc rbx
	jmp next
	
negative:
	inc rdx
	
next:
	add rsi, 8
	dec rcx
	jnz next_num
	
mov [p_c], rbx
mov [n_c], rdx

print msg1, msg1_len
mov rax, [p_c]
call display

print msg2, msg2_len
mov rax, [n_c]
call display

print msg3, msg3_len

exit

display: 
      mov rbx,16
      mov rcx,2
      mov rsi, char_ans+1
inc:
          mov rdx,0
          div rbx
          cmp dl,09h
          jbe add30
          add dl,07h
          
add30: add dl,30h
          mov [rsi],dl
          dec rsi
          dec rcx
          jnz inc
          print char_ans,2
ret
