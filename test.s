section .text
    global _start
    extern ft_strcpy
    extern ft_strlen
    extern ft_strdup

_start:
    ; Prepare arguments for ft_strcpy
    lea rdi, [rel dest]   ; dest → RDI
    lea rsi, [rel msg]    ; src  → RSI
    call ft_strcpy

    ; Print original string (msg)
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; fd = stdout
    lea rsi, [rel msg]
    mov rdx, msg_len
    syscall

    ; Call ft_strlen to get length of copied string
    lea rdi, [rel dest]   ; Pass dest as parameter to ft_strlen
    call ft_strlen        ; Call ft_strlen, result will be in RAX
    mov rdx, rax          ; Move length result to RDX for syscall

    ; Print copied string (dest) using length from ft_strlen
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; fd = stdout
    lea rsi, [rel dest]
    ; rdx already contains length from ft_strlen
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
    msg db "Hello from ft_strcpy!", 0xA
    msg_len equ $ - msg

section .bss
    dest resb 64
