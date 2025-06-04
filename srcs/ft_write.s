section .text
  global ft_write
  extern __errno_location

ft_write:
  ; Check if buffer is NULL
  test rsi, rsi
  jz .null_error
  
  ; call write
  mov rax, 1
  syscall
  ; test if return of write < 0
  test rax, rax
  js .error
  ret

.null_error:
  ; set errno = EINVAL (22)
  call __errno_location wrt ..plt
  mov dword [rax], 22  ; EINVAL = 22
  mov rax, -1
  ret

.error:
  ; set errno = -rax
  neg rax
  mov rdi, rax
  call __errno_location wrt ..plt
  mov [rax], edi
  ; return -1
  mov rax, -1
  ret
