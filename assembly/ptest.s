	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	leaq	-32(%rbp), %rax
	movq	___stack_chk_guard@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, -8(%rbp)
	movl	$0, -36(%rbp)
	movq	l___const.main.n(%rip), %rcx
	movq	%rcx, -32(%rbp)
	movq	l___const.main.n+8(%rip), %rcx
	movq	%rcx, -24(%rbp)
	movq	l___const.main.n+16(%rip), %rcx
	movq	%rcx, -16(%rbp)
	movq	%rax, -48(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	cmpl	$-1, (%rax)
	je	LBB0_3
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	addq	$4, %rcx
	movq	%rcx, -48(%rbp)
	leaq	L_.str(%rip), %rdi
	movq	%rax, %rsi
	movb	$0, %al
	callq	_printf
	movl	%eax, -52(%rbp)         ## 4-byte Spill
	jmp	LBB0_1
LBB0_3:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_5
## %bb.4:
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	retq
LBB0_5:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	4               ## @__const.main.n
l___const.main.n:
	.long	1                       ## 0x1
	.long	3                       ## 0x3
	.long	5                       ## 0x5
	.long	7                       ## 0x7
	.long	11                      ## 0xb
	.long	4294967295              ## 0xffffffff

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%p"


.subsections_via_symbols
