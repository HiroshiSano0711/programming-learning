	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movq	_result@GOTPCREL(%rip), %rax
	movl	$0, -4(%rbp)
	movl	$0, (%rax)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	_result@GOTPCREL(%rip), %rax
	movl	(%rax), %esi
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	movl	%eax, -8(%rbp)          ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	___stdinp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	movl	$100, %esi
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	callq	_fgets
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	_operator@GOTPCREL(%rip), %rdx
	movq	_value@GOTPCREL(%rip), %rcx
	leaq	L_.str.2(%rip), %rsi
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_sscanf
	movq	_operator@GOTPCREL(%rip), %rcx
	movsbl	(%rcx), %r8d
	cmpl	$43, %r8d
	jne	LBB0_3
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	_result@GOTPCREL(%rip), %rax
	movq	_value@GOTPCREL(%rip), %rcx
	movl	(%rcx), %edx
	addl	(%rax), %edx
	movl	%edx, (%rax)
	jmp	LBB0_18
LBB0_3:                                 ##   in Loop: Header=BB0_1 Depth=1
	movq	_operator@GOTPCREL(%rip), %rax
	movsbl	(%rax), %ecx
	cmpl	$45, %ecx
	jne	LBB0_5
## %bb.4:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	_result@GOTPCREL(%rip), %rax
	movq	_value@GOTPCREL(%rip), %rcx
	movl	(%rcx), %edx
	movl	(%rax), %esi
	subl	%edx, %esi
	movl	%esi, (%rax)
	jmp	LBB0_17
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	movq	_operator@GOTPCREL(%rip), %rax
	movsbl	(%rax), %ecx
	cmpl	$42, %ecx
	jne	LBB0_7
## %bb.6:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	_result@GOTPCREL(%rip), %rax
	movq	_value@GOTPCREL(%rip), %rcx
	movl	(%rcx), %edx
	imull	(%rax), %edx
	movl	%edx, (%rax)
	jmp	LBB0_16
LBB0_7:                                 ##   in Loop: Header=BB0_1 Depth=1
	movq	_operator@GOTPCREL(%rip), %rax
	movsbl	(%rax), %ecx
	cmpl	$47, %ecx
	jne	LBB0_11
## %bb.8:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	_value@GOTPCREL(%rip), %rax
	cmpl	$0, (%rax)
	jne	LBB0_10
## %bb.9:                               ##   in Loop: Header=BB0_1 Depth=1
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB0_1
LBB0_10:                                ##   in Loop: Header=BB0_1 Depth=1
	movq	_result@GOTPCREL(%rip), %rax
	movq	_value@GOTPCREL(%rip), %rcx
	movl	(%rcx), %edx
	movl	(%rax), %esi
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	movl	%esi, %eax
	movl	%edx, -36(%rbp)         ## 4-byte Spill
	cltd
	movl	-36(%rbp), %esi         ## 4-byte Reload
	idivl	%esi
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movl	%eax, (%rcx)
	jmp	LBB0_15
LBB0_11:                                ##   in Loop: Header=BB0_1 Depth=1
	movq	_operator@GOTPCREL(%rip), %rax
	movsbl	(%rax), %ecx
	cmpl	$113, %ecx
	jne	LBB0_13
## %bb.12:
	jmp	LBB0_19
LBB0_13:                                ##   in Loop: Header=BB0_1 Depth=1
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.14:                              ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_15
LBB0_15:                                ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_16
LBB0_16:                                ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_17
LBB0_17:                                ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_18
LBB0_18:                                ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
LBB0_19:
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.comm	_result,4,2             ## @result
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"\347\265\220\346\236\234\357\274\232 %d\n"

L_.str.1:                               ## @.str.1
	.asciz	"\346\274\224\347\256\227\345\255\220\343\201\250\346\225\260\345\255\227\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\255\343\200\202q\343\202\222\345\205\245\345\212\233\343\201\231\343\202\213\343\201\250\346\255\242\343\201\276\343\202\213\343\202\210\343\200\202\n"

	.comm	_buff,100,4             ## @buff
L_.str.2:                               ## @.str.2
	.asciz	"%c %d"

	.comm	_operator,1,0           ## @operator
	.comm	_value,4,2              ## @value
L_.str.3:                               ## @.str.3
	.asciz	"0\343\201\247\343\201\257\345\211\262\343\202\214\343\201\276\343\201\233\343\202\223\343\200\202"

L_.str.4:                               ## @.str.4
	.asciz	"\346\274\224\347\256\227\345\255\220\343\201\257+, -, *, /\343\201\256\343\201\251\343\202\214\343\201\213\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\255"


.subsections_via_symbols
