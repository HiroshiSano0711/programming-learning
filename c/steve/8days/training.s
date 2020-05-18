	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_write_line             ## -- Begin function write_line
	.p2align	4, 0x90
_write_line:                            ## @write_line
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
                                        ## kill: def $dl killed $dl killed $edx
                                        ## kill: def $sil killed $sil killed $esi
	movl	%edi, -4(%rbp)
	movb	%sil, -5(%rbp)
	movb	%dl, -6(%rbp)
	movsbl	-5(%rbp), %esi
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -12(%rbp)
LBB0_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_3 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB0_8
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	$0, -16(%rbp)
LBB0_3:                                 ##   Parent Loop BB0_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$5, -16(%rbp)
	jge	LBB0_6
## %bb.4:                               ##   in Loop: Header=BB0_3 Depth=2
	movsbl	-6(%rbp), %esi
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.5:                               ##   in Loop: Header=BB0_3 Depth=2
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	LBB0_3
LBB0_6:                                 ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %esi
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.7:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	LBB0_1
LBB0_8:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_write_square           ## -- Begin function write_square
	.p2align	4, 0x90
_write_square:                          ## @write_square
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %edi
	movl	$43, %esi
	movl	$45, %edx
	callq	_write_line
	movl	$0, -12(%rbp)
LBB1_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB1_3 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	LBB1_8
## %bb.2:                               ##   in Loop: Header=BB1_1 Depth=1
	movl	$0, -16(%rbp)
LBB1_3:                                 ##   Parent Loop BB1_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$3, -16(%rbp)
	jge	LBB1_6
## %bb.4:                               ##   in Loop: Header=BB1_3 Depth=2
	movl	-4(%rbp), %edi
	movl	$124, %esi
	movl	$32, %edx
	callq	_write_line
## %bb.5:                               ##   in Loop: Header=BB1_3 Depth=2
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	LBB1_3
LBB1_6:                                 ##   in Loop: Header=BB1_1 Depth=1
	movl	-4(%rbp), %edi
	movl	$43, %esi
	movl	$45, %edx
	callq	_write_line
## %bb.7:                               ##   in Loop: Header=BB1_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	LBB1_1
LBB1_8:
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
## %bb.0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	___stdinp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	movl	$100, %esi
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	callq	_fgets
	movq	_buff@GOTPCREL(%rip), %rdi
	leaq	L_.str.3(%rip), %rsi
	leaq	-8(%rbp), %rdx
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_sscanf
	leaq	L_.str.4(%rip), %rdi
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movq	_buff@GOTPCREL(%rip), %rdi
	movq	___stdinp@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	movl	$100, %esi
	movl	%eax, -32(%rbp)         ## 4-byte Spill
	callq	_fgets
	movq	_buff@GOTPCREL(%rip), %rdi
	leaq	L_.str.3(%rip), %rsi
	leaq	-12(%rbp), %rdx
	movq	%rax, -40(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_sscanf
	cmpl	$1, -8(%rbp)
	jl	LBB2_2
## %bb.1:
	cmpl	$1, -12(%rbp)
	jge	LBB2_3
LBB2_2:
	leaq	L_.str.5(%rip), %rdi
	xorl	%eax, %eax
                                        ## kill: def $al killed $al killed $eax
	callq	_printf
	movl	$1, %edi
	movl	%eax, -44(%rbp)         ## 4-byte Spill
	callq	_exit
LBB2_3:
	movl	-12(%rbp), %edi
	movl	-8(%rbp), %esi
	callq	_write_square
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%c"

L_.str.1:                               ## @.str.1
	.asciz	"\n"

L_.str.2:                               ## @.str.2
	.asciz	"\347\270\246\343\201\257\344\275\225\350\241\214\343\201\253\343\201\227\343\201\276\343\201\231\343\201\213\357\274\237\n"

	.comm	_buff,100,4             ## @buff
L_.str.3:                               ## @.str.3
	.asciz	"%d"

L_.str.4:                               ## @.str.4
	.asciz	"\346\250\252\343\201\257\344\275\225\345\210\227\343\201\253\343\201\227\343\201\276\343\201\231\343\201\213\357\274\237\n"

L_.str.5:                               ## @.str.5
	.asciz	"\347\270\246\346\250\252\343\201\257\343\201\235\343\202\214\343\201\236\343\202\2141\344\273\245\344\270\212\343\201\256\346\225\264\346\225\260\343\202\222\345\205\245\345\212\233\343\201\227\343\201\246\343\201\217\343\201\240\343\201\225\343\201\204\343\200\202\n"


.subsections_via_symbols
