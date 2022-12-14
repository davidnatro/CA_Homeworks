# int size (-20 на стеке) -> r12d
# int i (-4 на стеке) -> r13d
# argc (-68 на стеке) -> r14d
# int64_t  elapsed_ns (-32 на стеке) -> r15

# так как регистр r15 используется только в конце метода, r14d лишь раз в начале, а r13d как счётчик в цикле
# то мы можем использовать использовать их повторно:
# long end.tv_sec (-8 на стеке ; метод timespecDiff) -> r13
# FILE *input (-16 на стеке) -> r15
# int min (-4 на стеке ; метод getRandomNumber) -> r14d
# int max (-8 на стеке ; метод getRandomNumber) -> r15d

# Внутри метода timespecDiff будем использовать регистры r8d, r9d (Только внутри метода! Чтобы избежать "затирания")
# long end.tv_sec (-24 на стеке) -> r8
# timespec start (-48 на стеке) -> r9
# start.tv_sec (-40 на стеке) -> r10


# Так как на timespec start, end требуется ссылка, а argv сам по себе является указателем, мы не можем заменить их хранение
# со стека на регистры
# struct timespec start -> -48 на стеке
# struct timespec end -> -64 на стеке
# argv -> -80 на стеке

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.globl	string
	.bss				# Секция глобальных неиницилизорванных перменных
string:
	.text
getRandomNumber:
	push	rbp		# /
	mov	rbp, rsp	#| Выделение фрейма
	sub	rsp, 16		# \
	mov	r14d, edi	# r14d = int min (1й аргумент функции)
	mov	r15d, esi	# r15d = int max (2й аргумент функции)
	call	rand@PLT	# Вызов rand
	mov	edx, r15d	# edx = int max
	add	edx, 1		# edx += 1
	mov	ecx, edx	# ecx = max + 1
	sub	ecx, r14d	# ecx -= int min
	cdq			# Используется для корректного деления знаковых 32 битных чисел
	idiv	ecx		# edx = (eax от rand()) % ecx
	mov	eax, r14d	# eax = int min
	add	eax, edx	# min += int max
	leave	# /
	ret	# \ Выход из функции
timespecDiff:
	push	rbp		# /
	mov	rbp, rsp	# \ Выделение фрейма
	mov	r15, rdi	# r15 = struct timespec end
	mov	r8, rsi		# r8 = end.tv_sec
	mov	r9, rdx		# r9 = struct timespec start
	mov	r10, rcx	# r10 = start.tv_sec
	mov	rax, r15	# rax = end
	imul	rax, rax, 1000000000	# Знаковое умножение
	mov	r13, rax	# r13 = результат умножения
	add	r13, r8		# r13 += r8 (end.tv_sec)
	mov	rax, r9		# rax = start
	imul	rax, rax, 1000000000	# Знаковое умножение
	mov	r15, rax	# r15 = результат умножения
	add	r15, r10	# r15 += r10 (start.tv_sec)
	mov	rax, r13	# rax = end
	sub	rax, r15	# end -= r15
	pop	rbp
	ret		# Выход из функции
	.section	.rodata		# read only секция
.LC0:
	.string	"-random"
.LC1:
	.string	"rb"
.LC2:
	.string	"Input file doesn't exist!"
.LC3:
	.string	"./main.exe <-random> <input file> <output file>"
.LC4:
	.string	"Elapsed: %ld ns\n"
	.text
	.globl	main
main:
	push	rbp		# /
	mov	rbp, rsp	#| Выделение фрейма
	sub	rsp, 80		# \
	mov	r14d, edi		# r14d = argc
	mov	QWORD PTR -80[rbp], rsi	# char **argv = rsi
	mov	edi, 0			# edi = 0 (1й аргумент функции)
	call	time@PLT		# Вызов time
	mov	edi, eax		# edi = текущее время (1й аргумент в srand)
	call	srand@PLT		# Вызов srand
	cmp	r14d, 3			# argc cmp 3
	jne	.L6			# Если argc != 3, то переход на .L6
	mov	rax, QWORD PTR -80[rbp]	# rax = argv[0]
	add	rax, 8			# rax += 8
	mov	rax, QWORD PTR [rax]	# rax = argv[1]
	lea	rsi, .LC0[rip]		# rsi = "-random" (2й аргумент функции)
	mov	rdi, rax		# rdi = argv[1] (1й аргумент)
	call	strcmp@PLT		# Вызов strcmp
	test	eax, eax		# Сравниваем результат равенства строк с 0
	jne	.L7			# Если результат != 0, то переход на .L7
	mov	esi, 500000		# esi = 50000 (2й аргумент функции)
	mov	edi, 10000		# edi = 10000 (1й аргумент функции)
	call	getRandomNumber		# Вызов функции
	mov	r12d, eax		# Результат функции - число из диапазона 10000 - 500000 (размер строки)
	mov	rdi, rax		# rdi = rax (int size ; 1й аргумент функции)
	call	malloc@PLT		# Вызов malloc
	mov	QWORD PTR string[rip], rax	# char *string = результат malloc (указатель на область памяти)
	mov	r13d, 0			# int i = 0 (начало цикла)
	jmp	.L8			# Переход на .L8
