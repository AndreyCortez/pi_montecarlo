#include "stdio.h"
#include "stdlib.h"
#include "omp.h"
#include "stdint.h"

#define M 1174068000


void montecarlo_seq(uint64_t iteracoes)
{
    uint64_t dentro = 0;

    for (uint64_t i = 0; i < iteracoes; i++)
    {
        if (i % 1000 == 0) printf("%d\n", i);
        double x = (double)rand()/RAND_MAX;

        double y = (double)rand()/RAND_MAX;

        if (x*x + y*y <= 1) dentro += 1;
    }

    printf("%f\n", (double)dentro*4.0/M);
}

int main()
{
    srand(49);

    montecarlo_seq(M);

    return 0;
}