	.file	"calculate.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -8[rbp], 1
	mov	eax, DWORD PTR -20[rbp]
	mov	DWORD PTR -4[rbp], eax
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -8[rbp]
	imul	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -8[rbp], eax
	sub	DWORD PTR -4[rbp], 1
.L2:
	cmp	DWORD PTR -4[rbp], 0
	jg	.L3
	mov	eax, DWORD PTR -8[rbp]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.globl	numerator
	.type	numerator, @function
numerator:
.LFB1:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	movsd	QWORD PTR -24[rbp], xmm0
	mov	DWORD PTR -28[rbp], edi
	movsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -12[rbp], 1
	jmp	.L6
.L7:
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -12[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -8[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -12[rbp], 1
.L6:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jle	.L7
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	numerator, .-numerator
	.section	.rodata
	.align 8
.LC5:
	.string	"\320\237\321\200\320\265\320\262\321\213\321\210\320\265\320\275 \320\273\320\270\320\274\320\270\321\202 \320\276\320\266\320\270\320\264\320\260\320\275\320\270\321\217!"
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB2:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 72
	.cfi_offset 3, -24
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
	mov	DWORD PTR -64[rbp], 1
	mov	DWORD PTR -60[rbp], 2
.L16:
	mov	eax, DWORD PTR -64[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -64[rbp], edx
	mov	rdx, QWORD PTR -40[rbp]
	mov	edi, eax
	movq	xmm0, rdx
	call	numerator
	movq	rbx, xmm0
	mov	eax, DWORD PTR -60[rbp]
	mov	edi, eax
	call	factorial
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	movq	xmm2, rbx
	divsd	xmm2, xmm0
	movsd	QWORD PTR -80[rbp], xmm2
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -60[rbp]
	mov	rax, QWORD PTR -72[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm1, QWORD PTR -56[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	add	DWORD PTR -60[rbp], 1
	movsd	xmm1, QWORD PTR -56[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	call	round@PLT
	movq	rax, xmm0
	movsd	xmm1, QWORD PTR .LC2[rip]
	movq	xmm0, rax
	divsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	xmm1, QWORD PTR -48[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	call	round@PLT
	movq	rax, xmm0
	movsd	xmm1, QWORD PTR .LC2[rip]
	movq	xmm0, rax
	divsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -32[rbp]
	movq	xmm1, QWORD PTR .LC3[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	ucomisd	xmm0, xmm1
	jnb	.L18
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	pxor	xmm0, xmm0
	jmp	.L12
.L18:
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -32[rbp]
	movq	xmm1, QWORD PTR .LC3[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC7[rip]
	comisd	xmm0, xmm1
	ja	.L19
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
	jmp	.L16
.L19:
	nop
	movsd	xmm0, QWORD PTR -56[rbp]
.L12:
	movq	rax, xmm0
	movq	xmm0, rax
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	calculate, .-calculate
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1090021888
	.align 16
.LC3:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC4:
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
