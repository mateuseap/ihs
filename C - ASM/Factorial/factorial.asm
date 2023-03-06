; How to run this code:
;   > nasm -f elf factorial.asm
;   > gcc -m32 -o factorial factorial.c factorial.o
;   > ./factorial
;
; Make sure you have gcc-multilib installed!

extern scanf, factorial, printf

SECTION .data

scanfParams db "%d", 0x00
resultMsg db "%d! (fatorial) eh: %d", 0x0a, 0x00

n dd 0

SECTION .text

global main

main:
    push n
    push dword scanfParams
    call scanf
    add esp, 8

    push dword[n]
    call factorial
    add esp, 8

    push eax
    push dword[n]
    push dword resultMsg
    call printf
    add esp, 8

    mov eax, 1
	mov ebx, 0
	int 0x80