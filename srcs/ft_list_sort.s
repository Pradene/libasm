%include "libasm.inc"

section .text
  global ft_list_sort

ft_list_sort:
  ; ARGUMENTS
  ; RDI = ft_list **lst (pointer to head pointer)
  ; RSI = comparison function
  push rbp
  mov rbp, rsp
  ; Preserve registers
  push rbx
  push r12
  push r13
  push r14
  push r15
  
  ; Check for null pointers
  test rdi, rdi           ; Check if lst is null
  jz .done
  test rsi, rsi           ; Check if comparison function is null
  jz .done
  mov r12, [rdi]          ; r12 = *lst (head of list)
  test r12, r12           ; Check if list is empty
  jz .done
  mov rbx, rsi            ; Save comparison function
  
.outer_loop:
  mov r13, r12            ; r13 = current node (starts from head)
  xor r15, r15            ; r15 = swapped flag (0 = no swap)
  
.inner_loop:
  test r13, r13
  jz .check_swapped       ; Safely exit if current node is null

  mov r14, [r13 + s_list.next]  ; r14 = next node
  test r14, r14           ; Check if next node exists
  jz .check_swapped       ; If no next node, check if we made any swaps
  
  ; Prepare arguments for comparison function
  ; We only need to preserve rdi and rsi since we're using them
  push rdi                ; Save original rdi
  push rsi                ; Save original rsi
  
  ; Set up function arguments
  mov rdi, [r13 + s_list.content]  ; First argument: current->data
  mov rsi, [r14 + s_list.content]  ; Second argument: next->data
  
  ; Align stack to 16 bytes before call (we pushed 2 * 8 = 16 bytes, so we're aligned)
  call rbx                ; Call comparison function
  
  ; Save result before restoring registers
  mov rcx, rax            ; Save comparison result
  
  ; Restore registers
  pop rsi                 ; Restore original rsi
  pop rdi                 ; Restore original rdi
  
  ; Check comparison result
  test rcx, rcx
  jle .no_swap            ; If result <= 0, no swap needed
  
  ; Swap the data fields
  mov rax, [r13 + s_list.content]
  mov rdx, [r14 + s_list.content]
  mov [r13 + s_list.content], rdx
  mov [r14 + s_list.content], rax
  mov r15, 1              ; Set swapped flag
  
.no_swap:
  mov r13, r14            ; Move to next node
  jmp .inner_loop
  
.check_swapped:
  test r15, r15           ; Check if any swaps were made
  jnz .outer_loop         ; If swaps were made, do another pass
  
.done:
  ; Restore registers
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  mov rsp, rbp
  pop rbp
  ret
