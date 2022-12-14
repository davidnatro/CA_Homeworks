	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	getRandomNumber
	.type	getRandomNumber, @function
getRandomNumber:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movsd	xmm1, QWORD PTR .LC0[rip]
	divsd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
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
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC1:
	.string	"-random"
.LC2:
	.string	"Random value is: "
.LC3:
	.string	"%.5f\n"
	.align 8
.LC6:
	.string	"\320\235\320\260 \320\264\320\260\320\275\320\275\320\276\320\274 \320\270\320\275\321\202\320\265\321\200\320\262\320\260\320\273\320\265 \321\201\321\202\320\265\320\277\320\265\320\275\320\275\320\276\320\271 \321\200\321\217\320\264 \321\200\320\260\321\201\321\205\320\276\320\264\320\270\321\202\321\201\321\217! \320\222\320\262\320\265\320\264\320\270\321\202\320\265 \320\267\320\275\320\260\321\207\320\265\320\275\320\270\320\265 \320\276\321\202 -1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276) \320\264\320\276 1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276)!"
	.align 8
.LC8:
	.string	"./main.exe <-random> <input file> <output file>"
.LC9:
	.string	"Elapsed: %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -68[rbp], 3
	jne	.L6
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L7
	mov	eax, 0
	call	getRandomNumber
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	jmp	.L8
.L7:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	read_data@PLT
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
.L8:
	movsd	xmm0, QWORD PTR -64[rbp]
	movq	xmm1, QWORD PTR .LC4[rip]
	andpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC5[rip]
	comisd	xmm0, xmm1
	jb	.L16
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L16:
	movsd	xmm1, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	call	round@PLT
	movq	rax, xmm0
	movsd	xmm1, QWORD PTR .LC7[rip]
	movq	xmm0, rax
	divsd	xmm0, xmm1
	movsd	QWORD PTR -64[rbp], xmm0
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	call	calculate@PLT
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR -64[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	call	print_data@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -32[rbp]
	mov	rsi, QWORD PTR -24[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespecDiff
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L13
.L6:
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
.L13:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.align 16
.LC4:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
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
