	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -52(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -48(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -44(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -40(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -36(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -32(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -28(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -24(%rbp)
	imull	$0, _MAX_BLOCK_PER_PAGE(%rip), %ecx
	movl	%ecx, -20(%rbp)
	movl	$0, -56(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$65536, -56(%rbp)       ## imm = 0x10000
	jae	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-56(%rbp), %eax
	shrl	$13, %eax
	movl	-56(%rbp), %edx
	movl	_BLOCK_UNIT(%rip), %ecx
	movl	-56(%rbp), %esi
	shrl	$13, %esi
	movl	%esi, %esi
	movl	%esi, %edi
	imull	-48(%rbp,%rdi,4), %ecx
	movl	-56(%rbp), %esi
	andl	_BIT_MASK(%rip), %esi
	addl	%esi, %ecx
	leaq	L_.str(%rip), %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	_printf
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
## %bb.5:                               ## %SP_return
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	retq
LBB0_6:                                 ## %CallStackCheckFailBlk
	callq	___stack_chk_fail
	ud2
                                        ## -- End function
	.section	__DATA,__data
	.globl	_PAGE_UNIT              ## @PAGE_UNIT
	.p2align	2
_PAGE_UNIT:
	.long	8192                    ## 0x2000

	.globl	_BLOCK_UNIT             ## @BLOCK_UNIT
	.p2align	2
_BLOCK_UNIT:
	.long	64                      ## 0x40

	.globl	_MAX_BLOCK_PER_PAGE     ## @MAX_BLOCK_PER_PAGE
	.p2align	2
_MAX_BLOCK_PER_PAGE:
	.long	128                     ## 0x80

	.globl	_BIT_MASK               ## @BIT_MASK
	.p2align	2
_BIT_MASK:
	.long	8191                    ## 0x1fff

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"\343\203\232\343\203\274\343\202\270\346\225\260 = %d, \344\273\256\346\203\263\343\202\242\343\203\211\343\203\254\343\202\271 = %d, \347\211\251\347\220\206\343\202\242\343\203\211\343\203\254\343\202\271 = %d \n"

.subsections_via_symbols
