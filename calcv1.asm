bits 64
EXIT equ 60
READ  equ 0
WRITE equ 1
STDIN equ 0
STDOUT equ 1

segment .data
    msg db "Please enter a digit ", 0xA,0xD 
    len equ $- msg
    msg2 db "Please enter a second digit", 0xA,0xD 
    len2 equ $- msg2
    msg3 db "The sum is: "
    len3 equ $- msg3
    msg_end db 10
segment .bss
    n1 resd 2
    n2 resd 2
    res resd 1

segment .text 
    global _start 
    _start:

    ;display msg1
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, msg
    mov rdx, len
    syscall

    ;read ==> n1
    mov rax, READ
    mov rdi, STDIN
    mov rsi, n1
    mov rdx, 2
    syscall

    ;display msg2
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, msg
    mov rdx, len
    syscall

    ;read ==> n2
    mov rax, READ
    mov rdi, STDIN
    mov rsi, n2
    mov rdx, 2
    syscall

    ;display msg3
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, msg3
    mov rdx, len3
    syscall

    ;n1 go from ASCII to decimal
    mov rax, [n1]
    sub rax, '0'
    ;same for n2
    mov rdi, [n2]
    sub rdi, '0'
    
    ;add of n1 and n2
    add rax, rdi
    ;convert ASCII to decimal
    add rax, '0'
    
    ;stock the result in result
    mov [res], rax

    ;display msg3
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, res
    mov rdx, 1
    syscall

    ;display '\n'
    mov rax, WRITE
    mov rdi, STDOUT
    mov rsi, msg_end
    mov rdx, 1
    syscall

    mov rax, EXIT
    mov rdi, 0
    syscall
