/*
 This code uses OpenMP!

 How to run it:
    > gcc -fopenmp fibonacci.c -o fibonacci -lm
    > ./fibonacci
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

#define N 10
#define NUM_THREADS omp_get_num_procs()

int main() {
    double vetor[N];

    #pragma omp parallel num_threads(NUM_THREADS) // Inicia uma região paralela, que permite que várias threads sejam executadas simultaneamente
    {
        #pragma omp single // Garante que apenas uma thread execute a região de código dentro dela, enquanto as outras esperam
        {
            printf("Thread [%d] inicializando o vetor\n\n", omp_get_thread_num());
            vetor[0] = 1; vetor[1] = 1;
            for(int i = 2; i < N; i++) {
                vetor[i] = vetor[i-1] + vetor[i-2];
            }
        }

        #pragma omp for // Diretiva utilizada para paralelizar um loop
            for (int i = 0; i < N; i++) {
                vetor[i] = pow(vetor[i], i);
                printf("Thread [%d] calculando a posição i = %d do vetor\n", omp_get_thread_num(), i);
            }
    }

    printf("\nVetor: \n");
    for (int i = 0; i < N; i++) {
        printf("[i = %d]: %.2lf\n", i, vetor[i]);
    }

    return 0;
}