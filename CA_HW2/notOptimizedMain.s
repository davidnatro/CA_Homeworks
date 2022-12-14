	.file	"main.c"
	.text
	.globl	string
	.bss
	.align 8
	.type	string, @object
	.size	string, 8
string:
	.zero	8
	.text
	.globl	getRandomNumber
	.type	getRandomNumber, @function
getRandomNumber:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	call	rand@PLT
	movl	-8(%rbp), %edx
	addl	$1, %edx
	movl	%edx, %ecx
	subl	-4(%rbp), %ecx
	cltd
	idivl	%ecx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	getRandomNumber, .-getRandomNumber
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rsi, %rax
	movq	%rdi, %r8
	movq	%r8, %rsi
	movq	%r9, %rdi
	movq	%rax, %rdi
	movq	%rsi, -32(%rbp)
	movq	%rdi, -24(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rcx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	addq	%rax, -16(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	imulq	$1000000000, %rax, %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	addq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	subq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC0:
	.string	"-random"
.LC1:
	.string	"rb"
.LC2:
	.string	"Input file doesn't exist!"
	.align 8
.LC3:
	.string	"./main.exe <-random> <input file> <output file>"
.LC4:
	.string	"Elapsed: %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	cmpl	$3, -84(%rbp)
	jne	.L6
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC0(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L7
	movl	$500000, %esi
	movl	$10000, %edi
	call	getRandomNumber
	movl	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	cltq
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, string(%rip)
	movl	$0, -72(%rbp)
	jmp	.L8
.L9:
	movl	$126, %esi
	movl	$48, %edi
	call	getRandomNumber
	movl	%eax, %edx
	movq	string(%rip), %rcx
	movl	-72(%rbp), %eax
	cltq
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addl	$1, -72(%rbp)
.L8:
	movl	-72(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.L9
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-96(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	-68(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_result@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	jmp	.L10
.L7:
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	jne	.L11
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L13
.L11:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	read_data@PLT
	movl	%eax, -68(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-96(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movl	-68(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_result@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	jmp	.L10
.L6:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L13
.L10:
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	timespecDiff
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	string(%rip), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
.L13:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
