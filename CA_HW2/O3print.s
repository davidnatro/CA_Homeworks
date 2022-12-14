	.file	"print.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w+"
.LC7:
	.string	"Letters: "
.LC8:
	.string	"%d"
.LC9:
	.string	"Digits: "
	.text
	.p2align 4
	.globl	print_result
	.type	print_result, @function
print_result:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	ebx, esi
	lea	rsi, .LC0[rip]
	sub	rsp, 8
	call	fopen@PLT
	mov	rbp, rax
	test	ebx, ebx
	jle	.L38
	lea	eax, -1[rbx]
	mov	rdx, QWORD PTR string[rip]
	cmp	eax, 14
	jbe	.L39
	mov	ecx, ebx
	mov	rax, rdx
	pxor	xmm11, xmm11
	movdqa	xmm10, XMMWORD PTR .LC1[rip]
	shr	ecx, 4
	movdqa	xmm7, XMMWORD PTR .LC4[rip]
	movdqa	xmm9, XMMWORD PTR .LC2[rip]
	movdqa	xmm1, xmm11
	sub	ecx, 1
	pxor	xmm4, xmm4
	pxor	xmm3, xmm3
	movdqa	xmm8, XMMWORD PTR .LC3[rip]
	sal	rcx, 4
	movdqa	xmm6, XMMWORD PTR .LC5[rip]
	movdqa	xmm5, XMMWORD PTR .LC6[rip]
	lea	rcx, 16[rdx+rcx]
	.p2align 4,,10
	.p2align 3
.L4:
	movdqu	xmm12, XMMWORD PTR [rax]
	movdqu	xmm0, XMMWORD PTR [rax]
	movdqa	xmm13, xmm4
	add	rax, 16
	paddb	xmm12, xmm10
	pand	xmm0, xmm9
	psubusb	xmm12, xmm6
	paddb	xmm0, xmm8
	pcmpeqb	xmm12, xmm4
	movdqa	xmm2, xmm0
	pminub	xmm2, xmm7
	pcmpeqb	xmm0, xmm2
	movdqa	xmm2, xmm12
	pcmpeqb	xmm2, xmm4
	pand	xmm0, xmm2
	pcmpgtb	xmm13, xmm0
	movdqa	xmm2, xmm0
	punpcklbw	xmm2, xmm13
	punpckhbw	xmm0, xmm13
	movdqa	xmm13, xmm3
	pcmpgtw	xmm13, xmm2
	movdqa	xmm14, xmm2
	punpcklwd	xmm14, xmm13
	punpckhwd	xmm2, xmm13
	movdqa	xmm13, xmm3
	pcmpgtw	xmm13, xmm0
	psubd	xmm1, xmm14
	psubd	xmm1, xmm2
	movdqa	xmm2, xmm0
	punpcklwd	xmm2, xmm13
	psubd	xmm1, xmm2
	movdqa	xmm2, xmm0
	movdqa	xmm0, xmm12
	punpckhwd	xmm2, xmm13
	pand	xmm0, xmm5
	movdqa	xmm13, xmm3
	psubd	xmm1, xmm2
	movdqa	xmm2, xmm4
	movdqa	xmm12, xmm0
	pcmpgtb	xmm2, xmm0
	punpcklbw	xmm12, xmm2
	punpckhbw	xmm0, xmm2
	pcmpgtw	xmm13, xmm12
	movdqa	xmm2, xmm12
	punpcklwd	xmm2, xmm13
	punpckhwd	xmm12, xmm13
	paddd	xmm2, xmm11
	movdqa	xmm11, xmm3
	pcmpgtw	xmm11, xmm0
	paddd	xmm2, xmm12
	movdqa	xmm12, xmm0
	punpcklwd	xmm12, xmm11
	punpckhwd	xmm0, xmm11
	paddd	xmm2, xmm12
	paddd	xmm2, xmm0
	movdqa	xmm11, xmm2
	cmp	rax, rcx
	jne	.L4
	movdqa	xmm0, xmm2
	mov	eax, ebx
	psrldq	xmm0, 8
	and	eax, -16
	paddd	xmm11, xmm0
	movdqa	xmm0, xmm11
	psrldq	xmm0, 4
	paddd	xmm11, xmm0
	movdqa	xmm0, xmm1
	psrldq	xmm0, 8
	movd	r12d, xmm11
	paddd	xmm1, xmm0
	movdqa	xmm0, xmm1
	psrldq	xmm0, 4
	paddd	xmm1, xmm0
	movd	r13d, xmm1
	test	bl, 15
	je	.L2
