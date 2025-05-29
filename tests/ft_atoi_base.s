section .data
  string db "1010", 0
  base db "01", 0
  fmt db "Result: %d", 10, 0

section .text
  global main
  extern printf
  extern ft_atoi_base

main:
  push rbp
  mov rbp, rsp
  sub rsp, 16      ; Maintain 16-byte stack alignment
  
  lea rdi, [rel string]
  lea rsi, [rel base]
  call ft_atoi_base
  
  ; Prepare for printf call
  mov rsi, rax
  lea rdi, [rel fmt]
  xor rax, rax     ; No vector registers used
  call printf wrt ..plt
  
  xor rax, rax     ; Return 0
  mov rsp, rbp
  pop rbp
  ret
