org 0x7c00
jmp 0x0000:start

string times 30 db 0 ;declara 30 bytes com o valor 0
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
        dec di
        mov al, 0
        stosb
        mov si, endl
        call print_string
        ret

print_string:
    .loop:
        lodsb ;carrega uma letra de si em al
        cmp al, 0 ;checa se chegou no final da string (equivalente a um '\0')
        je .endloop 
        call print_char 
        jmp .loop
    .endloop:
        ret

print_number:
    mov bx, 10 ;cor da fonte (ciano)
    mov cx, 0
    .loop1:
        mov dx, 0
        div bx
        add dx, 48
        push dx
        inc cx
        cmp ax, 0
        jne .loop1
    .loop2:
        pop ax
        mov ah, 0x0E
        int 0x10
        loop .loop2
    .done:
        ret

count_vowels:
    mov di, si
    xor cx, cx
    .loop: ;colocando a string na pilha
        lodsb ;carrega uma letra de si em al e passa para o próximo caractere
        cmp al, 0 ;checa se já chegou ao final da string (equivalente a um '\0')
        je .endloop
        cmp al, 'a' ;checa se a letra que está em al é uma vogal
        je .count_vowel
        cmp al, 'e'
        je .count_vowel
        cmp al, 'i'
        je .count_vowel
        cmp al, 'o'
        je .count_vowel
        cmp al, 'u'
        je .count_vowel
        cmp al, 'A'
        je .count_vowel
        cmp al, 'E'
        je .count_vowel
        cmp al, 'I'
        je .count_vowel
        cmp al, 'O'
        je .count_vowel
        cmp al, 'U'
        je .count_vowel
        jmp .loop
    .count_vowel: ;cl é incrementado quando uma vogal é identificada
        inc cl
        jmp .loop
    .endloop:
        ret
        
start:
    xor ax, ax
    mov cx, ax
    mov dx, ax

    call video_mode

    mov di, string 
    call read_string
    
    mov si, string
    call count_vowels

    xor ax, ax
    mov ax, cx ;o valor que está em cx é a qtd. de vogais presentes na palavra
    call print_number

times 510-($-$$) db 0
dw 0xaa55