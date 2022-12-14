# -36[rbp] (-36 на стеке, argc) -> r12d
# -8[rbp] (FILE *input) -> r13
# -16[rbp] (FILE *output) -> r14
# -20[rbp] (arr_size) -> r15d

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.globl	InputArray		# Делает массив доступным для других единиц компиляции
	.bss
	.type	InputArray, @object
	.size	InputArray, 4000	# 4000 - длина массива * 4, так как int 4 байта
InputArray:
	.globl	ResultArray		# Делает массив доступным для других единиц компиляции
	.type	ResultArray, @object
	.size	ResultArray, 4000	# 4000 - длина массива * 4, так как int 4 байта
ResultArray:
	.section	.rodata		# read only секция
.LC0:
	.string	"./main.exe <input file> <output file>!"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string "%d"
.LC4:
	.string	"Wrong array size!"
	.text				# Начало секции кода
	.globl	main
	.type	main, @function		# Идентифицирует main как функцию
main:
	push	rbp		# /
	mov	rbp, rsp	# | Выделение фрейма
	sub	rsp, 48		# \
	mov	r12d, edi			# edi - 1й аргумент => argc
	mov	QWORD PTR -48[rbp], rsi		# rsi - 2й аргумент => argv
	cmp	r12d, 3				# if (argc == 3), то
	je	.L2				# переход на .L2, иначе
	lea	rdi, .LC0[rip]			# Кладем строку .LC0 в rdi (передача 1-го аргумента)
	call	puts@PLT			# Вызов printf
	mov	eax, 0				# Подготовка к возврату 0
	jmp	.L4				# Выход из функции
.L2:
	mov	rax, QWORD PTR -48[rbp]		# Кладем argv[1] в rax
	add	rax, 8				# Увеличиваем rax на 8 байт и получаем argv[2]
	mov	rax, QWORD PTR [rax]		# rax = argv[2]
	lea	rsi, .LC1[rip]			# rsi = "r" (Второй аргумент функции)
	mov	rdi, rax			# rdi = argv[1] (Первый аргумент функции - имя входного
						# файла)
	call	fopen@PLT			# Вызов fopen(открываем файл)

	mov	r13, rax			# Объект FILE *input
	mov	rax, QWORD PTR -48[rbp]		# rax = argv[0]
	add	rax, 16				# rax += 16 байт
	mov	rax, QWORD PTR [rax]		# rax = arv[2]
	lea	rsi, .LC2[rip]			# rsi = "w" (2й аргумент функции)
	mov	rdi, rax			# rdi = rax (1й аргумент функции)
	call	fopen@PLT			# Вызов fopen(открываем файл)

	mov	r14, rax			# Объект FILE *output
	lea	rdx, -20[rbp]			# rdx = &arr_size
	mov	rdi, r13			# rdi = FILE *input
	lea	rsi, .LC3[rip]			# rcx = "%d"
	mov	eax, 0
	call	__isoc99_fscanf@PLT		# Вызов fscanf
	mov	r15d, DWORD PTR -20[rbp]	# Сохраняем прочитанный arr_size в зарезирвированный регистр

	cmp	r15d, 0				# arr_size cmp 0 Проверка размера массива
	jle	.L3				# Переход на .L3, если arr_size <= 0
	cmp	r15d, 999			# arr_size cmp 999
	jg	.L3				# Переход на .L3, если arr_size > 999

	mov	rsi, r13			# rsi = FILE *input (2й аргумент)
	mov	edi, r15d			# edi (rdi 0-3 байта) = r15d (arr_size)
	call	read_data@PLT			# Вызов read_data

	mov	rsi, r14			# rsi = FILE *output (2й аргумент)
	mov	edi, r15d			# edi (rdi 0-3 байта) = r15d (arr_size)
	call	print_data@PLT			# Вызов print_data
	mov	eax, 0				# Подготовка к возврату 0
.L4:
	leave	# / Выход из функции
	ret	# \
.L3:
	lea	rdi, .LC4[rip]			# rdi = "Wrong array size!" (1й аргумент функции)
	call	puts@PLT			# Вызов функции puts
	mov	eax, 0
	jmp	.L4				# Выход из функции
