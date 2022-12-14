import os

# os.system("gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -fcf-protection=none main.c -S -o main.s")
# os.system("gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -fcf-protection=none read.c -S -o read.s")
# os.system("gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -fcf-protection=none print.c -S -o print.s")

os.system("gcc -c main.s -o main.o")
os.system("gcc -c read.s -o read.o")
os.system("gcc -c print.s -o print.o")

os.system("gcc print.o read.o main.o -o main.exe")


os.system("rm -rf *o")

os.system("./main.exe input.txt output.txt")
os.system("cat output.txt")
