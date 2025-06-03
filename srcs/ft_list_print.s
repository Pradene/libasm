%include "libasm.inc"

section .data
  null_str db "(null)", 0

section .text
  global ft_list_print
  extern puts

ft_list_print:
  push rbp
  mov rbp, rsp
  push rbx
  sub rsp, 8                ; Align stack

  mov rbx, rdi              ; Current node

.loop:
  test rbx, rbx
  jz .done

  mov rsi, [rbx + s_list.content]   ; rsi = string to print
  test rsi, rsi
  jz .null_content

  mov rdi, [rbx + s_list.content]           ; rdi = "%s\n"
  call puts wrt ..plt
  jmp .next_node

.null_content:
  lea rdi, [rel null_str]
  call puts wrt ..plt

.next_node:
  mov rbx, [rbx + s_list.next]
  jmp .loop

.done:
  add rsp, 8
  pop rbx
  pop rbp
  ret

