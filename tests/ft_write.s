section .data
    test_header     db "=== Testing ft_write ===", 10, 0
    test_header_len equ $ - test_header - 1

    testfile        db "testfile.txt", 0
    test_content    db "Test content for ft_write", 0
    content_len     equ $ - test_content - 1
    buffer          times 50 db 0

    valid_fd        dq 0
    invalid_fd      dq -1

    pass_msg        db "PASS", 10, 0
    pass_len        equ $ - pass_msg - 1
    fail_msg        db "FAIL", 10, 0
    fail_len        equ $ - fail_msg - 1

    write_ok_desc   db "Test 1 - Valid write : ", 0
    write_ok_len    equ $ - write_ok_desc - 1
    write_err_desc  db "Test 2 - Invalid fd: ", 0
    write_err_len   equ $ - write_err_desc - 1

    EBADF           equ 9
    O_RDWR          equ 02o
    O_CREAT         equ 0100o
    S_IRWXU         equ 0700o

section .text
    global main
    extern ft_write
    extern __errno_location

main:
    ; Print header
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, test_header_len
    syscall

    ; Create test file
    mov rax, 2
    lea rdi, [rel testfile]
    mov rsi, O_CREAT | O_RDWR
    mov rdx, S_IRWXU
    syscall
    mov [rel valid_fd], rax

    call test_write_ok
    call test_write_err

    ; Cleanup
    mov rax, 3
    mov rdi, [rel valid_fd]
    syscall

    mov rax, 87
    lea rdi, [rel testfile]
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

; Helper functions
print_pass:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel pass_msg]
    mov rdx, pass_len
    syscall
    ret

print_fail:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel fail_msg]
    mov rdx, fail_len
    syscall
    ret

reset_errno:
    call __errno_location wrt ..plt
    mov dword [rax], 0
    ret

; Test cases
test_write_ok:
    ; Print description
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel write_ok_desc]
    mov rdx, write_ok_len
    syscall

    ; Write to file using ft_write
    mov rdi, [rel valid_fd]
    lea rsi, [rel test_content]
    mov rdx, content_len
    call ft_write

    ; Validate return value
    cmp rax, content_len
    jne .fail

    ; Reset file position to beginning
    mov rax, 8      ; lseek syscall
    mov rdi, [rel valid_fd]
    xor rsi, rsi    ; Offset 0
    xor rdx, rdx    ; SEEK_SET
    syscall

    ; Read back what was written
    mov rax, 0      ; read syscall
    mov rdi, [rel valid_fd]
    lea rsi, [rel buffer]
    mov rdx, 50
    syscall

    ; Validate content
    lea rdi, [rel buffer]
    lea rsi, [rel test_content]
    mov rcx, content_len
    repe cmpsb
    jne .fail

    call print_pass
    ret
.fail:
    call print_fail
    ret

test_write_err:
    ; Print description
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel write_err_desc]
    mov rdx, write_err_len
    syscall

    call reset_errno

    ; Attempt write to invalid fd
    mov rdi, [rel invalid_fd]
    lea rsi, [rel test_content]
    mov rdx, content_len
    call ft_write

    ; Validate return value
    cmp rax, -1
    jne .fail

    ; Validate errno
    call __errno_location wrt ..plt
    mov eax, [rax]
    cmp eax, EBADF
    jne .fail

    call print_pass
    ret
.fail:
    call print_fail
    ret
