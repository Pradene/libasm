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
    global main
    extern ft_strcpy
    extern ft_strcmp
    extern ft_write

main:
    ; Print test header
    mov rdi, 1
    lea rsi, [rel test_header]  ; Use RIP-relative addressing
    mov rdx, 27
    call ft_write

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
    
    mov rdi, 1
    lea rsi, [rel pass_msg]     ; Use RIP-relative addressing
    mov rdx, 5
    call ft_write
    
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
    
    mov rdi, 1
    lea rsi, [rel fail_msg]     ; Use RIP-relative addressing
    mov rdx, 5
    call ft_write
    
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

test1:
    ; Print test message
    mov rdi, 1
    lea rsi, [rel test1_msg]    ; Use RIP-relative addressing
    mov rdx, 24
    call ft_write
    
    ; Clear destination buffer
    lea rax, [rel dest_buffer1] ; Use RIP-relative addressing
    mov byte [rax], 0
    
    ; Test empty string copy
    lea rdi, [rel dest_buffer1] ; destination - RIP-relative
    lea rsi, [rel empty_src]    ; source - RIP-relative
    call ft_strcpy
    
    ; Check if return value is destination
    lea rdx, [rel dest_buffer1] ; RIP-relative for comparison
    cmp rax, rdx
    jne .fail
    
    ; Check if strings are equal
    lea rdi, [rel dest_buffer1] ; RIP-relative
    lea rsi, [rel empty_src]    ; RIP-relative
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
    mov rdi, 1
    lea rsi, [rel test2_msg]    ; Use RIP-relative addressing
    mov rdx, 24
    call ft_write
    
    ; Clear destination buffer
    mov rcx, 10
    lea rdi, [rel dest_buffer2] ; Use RIP-relative addressing
    mov al, 0xFF
    rep stosb
    
    ; Test short string copy
    lea rdi, [rel dest_buffer2] ; destination - RIP-relative
    lea rsi, [rel short_src]    ; source - RIP-relative
    call ft_strcpy
    
    ; Check if return value is destination
    lea rdx, [rel dest_buffer2] ; RIP-relative for comparison
    cmp rax, rdx
    jne .fail
    
    ; Check if strings are equal
    lea rdi, [rel dest_buffer2] ; RIP-relative
    lea rsi, [rel short_src]    ; RIP-relative
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
    mov rdi, 1
    lea rsi, [rel test3_msg]    ; Use RIP-relative addressing
    mov rdx, 25
    call ft_write
    
    ; Clear destination buffer
    mov rcx, 50
    lea rdi, [rel dest_buffer3] ; Use RIP-relative addressing
    mov al, 0xFF
    rep stosb
    
    ; Test medium string copy
    lea rdi, [rel dest_buffer3] ; destination - RIP-relative
    lea rsi, [rel medium_src]   ; source - RIP-relative
    call ft_strcpy
    
    ; Check if return value is destination
    lea rdx, [rel dest_buffer3] ; RIP-relative for comparison
    cmp rax, rdx
    jne .fail
    
    ; Check if strings are equal
    lea rdi, [rel dest_buffer3] ; RIP-relative
    lea rsi, [rel medium_src]   ; RIP-relative
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
    mov rdi, 1
    lea rsi, [rel test4_msg]    ; Use RIP-relative addressing
    mov rdx, 23
    call ft_write
    
    ; Clear destination buffer
    mov rcx, 100
    lea rdi, [rel dest_buffer4] ; Use RIP-relative addressing
    mov al, 0xFF
    rep stosb
    
    ; Test long string copy
    lea rdi, [rel dest_buffer4] ; destination - RIP-relative
    lea rsi, [rel long_src]     ; source - RIP-relative
    call ft_strcpy
    
    ; Check if return value is destination
    lea rdx, [rel dest_buffer4] ; RIP-relative for comparison
    cmp rax, rdx
    jne .fail
    
    ; Check if strings are equal
    lea rdi, [rel dest_buffer4] ; RIP-relative
    lea rsi, [rel long_src]     ; RIP-relative
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
    mov rdi, 1
    lea rsi, [rel test5_msg]    ; Use RIP-relative addressing
    mov rdx, 39
    call ft_write
    
    ; Clear destination buffer
    mov rcx, 100
    lea rdi, [rel dest_buffer5] ; Use RIP-relative addressing
    mov al, 0xFF
    rep stosb
    
    ; Test string with numbers and symbols
    lea rdi, [rel dest_buffer5] ; destination - RIP-relative
    lea rsi, [rel special_src]  ; source - RIP-relative
    call ft_strcpy
    
    ; Check if return value is destination
    lea rdx, [rel dest_buffer5] ; RIP-relative for comparison
    cmp rax, rdx
    jne .fail
    
    ; Check if strings are equal
    lea rdi, [rel dest_buffer5] ; RIP-relative
    lea rsi, [rel special_src]  ; RIP-relative
    call ft_strcmp
    cmp rax, 0
    je .pass
    
.fail:
    call print_fail
    ret
.pass:
    call print_pass
    ret
