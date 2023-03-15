/* 
  How to run this code:
    > nasm -f elf AP4.asm
    > gcc -m32 -no-pie -o AP4 AP4.c AP4.o
    > ./AP4 

  Make sure you have gcc-multilib installed!
*/

#include <stdio.h>

extern float coneVolume(float r, float h);

int main() {
    float r, h;

    printf("Insira o raio do cone: ");
    scanf("%f", &r);

    printf("Insira a altura do cone: ");
    scanf("%f", &h);

    float ans = coneVolume(r, h);

    printf("\nO volume do cone é: %.2f\n", ans);

    return 0;
}
