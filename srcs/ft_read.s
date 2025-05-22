section .text
  global ft_write

ft_write:
  mov rax, 0
  syscall
  ret
