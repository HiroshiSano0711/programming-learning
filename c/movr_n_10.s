	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
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
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	$100000000, %r14d       ## imm = 0x5F5E100
	xorl	%r15d, %r15d
	cmpl	$2, %edi
	jl	LBB0_3
## %bb.1:
	movq	%rsi, %r12
	movl	%edi, %r13d
	movq	8(%rsi), %rdi
	callq	_atoi
	movl	%eax, %r14d
	cmpl	$2, %r13d
	jne	LBB0_4
LBB0_3:
	xorl	%ebx, %ebx
	jmp	LBB0_9
LBB0_4:
	movq	16(%r12), %rdi
	callq	_atoi
	movl	%eax, %ebx
	cmpl	$4, %r13d
	jl	LBB0_9
## %bb.5:
	movq	24(%r12), %rdi
	callq	_atoi
	movl	%eax, %r15d
	cmpl	$4, %r13d
	je	LBB0_9
## %bb.6:
	movq	32(%r12), %rdi
	callq	_atoi
	cmpl	$9, %eax
	ja	LBB0_8
## %bb.7:
	movl	%eax, %eax
	leaq	LJTI0_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
LBB0_8:
	## InlineAsm Start
DUMMY1:
	## InlineAsm End
LBB0_9:
	movl	%r15d, %ebx
LBB0_10:
	movl	%r15d, %ebx
LBB0_11:
	movl	%r15d, %ebx
LBB0_12:
	movl	%r15d, %ebx
LBB0_13:
	movl	%r15d, %ebx
LBB0_14:
	movl	%r15d, %ebx
LBB0_15:
	movl	%r15d, %ebx
LBB0_16:
	movl	%r15d, %ebx
LBB0_17:
	movl	%r15d, %ebx
LBB0_18:
	movl	%r15d, %ebx
	## InlineAsm Start
DUMMY2:
	## InlineAsm End
	decl	%r14d
	jg	LBB0_8
## %bb.19:
	leaq	L_.str(%rip), %rdi
	movl	%ebx, %esi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
	.p2align	2, 0x90
	.data_region jt32
.set L0_0_set_9, LBB0_9-LJTI0_0
.set L0_0_set_10, LBB0_10-LJTI0_0
.set L0_0_set_11, LBB0_11-LJTI0_0
.set L0_0_set_12, LBB0_12-LJTI0_0
.set L0_0_set_13, LBB0_13-LJTI0_0
.set L0_0_set_14, LBB0_14-LJTI0_0
.set L0_0_set_15, LBB0_15-LJTI0_0
.set L0_0_set_16, LBB0_16-LJTI0_0
.set L0_0_set_17, LBB0_17-LJTI0_0
.set L0_0_set_18, LBB0_18-LJTI0_0
LJTI0_0:
	.long	L0_0_set_9
	.long	L0_0_set_10
	.long	L0_0_set_11
	.long	L0_0_set_12
	.long	L0_0_set_13
	.long	L0_0_set_14
	.long	L0_0_set_15
	.long	L0_0_set_16
	.long	L0_0_set_17
	.long	L0_0_set_18
	.end_data_region
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"a = %d\n"


.subsections_via_symbols
