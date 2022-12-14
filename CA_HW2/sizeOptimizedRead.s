	.file	"read.c"
	.intel_syntax noprefix
	.text
	.globl	read_data
	.type	read_data, @function
read_data:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, 2
	mov	esi, 0
	mov	rdi, rax
	call	fseek@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	ftell@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, 0
	mov	esi, 0
	mov	rdi, rax
	call	fseek@PLT
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR string[rip], rax
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR string[rip]
	mov	rcx, QWORD PTR -24[rbp]
	mov	esi, 1
	mov	rdi, rax
	call	fread@PLT
	mov	eax, DWORD PTR -4[rbp]
	leave
	ret
	.size	read_data, .-read_data
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
