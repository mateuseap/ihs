nasm -f elf calcularPi.asm
gcc -m32 -no-pie -o calcularPi calcularPi.c calcularPi.o
clear
./calcularPi