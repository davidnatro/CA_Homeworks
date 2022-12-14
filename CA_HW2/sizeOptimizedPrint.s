	.file	"print.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w+"
.LC1:
	.string	"Letters: "
.LC2:
	.string	"%d"
.LC3:
	.string	"Digits: "
	.text
	.globl	print_result
	.type	print_result, @function
print_result:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR -44[rbp], esi
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	mov	DWORD PTR -12[rbp], 0
	jmp	.L2
.L7:
	mov	rdx, QWORD PTR string[rip]
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -25[rbp], al
	cmp	BYTE PTR -25[rbp], 47
	jle	.L3
	cmp	BYTE PTR -25[rbp], 57
	jg	.L3
	add	DWORD PTR -8[rbp], 1
	jmp	.L4
.L3:
	cmp	BYTE PTR -25[rbp], 64
	jle	.L5
	cmp	BYTE PTR -25[rbp], 90
	jle	.L6
.L5:
	cmp	BYTE PTR -25[rbp], 96
	jle	.L4
	cmp	BYTE PTR -25[rbp], 122
	jg	.L4
.L6:
	add	DWORD PTR -4[rbp], 1
.L4:
	add	DWORD PTR -12[rbp], 1
.L2:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L7
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 9
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	edx, DWORD PTR -4[rbp]
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	mov	edi, 10
	call	fputc@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rcx, rax
	mov	edx, 8
	mov	esi, 1
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	edx, DWORD PTR -8[rbp]
	mov	rax, QWORD PTR -24[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	mov	edi, 10
	call	fputc@PLT
	nop
	leave
	ret
	.size	print_result, .-print_result
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