.L9:					# .L9 = Тело цикла
	mov	esi, 126		# esi = 126 (2й аргумент функции)
	mov	edi, 48			# edi = 48 (1й аргумент функции)
	call	getRandomNumber		# Вызов getRandomNumber
	mov	edx, eax		# edx = eax (Число из диапазона от 48 до 126 ; 3й аргумент функции)
	mov	rcx, QWORD PTR string[rip]	# rcx = char *string (4й аргумент функции)
	mov	eax, r13d		# eax = i
	add	rax, rcx		# rax == eax => *string += rax (не совсем верно говорить, что здесь *string += rax,
					# мы получаем адрес в памяти, на который нужно сослаться
	mov	BYTE PTR [rax], dl	# *string[i] = dl (0 byte edx) (Случайное значение приведенное к char)
	add	r13d, 1			# i += 1
.L8:
	cmp	r13d, r12d		# i cmp size
	jl	.L9			# Если i < size, то переход на .L9
	lea	rsi, -48[rbp]		# rsi = &start (ссылка на timespec start ; 2й аргумент функции)
	mov	edi, 1			# edi = 1 (1й аргумент функции)
	call	clock_gettime@PLT 	# Вызов clock_gettime
	mov	rax, QWORD PTR -80[rbp]	# rax = argv[0]
	add	rax, 16			# rax += 16
	mov	esi, r12d		# esi = int size (2й аргумент функции)
	mov	rdi, QWORD PTR [rax]	# rdi = argv[2] (1й аргумент функции)
	call	print_result@PLT
	lea	rsi, -64[rbp]		# rsi = &end (ссылка на timespec end ; 2й аргумент функции)
	mov	edi, 1			# edi = 1 (1й аргумент функции)
	call	clock_gettime@PLT	# Вызов clock_gettime
	jmp	.L10			# Переход на .L10
.L7:
	mov	rax, QWORD PTR -80[rbp]	# rax = argv[0]
	add	rax, 8			# rax += 8
	lea	rsi, .LC1[rip]		# rsi = "rb" (2й аргумент функции)
	mov	rdi, QWORD PTR [rax]	# rdi = argv[1] (1й аргумент функции)
	call	fopen@PLT		# Вызов fopen
	mov	r15, rax		# r15 (FILE *input) = результат fopen
	cmp	r15, 0			# r15 cmp 0
	jne	.L11			# Если r15 != 0, то переход на .L11
	lea	rdi, .LC2[rip]		# rdi = строка из .LC2 (1й аргумент функции)
	call	puts@PLT		# Вызов puts
	mov	eax, 0			# eax = 0
	jmp	.L13			# Выход из функции
.L11:
	mov	rdi, r15		# rdi = FILE *input (1й аргумент функции)
	call	read_data@PLT		# Вызов read_data
	mov	r12d, eax		# int size = eax (длина строки возвращается из функции)
	lea	rsi, -48[rbp]		# rsi = &start (ссылка на timespec start ; 2й аргумент функции)
	mov	edi, 1			# edi = 1 (1й аргумент функции)
	call	clock_gettime@PLT	# Вызов clock_gettime
	mov	rax, QWORD PTR -80[rbp]	# rax = argv[0]
	add	rax, 16			# rax += 16
	mov	esi, r12d		# esi = size (2й аргумент функции)
	mov	rdi, QWORD PTR [rax]	# rdi = argv[2] (1й аргумент функции)
	call	print_result@PLT	# Вызов print_result
	lea	rsi, -64[rbp]		# rsi = &end (сслыка на timespec end ; 2й аргумент функции)
	mov	edi, 1			# edi = 1 (1й аргумент функции)
	call	clock_gettime@PLT	# Вызов clock_gettime
	jmp	.L10			# Переход на .L10
.L6:
	lea	rdi, .LC3[rip] 	# rdi = "./main.exe <-random> <input file> <output file>" (1й аргумент функции)
	call	puts@PLT	# Вызов puts (printf + "\n)
	mov	eax, 0		# eax = 0
	jmp	.L13		# Завершение программы
.L10:
	# В функцию timespecDiff на языке C передается 2 аргумента,
	# Долго ломая голову и пытаясь понять, что здесь происходит, а именно почему мы передаем 4 аргумента,
	# я пришел к выводу, что компилятор преобразовал данную в функцию в функцию с 4мя аргументами,
	# так как мы передаем структуру, поле которой сохраняется в стековом фрейме метода и будет в нем использовано.
	# Данные переменные не были переложены в регистры, так как в программе на них требовалась ссылка.
	# На данном этапе нет смысла перемещать их в регистры со стека, ради передачи в метод, но внутри
	# метода они будут переложены со стека в регистры.
	mov	rdx, QWORD PTR -48[rbp] # rdx = start		(3й аргумент функции)
	mov	rcx, QWORD PTR -40[rbp] # rcx = start.tv_sec	(4й аргумент функции)
	mov	rdi, QWORD PTR -64[rbp] # rdi = end		(1й аргумент функции)
	mov	rsi, QWORD PTR -56[rbp] # rsi = end.tv_sec	(2й аргумент функции)
	call	timespecDiff		# Вызов timespecDiff
	mov	r15, rax		# elapsed_ns = результат timespecDiff (количество нано секунд)
	mov	rsi, r15		# rsi = elapsed_ns (2й аргумент функции)
	lea	rdi, .LC4[rip]		# rdi = "Elapsed: %ld ns\n)" (1й аргумент функции)
	call	printf@PLT		# Вызов printf
	mov	rdi, QWORD PTR string[rip]	# rdi = char *string (1й аргумент функции)
	call	free@PLT		# Вызов free (очищаем память)
	mov	eax, 0			# eax = 0
.L13:
	leave	# /
	ret	# \ Выход из функции
