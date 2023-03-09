/*
 This code uses OpenMP!

 How to run it:
    > gcc -fopenmp threadsExample.c -o threadsExample
    > ./threadsExample
*/


#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main() {

    int nThreads, tId;

    printf("O numero de processadores eh: %d\n\n", omp_get_num_procs());

    #pragma omp parallel num_threads(5) private(nThreads, tId) 
    {
        tId = omp_get_thread_num();

        printf("Eu sou a thread de ID %d\n", tId);

        if(tId == 0) {
            printf(">> O numero total de threads eh: %d\n", omp_get_num_threads());
        }
    }

    return 0;
}