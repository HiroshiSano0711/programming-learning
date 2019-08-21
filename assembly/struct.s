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
	xorl	%esi, %esi
	movl	$40, %eax
	movl	%eax, %edx
	movq	___stack_chk_guard@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, -8(%rbp)
	movl	$0, -52(%rbp)
	leaq	-48(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_memset
	movl	$1, -48(%rbp)
	movl	$100, -44(%rbp)
	movl	$2, -40(%rbp)
	movl	$101, -36(%rbp)
	movl	$3, -32(%rbp)
	movl	$102, -28(%rbp)
	movl	$0, -56(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$3, -56(%rbp)
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movslq	-56(%rbp), %rax
	movl	$10, -48(%rbp,%rax,8)
	movslq	-56(%rbp), %rax
	movl	$1000, -44(%rbp,%rax,8) ## imm = 0x3E8
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	jmp	LBB0_1
LBB0_4:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_6
## %bb.5:
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	retq
LBB0_6:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
