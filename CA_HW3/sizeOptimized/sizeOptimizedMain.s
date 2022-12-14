	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	getRandomNumber
	.type	getRandomNumber, @function
getRandomNumber:
	push	rax
	call	rand@PLT
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC0[rip]
	pop	rdx
	ret
	.size	getRandomNumber, .-getRandomNumber
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
	imul	rdi, rdi, 1000000000
	imul	rdx, rdx, 1000000000
	add	rdi, rsi
	add	rdx, rcx
	mov	rax, rdi
	sub	rax, rdx
	ret
	.size	timespecDiff, .-timespecDiff
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"-random"
.LC2:
	.string	"Random value is: "
.LC3:
	.string	"%.5f\n"
.LC6:
	.string	"\320\235\320\260 \320\264\320\260\320\275\320\275\320\276\320\274 \320\270\320\275\321\202\320\265\321\200\320\262\320\260\320\273\320\265 \321\201\321\202\320\265\320\277\320\265\320\275\320\275\320\276\320\271 \321\200\321\217\320\264 \321\200\320\260\321\201\321\205\320\276\320\264\320\270\321\202\321\201\321\217! \320\222\320\262\320\265\320\264\320\270\321\202\320\265 \320\267\320\275\320\260\321\207\320\265\320\275\320\270\320\265 \320\276\321\202 -1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276) \320\264\320\276 1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276)!"
.LC8:
	.string	"Elapsed: %ld ns\n"
.LC9:
	.string	"./main.exe <-random> <input file> <output file>"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	ebp, edi
	xor	edi, edi
	push	rbx
	mov	rbx, rsi
	sub	rsp, 56
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 3
	jne	.L5
	mov	rbp, QWORD PTR 8[rbx]
	lea	rsi, .LC1[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L6
	call	getRandomNumber
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	movsd	QWORD PTR 8[rsp], xmm0
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	lea	rsi, .LC3[rip]
	mov	al, 1
	mov	edi, 1
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	jmp	.L7
.L6:
	mov	rdi, rbp
	call	read_data@PLT
.L7:
	movaps	xmm1, xmm0
	andps	xmm1, XMMWORD PTR .LC4[rip]
	lea	rdi, .LC6[rip]
	comisd	xmm1, QWORD PTR .LC5[rip]
	jnb	.L14
	mulsd	xmm0, QWORD PTR .LC7[rip]
	call	round@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	divsd	xmm0, QWORD PTR .LC7[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	call	clock_gettime@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	call	calculate@PLT
	lea	rsi, 32[rsp]
	mov	edi, 1
	movsd	QWORD PTR 8[rsp], xmm0
	call	clock_gettime@PLT
	mov	rdi, QWORD PTR 16[rbx]
	movsd	xmm0, QWORD PTR 8[rsp]
	call	print_data@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR 32[rsp]
	mov	rsi, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 24[rsp]
	call	timespecDiff
	lea	rsi, .LC8[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	jmp	.L10
.L5:
	lea	rdi, .LC9[rip]
.L14:
	call	puts@PLT
.L10:
	add	rsp, 56
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC4:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC5:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1090021888
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
