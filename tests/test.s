section .data
    ; Test strings
    empty_str       db 0
    short_str       db "Hi", 0
    medium_str      db "Hello World", 0
    long_str        db "This is a longer test string for strlen", 0
    
    ; Test result messages
    test_msg        db "Testing ft_strlen:", 10, 0
    empty_msg       db "Empty string test: ", 0
    short_msg       db "Short string test: ", 0
    medium_msg      db "Medium string test: ", 0
    long_msg        db "Long string test: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0
    
    ; Expected results
    empty_expected  equ 0
    short_expected  equ 2
    medium_expected equ 11
    long_expected   equ 39

section .bss
    result_buffer   resb 16

section .text
    global _start
    extern ft_strlen

_start:
    ; Print test header
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, test_msg
    mov rdx, 19             ; length of test_msg
    syscall

    ; Test 1: Empty string
    mov rax, 1
    mov rdi, 1
    mov rsi, empty_msg
    mov rdx, 20
    syscall
    
    mov rdi, empty_str
    call ft_strlen
    cmp rax, empty_expected
    je test1_pass
    
    mov rax, 1
    mov rdi, 1
    mov rsi, fail_msg
    mov rdx, 5
    syscall
    jmp test2
    
test1_pass:
    mov rax, 1
    mov rdi, 1
    mov rsi, pass_msg
    mov rdx, 5
    syscall

test2:
    ; Test 2: Short string
    mov rax, 1
    mov rdi, 1
    mov rsi, short_msg
    mov rdx, 20
    syscall
    
    mov rdi, short_str
    call ft_strlen
    cmp rax, short_expected
    je test2_pass
    
    mov rax, 1
    mov rdi, 1
    mov rsi, fail_msg
    mov rdx, 5
    syscall
    jmp test3
    
test2_pass:
    mov rax, 1
    mov rdi, 1
    mov rsi, pass_msg
    mov rdx, 5
    syscall

test3:
    ; Test 3: Medium string
    mov rax, 1
    mov rdi, 1
    mov rsi, medium_msg
    mov rdx, 21
    syscall
    
    mov rdi, medium_str
    call ft_strlen
    cmp rax, medium_expected
    je test3_pass
    
    mov rax, 1
    mov rdi, 1
    mov rsi, fail_msg
    mov rdx, 5
    syscall
    jmp test4
    
test3_pass:
    mov rax, 1
    mov rdi, 1
    mov rsi, pass_msg
    mov rdx, 5
    syscall

test4:
    ; Test 4: Long string
    mov rax, 1
    mov rdi, 1
    mov rsi, long_msg
    mov rdx, 19
    syscall
    
    mov rdi, long_str
    call ft_strlen
    cmp rax, long_expected
    je test4_pass
    
    mov rax, 1
    mov rdi, 1
    mov rsi, fail_msg
    mov rdx, 5
    syscall
    jmp exit
    
test4_pass:
    mov rax, 1
    mov rdi, 1
    mov rsi, pass_msg
    mov rdx, 5
    syscall

exit:
    ; Print final newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
    ; Exit program
    mov rax, 60             ; sys_exit
    mov rdi, 0              ; exit status
    syscall
