section .data
    ; Test strings
    test1_str        db 0
    test1_len        equ ($ - test1_str) - 1     ; Subtract 1 for null terminator
    test2_str        db "Hi", 0
    test2_len        equ ($ - test2_str) - 1     ; Subtract 1 for null terminator
    test3_str        db "Hello World", 0
    test3_len        equ ($ - test3_str) - 1    ; Subtract 1 for null terminator
    test4_str        db "This is a longer test string for strlen", 0
    test4_len        equ ($ - test4_str) - 1      ; Subtract 1 for null terminator
    test5_str        db "Test with numbers 123 and symbols !@#", 0
    test5_len        equ ($ - test5_str) - 1   ; Subtract 1 for null terminator
    
    ; Test result messages
    test_header      db "=== Testing ft_strlen ===", 10, 0
    test1_desc       db "Test 1 - Empty string: ", 0
    test2_desc       db "Test 2 - Short string: ", 0
    test3_desc       db "Test 3 - Medium string: ", 0
    test4_desc       db "Test 4 - Long string: ", 0
    test5_desc       db "Test 5 - String with numbers/symbols: ", 0
    pass_msg         db "PASS", 10, 0
    fail_msg         db "FAIL", 10, 0
    newline          db 10, 0

section .text
    global main
    extern ft_strlen

main:
    ; Print test header
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, 27
    syscall
    
    ; Run all tests
    call test1
    call test2
    call test3
    call test4
    call test5

    ; Exit program
    mov rax, 60
    mov rdi, 0
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
    lea rsi, [rel test1_desc]
    mov rdx, 24
    syscall
    
    ; Test empty string
    lea rdi, [rel test1_str]
    call ft_strlen
    cmp rax, test1_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test2:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test2_desc]
    mov rdx, 24
    syscall
    
    ; Test short string
    lea rdi, [rel test2_str]
    call ft_strlen
    cmp rax, test2_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test3:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test3_desc]
    mov rdx, 25
    syscall
    
    ; Test medium string
    lea rdi, [rel test3_str]
    call ft_strlen
    cmp rax, test3_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test4:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test4_desc]
    mov rdx, 23
    syscall
    
    ; Test long string
    lea rdi, [rel test4_str]
    call ft_strlen
    cmp rax, test4_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test5:
    ; Print test message
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test5_desc]
    mov rdx, 39
    syscall

    ; Test string with numbers and symbols
    lea rdi, [rel test5_str]
    call ft_strlen
    cmp rax, test5_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret
