	.file	"calculate.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
	mov	eax, 1
.L2:
	test	edi, edi
	jle	.L5
	imul	eax, edi
	dec	edi
	jmp	.L2
.L5:
	ret
	.size	factorial, .-factorial
	.globl	numerator
	.type	numerator, @function
numerator:
	movaps	xmm1, xmm0
	mov	eax, 1
.L7:
	cmp	eax, edi
	jg	.L9
	cvtsi2sd	xmm3, eax
	movaps	xmm2, xmm0
	inc	eax
	subsd	xmm2, xmm3
	mulsd	xmm1, xmm2
	jmp	.L7
.L9:
	movaps	xmm0, xmm1
	ret
	.size	numerator, .-numerator
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"\320\237\321\200\320\265\320\262\321\213\321\210\320\265\320\275 \320\273\320\270\320\274\320\270\321\202 \320\276\320\266\320\270\320\264\320\260\320\275\320\270\321\217!"
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
	push	rbp
	push	rbx
	mov	ebx, 1
	sub	rsp, 40
	movsd	xmm2, QWORD PTR .LC1[rip]
	movsd	QWORD PTR [rsp], xmm0
	mulsd	xmm2, xmm0
	addsd	xmm2, QWORD PTR .LC2[rip]
.L14:
	mov	rax, QWORD PTR .LC1[rip]
	mov	edi, ebx
	inc	ebx
	movsd	QWORD PTR 16[rsp], xmm2
	movq	xmm0, rax
	call	numerator
	cvtsi2sd	xmm1, ebx
	mov	edi, ebx
	movsd	QWORD PTR 8[rsp], xmm0
	call	factorial
	movsd	xmm0, QWORD PTR [rsp]
	mov	ebp, eax
	call	pow@PLT
	cvtsi2sd	xmm6, ebp
	movsd	xmm3, QWORD PTR 8[rsp]
	movsd	xmm2, QWORD PTR 16[rsp]
	movaps	xmm1, xmm0
	movsd	QWORD PTR 24[rsp], xmm2
	divsd	xmm3, xmm6
	movaps	xmm0, xmm3
	mulsd	xmm0, xmm1
	addsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm0, xmm2
	movsd	QWORD PTR 16[rsp], xmm2
	call	round@PLT
	movsd	xmm4, QWORD PTR 24[rsp]
	movaps	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	divsd	xmm1, QWORD PTR .LC3[rip]
	movsd	QWORD PTR 8[rsp], xmm1
	mulsd	xmm0, xmm4
	call	round@PLT
	movsd	xmm1, QWORD PTR 8[rsp]
	movq	xmm5, QWORD PTR .LC4[rip]
	divsd	xmm0, QWORD PTR .LC3[rip]
	movsd	xmm4, QWORD PTR .LC5[rip]
	movsd	xmm2, QWORD PTR 16[rsp]
	movaps	xmm3, xmm1
	andps	xmm3, xmm5
	ucomisd	xmm4, xmm3
	jnb	.L17
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	xorps	xmm2, xmm2
	jmp	.L10
.L17:
	subsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC7[rip]
	andps	xmm0, xmm5
	comisd	xmm1, xmm0
	jbe	.L14
.L10:
	add	rsp, 40
	movaps	xmm0, xmm2
	pop	rbx
	pop	rbp
	ret
	.size	calculate, .-calculate
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1071644672
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	0
	.long	1090021888
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
	.long	-1
	.long	2146435071
	.align 8
.LC7:
	.long	1202590843
	.long	1064598241
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
