section .data
    ; Source strings for testing
    empty_src       db 0
    short_src       db "Hi", 0 
    medium_src      db "Hello World", 0
    long_src        db "This is a longer test string for strcpy", 0
    special_src     db "Test with numbers 123 and symbols !@#", 0
    
    ; Test result messages
    test_header     db "=== Testing ft_strcpy ===", 10, 0
    test1_msg       db "Test 1 - Empty string: ", 0
    test2_msg       db "Test 2 - Short string: ", 0
    test3_msg       db "Test 3 - Medium string: ", 0
    test4_msg       db "Test 4 - Long string: ", 0
    test5_msg       db "Test 5 - String with numbers/symbols: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .bss
    ; Destination buffers for copying (allocate enough space)
    dest_buffer1    resb 1
    dest_buffer2    resb 10
    dest_buffer3    resb 50
    dest_buffer4    resb 100
    dest_buffer5    resb 100

section .text
    global _start
    extern ft_strcpy
    extern ft_strcmp

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
    
    ; Clear destination buffer
    mov byte [dest_buffer1], 0xFF
    
    ; Test empty string copy
    mov rdi, dest_buffer1   ; destination
    mov rsi, empty_src      ; source
    call ft_strcpy
    
    ; Check if return value is destination
    cmp rax, dest_buffer1
    jne .fail
    
    ; Check if strings are equal
    mov rdi, dest_buffer1
    mov rsi, empty_src
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
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
    
    ; Clear destination buffer
    mov rcx, 10
    mov rdi, dest_buffer2
    mov al, 0xFF
    rep stosb
    
    ; Test short string copy
    mov rdi, dest_buffer2   ; destination
    mov rsi, short_src      ; source
    call ft_strcpy
    
    ; Check if return value is destination
    cmp rax, dest_buffer2
    jne .fail
    
    ; Check if strings are equal
    mov rdi, dest_buffer2
    mov rsi, short_src
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
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
    
    ; Clear destination buffer
    mov rcx, 50
    mov rdi, dest_buffer3
    mov al, 0xFF
    rep stosb
    
    ; Test medium string copy
    mov rdi, dest_buffer3   ; destination
    mov rsi, medium_src     ; source
    call ft_strcpy
    
    ; Check if return value is destination
    cmp rax, dest_buffer3
    jne .fail
    
    ; Check if strings are equal
    mov rdi, dest_buffer3
    mov rsi, medium_src
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
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
    
    ; Clear destination buffer
    mov rcx, 100
    mov rdi, dest_buffer4
    mov al, 0xFF
    rep stosb
    
    ; Test long string copy
    mov rdi, dest_buffer4   ; destination
    mov rsi, long_src       ; source
    call ft_strcpy
    
    ; Check if return value is destination
    cmp rax, dest_buffer4
    jne .fail
    
    ; Check if strings are equal
    mov rdi, dest_buffer4
    mov rsi, long_src
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
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
    
    ; Clear destination buffer
    mov rcx, 100
    mov rdi, dest_buffer5
    mov al, 0xFF
    rep stosb
    
    ; Test string with numbers and symbols
    mov rdi, dest_buffer5   ; destination
    mov rsi, special_src    ; source
    call ft_strcpy
    
    ; Check if return value is destination
    cmp rax, dest_buffer5
    jne .fail
    
    ; Check if strings are equal
    mov rdi, dest_buffer5
    mov rsi, special_src
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
    call print_fail
    ret
.pass:
    call print_pass
    ret
