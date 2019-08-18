.text

.globl start
start:
    movq  %rsp, %rbp

    movq $1, %rax
    movq $1, %rdi
    movq 8(%rbp), %rsi       # program name address ?
    movq $5, %rdx
    syscall

    movq $60, %rax
    movq $0, %rdi
    syscall