	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	getRandomNumber
	.type	getRandomNumber, @function
getRandomNumber:
	push	rbp
	mov	ebp, edi
	push	rbx
	mov	ebx, esi
	sub	rsp, 8
	call	rand@PLT
	lea	esi, 1[rbx]
	add	rsp, 8
	sub	esi, ebp
	cdq
	pop	rbx
	idiv	esi
	lea	eax, [rdx+rbp]
	pop	rbp
	ret
	.size	getRandomNumber, .-getRandomNumber
	.p2align 4
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
.LC0:
	.string	"-random"
.LC1:
	.string	"rb"
.LC2:
	.string	"Input file doesn't exist!"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"./main.exe <-random> <input file> <output file>"
	.section	.rodata.str1.1
.LC4:
	.string	"Elapsed: %ld ns\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r13
	push	r12
	push	rbp
	mov	ebp, edi
	xor	edi, edi
	push	rbx
	mov	rbx, rsi
	sub	rsp, 40
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 3
	jne	.L6
	mov	rbp, QWORD PTR 8[rbx]
	lea	rsi, .LC0[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	je	.L15
	mov	rdi, rbp
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	rdi, rax
	test	rax, rax
	je	.L16
	call	read_data@PLT
	mov	rsi, rsp
	mov	edi, 1
	mov	ebp, eax
	call	clock_gettime@PLT
	mov	rdi, QWORD PTR 16[rbx]
	mov	esi, ebp
	call	print_result@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
.L10:
	imul	rdx, QWORD PTR 16[rsp], 1000000000
	add	rdx, QWORD PTR 24[rsp]
	mov	edi, 1
	imul	rax, QWORD PTR [rsp], 1000000000
	add	rax, QWORD PTR 8[rsp]
	lea	rsi, .LC4[rip]
	sub	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, QWORD PTR string[rip]
	call	free@PLT
.L12:
	add	rsp, 40
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L15:
	call	rand@PLT
	mov	ecx, 490001
	cdq
	idiv	ecx
	lea	r12d, 10000[rdx]
	mov	ebp, edx
	movsx	rdi, r12d
	call	malloc@PLT
	mov	QWORD PTR string[rip], rax
	test	r12d, r12d
	jle	.L8
	add	ebp, 9999
	xor	r13d, r13d
	.p2align 4,,10
	.p2align 3
.L9:
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1739733589
	sar	ecx, 31
	sar	rdx, 37
	sub	edx, ecx
	imul	edx, edx, 79
	sub	eax, edx
	mov	rdx, QWORD PTR string[rip]
	add	eax, 48
	mov	BYTE PTR [rdx+r13], al
	mov	rax, r13
	add	r13, 1
	cmp	rax, rbp
	jne	.L9
.L8:
	mov	rsi, rsp
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rdi, QWORD PTR 16[rbx]
	mov	esi, r12d
	call	print_result@PLT
	lea	rsi, 16[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
	jmp	.L10
.L6:
	lea	rdi, .LC3[rip]
	call	puts@PLT
	jmp	.L12
.L16:
	lea	rdi, .LC2[rip]
	call	puts@PLT
	jmp	.L12
	.size	main, .-main
	.globl	string
	.bss
	.align 8
	.type	string, @object
	.size	string, 8
string:
	.zero	8
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
