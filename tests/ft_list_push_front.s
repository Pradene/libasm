%include "libasm.inc"

section .data
  test_header db "=== Testing ft_list_push_front ===", 0
  str1 db "First", 0
  str2 db "Second", 0  
  str3 db "Third", 0
  str4 db "Fourth", 0

section .bss
  list_head resq 1               ; Reserve space for list head pointer

section .text
  global main
  extern ft_list_push_front
  extern ft_list_print
  extern puts
  extern exit

main:

  push rbp
  mov rbp, rsp

  ; Print test header
  lea rdi, [rel test_header]
  call puts wrt ..plt
  
  ; Initialize list head to NULL
  mov qword [rel list_head], 0   ; Use RIP-relative addressing
  
  ; Push "Fourth" (will be last in output since we're pushing to front)
  lea rdi, [rel list_head]       ; address of head pointer (RIP-relative)
  lea rsi, [rel str4]            ; "Fourth" (RIP-relative)
  call ft_list_push_front
  
  ; Push "Third"
  lea rdi, [rel list_head]       ; RIP-relative
  lea rsi, [rel str3]            ; "Third" (RIP-relative)
  call ft_list_push_front
  
  ; Push "Second" 
  lea rdi, [rel list_head]       ; RIP-relative
  lea rsi, [rel str2]            ; "Second" (RIP-relative)
  call ft_list_push_front
  
  ; Push "First" (will be first in output)
  lea rdi, [rel list_head]       ; RIP-relative
  lea rsi, [rel str1]            ; "First" (RIP-relative)
  call ft_list_push_front
  
  ; Print the entire list
  mov rdi, [rel list_head]       ; pass head pointer value (RIP-relative)
  call ft_list_print

  mov rsp, rbp
  pop rbp
  
  mov rax, 60
  xor rdi, rdi
  syscall
