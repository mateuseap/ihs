extern printf
extern scanf

SECTION .data

scanfParams db "%f %f", 0x00
resultMsg db "O resultado da soma eh: %.2f", 0x0a, 0x00

x dd 0
y dd 0
z dq 0

SECTION .text

global main

main:
    push y
    push x
    push dword scanfParams
    call scanf
    add esp, 12

    fld dword[x]
    fld dword[y]
    
    faddp
    
    fstp qword[z]

    push dword[z+4]
    push dword[z]
    push resultMsg
    call printf
    add esp, 12