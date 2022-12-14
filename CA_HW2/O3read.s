	.file	"read.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	read_data
	.type	read_data, @function
read_data:
	push	r14
	mov	edx, 2
	xor	esi, esi
	push	r13
	mov	r13, rdi
	push	r12
	call	fseek@PLT
	mov	rdi, r13
	call	ftell@PLT
	xor	edx, edx
	xor	esi, esi
	mov	rdi, r13
	mov	r12, rax
	mov	r14d, eax
	call	fseek@PLT
	movsx	r12, r12d
	mov	rdi, r12
	call	malloc@PLT
	mov	rcx, r13
	mov	rdx, r12
	mov	esi, 1
	mov	rdi, rax
	mov	QWORD PTR string[rip], rax
	call	fread@PLT
	mov	eax, r14d
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	read_data, .-read_data
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
