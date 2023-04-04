/* 
  How to run this code:
    > chmod -R 777 ./ 
    > ./script.sh

  Make sure you have gcc-multilib installed!
*/

#include <stdio.h>
#include <stdlib.h>

extern void cone(float *vol, float r, float h);

int main() {
    float vol, r, h;

    printf("Insira o raio do cone: ");
    scanf("%f", &r);

    printf("Insira a altura do cone: ");
    scanf("%f", &h);

    cone(&vol, r, h);

    printf("\nO volume do cone é: %.2f\n", vol);

    return 0;
}