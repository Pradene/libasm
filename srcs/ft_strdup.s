section .text
    global ft_strdup
    extern ft_strcpy
    extern ft_strlen
    extern malloc

ft_strdup:
    ; SRC = RDI
    push rdi ; save RDI inside the stack

    ; do not put src inside RDI because already in there
    call ft_strlen

    add rax, 1 ; add one for null terminated character
    mov rdi, rax ; move value inside RDI for malloc
    call malloc

    test rax, rax ; test if malloc returned NULL
    jz .error

    pop rsi ; get back SRC inside RSI 
    mov rdi, rax
    call ft_strcpy

    ; DEST is already inside RAX
    ret

.error:
    pop rdi ; restore stack before returning
    xor rax, rax ; return NULL
    ret

section .data
