section .text
  global ft_atoi_base
  extern ft_strlen
  extern ft_strchr

is_base_valid:
  ; ARGUMENTS
  ; RDI = SRC

  ; RETURN RAX (boolean)
  ; true = valid

  push rbp        ; Save caller's base pointer
  mov rbp, rsp    ; Set up our base pointer

  push rbx
  mov rbx, rdi

  sub rsp, 256    ; Allocate 256 bytes on stack
  ; Clear the array
  mov rdi, rsp    ; Array starts at current stack pointer
  mov rcx, 256    ; Clear 256 bytes
  xor al, al      ; Value to store (0)
  rep stosb

  mov rdi, rbx
  xor rcx, rcx

.loop:
  ; Duplicate checking logic
  ; Access character 'A' (ASCII 65): [rbp - 256 + 65]

  ; Check null terminated character
  mov al, [rdi + rcx]
  test al, al
  jz .check_invalid_character

  ; Check if we already see the character
  movzx rax, al
  cmp byte [rbp - 256 + rax], 1
  je .ko
  mov byte [rbp - 256 + rax], 1

  inc rcx
  jmp .loop

.check_invalid_character:
  cmp byte [rbp - 256 + 32], 1 ; 32 == SPACE
  je .ko
  cmp byte [rbp - 256 + 43], 1 ; 43 == '+'
  je .ko
  cmp byte [rbp - 256 + 45], 1 ; 45 == '-'
  je .ko

  jmp .ok

.ok:
  mov rax, 1
  jmp .done

.ko:
  mov rax, 0
  jmp .done

.done:
  add rsp, 256
  pop rbx
  mov rsp, rbp    ; Restore stack pointer
  pop rbp         ; Restore caller's base pointer
  ret



ft_atoi_base:
  ; ARGUMENTS
  ; RDI = SRC
  ; RSI = BASE

  ; [rbp - 8]  = input
  ; [rbp - 16] = base
  ; [rbp - 24] = base length
  ; [rbp - 32] = sign
  ; [rbp - 40] = result
  ; [rbp - 48] = current character value

  push rbp
  mov rbp, rsp
  sub rsp, 48

  ; Check for null pointers
  test rdi, rdi
  jz .done
  test rsi, rsi
  jz .done

  mov [rbp - 8], rdi
  mov [rbp - 16], rsi

  mov rdi, [rbp - 16]
  call ft_strlen
  mov [rbp - 24], rax

  mov QWORD [rbp - 32], 1
  mov QWORD [rbp - 40], 0
  mov QWORD [rbp - 48], 0

  cmp QWORD [rbp - 24], 2 ; Check if base contains at least 2 character
  jl .done

  mov rdi, [rbp - 16]
  call is_base_valid
  test rax, rax
  jz .done

  xor rcx, rcx ; Reset counter

.skip_whitespace:
  mov rax, [rbp - 8]
  mov al, [rax + rcx] ; Get the current character

  test al, al ; Check if we reached null terminated character
  jz .done

  cmp al, 32 ; Check if current character is a whitespace
  je .next_whitespace
  cmp al, 9
  je .next_whitespace
  cmp al, 10
  je .next_whitespace
  cmp al, 11
  je .next_whitespace
  cmp al, 12
  je .next_whitespace
  cmp al, 13
  je .next_whitespace 

  jmp .check_minus

.next_whitespace:
  inc rcx
  jmp .skip_whitespace

.check_minus:
  cmp al, 45 ; Check if it is '-'
  jne .check_plus ; If char is not '-' check if it is '+'

  inc rcx ; Increment counter if first char is '-'
  mov QWORD [rbp - 32], -1 ; Set SIGN to negative
  mov rax, [rbp - 8]
  mov al, [rax + rcx]
  jmp .loop

.check_plus:
  cmp al, 43 ; Check if it is '+'
  jne .loop

  inc rcx
  mov QWORD [rbp - 32], 1
  mov rax, [rbp - 8]
  mov al, [rax + rcx]
  jmp .loop

.loop:
  mov rax, [rbp - 8]
  mov al, [rax + rcx]
  test al, al
  jz .done

  mov rdi, [rbp - 16]
  movzx rsi, al
  call ft_strchr

  test rax, rax
  jz .done

  sub rax, [rbp - 16]
  mov [rbp - 48], rax

  ; result = result * base length + current character value
  mov rax, [rbp - 40]
  mul QWORD [rbp - 24]
  add rax, [rbp - 48]
  mov [rbp - 40], rax

  inc rcx
  jmp .loop

.done:
  mov rax, [rbp - 40]
  mov rcx, [rbp - 32]
  imul rax, rcx

  mov rsp, rbp
  pop rbp
  ret
