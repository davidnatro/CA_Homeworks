# r12d -> argc (-52 на стеке)
# r13 -> double data (-8 на стеке)
# r14 -> int64_t elapsed_ns (-16 на стеке)

# timespec start, end (-32 и -48 на стеке) не будем перекладывать в регистры, так как на них требуются ссылки

	.intel_syntax noprefix			# Синтаксис intel
	.text					# Начало секции
	.globl	getRandomNumber			# Доступ для внешних единиц компиляции
getRandomNumber:
	push	rbp				# /
	mov	rbp, rsp			# \ Выделение фрейма
	call	rand@PLT			# Вызов rand
	pxor	xmm0, xmm0			# Зануление бит
	cvtsi2sd	xmm0, eax		# Кастим результат rand к double
	movsd	xmm1, QWORD PTR .LC0[rip]	# xmm1 = RAND_MAX
	divsd	xmm0, xmm1			# rand() / RAND_MAX
	movq	rax, xmm0			# rax = xmm0
	#movq	xmm0, rax			# не требуется
	pop	rbp				# pop rbp
	ret					# Выход из функции

	.globl	timespecDiff
timespecDiff:
	push	rbp		# /
	mov	rbp, rsp	# \ Выделение фрейма
	mov	r10, rdi	# r10 = end
	mov	r9, rsi		# r9 = end.tv_sec
	mov	r8, rdx		# r8 = start
	mov	r11, rcx	# r11 = start.tv_sec
	mov	rax, r10	# rax = end
	imul	rax, rax, 1000000000 # end.tv_sec * 1000000000
	mov	r13, rax	# r13 = результат умножения ; r13 - int64_t nsecA
	mov	rax, r9		# rax = end.tv_sec
	add	r13, rax	# nsecA += end.tv_sec
	mov	rax, r8		# rax = end.tv_sec
	imul	rax, rax, 1000000000 # start.tv_sec * 1000000000
	mov	r14, rax	# r14 = результат умножения ; r14 - int64_t nsecB
	mov	rax, r11	# rax = start.tv_sec
	add	r14, rax	# nsecB += start.tv_sec
	mov	rax, r13	# rax = nsecA
	sub	rax, r14	# return nsecA - nsecB
	pop	rbp		# pop rbp
	ret			# Выход из функции

	.section	.rodata			# read only секция
.LC1:
	.string	"-random"
.LC2:
	.string	"Random value is: "
.LC3:
	.string	"%.5f\n"
	.align 8
.LC6:
	.string	"\320\235\320\260 \320\264\320\260\320\275\320\275\320\276\320\274 \320\270\320\275\321\202\320\265\321\200\320\262\320\260\320\273\320\265 \321\201\321\202\320\265\320\277\320\265\320\275\320\275\320\276\320\271 \321\200\321\217\320\264 \321\200\320\260\321\201\321\205\320\276\320\264\320\270\321\202\321\201\321\217! \320\222\320\262\320\265\320\264\320\270\321\202\320\265 \320\267\320\275\320\260\321\207\320\265\320\275\320\270\320\265 \320\276\321\202 -1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276) \320\264\320\276 1 (\320\275\320\265 \320\262\320\272\320\273\321\216\321\207\320\270\321\202\320\265\320\273\321\214\320\275\320\276)!"
	.align 8
.LC8:
	.string	"./main.exe <-random> <input file> <output file>"
.LC9:
	.string	"Elapsed: %ld ns\n"
	.text
	.globl	main		# Доступ для внешних единиц компиляции
main:
	push	rbp		# /
	mov	rbp, rsp	#| Выделение фрейма
	sub	rsp, 64		# \
	mov	r12d, edi		# r12d = argc
	mov	QWORD PTR -64[rbp], rsi # -64[rbp] = argv
	mov	edi, 0			# edi = 0 (1й аргумент функции)
	call	time@PLT		# Вызов функции time
	mov	edi, eax		# edi = результат функции time (передаем первым аргументом в функцию srand)
	call	srand@PLT		# Вызов srand
	cmp	r12d, 3			# argc cmp 3
	jne	.L6			# argc != 3 ? Переход на .L6
	mov	rax, QWORD PTR -64[rbp]	# rax = argv[0]
	add	rax, 8			# rax += 8
	lea	rsi, .LC1[rip]		# rsi = "-random" (2й аргумент функции)
	mov	rdi, QWORD PTR[rax]	# rdi = argv[1]	(1й аргумент функции)
	call	strcmp@PLT		# Вызов strcmp
	test	eax, eax		# eax cmp 0
	jne	.L7			# eax != 0 ? Переход на .L7
	mov	eax, 0			# eax = 0
	call	getRandomNumber		# вызов getRandomNumber
	movq	r13, xmm0		# r13 = результат getRandomNumber
	lea	rdi, .LC2[rip]		# edi = "Random value is: " (1й аргумент функции)
	mov	eax, 0			# eax = 0
	call	printf@PLT		# Вызов printf
	movq	xmm0, r13		# xmm0 = double data	(2й аргумент функции)
	lea	rdi, .LC3[rip]		# rdi = "%.5f\n" (1й аргумент функции)
	mov	eax, 1			# eax = 1
	call	printf@PLT		# Вызов printf
	jmp	.L8			# переход на .L8
