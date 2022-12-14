	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	getRandomNumber
	.type	getRandomNumber, @function
getRandomNumber:
.LFB51:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC0[rip]
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE51:
	.size	getRandomNumber, .-getRandomNumber
	.p2align 4
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
.LFB52:
	.cfi_startproc
	endbr64
	imul	rdi, rdi, 1000000000
	imul	rdx, rdx, 1000000000
	add	rdi, rsi
	add	rdx, rcx
	mov	rax, rdi
	sub	rax, rdx
	ret
	.cfi_endproc
.LFE52:
	.size	timespecDiff, .-timespecDiff
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"-random"
.LC2:
	.string	"Random value is: "
.LC3:
	.string	"%.5f\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"\320\235\320\260 \320\264\320\260\320\275\320\275\320\276\320\274 \320\270\320\275\321\202\320\265\321\200\320\262\320\260\320\273\320\265 \321\201\321\202\320\265\320\277\320\265\320\275\320\275\320\276\320\271 \321\200\321\217\320\264 \321\200\320\260\321\201\321\205\320\276\320\264\320\270\321\202\321\201\321\217! \320\222\320\262\320\265\320\264\320\270\321\202\320\265 \320\267\320\275\320\260\321\207\320\265\320\275\320\270\320\265 \320\276\321\202 -1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276) \320\264\320\276 1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276)!"
	.section	.rodata.str1.1
.LC8:
	.string	"Elapsed: %ld ns\n"
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"./main.exe <-random> <input file> <output file>"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB53:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	ebp, edi
	xor	edi, edi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	mov	rbx, rsi
	sub	rsp, 72
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 56[rsp], rax
	xor	eax, eax
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 3
	jne	.L6
	mov	rbp, QWORD PTR 8[rbx]
	lea	rsi, .LC1[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	je	.L16
	mov	rdi, rbp
	call	read_data@PLT
.L8:
	movapd	xmm1, xmm0
	andpd	xmm1, XMMWORD PTR .LC4[rip]
	comisd	xmm1, QWORD PTR .LC5[rip]
	jnb	.L17
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
	lea	rsi, .LC8[rip]
	mov	edi, 1
	imul	rdx, QWORD PTR 32[rsp], 1000000000
	add	rdx, QWORD PTR 40[rsp]
	imul	rax, QWORD PTR 16[rsp], 1000000000
	add	rax, QWORD PTR 24[rsp]
	sub	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
.L11:
	mov	rax, QWORD PTR 56[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L18
	add	rsp, 72
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.L16:
	.cfi_restore_state
	call	rand@PLT
	pxor	xmm0, xmm0
	mov	edi, 1
	lea	rsi, .LC2[rip]
	cvtsi2sd	xmm0, eax
	xor	eax, eax
	divsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	mov	edi, 1
	lea	rsi, .LC3[rip]
	mov	eax, 1
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	jmp	.L8
.L6:
	lea	rdi, .LC9[rip]
	call	puts@PLT
	jmp	.L11
.L17:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L11
.L18:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE53:
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
