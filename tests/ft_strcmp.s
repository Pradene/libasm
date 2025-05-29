section .data
    ; Test strings for strcmp
    str1_empty      db 0
    str2_empty      db 0
    
    str1_equal      db "Hello", 0
    str2_equal      db "Hello", 0
    
    str1_less       db "Apple", 0
    str2_less       db "Apples", 0
    
    str1_greater    db "Banano", 0
    str2_greater    db "Banana", 0
    
    str1_case       db "cat", 0
    str2_case       db "Cat", 0

    ; Messages
    header_msg      db "=== Testing ft_strcmp ===", 10, 0
    header_len      equ $ - header_msg - 1
    test1_msg       db "Test 1 - Empty strings: ", 0
    test1_len       equ $ - test1_msg - 1
    test2_msg       db "Test 2 - Equal strings: ", 0
    test2_len       equ $ - test2_msg - 1
    test3_msg       db "Test 3 - First string shorter: ", 0
    test3_len       equ $ - test3_msg - 1
    test4_msg       db "Test 4 - First string greater: ", 0
    test4_len       equ $ - test4_msg - 1
    test5_msg       db "Test 5 - Case sensitivity: ", 0
    test5_len       equ $ - test5_msg - 1
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .text
    global main
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
    call test5

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

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
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test1_msg]
    mov rdx, test1_len
    syscall

    lea rdi, [rel str1_empty]
    lea rsi, [rel str2_empty]
    call ft_strcmp
    test rax, rax
    jz .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test2:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test2_msg]
    mov rdx, test2_len
    syscall

    lea rdi, [rel str1_equal]
    lea rsi, [rel str2_equal]
    call ft_strcmp
    test rax, rax
    jz .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test3:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test3_msg]
    mov rdx, test3_len
    syscall

    lea rdi, [rel str1_less]
    lea rsi, [rel str2_less]
    call ft_strcmp
    test rax, rax
    js .pass       ; Check if result is negative
    call print_fail
    ret
.pass:
    call print_pass
    ret

test4:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test4_msg]
    mov rdx, test4_len
    syscall

    lea rdi, [rel str1_greater]
    lea rsi, [rel str2_greater]
    call ft_strcmp
    test rax, rax
    jg .pass      ; Check if result is positive
    call print_fail
    ret
.pass:
    call print_pass
    ret

test5:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test5_msg]
    mov rdx, test5_len
    syscall

    lea rdi, [rel str1_case]
    lea rsi, [rel str2_case]
    call ft_strcmp
    test rax, rax
    jg .pass       ; Check if result is positive
    call print_fail
    ret
.pass:
    call print_pass
    ret