.L7:
	mov	rax, QWORD PTR -64[rbp]	# rax = argv[0]
	add	rax, 8			# argv += 8
	mov	rdi, QWORD PTR [rax]	# rdi = argv[1] (1й аргумент функции)
	call	read_data@PLT		# Вызов read_data
	movq	r13, xmm0		# data = xmm0 (в xmm0 лежит результат read_data)
.L8:
	movq	xmm0, r13		# xmm0 = data
	movq	xmm1, QWORD PTR .LC4[rip] # /fabs(data)
	andpd	xmm0, xmm1	 	  # \логическое И
	movsd	xmm1, QWORD PTR .LC5[rip] # xmm1 = 1
	comisd	xmm0, xmm1		# fabs(data) cmp 1
	jb	.L15			# Переход на .L15, если xmm0 < xmm1
	lea	rdi, .LC6[rip]		# rdi = "текст" (1й аргумент функции)
	call	puts@PLT		# Вызов puts
	mov	eax, 0			# return 0
	jmp	.L13			# Выход из функции
.L15:
	movq	xmm1, r13		# xmm1 = data
	movsd	xmm0, QWORD PTR .LC7[rip] # xmm0 = 100000.0
	mulsd	xmm1, xmm0		# data * 100000.0
	movq	rax, xmm1		# rax = xmm1 = data * 100000.0
	movq	xmm0, rax		# xmm0 = rax
	call	round@PLT		# Вызов round
	movq	rax, xmm0		# rax = результат round
	movsd	xmm1, QWORD PTR .LC7[rip] # xmm 1 = 100000.0
	movq	xmm0, rax		# xmm0 = rax(результат round)
	divsd	xmm0, xmm1		# xmm0 = round(data * 100000.0) / 100000.0
	movq	r13, xmm0		# data = xmm0
	lea	rsi, -32[rbp]		# rsi = &start (2й аргумент функции)
	mov	edi, 1			# edi = 1 (1й аргумент функции ; CLOCK_MONOTONIC)
	call	clock_gettime@PLT	# Вызов clock_gettime
	movq	xmm0, r13		# xmm0 = double data
	call	calculate@PLT		# Вызов calculate
	movq	r13, xmm0		# data = результат calculate
	lea	rsi, -48[rbp]		# rsi = &end (-48 на стеке)
	mov	edi, 1			# edi = 1 (1й аргумент функции ; CLOCK_MONOTONIC)
	call	clock_gettime@PLT	# Вызов clock_gettime
	mov	rax, QWORD PTR -64[rbp]	# rax = argv[0]
	add	rax, 16			# rax += 16
	mov	rdi, QWORD PTR [rax]	# rax = argv[2]	(1й аргумент функции)
	movq	xmm0, r13		# xmm0 = data (2й аргумент функции)
	call	print_data@PLT		# Вызов print_data
	mov	rdx, QWORD PTR -32[rbp]	# rdx = start (3й аргумент функции)
	mov	rcx, QWORD PTR -24[rbp]	# rcx = поле tv_sec структуры start (4й аргумент функции)
	mov	rdi, QWORD PTR -48[rbp]	# rdi = end (1й аргумент функции)
	mov	rsi, QWORD PTR -40[rbp]	# rsi = поле tv_sec структуры end (2й аргумент функции)
	call	timespecDiff		# Вызов timespecDiff
	mov	r14, rax		# r14 (int64_t elapsed_ns) = результат timespecDiff
	mov	rsi, r14		# rsi = elapsed_ns (2й аргумент функции)
	lea	rdi, .LC9[rip]		# rdi = "Elapsed: %ld ns\n" (1й аргумент функции)
	mov	eax, 0			# eax = 0
	call	printf@PLT		# Вызов printf
	mov	eax, 0			# return 0;
	jmp	.L13			# Выход из функции
.L6:
	lea	rdi, .LC8[rip]		# rdi = "./main.exe <-random> <input file> <output file>" (1й аргумент функции)
	call	puts@PLT		# Вызов puts
	mov	eax, 0			# return 0;
.L13:
	leave		# /
	ret		# \ Выход из функции

	.section	.rodata		# read only секция
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.align 16
.LC4:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC5:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1090021888