.L3:
	movsx	rcx, eax
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	jbe	.L43
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
.L8:
	lea	ecx, 1[rax]
	cmp	ecx, ebx
	jge	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L9
	add	r12d, 1
.L10:
	lea	ecx, 2[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L11
	add	r12d, 1
.L12:
	lea	ecx, 3[rax]
	cmp	ecx, ebx
	jge	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L13
	add	r12d, 1
.L14:
	lea	ecx, 4[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L15
	add	r12d, 1
.L16:
	lea	ecx, 5[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L17
	add	r12d, 1
.L18:
	lea	ecx, 6[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L19
	add	r12d, 1
.L20:
	lea	ecx, 7[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	jbe	.L44
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
.L22:
	lea	ecx, 8[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L23
	add	r12d, 1
.L24:
	lea	ecx, 9[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L25
	add	r12d, 1
.L26:
	lea	ecx, 10[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L27
	add	r12d, 1
.L28:
	lea	ecx, 11[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L29
	add	r12d, 1
.L30:
	lea	ecx, 12[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L31
	add	r12d, 1
.L32:
	lea	ecx, 13[rax]
	cmp	ebx, ecx
	jle	.L2
	movsx	rcx, ecx
	movzx	ecx, BYTE PTR [rdx+rcx]
	lea	esi, -48[rcx]
	cmp	sil, 9
	ja	.L33
	add	r12d, 1
.L34:
	add	eax, 14
	cmp	ebx, eax
	jle	.L2
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	lea	edx, -48[rax]
	cmp	dl, 9
	jbe	.L35
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	r13d, 0
.L2:
	mov	rcx, rbp
	mov	edx, 9
	mov	esi, 1
	lea	rdi, .LC7[rip]
	call	fwrite@PLT
	mov	ecx, r13d
	mov	rdi, rbp
	mov	esi, 1
	lea	r13, .LC8[rip]
	xor	eax, eax
	mov	rdx, r13
	call	__fprintf_chk@PLT
	mov	rsi, rbp
	mov	edi, 10
	call	fputc@PLT
	mov	rcx, rbp
	mov	edx, 8
	mov	esi, 1
	lea	rdi, .LC9[rip]
	call	fwrite@PLT
	mov	rdi, rbp
	mov	ecx, r12d
	mov	rdx, r13
	mov	esi, 1
	xor	eax, eax
	call	__fprintf_chk@PLT
	add	rsp, 8
	mov	rsi, rbp
	mov	edi, 10
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	jmp	fputc@PLT
	.p2align 4,,10
	.p2align 3
.L43:
	add	r12d, 1
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L9:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L11:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L13:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L15:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L17:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L19:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L44:
	add	r12d, 1
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L23:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L24
	.p2align 4,,10
	.p2align 3
.L25:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L27:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L29:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L38:
	xor	r12d, r12d
	xor	r13d, r13d
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L31:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L33:
	and	ecx, -33
	sub	ecx, 65
	cmp	cl, 26
	adc	r13d, 0
	jmp	.L34
.L39:
	xor	eax, eax
	xor	r12d, r12d
	xor	r13d, r13d
	jmp	.L3
.L35:
	add	r12d, 1
	jmp	.L2
	.size	print_result, .-print_result
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.byte	-48
	.align 16
.LC2:
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.byte	-33
	.align 16
.LC3:
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.byte	-65
	.align 16
.LC4:
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.align 16
.LC5:
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.align 16
.LC6:
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
