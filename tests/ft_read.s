section .data
    test_header     db "=== Testing ft_read ===", 10, 0
    test_header_len equ $ - test_header - 1

    testfile        db "testfile.txt", 0
    file_content    db "Test content for ft_read", 0
    content_len     equ $ - file_content - 1
    buffer          times 50 db 0

    valid_fd        dq 0
    invalid_fd      dq -1

    pass_msg        db "PASS", 10, 0
    pass_len        equ $ - pass_msg - 1
    fail_msg        db "FAIL", 10, 0
    fail_len        equ $ - fail_msg - 1

    read_ok_desc    db "Test 1 - Valid read: ", 0
    read_ok_len     equ $ - read_ok_desc - 1
    read_err_desc   db "Test 2 - Invalid fd: ", 0
    read_err_len    equ $ - read_err_desc - 1

    EBADF           equ 9
    O_RDONLY        equ 0

section .text
    global main
    extern ft_read
    extern ft_write
    extern __errno_location

main:
    ; Print header
    mov rdi, 1
    lea rsi, [rel test_header]
    mov rdx, test_header_len
    call ft_write

    ; Create test file
    mov rax, 2
    lea rdi, [rel testfile]
    mov rsi, 0102o  ; O_CREAT|O_RDWR
    mov rdx, 0666o
    syscall
    mov [rel valid_fd], rax

    ; Write to test file
    mov rdi, rax
    lea rsi, [rel file_content]
    mov rdx, content_len
    call ft_write

    ; Close file
    mov rax, 3
    mov rdi, [rel valid_fd]
    syscall

    ; Reopen for reading
    mov rax, 2
    lea rdi, [rel testfile]
    mov rsi, O_RDONLY
    xor rdx, rdx
    syscall
    mov [rel valid_fd], rax

    call test_read_ok
    call test_read_err

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

reset_errno:
    call __errno_location wrt ..plt
    mov dword [rax], 0
    ret

; Test cases
test_read_ok:
    ; Print description
    mov rdi, 1
    lea rsi, [rel read_ok_desc]
    mov rdx, read_ok_len
    call ft_write

    ; Read from file using ft_read
    mov rdi, [rel valid_fd]
    lea rsi, [rel buffer]
    mov rdx, 50
    call ft_read

    ; Validate return value
    cmp rax, content_len
    jne .fail

    ; Validate content
    lea rdi, [rel buffer]
    lea rsi, [rel file_content]
    mov rcx, content_len
    repe cmpsb
    jne .fail

    call print_pass
    ret
.fail:
    call print_fail
    ret

test_read_err:
    ; Print description
    mov rdi, 1
    lea rsi, [rel read_err_desc]
    mov rdx, read_err_len
    call ft_write

    call reset_errno

    ; Attempt read from invalid fd
    mov rdi, [rel invalid_fd]
    lea rsi, [rel buffer]
    mov rdx, 50
    call ft_read

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
