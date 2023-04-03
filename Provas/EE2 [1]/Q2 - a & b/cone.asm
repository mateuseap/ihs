section .data

three dq 3.0

section .text

global cone

cone:
    ; Criando um novo stack frame
    push ebp
    mov ebp, esp

    ; Iniciando a FPU
    finit

    ; Calculando o volume do cone
    mov eax, [ebp + 8]  ; passando o endereço do ponteiro vol para eax
    fldpi               ; PI em st0
    fld dword[ebp + 12] ; r em st0, PI em st1
    fld dword[ebp + 16] ; h em st0, r em st1, PI em st2
    fmul st1            ; h * r em st0, r em st1, PI em st2
    fmulp st1, st0      ; h * r² em st0, PI em st1
    fmulp st1, st0      ; h * r² * PI em st0
    fld qword[three]    ; 3.0 em st0, h * r² * PI em st1
    fdivr st1           ; (h * r² * PI)/3.0 em st0, h * r² * PI em st1
    fstp dword[eax]

    ; Destruindo o stack frame
    mov esp, ebp
    pop ebp

    ; Retorno da função (o resultado estará em st0)
    ret