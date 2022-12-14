	.file	"main.c"
	.intel_syntax noprefix
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
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	DWORD PTR -8[rbp], esi
	call	rand@PLT
	mov	edx, DWORD PTR -8[rbp]
	add	edx, 1
	mov	ecx, edx
	sub	ecx, DWORD PTR -4[rbp]
	cdq
	idiv	ecx
	mov	eax, DWORD PTR -4[rbp]
	add	eax, edx
	leave
	ret
	.size	getRandomNumber, .-getRandomNumber
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
	push	rbp
	mov	rbp, rsp
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
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	pop	rbp
	ret
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
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -68[rbp], 3
	jne	.L6
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L7
	mov	esi, 500000
	mov	edi, 10000
	call	getRandomNumber
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR string[rip], rax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	esi, 126
	mov	edi, 48
	call	getRandomNumber
	mov	edx, eax
	mov	rcx, QWORD PTR string[rip]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], dl
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L9
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR -20[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	print_result@PLT
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	jmp	.L10
.L7:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	jne	.L11
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L11:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	read_data@PLT
	mov	DWORD PTR -20[rbp], eax
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR -20[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	print_result@PLT
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	jmp	.L10
.L6:
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L10:
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespecDiff
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR string[rip]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L13:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
