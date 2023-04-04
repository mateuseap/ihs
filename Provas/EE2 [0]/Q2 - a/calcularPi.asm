extern scanf

SECTION .data
    scanfParams db "%d", 0x00
    two dq 2.0
    sum dq 0.0
    n dd 0

SECTION .text
    global calcularPi

calcularPi:
    ; Criando um novo stack frame
    push ebp
    mov ebp, esp

    ; Iniciando a FPU
    finit

    ; Lendo a variável n
    push n
    push scanfParams
    call scanf
    add esp, 8

    ; Guarda valor no endereço de n
    mov eax, [n]
    mov ecx, [ebp + 12]
    mov [ecx], eax

    ; Colocando em ecx o valor de n
    mov ecx, [n]

    ; Caso ecx = 0 (lembrando que ecx = n nesse trecho), pulamos para o final do código
    cmp ecx, 0  
    je .end

.for:
    fld1              ; 1 em st0
    fld qword[two]    ; 2 em st0 e 1 em st1
    fild dword[n]     ; k em st0, 2 em st1 e 1 em st2
    fmulp st1, st0    ; 2k em st0, 1 em st1
    faddp st1, st0    ; 2k + 1 em st0
    
    mov eax, [n]
    fld1              ; 1 em st0, 2k + 1 em st1
.for1:
    fchs           
    dec eax
    cmp eax, 0
    je .end1
    jmp .for1
.end1:
    fdiv st1          ; ((-1)^k)/(2k + 1) em st0, 2k + 1 em st0
    fstp st1          ; ((-1)^k)/(2k + 1) em st0
    fld qword[sum]    ; sum em st0, ((-1)^k)/(2k + 1) em st1
    faddp st1, st0    ; sum + ((-1)^k)/(2k + 1) em st0
    fstp qword[sum]   ; pilha zerada e valor da variável sum atualizado
    dec ecx
    cmp ecx, 0
    je .end
    mov [n], ecx      ; atualizando o valor de n
    jmp .for
.end:
    fld1             ; 1 em st0
    fld qword[sum]   ; sum em st0, 1 em st1
    faddp st1, st0   ; sum + 1 em st0
    fst qword[sum]   ; valor da variável sum atualizado
    fstp             ; pilha zerada

    mov eax, dword[ebp + 8]   ; Passando o endereço do ponteiro 'pi' para eax
    fstp dword[eax]           ; Carregando o valor de st0 no ponteiro 'pi'

    ; Destruindo o stack frame
    mov esp, ebp
    pop ebp

    ; Retorno da função (o resultado estará em st0)
    ret
