%include "libasm.inc"
section .text
  global ft_list_push_front
  extern malloc

ft_list_push_front:
  ; ARGUMENTS
  ; RDI = t_list** lst (address of head pointer)
  ; RSI = void*    data (content to add)
  push rbp
  mov rbp, rsp
  push rdi                       ; save lst pointer
  push rsi                       ; save data pointer
  
  test rdi, rdi                  ; if (lst == NULL)
  jz .done
  
  ; Allocate memory for new node
  mov rdi, 16                    ; sizeof(s_list) = 8 bytes for content + 8 bytes for next
  call malloc wrt ..plt
  test rax, rax                  ; if (malloc failed)
  jz .exit
  
  pop rsi                        ; restore data pointer
  pop rdi                        ; restore lst pointer
  
  ; Set up the new node
  mov [rax + s_list.content], rsi ; new->content = data
  mov rdx, [rdi]                 ; RDX = *lst (current head pointer)
  mov [rax + s_list.next], rdx   ; new->next = *lst
  
  ; Update head pointer
  mov [rdi], rax                 ; *lst = new (update lst to point to new node)
  
  jmp .done

.exit:
  add rsp, 16                    ; clean up stack if we pushed values
.done:
  mov rsp, rbp
  pop rbp
  ret
