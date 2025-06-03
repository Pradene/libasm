%include "libasm.inc"

section .text
  global ft_list_size

ft_list_size:
  ; ARGUMENTS
  ; RDI = FT_LIST

  push rbp
  mov rbp, rsp

  xor rcx, rcx

.loop:
  test rdi, rdi
  je .done

  inc rcx

  mov rdi, [rdi + s_list.next] ; Access next element
  jmp .loop

.done:
  mov rax, rcx

  mov rsp, rbp
  pop rbp
  ret
