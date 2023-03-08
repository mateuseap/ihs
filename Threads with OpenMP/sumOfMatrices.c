/*
 This code uses OpenMP!

 How to run it:
    > gcc - fopenmp sumOfMatrices.c -o sumOfMatrices
    > ./sumOfMatrices
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main() {

    int A[2][2] = {{1,2},{3,4}};
    int B[2][2] = {{5,6},{7,8}};
    int C[2][2];
    int i, j, tId;

    #pragma omp parallel private(j, tId)
    {
        #pragma omp for
        for(i = 0; i < 2; i++) {
            for(j = 0; j < 2; j++) {
                tId = omp_get_thread_num();
                C[i][j] = A[i][j] + B[i][j];
                printf("A thread de ID %d calculou C[%d][%d]\n", tId, i, j);
            }
        }
    }

    return 0;
}