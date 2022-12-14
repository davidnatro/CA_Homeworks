	.file	"print.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
.LC1:
	.string	"%.5f\n"
	.text
	.globl	print_data
	.type	print_data, @function
print_data:
	sub	rsp, 24
	lea	rsi, .LC0[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	call	fopen@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	mov	esi, 1
	lea	rdx, .LC1[rip]
	mov	rdi, rax
	add	rsp, 24
	mov	al, 1
	jmp	__fprintf_chk@PLT
	.size	print_data, .-print_data
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
