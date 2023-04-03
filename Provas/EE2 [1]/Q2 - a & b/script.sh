nasm -f elf cone.asm
gcc -m32 -no-pie -o cone cone.c cone.o
./cone
