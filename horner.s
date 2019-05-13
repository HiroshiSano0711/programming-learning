	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function main
LCPI0_0:
	.quad	4602678819172646912     ## double 0.5
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
	subq	$32, %rsp
	movsd	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movl	$0, -4(%rbp)
	movsd	%xmm0, -16(%rbp)
	movsd	-16(%rbp), %xmm0        ## xmm0 = mem[0],zero
	leaq	_main.a(%rip), %rdi
	movl	$2, %esi
	callq	_P
	leaq	L_.str(%rip), %rdi
	movb	$1, %al
	callq	_printf
	xorl	%esi, %esi
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movl	%esi, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_P                      ## -- Begin function P
	.p2align	4, 0x90
_P:                                     ## @P
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movsd	%xmm0, -8(%rbp)
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	LBB1_2
## %bb.1:
	movsd	-8(%rbp), %xmm0         ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movl	-20(%rbp), %ecx
	subl	$1, %ecx
	movq	%rax, %rdi
	movl	%ecx, %esi
	callq	_P
	mulsd	-8(%rbp), %xmm0
	movq	-16(%rbp), %rax
	addsd	(%rax), %xmm0
	movsd	%xmm0, -32(%rbp)        ## 8-byte Spill
	jmp	LBB1_3
LBB1_2:
	movq	-16(%rbp), %rax
	movsd	(%rax), %xmm0           ## xmm0 = mem[0],zero
	movsd	%xmm0, -32(%rbp)        ## 8-byte Spill
LBB1_3:
	movsd	-32(%rbp), %xmm0        ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__data
	.p2align	4               ## @main.a
_main.a:
	.quad	4617315517961601024     ## double 5
	.quad	4624633867356078080     ## double 15
	.quad	4627730092099895296     ## double 25

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%f"


.subsections_via_symbols
