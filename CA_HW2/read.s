# FILE *input(-24 на стеке) -> r12
# int size (-4 на стеке) -> r13d

	.intel_syntax noprefix		# Синтаксис intel
	.text
	.globl	read_data		# Доступ к функции для внешних единиц компиляции
read_data:			# Функция read_data
	push	rbp		# /
	mov	rbp, rsp	#| Выделение фрейма
	sub	rsp, 32		# \
	mov	r12, rdi	# r12 = FILE *input
	mov	edx, 2		# edx = 2 (3й аргумент функции)
	mov	esi, 0		# esi = 0 (2й аргмуент функции)
	mov	rdi, r12	# rdi = FILE *input (1й аргумент функции)
	call	fseek@PLT	# Вызов fseek

	mov	rdi, r12	# rdi = FILE *input (1й аргумент функции)
	call	ftell@PLT	# Вызов ftell
	mov	r13d, eax	# int size = результат ftell(длина строки)

	mov	edx, 0		# edx = 0 (3й аргумент функции)
	mov	esi, 0		# esi = 0 (2й аргумент функции)
	mov	rdi, r12	# rdi = FILE *input(1й аргумент функции)
	call	fseek@PLT	# Вызов fseek
	mov	eax, r13d	# eax = size
	mov	rdi, rax	# rdi = rax (1й аргумент функции)
	call	malloc@PLT	# Вызов malloc (string = malloc(size);)
	mov	QWORD PTR string[rip], rax	# char *string = rax (область памяти; результат malloc)
	movsx	rdx, r13d			# rdx = size (3й аргумент функции)
	mov	rcx, r12			# rcx = FILE *input (4й аргумент функции)
	mov	esi, 1				# esi = 1 (2й аргумент функции)
	mov	rdi, QWORD PTR string[rip]	# rdi = QWORD PTR string[rip] (1й аргумент функции; char *string)
	call	fread@PLT			# Вызов fread
	mov	eax, r13d			# eax = r13d (функция возвращает size)
	leave	# /
	ret	# \ Выход из функции
