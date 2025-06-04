section .data
    ; Test header
    test_header     db "=== Testing ft_atoi_base ===", 10, 0
    test_header_len equ $ - test_header - 1  ; Subtract null terminator

    ; Test cases
    test1_str       db "1010", 0
    test1_base      db "01", 0
    test1_expected  dq 10
    test1_desc      db "Test 1 - '1010' in base '01': ", 0
    test1_desc_len  equ $ - test1_desc - 1

    test2_str       db "7F", 0
    test2_base      db "0123456789ABCDEF", 0
    test2_expected  dq 127
    test2_desc      db "Test 2 - '7F' in base '0123456789ABCDEF': ", 0
    test2_desc_len  equ $ - test2_desc - 1

    test3_str       db "-10", 0
    test3_base      db "01", 0
    test3_expected  dq -2
    test3_desc      db "Test 3 - '-10' in base '01': ", 0
    test3_desc_len  equ $ - test3_desc - 1

    test4_str       db "   +42", 0
    test4_base      db "0123456789", 0
    test4_expected  dq 42
    test4_desc      db "Test 4 - '   +42' in base '0123456789': ", 0
    test4_desc_len  equ $ - test4_desc - 1

    test5_str       db "   -42", 0
    test5_base      db "0123456789", 0
    test5_expected  dq -42
    test5_desc      db "Test 5 - '   -42' in base '0123456789': ", 0
    test5_desc_len  equ $ - test5_desc - 1

    test6_str       db "0", 0
    test6_base      db "0123456789", 0
    test6_expected  dq 0
    test6_desc      db "Test 6 - '0' in base '0123456789': ", 0
    test6_desc_len  equ $ - test6_desc - 1

    test7_str       db "invalid", 0
    test7_base      db "01", 0
    test7_expected  dq 0
    test7_desc      db "Test 7 - 'invalid' in base '01': ", 0
    test7_desc_len  equ $ - test7_desc - 1

    test8_str       db "123", 0
    test8_base      db "0", 0
    test8_expected  dq 0
    test8_desc      db "Test 8 - base '0' (invalid): ", 0
    test8_desc_len  equ $ - test8_desc - 1

    test9_str       db "1010", 0
    test9_base      db "011", 0
    test9_expected  dq 0
    test9_desc      db "Test 9 - base with duplicates: ", 0
    test9_desc_len  equ $ - test9_desc - 1

    ; Messages
    pass_msg        db "PASS", 10, 0
    pass_len        equ $ - pass_msg - 1
    fail_msg        db "FAIL", 10, 0
    fail_len        equ $ - fail_msg - 1

section .text
    global main
    extern ft_atoi_base
    extern ft_write

main:
    ; Print header
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, test_header_len
    call ft_write

    ; Run tests
    call test1
    call test2
    call test3
    call test4
    call test5
    call test6
    call test7
    call test8
    call test9

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall

; Helper functions
print_pass:
    mov rdi, 1
    lea rsi, [rel pass_msg]
    mov rdx, pass_len
    call ft_write
    ret

print_fail:
    mov rdi, 1
    lea rsi, [rel fail_msg]
    mov rdx, fail_len
    call ft_write
    ret

; Test functions
test1:
    ; Print test description
    mov rdi, 1
    lea rsi, [rel test1_desc]
    mov rdx, test1_desc_len
    call ft_write

    ; Run test
    lea rdi, [rel test1_str]
    lea rsi, [rel test1_base]
    call ft_atoi_base

    ; Check result
    cmp rax, [rel test1_expected]
    je .pass
    jmp .fail

.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test2:
    mov rdi, 1
    lea rsi, [rel test2_desc]
    mov rdx, test2_desc_len
    call ft_write

    lea rdi, [rel test2_str]
    lea rsi, [rel test2_base]
    call ft_atoi_base

    cmp rax, [rel test2_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test3:
    mov rdi, 1
    lea rsi, [rel test3_desc]
    mov rdx, test3_desc_len
    call ft_write

    lea rdi, [rel test3_str]
    lea rsi, [rel test3_base]
    call ft_atoi_base

    cmp rax, [rel test3_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test4:
    mov rdi, 1
    lea rsi, [rel test4_desc]
    mov rdx, test4_desc_len
    call ft_write

    lea rdi, [rel test4_str]
    lea rsi, [rel test4_base]
    call ft_atoi_base

    cmp rax, [rel test4_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test5:
    mov rdi, 1
    lea rsi, [rel test5_desc]
    mov rdx, test5_desc_len
    call ft_write

    lea rdi, [rel test5_str]
    lea rsi, [rel test5_base]
    call ft_atoi_base

    cmp rax, [rel test5_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test6:
    mov rdi, 1
    lea rsi, [rel test6_desc]
    mov rdx, test6_desc_len
    call ft_write

    lea rdi, [rel test6_str]
    lea rsi, [rel test6_base]
    call ft_atoi_base

    cmp rax, [rel test6_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test7:
    mov rdi, 1
    lea rsi, [rel test7_desc]
    mov rdx, test7_desc_len
    call ft_write

    lea rdi, [rel test7_str]
    lea rsi, [rel test7_base]
    call ft_atoi_base

    cmp rax, [rel test7_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test8:
    mov rdi, 1
    lea rsi, [rel test8_desc]
    mov rdx, test8_desc_len
    call ft_write

    lea rdi, [rel test8_str]
    lea rsi, [rel test8_base]
    call ft_atoi_base

    cmp rax, [rel test8_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret

test9:
    mov rdi, 1
    lea rsi, [rel test9_desc]
    mov rdx, test9_desc_len
    call ft_write

    lea rdi, [rel test9_str]
    lea rsi, [rel test9_base]
    call ft_atoi_base

    cmp rax, [rel test9_expected]
    je .pass
    jmp .fail
.pass:
    call print_pass
    ret
.fail:
    call print_fail
    ret
