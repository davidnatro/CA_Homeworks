# Метод factorial
# r12d -> int num (- 20 на стеке ; 1й аргумент функции)
# r13d -> int result (-4 на стеке)
# r14d -> int i (-8 на стеке)

# Метод numerator
# r8 -> double pow (-24 на стеке) (используется только внутри функции, так как r8 не зарезирвированный регистр)
# r12d -> int num (-28 на стеке)
# r13d -> int i (-12 на стеке)
# r14 -> double result (-8 на стеке)

# Метод calculate
# r12d -> int i (-36 на стеке)
# r13 -> double chr (-56 на стеке)
# r14 -> double chp(-64 на стеке)
# r15d -> int fact (-40 на стеке)
# Так как зарезирвированные регистры закончились, r8-r11 использовать мы не можем, так как после вызовов функций они затрутся,
# а зарезирвированных xmm регистров не бывает, то -80, -72, -32, -24, -48 останутся на стеке

	.intel_syntax noprefix	# Синтаксис intel
	.text
	.globl	factorial	# Доступ для внешних единиц компиляции
factorial:
	push	rbp		# /
	mov	rbp, rsp	# \ Выделение фрейма
	mov	r12d, edi	# r12d = int num
	mov	r13d, 1		# r13d = result = 1
	mov	r14d, r12d	# r14d = int i = num
	jmp	.L2		# переход на .L2
.L3:
	mov	eax, r13d	# eax = result
	imul	eax, r14d	# eax = result * i
	mov	r13d, eax	# result = eax
	sub	r14d, 1		# i -= 1
.L2:
	cmp	r14d, 0		# i cmp 0 (i >= 1)
	jg	.L3		# переход на .L3, если i >= 1
	mov	eax, r13d	# eax = result
	pop	rbp		# pop rbp
	ret			# Выход из функции
	.globl	numerator
numerator:
	push	rbp				# /
	mov	rbp, rsp			# \ Выделение фрейма
	movq	r8, xmm0 			# r8 = -24[rbp] = pow (xmm0 используется для передачи аргументов в метод)
	mov	r12d, edi			# r12d = num
	movq	r14, xmm0			# double result = pow
	mov	r13d, 1				# int i = 0
	jmp	.L6				# переход на .L6
.L7:
	pxor	xmm1, xmm1			# зануление бит
	cvtsi2sd	xmm1, r13d		# Каст int i к double
	movq	xmm0, r8			# xmm0 = pow
	subsd	xmm0, xmm1			# pow - i
	movq	xmm1, r14			# xmm1 = result
	mulsd	xmm0, xmm1			# xmm0 * xmm1
	movq	r14, xmm0			# result = xmm0
	add	r13d, 1				# i += 1
.L6:
	cmp	r13d, r12d			# i cmp num (i <= num)
	jle	.L7				# i <= num ? => Переход на .L7
	movq	xmm0, r14			# xmm0 = result
	movq	rax, xmm0			# rax = result
	pop	rbp				# pop rbp со стека
	ret					# Выход из функции
	.section	.rodata	# read only секция
	.align 8
.LC5:		# Текст на русском (Может неверно отображаться на некоторых устройствах)
	.string	"\320\237\321\200\320\265\320\262\321\213\321\210\320\265\320\275 \320\273\320\270\320\274\320\270\321\202 \320\276\320\266\320\270\320\264\320\260\320\275\320\270\321\217!"
	.text
	.globl	calculate	# Доступ для внешних единиц компиляции
calculate:
	push	rbp				# /
	mov	rbp, rsp			#| Выделение фрейма
	sub	rsp, 72				# \
	push	rbx				# сохраняем rbx на стек
	movsd	QWORD PTR -72[rbp], xmm0	# -72[rbp] = double x (xmm0 используется для передачи аргументов в методы)
	movsd	xmm0, QWORD PTR .LC0[rip]	# xmm0 = 0.5 ; компилятор сводит меня с ума
	movsd	QWORD PTR -48[rbp], xmm0	# -48[rbp] = xmm0 (double m)
	movapd	xmm1, xmm0			# xmm1 = xmm0
	mulsd	xmm1, QWORD PTR -72[rbp]	# xmm1 *= x
	movsd	xmm0, QWORD PTR .LC1[rip]	# xmm0 = 1
	addsd	xmm0, xmm1			# result = 1 + m * x;
	movsd	QWORD PTR -24[rbp], xmm0	# -24[rbp] = result
	movsd	QWORD PTR -32[rbp], xmm0	# -32[rbp] = previous = result
	mov	r12d, 1				# int i = 1;
	mov	r15d, 2				# int fact = 2;
