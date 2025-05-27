section .data
    ; Test strings
    empty_str       db 0
    short_str       db "Hi", 0
    long_str        db "This is a test string for strdup", 0
    special_str     db "123!@#", 0

    ; Messages
    header_msg      db "=== Testing ft_strdup ===", 10, 0
    header_len      equ ($ - header_msg) - 1
    test1_msg       db "Test 1 - Single char string: ", 0
    test1_len       equ ($ - test1_msg) - 1
    test2_msg       db "Test 2 - Short string: ", 0
    test2_len       equ ($ - test2_msg) - 1
    test3_msg       db "Test 3 - Long string: ", 0
    test3_len       equ ($ - test3_msg) - 1
    test4_msg       db "Test 4 - Special characters: ", 0
    test4_len       equ ($ - test4_msg) - 1
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .bss
    dup_ptr         resq 1      ; To store the duplicated string pointer

section .text
    global main
    extern free
    extern ft_strdup
    extern ft_strcmp

main:
    ; Print header
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel header_msg]
    mov rdx, header_len
    syscall
    
    call test1
    call test2
    call test3
    call test4
    
    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

; Helper function to print PASS
print_pass:
    push rax
    push rdi
    push rsi
    push rdx
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel pass_msg]
    mov rdx, 5
    syscall
    
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

; Helper function to print FAIL
print_fail:
    push rax
    push rdi
    push rsi
    push rdx
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel fail_msg]
    mov rdx, 5
    syscall
    
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

test1:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test1_msg]
    mov rdx, test1_len
    syscall
    
    ; Call ft_strdup
    lea rdi, [rel empty_str]
    call ft_strdup
    
    ; Check if strdup returned NULL
    test rax, rax
    jz .fail
    
    ; Store the duplicated pointer
    lea rbx, [rel dup_ptr]
    mov [rbx], rax
    
    ; Compare original and duplicate
    lea rdi, [rel empty_str]
    mov rsi, rax
    call ft_strcmp
    
    ; ft_strcmp returns 0 if strings are equal
    test rax, rax
    jnz .fail
    
    call print_pass
    ; call free wrt ..plt
    lea rbx, [rel dup_ptr]
    mov rdi, [rbx]
    call free wrt ..plt
    ret
.fail:
    call print_fail
    ret

test2:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test2_msg]
    mov rdx, test2_len
    syscall
    
    ; Call ft_strdup
    lea rdi, [rel short_str]
    call ft_strdup
    
    ; Check if strdup returned NULL
    test rax, rax
    jz .fail
    
    ; Store the duplicated pointer
    lea rbx, [rel dup_ptr]
    mov [rbx], rax
    
    ; Compare original and duplicate
    lea rdi, [rel short_str]
    mov rsi, rax
    call ft_strcmp
    
    ; ft_strcmp returns 0 if strings are equal
    test rax, rax
    jnz .fail
    
    call print_pass
    lea rbx, [rel dup_ptr]
    mov rdi, [rbx]
    call free wrt ..plt
    ret
.fail:
    call print_fail
    ret

test3:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test3_msg]
    mov rdx, test3_len
    syscall
    
    ; Call ft_strdup
    lea rdi, [rel long_str]
    call ft_strdup
    
    ; Check if strdup returned NULL
    test rax, rax
    jz .fail
    
    ; Store the duplicated pointer
    lea rbx, [rel dup_ptr]
    mov [rbx], rax
    
    ; Compare original and duplicate
    lea rdi, [rel long_str]
    mov rsi, rax
    call ft_strcmp
    
    ; ft_strcmp returns 0 if strings are equal
    test rax, rax
    jnz .fail
    
    call print_pass
    lea rbx, [rel dup_ptr]
    mov rdi, [rbx]
    call free wrt ..plt
    ret
.fail:
    call print_fail
    ret

test4:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test4_msg]
    mov rdx, test4_len
    syscall
    
    ; Call ft_strdup  
    lea rdi, [rel special_str]
    call ft_strdup
    
    ; Check if strdup returned NULL
    test rax, rax
    jz .fail
    
    ; Store the duplicated pointer
    lea rbx, [rel dup_ptr]
    mov [rbx], rax
    
    ; Compare original and duplicate
    lea rdi, [rel special_str]
    mov rsi, rax
    call ft_strcmp
    
    ; ft_strcmp returns 0 if strings are equal
    test rax, rax
    jnz .fail
    
    call print_pass
    lea rbx, [rel dup_ptr]
    mov rdi, [rbx]
    call free wrt ..plt
    ret
.fail:
    call print_fail
    ret
