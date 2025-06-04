section .data
    ; Test strings
    str1            db "first", 0
    str2            db "second", 0  
    str3            db "third", 0
    str4            db "fourth", 0
    str5            db "fifth", 0
    
    ; Test result messages
    test_header     db "=== Testing ft_list_size ===", 10, 0
    test1_desc      db "Test 1 - Empty list: ", 0
    test2_desc      db "Test 2 - Single element: ", 0
    test3_desc      db "Test 3 - Two elements: ", 0
    test4_desc      db "Test 4 - Three elements: ", 0
    test5_desc      db "Test 5 - Five elements: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .bss
    list_head       resq 1          ; Reserve space for list head pointer

section .text
    global main
    extern ft_list_push_front
    extern ft_list_size
    extern ft_write

main:
    ; Print test header
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, 30
    call ft_write
    
    ; Initialize list head to NULL
    mov qword [rel list_head], 0
    
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
    lea rsi, [rel pass_msg]
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
    lea rsi, [rel fail_msg]
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
    lea rsi, [rel test1_desc]
    mov rdx, 22
    call ft_write
    
    ; Test empty list (should return 0)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 0
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test2:
    ; Print test message
    mov rdi, 1
    lea rsi, [rel test2_desc]
    mov rdx, 26
    call ft_write
    
    ; Add first element
    lea rdi, [rel list_head]
    lea rsi, [rel str1]
    call ft_list_push_front
    
    ; Test single element list (should return 1)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 1
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test3:
    ; Print test message
    mov rdi, 1
    lea rsi, [rel test3_desc]
    mov rdx, 24
    call ft_write
    
    ; Add second element
    lea rdi, [rel list_head]
    lea rsi, [rel str2]
    call ft_list_push_front
    
    ; Test two element list (should return 2)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 2
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test4:
    ; Print test message
    mov rdi, 1
    lea rsi, [rel test4_desc]
    mov rdx, 26
    call ft_write
    
    ; Add third element
    lea rdi, [rel list_head]
    lea rsi, [rel str3]
    call ft_list_push_front
    
    ; Test three element list (should return 3)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 3
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret

test5:
    ; Print test message
    mov rdi, 1
    lea rsi, [rel test5_desc]
    mov rdx, 25
    call ft_write
    
    ; Add fourth and fifth elements
    lea rdi, [rel list_head]
    lea rsi, [rel str4]
    call ft_list_push_front
    
    lea rdi, [rel list_head]
    lea rsi, [rel str5]
    call ft_list_push_front
    
    ; Test five element list (should return 5)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 5
    je .pass
    call print_fail
    ret
.pass:
    call print_pass
    ret
