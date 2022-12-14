	.file	"read.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"%lf"
	.text
	.globl	read_data
	.type	read_data, @function
read_data:
	sub	rsp, 24
	lea	rsi, .LC0[rip]
	call	fopen@PLT
	lea	rdx, 8[rsp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	read_data, .-read_data
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
