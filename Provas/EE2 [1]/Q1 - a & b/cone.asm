SECTION .data
    raio dd 4.0
    altura dd 3.0
    volume dd 0

SECTION .text
    global mainTest

mainTest:
    ; Inicializando a FPU
    finit

    ; Calculando o volume
    fldpi             ; Pi em st0
    fld dword[altura] ; altura em st0, Pi em st1
    fld dword[raio]   ; raio em st0, altura em st1, Pi em st2
    fld dword[raio]   ; raio em st0, raio em st1, altura em st2, Pi em st3
    fmulp st1, st0    ; raio² em st0, altura em st1, Pi em st2
    fmulp st1, st0    ; (raio² * altura) em st0, Pi em st1
    fmulp st1, st0    ; (raio² * altura * Pi) em st0
    fld dword[altura] ; altura (3.0) em st0, (raio² * altura * Pi) em st1
    fdivr st1         ; (raio² * altura * Pi)/3 em st0, (raio² * altura * Pi) em st1

    ; Salvando o resultado na variável volume
    fstp dword[volume]

    ; Limpando a pilha
    fstp ; o valor (raio² * altura * Pi) ainda estava armazenado em st0, com esse comando limpamos a pilha

    fld dword[volume] ; volume em st0 (adicionei o valor em st0 para poder printar no código em C)

    ret