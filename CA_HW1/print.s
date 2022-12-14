# arr_size (-20 на стеке (-20[rbp])) -> r12d
# FILE *output (-32[rbp]) -> r13
# int i = 0 (счетчик цикла; -4[rbp]) -> r14d

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.section	.rodata		# read only секция
.LC0:
	.string	"Result: "
.LC1:
	.string	"%d"
	.text
	.globl	print_data		# Определение print_data для внешних единиц компиляции
	.type	print_data, @function	# Определение print_data как функции
print_data:
	push	rbp		# /
	mov	rbp, rsp	# | Выделение фрейма
	sub	rsp, 32		# \
	mov	r12d, edi	# r12d = arr_size
	mov	r13, rsi	# r13 = FILE *output

	mov	rcx, r13	# rcx = FILE *output (4й аргумент функции fwrite)
	mov	edx, 8		# 3й аргумент функции fwrite = sizeof("Result: ")
	mov	esi, 1		# 2й аргумент функции fwrite = size (Размер каждого символа в байтах)
	lea	rdi, .LC0[rip]	# rdi = "Result: " (1й аргумент функции fwrite)
	call	fwrite@PLT	# Вызов fwrite

	mov	r14d, 0		# int i = 0
	jmp	.L2		# Переход на .L2

.L3:				# Тело цикла
	mov	eax, r14d	# eax = i
	lea	rdx, 0[0+rax*4]
	lea	rax, ResultArray[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	rdi, r13	# rdi = FILE *output	(1й аргумент функции)
	lea	rsi, .LC1[rip]	# rsi = "%d"		(2й аргумент функции)
	mov	eax, 0
	call	fprintf@PLT	# Вызов fprintf

	mov	rsi, r13	# rsi = FILE *output	(2й аргумент функции)
	mov	edi, 32		# edi (0-3 bytes rdi) = 32 (1й аргумент функции)
	call	fputc@PLT	# Вызов fputc
	add	r14d, 1		# i += 1
.L2:
	cmp	r14d, r12d	# i cmp arr_size
	jl	.L3		# Если i < arr_size переходим на .L3
	mov	rsi, r13	# rsi (2й аргумент функции) = FILE *output
	mov	edi, 10		# edi (0-3 byte rdi) = 10
	call	fputc@PLT	# Вызов fputc

	leave			# / Выход из функции
	ret			# \
