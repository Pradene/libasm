section .text
    global ft_strlen

ft_strlen:
  ; SRC = RDI
  ; Return: RAX = length

  xor rcx, rcx ; Reset rcx

.loop:
  mov al, byte [rdi + rcx]
  test al, al
  jz .done

  inc rcx
  jmp .loop

.done:
  mov rax, rcx
  ret
