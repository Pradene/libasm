section .data
    ; Test strings
    empty_str       db 0
    empty_len       equ ($ - empty_str) - 1     ; Subtract 1 for null terminator
    short_str       db "Hi", 0
    short_len       equ ($ - short_str) - 1     ; Subtract 1 for null terminator
    medium_str      db "Hello World", 0
    medium_len      equ ($ - medium_str) - 1    ; Subtract 1 for null terminator
    long_str        db "This is a longer test string for strlen", 0
    long_len        equ ($ - long_str) - 1      ; Subtract 1 for null terminator
    special_str     db "Test with numbers 123 and symbols !@#", 0
    special_len     equ ($ - special_str) - 1   ; Subtract 1 for null terminator
    
    ; Test result messages
    test_header     db "=== Testing ft_strlen ===", 10, 0
    test1_msg       db "Test 1 - Empty string: ", 0
    test2_msg       db "Test 2 - Short string: ", 0
    test3_msg       db "Test 3 - Medium string: ", 0
    test4_msg       db "Test 4 - Long string: ", 0
    test5_msg       db "Test 5 - String with numbers/symbols: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .text
    global _start
    extern ft_strlen

_start:
    ; Print test header
    mov rax, 1
    mov rdi, 1
    mov rsi, test_header
    mov rdx, 27
    syscall
    
    ; Run all tests
    call test1
    call test2
    call test3
    call test4
    call test5
    
    ; Print final newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
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
    mov rsi, pass_msg
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
    mov rsi, fail_msg
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
    mov rsi, test1_msg
    mov rdx, 24
    syscall
    
    ; Test empty string
    mov rdi, empty_str
    call ft_strlen
    cmp rax, empty_len
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
    mov rsi, test2_msg
    mov rdx, 24
    syscall
    
    ; Test short string
    mov rdi, short_str
    call ft_strlen
    cmp rax, short_len
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
    mov rsi, test3_msg
    mov rdx, 25
    syscall
    
    ; Test medium string
    mov rdi, medium_str
    call ft_strlen
    cmp rax, medium_len
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
    mov rsi, test4_msg
    mov rdx, 23
    syscall
    
    ; Test long string
    mov rdi, long_str
    call ft_strlen
    cmp rax, long_len
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
    mov rsi, test5_msg
    mov rdx, 39
    syscall
    
    ; Test string with numbers and symbols
    mov rdi, special_str
    call ft_strlen
    cmp rax, special_len
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret
