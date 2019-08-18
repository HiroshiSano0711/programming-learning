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
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movl	$7, -8(%rbp)
	movl	$2, -12(%rbp)
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	leaq	L_.str(%rip), %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	_printf
	movl	-8(%rbp), %esi
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	movl	%esi, %eax
	cltd
	idivl	-12(%rbp)
	movl	%eax, -16(%rbp)
	movl	-8(%rbp), %eax
	cltd
	idivl	-12(%rbp)
	movl	%edx, -20(%rbp)
	movl	-16(%rbp), %esi
	movl	-20(%rbp), %edx
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	xorl	%edx, %edx
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"a*b=%d\n"

L_.str.1:                               ## @.str.1
	.asciz	"a/b=%d...%d\n"


.subsections_via_symbols
