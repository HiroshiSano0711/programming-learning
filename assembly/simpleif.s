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
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	movl	$10, -8(%rbp)
	movl	-8(%rbp), %eax
	testl	%eax, %eax
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	je	LBB0_1
	jmp	LBB0_6
LBB0_6:
	movl	-12(%rbp), %eax         ## 4-byte Reload
	subl	$1, %eax
	movl	%eax, -16(%rbp)         ## 4-byte Spill
	je	LBB0_2
	jmp	LBB0_7
LBB0_7:
	movl	-12(%rbp), %eax         ## 4-byte Reload
	subl	$10, %eax
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	je	LBB0_3
	jmp	LBB0_4
LBB0_1:
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	jmp	LBB0_5
LBB0_2:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	jmp	LBB0_5
LBB0_3:
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -32(%rbp)         ## 4-byte Spill
	jmp	LBB0_5
LBB0_4:
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -36(%rbp)         ## 4-byte Spill
LBB0_5:
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"zero\n"

L_.str.1:                               ## @.str.1
	.asciz	"one\n"

L_.str.2:                               ## @.str.2
	.asciz	"ten\n"

L_.str.3:                               ## @.str.3
	.asciz	"error\n"


.subsections_via_symbols
