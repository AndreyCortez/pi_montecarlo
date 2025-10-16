#include "stdio.h"
#include "random.h"


#define M 10000

int main()
{
    srand(49);

    int dentro = 0;

    for (int i = 0; i < M; i++)
    {
        x = (float)rand()/RAND_MAX;
        y = (float)rand()/RAND_MAX;

        if (x*x + y*y <= 1) dentro += 1;
    }

    printf("%f\n", float(dentro)/M);
    return 0;
}