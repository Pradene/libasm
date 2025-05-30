%include "libasm.inc"

section .text
  global ft_list_push_front

ft_list_push_front:
  ; ARGUMENTS
  ; RDI = t_list** lst (address of head pointer)
  ; RSI = t_list*  new (new node to add)

  push rbp
  mov rbp, rsp

  test rdi, rdi                  ; if (lst == NULL)
  jz .done

  mov rdx, [rdi]                 ; RDX = *lst (current head pointer)

  test rdx, rdx                  ; if (*lst == NULL)
  jz .update_head                ; don't update new->next if *lst == NULL

  mov [rsi + s_list.next], rdx   ; new->next = *lst

.update_head:
  mov [rdi], rsi                 ; *lst = new (update lst to point to first element of list)

.done:
  mov rsp, rbp
  pop rbp
  ret
