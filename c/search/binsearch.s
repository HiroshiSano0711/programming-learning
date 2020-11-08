	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp
	leaq	-80(%rbp), %rax
	leaq	l___const.main.k(%rip), %rcx
	movq	___stack_chk_guard@GOTPCREL(%rip), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, -8(%rbp)
	movl	$0, -84(%rbp)
	movl	$9, -88(%rbp)
	movq	%rax, %rdx
	movq	%rdx, %rdi
	movq	%rcx, %rsi
	movl	$60, %edx
	movq	%rax, -104(%rbp)        ## 8-byte Spill
	callq	_memcpy
	movl	-88(%rbp), %edi
	movq	-104(%rbp), %rsi        ## 8-byte Reload
	movl	$15, %edx
	callq	_binsearch
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	addl	$1, %eax
	leaq	L_.str(%rip), %rdi
	movl	%eax, %esi
	movb	$0, %al
	callq	_printf
	movq	___stack_chk_guard@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdi
	cmpq	%rdi, %rcx
	jne	LBB0_2
## %bb.1:                               ## %SP_return
	xorl	%eax, %eax
	addq	$112, %rsp
	popq	%rbp
	retq
LBB0_2:                                 ## %CallStackCheckFailBlk
	callq	___stack_chk_fail
	ud2
                                        ## -- End function
	.globl	_binsearch              ## -- Begin function binsearch
	.p2align	4, 0x90
_binsearch:                             ## @binsearch
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	(%rcx), %eax
	jg	LBB1_2
## %bb.1:
	movl	$0, -4(%rbp)
	jmp	LBB1_11
LBB1_2:
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	-20(%rbp), %edx
	subl	$1, %edx
	movslq	%edx, %rsi
	cmpl	(%rcx,%rsi,4), %eax
	jle	LBB1_4
## %bb.3:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	LBB1_11
LBB1_4:
	movl	$0, -28(%rbp)
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -32(%rbp)
LBB1_5:                                 ## =>This Inner Loop Header: Depth=1
	movl	-32(%rbp), %eax
	subl	-28(%rbp), %eax
	cmpl	$1, %eax
	jle	LBB1_10
## %bb.6:                               ##   in Loop: Header=BB1_5 Depth=1
	movl	-32(%rbp), %eax
	addl	-28(%rbp), %eax
	sarl	$1, %eax
	movl	%eax, -24(%rbp)
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rcx
	movslq	-24(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jg	LBB1_8
## %bb.7:                               ##   in Loop: Header=BB1_5 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -32(%rbp)
	jmp	LBB1_9
LBB1_8:                                 ##   in Loop: Header=BB1_5 Depth=1
	movl	-24(%rbp), %eax
	movl	%eax, -28(%rbp)
LBB1_9:                                 ##   in Loop: Header=BB1_5 Depth=1
	jmp	LBB1_5
LBB1_10:
	movl	-32(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB1_11:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	4               ## @__const.main.k
l___const.main.k:
	.long	5                       ## 0x5
	.long	10                      ## 0xa
	.long	20                      ## 0x14
	.long	30                      ## 0x1e
	.long	40                      ## 0x28
	.long	50                      ## 0x32
	.long	60                      ## 0x3c
	.long	70                      ## 0x46
	.long	80                      ## 0x50
	.long	90                      ## 0x5a
	.long	100                     ## 0x64
	.long	110                     ## 0x6e
	.long	120                     ## 0x78
	.long	130                     ## 0x82
	.long	140                     ## 0x8c

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"x\343\201\256\344\275\215\347\275\256\343\201\257 %d \347\225\252\347\233\256\343\201\256\350\246\201\347\264\240\343\201\247\343\201\231\n"

.subsections_via_symbols
