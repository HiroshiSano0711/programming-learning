	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function main
LCPI0_0:
	.quad	4612361558371493478     ## double 2.2999999999999998
LCPI0_1:
	.quad	4608218246714312622     ## double 1.23
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movsd	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	LCPI0_1(%rip), %xmm1    ## xmm1 = mem[0],zero
	movl	$0, -4(%rbp)
	movsd	%xmm1, -16(%rbp)
	movsd	%xmm0, -24(%rbp)
	movsd	-16(%rbp), %xmm0        ## xmm0 = mem[0],zero
	addsd	-24(%rbp), %xmm0
	movsd	%xmm0, -32(%rbp)
	movsd	-32(%rbp), %xmm0        ## xmm0 = mem[0],zero
	leaq	L_.str(%rip), %rdi
	movb	$1, %al
	callq	_printf
	movsd	-16(%rbp), %xmm0        ## xmm0 = mem[0],zero
	subsd	-24(%rbp), %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-40(%rbp), %xmm0        ## xmm0 = mem[0],zero
	leaq	L_.str.1(%rip), %rdi
	movl	%eax, -44(%rbp)         ## 4-byte Spill
	movb	$1, %al
	callq	_printf
	xorl	%ecx, %ecx
	movl	%eax, -48(%rbp)         ## 4-byte Spill
	movl	%ecx, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"a+b=%lf"

L_.str.1:                               ## @.str.1
	.asciz	"a-b=%lf"


.subsections_via_symbols
