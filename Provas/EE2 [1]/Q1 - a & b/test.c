/* 
  How to run this code:
    > chmod -R 777 ./ 
    > ./script.sh

  Make sure you have gcc-multilib installed!
*/

#include <stdio.h>
#include <stdlib.h>

extern float mainTest();

int main() {
    float volume;

    volume = mainTest();

    printf("O volume eh de: %.2f\n", volume);

    return 0;
}