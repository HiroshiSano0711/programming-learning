	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function main
LCPI0_0:
	.quad	4696837146684686336     ## double 1.0E+6
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
LCPI0_1:
	.long	1127219200              ## 0x43300000
	.long	1160773632              ## 0x45300000
	.long	0                       ## 0x0
	.long	0                       ## 0x0
LCPI0_2:
	.quad	4841369599423283200     ## double 4503599627370496
	.quad	4985484787499139072     ## double 1.9342813113834067E+25
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$112, %rsp
	movl	$0, -4(%rbp)
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	leaq	-36(%rbp), %rsi
	movl	%eax, -60(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_scanf
	movl	-36(%rbp), %esi
	leaq	L_.str.2(%rip), %rdi
	movl	%eax, -64(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	leaq	-40(%rbp), %rsi
	movl	%eax, -68(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_scanf
	movl	%eax, -72(%rbp)         ## 4-byte Spill
	callq	_clock
	movq	%rax, -16(%rbp)
	movl	$0, -44(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	cvtsi2sdl	-36(%rbp), %xmm0
	callq	_recursion
	movsd	%xmm0, -56(%rbp)
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB0_1
LBB0_4:
	movsd	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	%xmm0, -80(%rbp)        ## 8-byte Spill
	callq	_clock
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	movaps	LCPI0_1(%rip), %xmm1    ## xmm1 = [1127219200,1160773632,0,0]
	punpckldq	%xmm1, %xmm0    ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movapd	LCPI0_2(%rip), %xmm1    ## xmm1 = [4.503599627370496E+15,1.9342813113834067E+25]
	subpd	%xmm1, %xmm0
	haddpd	%xmm0, %xmm0
	movsd	-80(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	-36(%rbp), %esi
	movsd	-56(%rbp), %xmm0        ## xmm0 = mem[0],zero
	movsd	-32(%rbp), %xmm1        ## xmm1 = mem[0],zero
	leaq	L_.str.3(%rip), %rdi
	movb	$2, %al
	callq	_printf
	movl	%eax, -84(%rbp)         ## 4-byte Spill
	callq	_clock
	movq	%rax, -16(%rbp)
	movl	$0, -44(%rbp)
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	LBB0_8
## %bb.6:                               ##   in Loop: Header=BB0_5 Depth=1
	cvtsi2sdl	-36(%rbp), %xmm0
	callq	_iteration
	movsd	%xmm0, -56(%rbp)
## %bb.7:                               ##   in Loop: Header=BB0_5 Depth=1
	movl	-44(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -44(%rbp)
	jmp	LBB0_5
LBB0_8:
	movsd	LCPI0_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	%xmm0, -96(%rbp)        ## 8-byte Spill
	callq	_clock
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, %xmm0
	movaps	LCPI0_1(%rip), %xmm1    ## xmm1 = [1127219200,1160773632,0,0]
	punpckldq	%xmm1, %xmm0    ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movapd	LCPI0_2(%rip), %xmm1    ## xmm1 = [4.503599627370496E+15,1.9342813113834067E+25]
	subpd	%xmm1, %xmm0
	haddpd	%xmm0, %xmm0
	movsd	-96(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	-36(%rbp), %esi
	movsd	-56(%rbp), %xmm0        ## xmm0 = mem[0],zero
	movsd	-32(%rbp), %xmm1        ## xmm1 = mem[0],zero
	leaq	L_.str.4(%rip), %rdi
	movb	$2, %al
	callq	_printf
	xorl	%edx, %edx
	movl	%eax, -100(%rbp)        ## 4-byte Spill
	movl	%edx, %eax
	addq	$112, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function recursion
LCPI1_0:
	.quad	4607182418800017408     ## double 1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_recursion
	.p2align	4, 0x90
_recursion:                             ## @recursion
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movsd	LCPI1_0(%rip), %xmm1    ## xmm1 = mem[0],zero
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0         ## xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	LBB1_2
## %bb.1:
	movsd	LCPI1_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	-8(%rbp), %xmm1         ## xmm1 = mem[0],zero
	movsd	-8(%rbp), %xmm2         ## xmm2 = mem[0],zero
	subsd	%xmm0, %xmm2
	movaps	%xmm2, %xmm0
	movsd	%xmm1, -16(%rbp)        ## 8-byte Spill
	callq	_recursion
	movsd	-16(%rbp), %xmm1        ## 8-byte Reload
                                        ## xmm1 = mem[0],zero
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -24(%rbp)        ## 8-byte Spill
	jmp	LBB1_3
LBB1_2:
	movsd	LCPI1_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	%xmm0, -24(%rbp)        ## 8-byte Spill
	jmp	LBB1_3
LBB1_3:
	movsd	-24(%rbp), %xmm0        ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function iteration
LCPI2_0:
	.quad	4607182418800017408     ## double 1
LCPI2_1:
	.quad	-4616189618054758400    ## double -1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_iteration
	.p2align	4, 0x90
_iteration:                             ## @iteration
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movsd	LCPI2_0(%rip), %xmm1    ## xmm1 = mem[0],zero
	movsd	%xmm0, -8(%rbp)
	movsd	%xmm1, -16(%rbp)
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	movsd	LCPI2_0(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	-8(%rbp), %xmm1         ## xmm1 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	jbe	LBB2_3
## %bb.2:                               ##   in Loop: Header=BB2_1 Depth=1
	movsd	LCPI2_1(%rip), %xmm0    ## xmm0 = mem[0],zero
	movsd	-8(%rbp), %xmm1         ## xmm1 = mem[0],zero
	movaps	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	movsd	%xmm2, -8(%rbp)
	mulsd	-16(%rbp), %xmm1
	movsd	%xmm1, -16(%rbp)
	jmp	LBB2_1
LBB2_3:
	movsd	-16(%rbp), %xmm0        ## xmm0 = mem[0],zero
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Enter the value of n, to compute n!: "

L_.str.1:                               ## @.str.1
	.asciz	"%d"

L_.str.2:                               ## @.str.2
	.asciz	"How many times do you want %d! to be computed? : "

L_.str.3:                               ## @.str.3
	.asciz	"Recursion: %d! = %1.0f time = %1.10f s\n"

L_.str.4:                               ## @.str.4
	.asciz	"Iteration: %d! = %1.0f time = %1.10f s\n"


.subsections_via_symbols