.L16:
	mov	eax, r12d			# /
	lea	edx, 1[rax]			#| i++ ( ох уж эта арифметика:) )
	mov	r12d, edx			# \
	mov	edi, eax			# edi = i (1й аргумент функции)
	movq	xmm0, QWORD PTR -48[rbp]	# xmm0 = m
						# !!! i должен быть вторым аргументом функции, а m первым, но gcc решил
						# их поменять местами ; Умыслов его, к сожалению, мне пока не понять !!!
	call	numerator			# Вызов numerator
	movq	rbx, xmm0			# rbx = результат numerator
						# xmm0 используется для возврата данных из метода
	mov	edi, r15d			# edi = fact (1й аргумент функции)
	call	factorial			# Вызов factorial
	pxor	xmm0, xmm0			# Зануление бит
	cvtsi2sd	xmm0, eax		# Кастим результат factorial к double
	movq	xmm2, rbx			# xmm2 = результат метода numerator
	divsd	xmm2, xmm0			# temp = numerator / factorial
	movsd	QWORD PTR -80[rbp], xmm2	# -80[rbp] = temp
	pxor	xmm0, xmm0			# Зануление бит
	cvtsi2sd	xmm0, r15d		# Кастим int fact к double ; xmm0 = fact
	mov	rax, QWORD PTR -72[rbp]		# rax = x
	movapd	xmm1, xmm0			# xmm1 = fact (2й аргумент функции)
	movq	xmm0, rax			# xmm0 = x (1й аргумент функции)
	call	pow@PLT				# Вызов pow
	mulsd	xmm0, QWORD PTR -80[rbp]	# xmm0 *= temp (numerator / factorial)
	movsd	xmm1, QWORD PTR -24[rbp]	# xmm1 = result
	addsd	xmm0, xmm1			# xmm0 += result
	movsd	QWORD PTR -24[rbp], xmm0	# -24[rbp] = xmm0
						# Все прошлые действия с функциями numerator и factorial В си:
						# result += numerator(m, i++) / factorial(fact) * pow(x, fact);
	add	r15d, 1				# ++fact;
	movsd	xmm1, QWORD PTR -24[rbp]	# xmm1 = result
	movsd	xmm0, QWORD PTR .LC2[rip]	# xmm0 = 100000.0
	mulsd	xmm1, xmm0			# temp = result * 100000.0
	movq	xmm0, xmm1			# xmm0 = temp (1й аргумент функции)
	call	round@PLT			# Вызов round
	movsd	xmm1, QWORD PTR .LC2[rip]	# xmm1 = 100000.0
	divsd	xmm0, xmm1			# xmm0 = (xmm0 = результат функции round) / (xmm1 = 100000.0)
	movq	r13, xmm0			# double chr = xmm0
	movsd	xmm1, QWORD PTR -32[rbp]	# xmm1 = double previous
	movsd	xmm0, QWORD PTR .LC2[rip]	# xmm0 = 100000.0
	mulsd	xmm1, xmm0			# previous * 100000.0
	movq	xmm0, xmm1			# xmm0 = previous * 100000.0 (1й аргумент функции)
	call	round@PLT			# Вызов round
	movsd	xmm1, QWORD PTR .LC2[rip]	# xmm1 = 100000.0
	divsd	xmm0, xmm1			# xmm0 = (xmm0 = результат round) / (xmm1 = 100000.0)
	movq	r14, xmm0			# double chp = xmm0
	movq	xmm0, r13			# xmm0 = double chr
	movq	xmm1, QWORD PTR .LC3[rip]	# xmm1 = 1 ?
	andpd	xmm1, xmm0			# isFinite(chr) - проверка chr на счетность
	movsd	xmm0, QWORD PTR .LC4[rip]	# xmm0 = 1
	ucomisd	xmm0, xmm1			# Сравнение xmm0, xmm1
	jnb	.L18				# Переход, если xmm0 > xmm1 (если число не счетно, то функция вернет 0, иначе 1)
	lea	rdi, .LC5[rip]			# rdi = "Превышен лимит ожидания!" (1й аргумент функции)
	call	printf@PLT			# Вызов printf
	pxor	xmm0, xmm0			# Зануление бит
	jmp	.L12				# Переход на .L12
.L18:
	movq	xmm0, r14			# xmm0 = chp
	movq	xmm1, r13			# xmm1 = chr
	subsd	xmm0, xmm1			# xmm0 = chp - chr
	movq	xmm1, QWORD PTR .LC3[rip]	# xmm1 = 0.005
	andpd	xmm1, xmm0			# логическое И для xmm1(0.005) и xmm0(chp - chr)
	movsd	xmm0, QWORD PTR .LC7[rip]	# xmm0 = 0.005
	comisd	xmm0, xmm1			# 0.005 cmp fabs(chp - chr)
	ja	.L19				# Если fabs(chp - chr) > 0.005 => переход на .L19
	movsd	xmm0, QWORD PTR -24[rbp]	# xmm0 = result
	movsd	QWORD PTR -32[rbp], xmm0	# previous = result
	jmp	.L16				# переход на .L16
.L19:
	movsd	xmm0, QWORD PTR -24[rbp]	# xmm0 (результат функции) = result
.L12:
	movq	rax, xmm0			# rax = result
	leave	# /
	ret	# \ Выход из функции
	.section	.rodata		# read only секция
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1090021888
	.align 16
.LC3:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC4:
	.long	-1
	.long	2146435071
	.align 8
.LC7:
	.long	1202590843
	.long	1064598241
