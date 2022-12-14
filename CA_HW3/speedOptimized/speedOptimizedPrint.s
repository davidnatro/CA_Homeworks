	.file	"print.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
.LC1:
	.string	"%.5f\n"
	.text
	.p2align 4
	.globl	print_data
	.type	print_data, @function
print_data:
.LFB23:
	.cfi_startproc
	endbr64
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rsi, .LC0[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	call	fopen@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	mov	esi, 1
	lea	rdx, .LC1[rip]
	mov	rdi, rax
	add	rsp, 24
	.cfi_def_cfa_offset 8
	mov	eax, 1
	jmp	__fprintf_chk@PLT
	.cfi_endproc
.LFE23:
	.size	print_data, .-print_data
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
