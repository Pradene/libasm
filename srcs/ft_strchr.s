section .text
  global ft_strchr

ft_strchr:
  ; ARGUMENTS
  ; RDI = SRC
  ; RSI = CHAR
  
  xor   rcx, rcx

  mov   dl, [rsi]

.loop:
  mov   al, [rdi + rcx]
  test  al, al
  jz    .not_found

  test  al, dl
  jz    .found

  inc   rcx
  jmp   .loop
  
.not_found:
  xor   rax, rax
  ret   ; Return NULL

.found:
  lea   rax, [rdi + rcx]
  ret   ; Return &src[i]
