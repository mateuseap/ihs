/*
 This code uses OpenMP!

 How to run it:
    > gcc -fopenmp sarrus.c -o sarrus
    > ./sarrus
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(){

    int A[3][3] = {
        {5, 0, 1}, 
        {-2, 3, 4}, 
        {0, 2, -1}
    };
    int sarrus[3][5] = {
        {5, 0, 1, 5, 0}, 
        {-2, 3, 4, -2, 3}, 
        {0, 2, -1, 0, 2}
    };
    int determinante = 0;

    #pragma omp parallel num_threads(2)
    {
        #pragma omp sections reduction(+:determinante)
        {
            #pragma omp section
            {
                for(int i = 0; i < 3; i++){
                    determinante += sarrus[0][i]*sarrus[1][i+1]*sarrus[2][i+2];
                }
            }
            
            #pragma omp section
            {
                for(int j = 0; j < 3; j++){
                    determinante -= sarrus[2][j]*sarrus[1][j+1]*sarrus[0][j+2];
                }
            }
        }

    }

    printf("\nO determinante da matriz A:\n\n");
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            printf("%d\t", A[i][j]);
        }
        printf("\n");
    }

    printf("\neh igual a %d\n", determinante);
    return 0;
}