%include "libasm.inc"

section .data
  ; Test strings
  str1 db "first", 0
  str2 db "second", 0  
  str3 db "third", 0
  str4 db "fourth", 0
  str5 db "fifth", 0
  
  ; Test messages
  test_header db "=== Testing ft_list_sort ===", 0
  separator db "---", 0

section .bss
  list_head resq 1               ; Reserve space for list head pointer

section .text
  global main
  extern ft_list_push_front
  extern ft_list_print
  extern ft_list_size
  extern ft_list_sort
  extern ft_strcmp
  extern puts
  extern printf

main:
  push rbp
  mov rbp, rsp
  sub rsp, 16                    ; Align stack to 16-byte boundary
  
  ; Print test header
  lea rdi, [rel test_header]
  call puts wrt ..plt
  
  ; Initialize list head to NULL
  mov qword [rel list_head], 0
  
  ; Add first element
  lea rdi, [rel list_head]
  lea rsi, [rel str1]
  call ft_list_push_front
  
  ; Add second element
  lea rdi, [rel list_head]
  lea rsi, [rel str2]
  call ft_list_push_front

  ; Add third element
  lea rdi, [rel list_head]
  lea rsi, [rel str3]
  call ft_list_push_front

  ; Add fourth element
  lea rdi, [rel list_head]
  lea rsi, [rel str4]
  call ft_list_push_front
  
  ; Add fifth element
  lea rdi, [rel list_head]
  lea rsi, [rel str5]
  call ft_list_push_front

  ; Show list
  mov rdi, [rel list_head]
  call ft_list_print
  
  lea rdi, [rel list_head]
  lea rsi, [rel ft_strcmp]
  call ft_list_sort

  lea rdi, [rel separator]
  call puts wrt ..plt


  ; Show final list
  mov rdi, [rel list_head]
  call ft_list_print
  
  ; Clean exit
  mov rsp, rbp
  pop rbp
  
  mov rax, 60                    ; sys_exit
  xor rdi, rdi                   ; exit status 0
  syscall

