/*
 This code uses OpenMP!

 How to run it:
    > gcc -fopenmp AP5.c -o AP5
    > ./AP5
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 3
#define NUM_THREADS omp_get_num_procs()

void fillMatrix(int matrix[][N]);
void printMatrix(int matrix[][N]);
void clearMatrix(int matrix[][N]);
void serialMatrixMultiplication(int matrixA[][N], int matrixB[][N], int resultMatrix[][N], int *evenNumbersCount);
void parallelMatrixMultiplication(int matrixA[][N], int matrixB[][N], int resultMatrix[][N], int *evenNumbersCount);

int main() {

    double time;
    int matrixA[N][N], matrixB[N][N], resultMatrix[N][N] = {0}, evenNumbersCount = 0;

    fillMatrix(matrixA);

    // printf("Matriz A:\n");
    // printMatrix(matrixA);
    // printf("\n");

    fillMatrix(matrixB);

    // printf("Matriz B:\n");
    // printMatrix(matrixB);
    // printf("\n");
    
    time = omp_get_wtime();
    serialMatrixMultiplication(matrixA, matrixB, resultMatrix, &evenNumbersCount);
    time = omp_get_wtime() - time;

    printf("Tempo de execução da multiplicação de matrizes em [série] > %lf\n", time);
    printf("Qtd. de números pares > %d\n", evenNumbersCount);
    // printf("\nMatriz resultado:\n");
    // printMatrix(resultMatrix);

    clearMatrix(resultMatrix);
    evenNumbersCount = 0;

    time = omp_get_wtime();
    parallelMatrixMultiplication(matrixA, matrixB, resultMatrix, &evenNumbersCount);
    time = omp_get_wtime() - time;

    printf("\nTempo de execução da multiplicação de matrizes em [paralelo] > %lf\n", time);
    printf("Qtd. de números pares > %d\n", evenNumbersCount);
    // printf("\nMatriz resultado:\n");
    // printMatrix(resultMatrix);

    return 0;
}

void fillMatrix(int matrix[][N]) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            matrix[i][j] = (rand() % 10);
        }
    }
}

void printMatrix(int matrix[][N]) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            printf(" %d ", matrix[i][j]);

            if(j == (N-1)) {
                printf("\n");
            }
        }
    }
}

void clearMatrix(int matrix[][N]) {
#pragma omp parallel for num_threads(NUM_THREADS)
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            matrix[i][j] = 0;
        }
    }
}

void serialMatrixMultiplication(int matrixA[][N], int matrixB[][N], int resultMatrix[][N], int *evenNumbersCount) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            for(int k = 0; k < N; k++) {
                resultMatrix[i][j] += (matrixA[i][k] * matrixB[k][j]);
            }

            if((resultMatrix[i][j] % 2) == 0) {
                (*evenNumbersCount)++;
            }
        }
    }
}

void parallelMatrixMultiplication(int matrixA[][N], int matrixB[][N], int resultMatrix[][N], int *evenNumbersCount) {
#pragma omp parallel for num_threads(NUM_THREADS)
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            for(int k = 0; k < N; k++) {
                resultMatrix[i][j] += (matrixA[i][k] * matrixB[k][j]);
            }

            if((resultMatrix[i][j] % 2) == 0) {
#pragma omp critical
                {
                    (*evenNumbersCount)++;
                }
            }
        }
    }
}