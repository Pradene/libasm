section .text
  global ft_strchr

ft_strchr:
  ; ARGUMENTS
  ; RDI = SRC (string pointer)
  ; RSI = CHAR (character value as integer)
  push rbp
  mov rbp, rsp

  push rcx

  mov   dl, sil    ; Get character from RSI (lower 8 bits)
  xor   rcx, rcx   ; Index counter

.loop:
  mov   al, [rdi + rcx]  ; Get current character from string
  cmp   al, dl           ; Compare with target character
  je    .found           ; Found it!
  test  al, al           ; Check if end of string
  jz    .check_null      ; End of string reached
  inc   rcx
  jmp   .loop

.check_null:
  test  dl, dl           ; Are we looking for null terminator?
  jz    .found           ; Yes, and we found it
  xor   rax, rax         ; No, return NULL
  jmp   .done

.found:
  lea   rax, [rdi + rcx] ; Return pointer to found character

.done:
  pop rcx
  mov rsp, rbp
  pop rbp
  ret
