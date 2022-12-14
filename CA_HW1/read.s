# r12d = edi - arr_size (1й аргумент функции)
# r13 = rsi - FILE *input (2й аргумент функции)
# r15d = (int i) - счётчик циклов (первого и второго)
# r13d = input_data == -12 на стеке (начиная со второго цикла будем использовать регистр,
					# так как в первом требуется ссылка на перменную)

	.intel_syntax noprefix		# Синтаксис intel
	.text				# Начало секции
	.section	.rodata		# read only секция
.LC0:
	.string	"%d"
	.text
	.globl	read_data		# Доступ других единиц компиляции к read_data
	.type	read_data, @function	# Определение read_data как функции 
read_data:
	push	rbp		# /
	mov	rbp, rsp	# | Выделение фрейма
	sub	rsp, 32		# \
	mov	r12d, edi	# r12d = arr_size
	mov	r13, rsi	# r13 = FILE *input
	mov	r15d, 0		# int i = 0
	jmp	.L2		# Переход на цикл

.L3:				# Тело цикла
	lea	rdx, -12[rbp]	# rdx = input_data& (3й аргумент функции)
	mov	rdi, r13	# rdi = File *input (1й аргумент функции)
	lea	rsi, .LC0[rip]	# rsi = "%d" (2й аргумент функции)
	mov	eax, 0
	call	__isoc99_fscanf@PLT	# Вызов fscanf

	mov	eax, DWORD PTR -12[rbp]	# eax = input_data
	movsx	rdx, r15d		# rdx = i

	lea	rcx, 0[0+rdx*4]
	lea	rdx, InputArray[rip]
	mov	DWORD PTR [rcx+rdx], eax

	add	r15d, 1		# i += 1
.L2:
	cmp	r15d, r12d		# i cmp arr_size
	jl	.L3			# Если i < arr_size переход на .L3,
	mov	r13d, 0			# иначе input_data = 0
	mov	r15d, 0			# int i = 0 (второй цикл)
	jmp	.L4			# Переход на .L4 (второй цикл)
.L9:
	lea	rdx, 0[0+rax*4]		#
	lea	rax, InputArray[rip]	# eax = InputArray[i]
	mov	eax, DWORD PTR [rdx+rax]#

	test	eax, eax		# InputArray[i] cmp 0
	jns	.L5			# Переход, если InputArray[i] >= 0 (jump not signed),
	mov	r13d, 1			# иначе input_data = 1
.L5:
	cmp	r13d, 0			# input_data cmp 0
	je	.L6			# Если input_data >= 1, то переход на .L6

	mov	eax, r15d		 # eax = i
	lea	rdx, 0[0+rax*4]		 # /
	lea	rax, InputArray[rip]	 #|
	mov	eax, DWORD PTR [rdx+rax] #| ResultArray[i] = InputArray[i]
	movsx	rdx, r15d		 #|
	lea	rcx, 0[0+rdx*4]		 #|
	lea	rdx, ResultArray[rip]	 #|
	mov	DWORD PTR [rcx+rdx], eax # \
	jmp	.L7			# Переход на .L7
.L6:
	mov	eax, r15d			# eax = i
	lea	rdx, 0[0+rax*4]			# /
	lea	rax, InputArray[rip]		#| eax = InputArray[i] = 0
	mov	eax, DWORD PTR [rdx+rax]	# \
	test	eax, eax			# eax cmp 0
	jne	.L8				# InputArray[i] != 0 => переход на .L8

	mov	eax, r15d			# eax = i
	lea	rdx, 0[0+rax*4]			# /
	lea	rax, ResultArray[rip]		#| ResultArray[i] = 1
	mov	DWORD PTR [rdx+rax], 1		# \
	jmp	.L7				# Переход .L7
.L8:
	mov	eax, r15d
	lea	rdx, 0[0+rax*4]			# /
	lea	rax, InputArray[rip]		#| eax = InputArray[i]
	mov	eax, DWORD PTR [rdx+rax]	# \
	movsx	rdx, r15d			#  rdx = i
	lea	rcx, 0[0+rdx*4]			# /
	lea	rdx, ResultArray[rip]		#| ResultArray[i] = eax
	mov	DWORD PTR [rcx+rdx], eax	# \
.L7:
	add	r15d, 1		# i += 1
.L4:
	mov	eax, r15d	# eax = i
	cmp	eax, r12d	# i cmp arr_size
	jl	.L9		# Если i < arr_size, то переход в .L9, иначе выход из функции

	leave	# /
	ret	# \ Выход из функции
