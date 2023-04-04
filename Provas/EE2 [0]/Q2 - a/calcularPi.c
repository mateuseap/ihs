/* 
  How to run this code:
    > chmod -R 777 ./ 
    > ./script.sh

  Make sure you have gcc-multilib installed!
*/

#include <stdio.h>
#include <stdlib.h>

extern void calcularPi(float *pi, int *n);

int main() {
    float pi;
    int n;

    printf("Digite o valor de n: ");
    calcularPi(&pi, &n);
    printf("\nO valor de PI é: %.4f\n", pi);

    return 0;
}
