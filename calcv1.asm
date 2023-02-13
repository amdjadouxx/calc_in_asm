bits 64

;constant assignement
EXIT equ 60
READ  equ 0
WRITE equ 1
STDIN equ 0
STDOUT equ 1

;variable assignement
segment .data
    msg db "Please enter a digit ", 0xA,0xD 
    len equ $- msg
    msg2 db "Please enter a second digit", 0xA,0xD 
    len2 equ $- msg2
    msg3 db "The sum is: %s", 10, 0
    len3 equ $- msg3
    msg_end db 10

;empty spaces to stock all integer
segment .bss
    n1 resd 2
    n2 resd 2
    res resd 1

;code
segment .text
extern printf
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

        print:
        ;display msg3
        mov rdi, msg3
        mov rsi, res
        mov al, 0
        call printf
    
        ;exit
        mov rax, EXIT
        mov rdi, 0
        syscall
