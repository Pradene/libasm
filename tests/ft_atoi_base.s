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

  lea rdi, [rel string]
  lea rsi, [rel base]
  call ft_atoi_base

  ; mov rsi, rax
  ; lea rdi, [rel fmt]
  ; xor rax, rax
  ; call printf wrt ..plt

  pop rbp
  ret

