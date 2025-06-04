%include "libasm.inc"

section .data
    ; Test strings
    str1            db "first", 0
    str2            db "second", 0  
    str3            db "third", 0
    str4            db "fourth", 0
    str5            db "fifth", 0
    
    ; Expected sorted order strings for comparison
    expected1       db "fifth", 0
    expected2       db "first", 0
    expected3       db "fourth", 0
    expected4       db "second", 0
    expected5       db "third", 0
    
    ; Test result messages
    test_header     db "=== Testing ft_list_sort ===", 10, 0
    test1_desc      db "Test 1 - Sort empty list: ", 0
    test2_desc      db "Test 2 - Sort single element: ", 0
    test3_desc      db "Test 3 - Sort two elements: ", 0
    test4_desc      db "Test 4 - Sort multiple elements: ", 0
    test5_desc      db "Test 5 - Verify final order: ", 0
    pass_msg        db "PASS", 10, 0
    fail_msg        db "FAIL", 10, 0
    newline         db 10, 0

section .bss
    list_head       resq 1          ; Reserve space for list head pointer

section .text
    global main
    extern ft_list_push_front
    extern ft_list_size
    extern ft_list_sort
    extern ft_strcmp

main:
    ; Print test header
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, 30
    syscall
    
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
    mov rdx, 27
    syscall
    
    ; Sort empty list (should not crash)
    lea rdi, [rel list_head]
    lea rsi, [rel ft_strcmp]
    call ft_list_sort
    
    ; Check if list is still empty
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
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test2_desc]
    mov rdx, 30
    syscall
    
    ; Add single element
    lea rdi, [rel list_head]
    lea rsi, [rel str1]
    call ft_list_push_front
    
    ; Sort single element list
    lea rdi, [rel list_head]
    lea rsi, [rel ft_strcmp]
    call ft_list_sort
    
    ; Check if size is still 1
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
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test3_desc]
    mov rdx, 28
    syscall
    
    ; Add second element (str2 = "second")
    lea rdi, [rel list_head]
    lea rsi, [rel str2]
    call ft_list_push_front
    
    ; Sort two element list
    lea rdi, [rel list_head]
    lea rsi, [rel ft_strcmp]
    call ft_list_sort
    
    ; Check if size is still 2
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
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test4_desc]
    mov rdx, 33
    syscall
    
    ; Add remaining elements
    lea rdi, [rel list_head]
    lea rsi, [rel str3]
    call ft_list_push_front
    
    lea rdi, [rel list_head]
    lea rsi, [rel str4]
    call ft_list_push_front
    
    lea rdi, [rel list_head]
    lea rsi, [rel str5]
    call ft_list_push_front
    
    ; Sort the full list
    lea rdi, [rel list_head]
    lea rsi, [rel ft_strcmp]
    call ft_list_sort
    
    ; Check if size is still 5
    mov rdi, [rel list_head]
    call ft_list_size
    cmp rax, 5
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
    mov rdx, 29
    syscall
    
    ; Verify the sorted order: fifth, first, fourth, second, third
    ; Check first element is "fifth"
    mov rdi, [rel list_head]
    test rdi, rdi
    jz .fail
    
    mov rdi, [rdi + s_list.content]
    lea rsi, [rel expected1]        ; "fifth"
    call ft_strcmp
    cmp rax, 0
    jne .fail
    
    ; Check second element is "first"
    mov rdi, [rel list_head]
    mov rdi, [rdi + s_list.next]    ; Move to second node
    test rdi, rdi
    jz .fail
    
    mov rdi, [rdi + s_list.content]
    lea rsi, [rel expected2]        ; "first"
    call ft_strcmp
    cmp rax, 0
    jne .fail
    
    ; If we got here, at least the first two are correct
    call print_pass
    ret
.fail:
    call print_fail
    ret
