	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	leaq	L_.str(%rip), %rdi
	movl	$10, %esi
	movb	$0, %al
	callq	_printf
	movq	_n@GOTPCREL(%rip), %rsi
	leaq	L_.str.1(%rip), %rdi
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_scanf
	leaq	L_.str.2(%rip), %rdi
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movl	$0, -8(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	_n@GOTPCREL(%rip), %rax
	movl	-8(%rbp), %ecx
	cmpl	(%rax), %ecx
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	_upper@GOTPCREL(%rip), %rax
	movq	_lower@GOTPCREL(%rip), %rcx
	movslq	-8(%rbp), %rdx
	shlq	$2, %rdx
	addq	%rdx, %rcx
	movslq	-8(%rbp), %rdx
	shlq	$2, %rdx
	addq	%rdx, %rax
	leaq	L_.str.3(%rip), %rdi
	movq	%rcx, %rsi
	movq	%rax, %rdx
	movb	$0, %al
	callq	_scanf
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	LBB0_1
LBB0_4:
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -8(%rbp)
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	movq	_n@GOTPCREL(%rip), %rax
	movl	-8(%rbp), %ecx
	cmpl	(%rax), %ecx
	jge	LBB0_8
## %bb.6:                               ##   in Loop: Header=BB0_5 Depth=1
	movl	-8(%rbp), %esi
	leaq	L_.str.5(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.7:                               ##   in Loop: Header=BB0_5 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	LBB0_5
LBB0_8:
	leaq	L_.str.6(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	callq	_lookfun
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_action                 ## -- Begin function action
	.p2align	4, 0x90
_action:                                ## @action
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	_n@GOTPCREL(%rip), %rax
	movl	-4(%rbp), %ecx
	cmpl	(%rax), %ecx
	jge	LBB1_4
## %bb.2:                               ##   in Loop: Header=BB1_1 Depth=1
	movq	_r@GOTPCREL(%rip), %rax
	movslq	-4(%rbp), %rcx
	movl	(%rax,%rcx,4), %esi
	leaq	L_.str.7(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.3:                               ##   in Loop: Header=BB1_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	LBB1_1
LBB1_4:
	leaq	L_.str.6(%rip), %rdi
	movb	$0, %al
	callq	_printf
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_lookfun                ## -- Begin function lookfun
	.p2align	4, 0x90
_lookfun:                               ## @lookfun
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	_n@GOTPCREL(%rip), %rax
	movl	(%rax), %ecx
	subl	$1, %ecx
	movl	%ecx, -8(%rbp)
	movl	$0, -4(%rbp)
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	_n@GOTPCREL(%rip), %rax
	movl	-4(%rbp), %ecx
	cmpl	(%rax), %ecx
	jge	LBB2_6
## %bb.2:                               ##   in Loop: Header=BB2_1 Depth=1
	movq	_upper@GOTPCREL(%rip), %rax
	movq	_r@GOTPCREL(%rip), %rcx
	movq	_lower@GOTPCREL(%rip), %rdx
	movslq	-4(%rbp), %rsi
	movl	(%rdx,%rsi,4), %edi
	movslq	-4(%rbp), %rdx
	movl	%edi, (%rcx,%rdx,4)
	movslq	-4(%rbp), %rcx
	cmpl	(%rax,%rcx,4), %edi
	jle	LBB2_4
## %bb.3:
	jmp	LBB2_14
LBB2_4:                                 ##   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_5
LBB2_5:                                 ##   in Loop: Header=BB2_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	LBB2_1
LBB2_6:
	jmp	LBB2_7
LBB2_7:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB2_8 Depth 2
	callq	_action
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB2_8:                                 ##   Parent Loop BB2_7 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	_upper@GOTPCREL(%rip), %rax
	movq	_r@GOTPCREL(%rip), %rcx
	movslq	-4(%rbp), %rdx
	movl	(%rcx,%rdx,4), %esi
	movslq	-4(%rbp), %rcx
	cmpl	(%rax,%rcx,4), %esi
	jge	LBB2_10
## %bb.9:                               ##   in Loop: Header=BB2_7 Depth=1
	movq	_r@GOTPCREL(%rip), %rax
	movslq	-4(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	addl	$1, %edx
	movl	%edx, (%rax,%rcx,4)
	jmp	LBB2_13
LBB2_10:                                ##   in Loop: Header=BB2_8 Depth=2
	movq	_r@GOTPCREL(%rip), %rax
	movq	_lower@GOTPCREL(%rip), %rcx
	movslq	-4(%rbp), %rdx
	movl	(%rcx,%rdx,4), %esi
	movslq	-4(%rbp), %rcx
	movl	%esi, (%rax,%rcx,4)
	movl	-4(%rbp), %esi
	addl	$-1, %esi
	movl	%esi, -4(%rbp)
	cmpl	$0, %esi
	jge	LBB2_12
## %bb.11:
	jmp	LBB2_14
LBB2_12:                                ##   in Loop: Header=BB2_8 Depth=2
	jmp	LBB2_8
LBB2_13:                                ##   in Loop: Header=BB2_7 Depth=1
	jmp	LBB2_7
LBB2_14:
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"n\343\201\256\346\225\260\345\200\244\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\217\343\201\240\343\201\225\343\201\204 (\343\201\237\343\201\240\343\201\227 %d \343\202\210\343\202\212\345\244\247\343\201\215\343\201\217\343\201\252\343\201\204)"

L_.str.1:                               ## @.str.1
	.asciz	"%d"

	.comm	_n,4,2                  ## @n
L_.str.2:                               ## @.str.2
	.asciz	"\343\203\232\343\202\242\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\217\343\201\240\343\201\225\343\201\204 (lower upper):\n"

L_.str.3:                               ## @.str.3
	.asciz	"%d %d"

	.comm	_lower,40,4             ## @lower
	.comm	_upper,40,4             ## @upper
L_.str.4:                               ## @.str.4
	.asciz	"\n\345\207\272\345\212\233: \n\n"

L_.str.5:                               ## @.str.5
	.asciz	"  r[%d]"

L_.str.6:                               ## @.str.6
	.asciz	"\n"

L_.str.7:                               ## @.str.7
	.asciz	"%6d"

	.comm	_r,40,4                 ## @r
.subsections_via_symbols
