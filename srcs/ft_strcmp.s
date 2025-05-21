section .text
    global ft_strcmp

ft_strcmp:
    ; S1 = RDI
    ; S2 = RSI
    xor rcx, rcx        ; Initialize counter to 0

.loop:
    xor rax, rax        ; Clear rax
    xor rbx, rbx        ; Clear rbx
    mov al, byte [rdi + rcx]  ; Load byte from s1 into al
    mov bl, byte [rsi + rcx]  ; Load byte from s2 into bl
    test al, al           ; Check if we've reached the end of s1
    jz .done
    cmp al, bl          ; Compare the two characters
    jne .done           ; If they differ, we're done
    inc rcx             ; Move to the next character
    jmp .loop

.done:
    sub rax, rbx        ; Calculate the difference
    ret
