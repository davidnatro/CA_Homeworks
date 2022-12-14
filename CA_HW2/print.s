# char *path (-40 на стеке) -> r12
# int size (-44 на стеке) -> r13d
# FILE *output (-24 на стеке) -> r14
# int i (-12 на стеке) -> r12d
# int count_digits (-8 на стеке) -> r15d
# int count_letters (-4 на стеке) -> r8d (так как все зарезирвированные регистры заняты,
					# будем использовать регистр r8d (только внутри тела функции!),
					# в качестве переменной count_letters,
					# который перед выходом из метода будет
					# перемещен на стек (-4), что бы избежать его
					# затирания после вызова fwrite)

# char temp (-25 на стеке) -> r9b (тоже самое, что и в предыдущих комментариях, проделаем с перменной temp,
					# которая находится внутри цикла, но сохранять впоследствии на стек
					# мы её не будем, так как она больше не понадобится.

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.section	.rodata		# read only секция
.LC0:
	.string	"w+"
.LC1:
	.string	"Letters: "
.LC2:
	.string	"%d"
.LC3:
	.string	"Digits: "
	.text
	.globl	print_result		# Функция доступна для внешних единиц компиляции
print_result:			# Функция print_result
	push	rbp		# /
	mov	rbp, rsp	#| Выделение фрейма
	sub	rsp, 48		# \
	mov	r12, rdi	# r12 = rdi (char *path  ; 1й аргумент функции)
	mov	r13d, esi	# r13d = esi (int size ; 2й аргумент функции)

	lea	rsi, .LC0[rip]	# rsi = "w+" (2й аргумент функции)
	mov	rdi, r12	# rdi = r12 (*path ; 1й аргумент функции)
	call	fopen@PLT	# Вызов fopen
	mov	r14, rax	# r14 = результат fopen (FILE *output)
	mov	r8d, 0		# int count_letters = 0
	mov	r15d, 0		# int count_digits = 0
	mov	r12d, 0		# int i = 0
	jmp	.L2		# Переход на .L2
.L7:						# Тело цикла
	mov	rdx, QWORD PTR string[rip]	# rdx = char *string
	mov	eax, r12d			# eax = i
	add	rax, rdx			# rax += rdx
	movzx	eax, BYTE PTR [rax]		# eax = string[i]
	mov	r9b, al				# r9b(char temp) = ((al)eax)string[i]
	cmp	r9b, 47				# temp cmp 47
	jle	.L3				# temp <= 47, то переход на .L3
	cmp	r9b, 57				# temp cmp 57
	jg	.L3				# temp > 57, то переход на .L3
	add	r15d, 1				# count_digits += 1
	jmp	.L4				# Переход на .L4
.L3:
	cmp	r9b, 64				# temp cmp 64
	jle	.L5				# temp <= 64, то переход на .L5
	cmp	r9b, 90				# temp cmp 90
	jle	.L6				# temp <= 90, то переход на .L6
.L5:
	cmp	r9b, 96				# temp cmp 96
	jle	.L4				# temp <= 96, то переход на .L4
	cmp	r9b, 122			# temp cmp 122
	jg	.L4				# temp > 122, то переход на .L4
.L6:
	add	r8d, 1				# count_letters += 1
.L4:
	add	r12d, 1				# i += 1
.L2:
	cmp	r12d, r13d		# i cmp size
	jl	.L7			# i < size, то переход на .L7 (тело цикла), иначе выход из цикла
	mov	DWORD PTR -4[rbp], r8d	# Сохраняем на стек count_letters (полное описание данного шага
									  # в самом верху файла)

	mov	rcx, r14	# rcx = FILE *output (4й аргумент функции) ; указатель на файловый поток вывода
	mov	edx, 9		# edx = 9 (3й аргумент функции) ; количество элементов (каждый с размером, указанным
												# в esi)
	mov	esi, 1		# esi = 1 (2й аргумент функции) ; размер каждого элемента в байтах
	lea	rdi, .LC1[rip]	# rdi = "Letters: " (1й аргумент функции) ; указатель на массив элементов
	call	fwrite@PLT	# Вызов fwrite

	mov	edx, DWORD PTR -4[rbp]	# edx = count_letters (3й аргумент функции)
	lea	rsi, .LC2[rip]		# rsi = "%d" (2й аргумент функции) 
	mov	rdi, r14		# rdi = r14 (FILE *output; 1й аргумент функции)
	mov	eax, 0			# eax = 0
	call	fprintf@PLT		# Вызов fprintf

	mov	rsi, r14		# rsi = r14(FILE *output ; 2й аргумент функции)
	mov	edi, 10			# edi = 10 (1й аргумент функции)
	call	fputc@PLT		# Вызов fputc (fprintf для \n)

	mov	rcx, r14		# rcx = r14 (FILE *output; 4й аргумент функции) ; указатель на 
											 # файловый поток вывода
	mov	edx, 8			# edx = 8 (3й аргумент функции) ; размер массива
	mov	esi, 1			# esi = 1 (2й аргумент функции) ; размер каждого элемента массива в байтах
	lea	rdi, .LC3[rip]		# rid = "Digits: " (1й аргумент функции)
	call	fwrite@PLT		# Вызов fwrite

	mov	edx, r15d		# edx = r15d (int count_digits ; 3й аргумент функции)
	lea	rsi, .LC2[rip]		# rsi = "%d" (2й аргумент функции)
	mov	rdi, r14		# rdi = r14 (FILE *output ; 1й аргумент функции)
	mov	eax, 0			# eax = 0
	call	fprintf@PLT		# Вызов fprintf

	mov	rsi, r14		# rsi = r14 (FILE *output ; 2й аргумент функции)
	mov	edi, 10			# edi = 10 (1й аргумент функции)
	call	fputc@PLT		# Вызов fputc (fprintf для \n)

	leave	# /
	ret	# \ Выход из функции
