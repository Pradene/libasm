section .text
  global ft_write
  extern __errno_location

ft_write:
  ; call write
  mov rax, 1
  syscall

  ; test if return of write < 0
  test rax, rax
  js .error

  ret

.error:
  ; set errno = -rax
  neg rax
  mov rdi, rax

  call __errno_location wrt ..plt ; get pointer to errno
  mov [rax], edi ; store errno inside int

  ; return -1
  mov rax, -1
  ret
