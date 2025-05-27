section .text
    global ft_strdup
    extern ft_strcpy
    extern ft_strlen
    extern malloc

ft_strdup:
    ; src = rdi
    push rdi ; save rdi inside the stack

    ; do not put src inside rdi because already in there
    call ft_strlen

    inc rax ; add one for null terminated character
    mov rdi, rax ; move value inside rdi for malloc
    call malloc wrt ..plt

    test rax, rax ; test if malloc returned null
    jz .error

    mov rdi, rax
    pop rsi ; get back src inside rsi 
    call ft_strcpy

    ; dest is already inside rax
    ret

.error:
    pop rdi ; restore stack before returning
    xor rax, rax ; return null
    ret
