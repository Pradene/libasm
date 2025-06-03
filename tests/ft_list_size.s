%include "libasm.inc"

section .data
    ; Test strings
    str1 db "first", 0
    str2 db "second", 0  
    str3 db "third", 0
    str4 db "fourth", 0
    str5 db "fifth", 0
    
    ; Test messages
    test_header db "=== Testing ft_list_size ===", 0
    empty_msg db "Empty list size: %d", 10, 0
    size_msg db "List size after adding element: %d", 10, 0
    final_msg db "Final list size: %d", 10, 0
    element_added db "Added: %s", 10, 0
    separator db "---", 0

section .bss
    list_head resq 1               ; Reserve space for list head pointer

section .text
    global main
    extern ft_list_push_front
    extern ft_list_print
    extern ft_list_size
    extern puts
    extern printf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16                    ; Align stack to 16-byte boundary
    
    ; Print test header
    lea rdi, [rel test_header]
    call puts wrt ..plt
    
    ; Initialize list head to NULL
    mov qword [rel list_head], 0
    
    ; Test 1: Empty list size
    mov rdi, [rel list_head]       ; pass head pointer value
    call ft_list_size
    
    lea rdi, [rel empty_msg]       ; printf format string
    mov rsi, rax                   ; size should be 0
    call printf wrt ..plt
    
    lea rdi, [rel separator]
    call puts wrt ..plt
    
    ; Test 2: Add elements one by one and check size
    
    ; Add first element
    lea rdi, [rel list_head]
    lea rsi, [rel str1]            ; "first"
    call ft_list_push_front
    
    lea rdi, [rel element_added]
    lea rsi, [rel str1]
    call printf wrt ..plt
    
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel size_msg]
    mov rsi, rax                   ; should be 1
    call printf wrt ..plt
    
    ; Add second element
    lea rdi, [rel list_head]
    lea rsi, [rel str2]            ; "second"
    call ft_list_push_front
    
    lea rdi, [rel element_added]
    lea rsi, [rel str2]
    call printf wrt ..plt
    
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel size_msg]
    mov rsi, rax                   ; should be 2
    call printf wrt ..plt
    
    ; Add third element
    lea rdi, [rel list_head]
    lea rsi, [rel str3]            ; "third"
    call ft_list_push_front
    
    lea rdi, [rel element_added]
    lea rsi, [rel str3]
    call printf wrt ..plt
    
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel size_msg]
    mov rsi, rax                   ; should be 3
    call printf wrt ..plt
    
    ; Add fourth element
    lea rdi, [rel list_head]
    lea rsi, [rel str4]            ; "fourth"
    call ft_list_push_front
    
    lea rdi, [rel element_added]
    lea rsi, [rel str4]
    call printf wrt ..plt
    
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel size_msg]
    mov rsi, rax                   ; should be 4
    call printf wrt ..plt
    
    ; Add fifth element
    lea rdi, [rel list_head]
    lea rsi, [rel str5]            ; "fifth"
    call ft_list_push_front
    
    lea rdi, [rel element_added]
    lea rsi, [rel str5]
    call printf wrt ..plt
    
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel size_msg]
    mov rsi, rax                   ; should be 5
    call printf wrt ..plt
    
    lea rdi, [rel separator]
    call puts wrt ..plt
    
    ; Test 3: Show final list and confirm size
    mov rdi, [rel list_head]
    call ft_list_size
    
    lea rdi, [rel final_msg]
    mov rsi, rax
    call printf wrt ..plt
    
    ; Show the actual list
    mov rdi, [rel list_head]
    call ft_list_print
    
    ; Clean exit
    mov rsp, rbp
    pop rbp
    
    mov rax, 60                    ; sys_exit
    xor rdi, rdi                   ; exit status 0
    syscall
