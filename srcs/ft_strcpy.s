section .text
    global ft_strcpy

ft_strcpy:
    ; RDI = DEST
    ; RSI = SRC
    ; Return: RAX = DEST (pointer to destination string)
    push rdi        ; save DEST so we can return it
    xor rcx, rcx    ; initialize counter to 0

.loop:
    mov al, byte [rsi + rcx]   ; load byte from source
    test al, al                ; check if we reached null terminator
    jz .done                   ; if zero, we're done
    mov byte [rdi + rcx], al   ; store byte to destination
    inc rcx                    ; increment counter
    jmp .loop                  ; continue loop

.done:
    mov byte [rdi + rcx], 0    ; ensure null terminator is written
    pop rax                    ; load original DEST into RAX for return value
    ret
