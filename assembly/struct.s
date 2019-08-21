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
	pushq	%r14
	pushq	%rbx
	subq	$96, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	movaps	l___const.main.member+64(%rip), %xmm0
	movaps	%xmm0, -48(%rbp)
	movaps	l___const.main.member+48(%rip), %xmm0
	movaps	%xmm0, -64(%rbp)
	movaps	l___const.main.member+32(%rip), %xmm0
	movaps	%xmm0, -80(%rbp)
	movaps	l___const.main.member+16(%rip), %xmm0
	movaps	%xmm0, -96(%rbp)
	movaps	l___const.main.member(%rip), %xmm0
	movaps	%xmm0, -112(%rbp)
	leaq	-108(%rbp), %rsi
	leaq	L_.str(%rip), %r14
	xorl	%eax, %eax
	movq	%r14, %rdi
	callq	_printf
	movl	-112(%rbp), %esi
	leaq	L_.str.1(%rip), %rbx
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	_printf
	leaq	-92(%rbp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	callq	_printf
	movl	-96(%rbp), %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	_printf
	leaq	-76(%rbp), %rsi
	xorl	%eax, %eax
	movq	%r14, %rdi
	callq	_printf
	movl	-80(%rbp), %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	_printf
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	jne	LBB0_2
## %bb.1:
	xorl	%eax, %eax
	addq	$96, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB0_2:
	callq	___stack_chk_fail
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	4               ## @__const.main.member
l___const.main.member:
	.long	1                       ## 0x1
	.asciz	"ken\000\000\000\000\000\000\000\000"
	.long	2                       ## 0x2
	.asciz	"ryu\000\000\000\000\000\000\000\000"
	.long	3                       ## 0x3
	.asciz	"gairu\000\000\000\000\000\000"
	.space	16
	.space	16

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"member[i].name= %s"

L_.str.1:                               ## @.str.1
	.asciz	"member[i].age= %d"


.subsections_via_symbols
