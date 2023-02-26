org 0x7c00
jmp 0x0000:start

string times 30 db 0
endl db ' ', 13, 10, 0

video_mode:
    mov ax, 0013h ;muda para o modo gráfico
    mov bh, 0 ;página de vídeo 0
    mov bl, 3 ;cor da fonte (ciano)
    int 10h ;interrupção de vídeo
    ret

read_char:
    mov ah, 0x00 ;número da chamada para ler um caractere do buffer do teclado e remover ele de lá
    int 16h ;interrupção do teclado
    ret ;após a execução dessa interrupção int 16h o caractere lido estará armazenado em al

print_char:
    mov ah, 0x0e ;número da chamada para mostrar na tela um caractere que está em al
    int 10h ;interrupção de vídeo
    ret

read_string:
    mov al, 0
    .for:
        call read_char
        stosb ;guarda o que está em al
        cmp al, 13 ;checa se o que está no al equivale a tecla 'enter' (carriage return)
        je .fim
        call print_char
        jmp .for
     .fim:
        ret

print_string:
    .loop:
        lodsb ;carrega uma letra de si em al
        cmp al, 0 ;checa se chegou no final da string (equivalente a um '\0')
        je .endloop 
        call print_char
        jmp .loop
    .endloop:
        iret

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Configurando a IVT
    mov di, 0x100 ; 40h
    mov word[di], print_string
    mov word[di+2], 0

    call video_mode

    mov di, string 
    call read_string

    mov si, endl
    int 40h ; Interrupção 40h

    mov si, string
    int 40h ; Interrupção 40h

times 510-($-$$) db 0
dw 0xaa55