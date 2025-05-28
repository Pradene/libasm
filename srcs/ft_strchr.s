section .text
  global ft_strchr

ft_strchr:
  ; ARGUMENTS
  ; RDI = SRC
  ; RSI = CHAR

  push rbp
  mov rbp, rsp

  mov   dl, [rsi]

  xor   rcx, rcx

.loop:
  mov   al, [rdi + rcx]
  test  al, dl
  je    .found

  test  al, al
  jz    .not_found

  inc   rcx
  jmp   .loop
  
.not_found:
  test dl, dl
  jz .found
  xor   rax, rax
  ret   ; Return NULL

.found:
  lea   rax, [rdi + rcx]
  pop rcx
  mov rsp, rbp
  pop rbp
  ret   ; Return &src[i]
