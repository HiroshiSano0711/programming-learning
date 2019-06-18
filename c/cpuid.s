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
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movl	$-2147483640, -8(%rbp)  ## imm = 0x80000008
	movl	-8(%rbp), %eax
	## InlineAsm Start
	cpuid
	## InlineAsm End
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	andl	$255, %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	shrl	$8, %eax
	andl	$255, %eax
	movl	%eax, -20(%rbp)
	movl	-12(%rbp), %esi
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	-16(%rbp), %esi
	movl	-16(%rbp), %edx
	leaq	L_.str.1(%rip), %rdi
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movl	-20(%rbp), %esi
	movl	-20(%rbp), %edx
	leaq	L_.str.2(%rip), %rdi
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	xorl	%edx, %edx
	movl	%eax, -32(%rbp)         ## 4-byte Spill
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"result = 0x%x\n"

L_.str.1:                               ## @.str.1
	.asciz	"physical_address_bits = 0x%x, (%d)\n"

L_.str.2:                               ## @.str.2
	.asciz	"linear_address_bits = 0x%x, (%d)\n"


.subsections_via_symbols
