%include "libasm.inc"

section .data
    ; Test strings
    str1            db "First", 0
    str2            db "Second", 0  
    str3            db "Third", 0
    str4            db "Fourth", 0
    
    ; Test result messages
    test_header     db "=== Testing ft_list_push_front ===", 10, 0
    test1_desc      db "Test 1 - Push to empty list: ", 0
    test2_desc      db "Test 2 - Push second element: ", 0
    test3_desc      db "Test 3 - Push third element: ", 0
    test4_desc      db "Test 4 - Push fourth element: ", 0
    test5_desc      db "Test 5 - Final list order: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .bss
    list_head       resq 1          ; Reserve space for list head pointer

section .text
    global main
    extern ft_list_push_front
    extern ft_list_size
    extern ft_strcmp
    extern ft_write

main:
    ; Print test header
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, 36
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
    mov rdx, 30
    call ft_write
    
    ; Push "Fourth" to empty list
    lea rdi, [rel list_head]
    lea rsi, [rel str4]
    call ft_list_push_front
    
    ; Check if list is no longer empty (size should be 1)
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 1
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
    mov rdx, 30
    call ft_write
    
    ; Push "Third"
    lea rdi, [rel list_head]
    lea rsi, [rel str3]
    call ft_list_push_front
    
    ; Check if size is now 2
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 2
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
    mov rdx, 29
    call ft_write
    
    ; Push "Second"
    lea rdi, [rel list_head]
    lea rsi, [rel str2]
    call ft_list_push_front
    
    ; Check if size is now 3
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 3
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
    mov rdx, 30
    call ft_write
    
    ; Push "First" (will be at front)
    lea rdi, [rel list_head]
    lea rsi, [rel str1]
    call ft_list_push_front
    
    ; Check if size is now 4
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 4
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
    mov rdx, 28
    call ft_write
    
    ; Verify the list head contains the last pushed element ("First")
    ; This tests that push_front actually puts new elements at the front
    mov rdi, [rel list_head]
    test rdi, rdi                   ; Check if head is not NULL
    jz .fail
    
    ; Get the content pointer from the first node
    mov rdi, [rdi + s_list.content] ; rdi = head->content
    lea rsi, [rel str1]             ; rsi = "First"
    call ft_strcmp
    cmp rax, 0
    je .pass
.fail:
    call print_fail
    ret
.pass:
    call print_pass
    ret
