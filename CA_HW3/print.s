# r12 (-24 на стеке) -> char *path
# r13 (-8 на стеке) -> FILE *file
# Так как регистры xmm затираются, оставим их на стеке

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.section	.rodata		# read only секция
.LC0:
	.string	"w"
.LC1:
	.string	"%.5f\n"
	.text
	.globl	print_data		# Доступ внешних единиц компиляции к print_data
print_data:				# Функция print_data
	push	rbp			# /
	mov	rbp, rsp		#| Выделение стека
	sub	rsp, 32			# \
	mov	r12, rdi		# r12 = char *path
	movsd	QWORD PTR -32[rbp], xmm0 # (-32 на стеке) = data
	lea	rsi, .LC0[rip]		# rsi = "w"	(2й аргумент функции)
	mov	rdi, r12		# rdi = char *path (1й аргумент функции)
	call	fopen@PLT		# Вызов fopen
	mov	r13, rax		# r13 = результат fopen (указатель FILE)
	movq	xmm0, QWORD PTR -32[rbp] # xmm0 = data (xmm0 используется для передачи параметров ; 3й аргумент функции)
	lea	rsi, .LC1[rip]		# rsi = "%.5f\n" (2й аргумент функции)
	mov	rdi, r13		# rdi = FILE *file (1й аргумент функции)
	call	fprintf@PLT		# Вызов fprintf

	leave	# /
	ret	# \ Выход из функции
