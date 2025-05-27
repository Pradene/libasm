section .text
  global ft_atoi_base
  extern ft_strlen
  extern ft_strchr

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

  mov [rbp - 8], rdi
  mov [rbp - 16], rsi

  mov rdi, [rbp - 16]
  call ft_strlen
  mov [rbp - 24], rax

  mov QWORD [rbp - 32], 1
  mov QWORD [rbp - 40], 0
  mov QWORD [rbp - 48], 0
  
  cmp [rbp - 24], 2 ; Check if base contains at least 2 character
  jl .done

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
  jmp .loop

.check_plus:
  cmp al, 43 ; Check if it is '+'
  jne .loop

  inc rcx
  mov QWORD [rbp - 32], 1
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
  mul QWORD [rbp - 32]

  mov rsp, rbp
  pop rbp
  ret

