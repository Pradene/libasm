section .text
    global ft_strlen

ft_strlen:
  ; SRC = RDI
  ; Return: RAX = length

  push rbp
  mov rbp, rsp

  push rcx
  xor rcx, rcx ; Reset rcx

.loop:
  mov al, byte [rdi + rcx]
  test al, al
  jz .done

  inc rcx
  jmp .loop

.done:
  mov rax, rcx
  pop rcx
  mov rsp, rbp
  pop rbp
  ret
