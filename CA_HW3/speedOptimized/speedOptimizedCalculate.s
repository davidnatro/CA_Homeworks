	.file	"calculate.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB23:
	.cfi_startproc
	endbr64
	mov	eax, 1
	test	edi, edi
	jle	.L4
	.p2align 4,,10
	.p2align 3
.L3:
	imul	eax, edi
	sub	edi, 1
	jne	.L3
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	ret
	.cfi_endproc
.LFE23:
	.size	factorial, .-factorial
	.p2align 4
	.globl	numerator
	.type	numerator, @function
numerator:
.LFB24:
	.cfi_startproc
	endbr64
	test	edi, edi
	jle	.L10
	add	edi, 1
	movapd	xmm1, xmm0
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L9:
	pxor	xmm3, xmm3
	movapd	xmm2, xmm0
	cvtsi2sd	xmm3, eax
	add	eax, 1
	subsd	xmm2, xmm3
	mulsd	xmm1, xmm2
	cmp	eax, edi
	jne	.L9
	movapd	xmm0, xmm1
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	movapd	xmm1, xmm0
	movapd	xmm0, xmm1
	ret
	.cfi_endproc
.LFE24:
	.size	numerator, .-numerator
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"\320\237\321\200\320\265\320\262\321\213\321\210\320\265\320\275 \320\273\320\270\320\274\320\270\321\202 \320\276\320\266\320\270\320\264\320\260\320\275\320\270\321\217!"
	.text
	.p2align 4
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB25:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	ebp, 2
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 40
	.cfi_def_cfa_offset 64
	movsd	xmm3, QWORD PTR .LC0[rip]
	movsd	QWORD PTR 24[rsp], xmm0
	mulsd	xmm0, xmm3
	addsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR [rsp], xmm0
	.p2align 4,,10
	.p2align 3
.L18:
	movapd	xmm2, xmm3
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L13:
	pxor	xmm1, xmm1
	movapd	xmm0, xmm3
	cvtsi2sd	xmm1, eax
	add	eax, 1
	subsd	xmm0, xmm1
	mulsd	xmm2, xmm0
	cmp	ebp, eax
	jne	.L13
	mov	ebx, 1
	.p2align 4,,10
	.p2align 3
.L14:
	imul	ebx, eax
	sub	eax, 1
	jne	.L14
	pxor	xmm1, xmm1
	movsd	xmm0, QWORD PTR 24[rsp]
	movsd	QWORD PTR 8[rsp], xmm2
	cvtsi2sd	xmm1, ebp
	add	ebp, 1
	call	pow@PLT
	pxor	xmm1, xmm1
	movsd	xmm2, QWORD PTR 8[rsp]
	cvtsi2sd	xmm1, ebx
	divsd	xmm2, xmm1
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	addsd	xmm2, QWORD PTR [rsp]
	mulsd	xmm0, xmm2
	movsd	QWORD PTR 16[rsp], xmm2
	call	round@PLT
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	divsd	xmm1, QWORD PTR .LC3[rip]
	movsd	QWORD PTR 8[rsp], xmm1
	mulsd	xmm0, QWORD PTR [rsp]
	call	round@PLT
	movsd	xmm1, QWORD PTR 8[rsp]
	movsd	xmm6, QWORD PTR .LC5[rip]
	divsd	xmm0, QWORD PTR .LC3[rip]
	mov	rax, QWORD PTR .LC0[rip]
	movsd	xmm2, QWORD PTR 16[rsp]
	movapd	xmm4, xmm1
	andpd	xmm4, XMMWORD PTR .LC4[rip]
	movq	xmm3, rax
	ucomisd	xmm6, xmm4
	jb	.L27
	subsd	xmm0, xmm1
	movsd	xmm7, QWORD PTR .LC7[rip]
	andpd	xmm0, XMMWORD PTR .LC4[rip]
	comisd	xmm7, xmm0
	ja	.L12
	movsd	QWORD PTR [rsp], xmm2
	jmp	.L18
.L27:
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	pxor	xmm2, xmm2
.L12:
	add	rsp, 40
	.cfi_def_cfa_offset 24
	movapd	xmm0, xmm2
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	calculate, .-calculate
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
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
