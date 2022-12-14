# r12 (-24 на стеке) -> char *path (1й аргумент функции)
# r13 (8 на стеке) -> FILE *file (результат fopen)
# переменную result оставим на стеке, так как на нее требуется ссылка

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.section	.rodata		# read only секция
.LC0:
	.string	"r"
.LC1:
	.string	"%lf"
	.text
	.globl	read_data		# Доступ к read_data для других единиц компиляции
read_data:				# Функция read_data
	push	rbp			# /
	mov	rbp, rsp		#| Выделение стека
	sub	rsp, 32			# \
	mov	r12, rdi		# r12 = char *path (сохраняем 1й аргумент функции)
	lea	rsi, .LC0[rip]		# rsi = "r"	( 2й аргумент функции fopen)
	mov	rdi, r12		# rdi = char *path (1й аргумент функции fopen)
	call	fopen@PLT		# Вызов fopen
	mov	r13, rax		# r13 = результат fopen (возвращает указатель FILE)
					# переменную result оставим на стеке, так как на нее требуется ссылка
	lea	rdx, -16[rbp]		# rdx = &result (3й аргумент функции)
	lea	rsi, .LC1[rip]		# rsi = "%lf" (2й аргумент функции)
	mov	rdi, r13		# rdi = FILE *file (1й аргумент функции)
	call	__isoc99_fscanf@PLT	# Вызов fscanf
	movsd	xmm0, QWORD PTR -16[rbp]# xmm0 = result (xmm0 - 128 битный регистр)
	movq	rax, xmm0		# возвращаем xmm0(result)
	leave	# /
	ret	# \ Выход из функции
