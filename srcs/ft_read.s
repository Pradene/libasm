section .text
  global ft_read
  extern __errno_location

ft_read:
  ; call read
  mov rax, 0
  syscall

  ; test if return of read < 0
  test rax, rax
  js .error

  ret

.error:
  ; set errno = -rax
  neg rax
  mov rdi, rax

  call __errno_location ; get pointer to errno
  mov [rax], edi ; store errno inside int

  ; return -1
  mov rax, -1
  ret
