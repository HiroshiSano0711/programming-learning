	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movl	$200, -8(%rbp)
	movl	$4, %edi
	callq	_malloc
	movq	_d@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	movq	(%rcx), %rax
	movl	$400, (%rax)            ## imm = 0x190
	leaq	L_.str(%rip), %rdi
	leaq	_a(%rip), %rsi
	leaq	-8(%rbp), %rdx
	leaq	_c(%rip), %rax
	movq	%rcx, -16(%rbp)         ## 8-byte Spill
	movq	%rax, %rcx
	movq	-16(%rbp), %r8          ## 8-byte Reload
	movb	$0, %al
	callq	_printf
	xorl	%r9d, %r9d
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movl	%r9d, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.comm	_d,8,3                  ## @d
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%p %p %p %p"

	.section	__TEXT,__const
	.p2align	2               ## @a
_a:
	.long	100                     ## 0x64

	.section	__DATA,__data
	.p2align	2               ## @c
_c:
	.long	300                     ## 0x12c


.subsections_via_symbols
