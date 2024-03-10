#include <stdio.h>
#include <omp.h>
int main(int argc, char *argv[])
{
    int tid;
    #pragma omp parallel private(tid)
    {
        tid = omp_get_thread_num();
        printf("<%d>\n", tid);
    }
    return 0;
}