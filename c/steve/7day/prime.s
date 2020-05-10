	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	___stdinp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	movl	$100, %esi
	movl	%eax, -8(%rbp)          ## 4-byte Spill
	callq	_fgets
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	_number@GOTPCREL(%rip), %rdx
	leaq	L_.str.1(%rip), %rsi
	movq	%rax, -16(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_sscanf
	movq	_number@GOTPCREL(%rip), %rcx
	cmpl	$1, (%rcx)
	je	LBB0_3
## %bb.1:
	movq	_number@GOTPCREL(%rip), %rax
	cmpl	$2, (%rax)
	je	LBB0_3
## %bb.2:
	movq	_number@GOTPCREL(%rip), %rax
	cmpl	$3, (%rax)
	jne	LBB0_4
LBB0_3:
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -4(%rbp)
	jmp	LBB0_13
LBB0_4:
	movq	_max@GOTPCREL(%rip), %rax
	movq	_number@GOTPCREL(%rip), %rcx
	cvtsi2sdl	(%rcx), %xmm0
	sqrtsd	%xmm0, %xmm0
	roundsd	$9, %xmm0, %xmm0
	cvttsd2si	%xmm0, %edx
	movl	%edx, (%rax)
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	movq	_max@GOTPCREL(%rip), %rax
	cmpl	$1, (%rax)
	jle	LBB0_9
## %bb.6:                               ##   in Loop: Header=BB0_5 Depth=1
	movq	_r@GOTPCREL(%rip), %rax
	movq	_max@GOTPCREL(%rip), %rcx
	movq	_number@GOTPCREL(%rip), %rdx
	movl	(%rdx), %esi
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movl	%esi, %eax
	cltd
	idivl	(%rcx)
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	movl	%edx, (%rcx)
	cmpl	$0, (%rcx)
	jne	LBB0_8
## %bb.7:
	jmp	LBB0_9
LBB0_8:                                 ##   in Loop: Header=BB0_5 Depth=1
	movq	_max@GOTPCREL(%rip), %rax
	movl	(%rax), %ecx
	addl	$-1, %ecx
	movl	%ecx, (%rax)
	jmp	LBB0_5
LBB0_9:
	movq	_r@GOTPCREL(%rip), %rax
	cmpl	$0, (%rax)
	jne	LBB0_11
## %bb.10:
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB0_12
LBB0_11:
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
LBB0_12:
	movl	$0, -4(%rbp)
LBB0_13:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"\347\264\240\346\225\260\345\210\244\345\256\232\343\200\2021\344\273\245\344\270\212\343\201\256\346\225\260\345\255\227\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\255\343\200\202\n"

	.comm	_buff,100,4             ## @buff
L_.str.1:                               ## @.str.1
	.asciz	"%d"

	.comm	_number,4,2             ## @number
L_.str.2:                               ## @.str.2
	.asciz	"\347\264\240\346\225\260\343\201\247\343\201\231\n"

	.comm	_max,4,2                ## @max
	.comm	_r,4,2                  ## @r
L_.str.3:                               ## @.str.3
	.asciz	"\347\264\240\346\225\260\343\201\247\343\201\257\343\201\252\343\201\204\n"

L_.str.4:                               ## @.str.4
	.asciz	"\347\264\240\346\225\260\n"


.subsections_via_symbols
