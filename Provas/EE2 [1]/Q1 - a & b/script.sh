nasm -f elf cone.asm
gcc -m32 -no-pie -o q1 test.c cone.o
clear
./q1