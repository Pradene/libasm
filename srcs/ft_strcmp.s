section .text
  global ft_strcmp
ft_strcmp:
  ; S1 = RDI
  ; S2 = RSI
  xor rcx, rcx        ; Initialize counter to 0
.loop:
  xor rax, rax        ; Clear rax
  xor rdx, rdx        ; Clear rdx
  mov al, byte [rdi + rcx]  ; Load byte from s1 into al
  mov dl, byte [rsi + rcx]  ; Load byte from s2 into dl
  
  ; Check if both strings have reached their end
  test al, al         ; Check if s1 has reached null terminator
  jz .s1_end
  test dl, dl         ; Check if s2 has reached null terminator  
  jz .s2_end
  
  cmp al, dl          ; Compare the two characters
  jne .done           ; If they differ, we're done
  inc rcx             ; Move to the next character
  jmp .loop

.s1_end:
  ; s1 has ended, check if s2 has also ended
  test dl, dl         ; Check if s2 has also reached null terminator
  jz .done            ; Both ended at same time, al=dl=0, difference is 0
  ; s1 ended but s2 continues, so s1 < s2
  ; al = 0, dl = some character, so 0 - dl = negative
  jmp .done

.s2_end:
  ; s2 has ended but s1 continues, so s1 > s2  
  ; al = some character, dl = 0, so al - 0 = positive
  jmp .done

.done:
  sub rax, rdx        ; Calculate the difference (al - dl)
  ret
