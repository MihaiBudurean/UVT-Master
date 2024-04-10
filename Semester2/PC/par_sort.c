#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int* create_array(int n)
{
    int *v = (int *)malloc(n * sizeof(int));
    if (v == NULL)
    {
        printf("Memory allocation failed.\n");
        exit(1);
    }

    for (int i = 0; i < n; i++)
    {
        v[i] = rand();
    }

    return v;
}

void print_array(int* v, int n)
{
    for (int i = 0; i < n; i++)
        printf("%d ", v[i]);
    printf("\n");
}

void swap(int* p1, int* p2)
{
    int temp;
    temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}

void odd_even_sort(int* v, int n, int p)
{
    short is_sorted = 0;
    omp_set_num_threads(p);
 
    while (!is_sorted)
    {
        is_sorted = 1;

        #pragma omp parallel for shared(v, n, is_sorted)
        for (int i = 1; i <= n - 2; i = i + 2)
            // #pragma omp critical
            // {
                if (v[i] > v[i + 1])
                {
                    swap(&v[i], &v[i + 1]);
                    is_sorted = 0;
                }
            // }
            
        #pragma omp parallel for shared(v, n, is_sorted)
        for (int i = 0; i <= n - 2; i = i + 2)
            // #pragma omp critical
            // {
                if (v[i] > v[i + 1])
                {
                    swap(&v[i], &v[i + 1]);
                    is_sorted = 0;
                }
            // }
    }
 
    return;
}

int main(int argc, char* argv[])
{
    if (argc != 3)
        printf("Incorrect number of arguments!");

    int n = atoi(argv[1]), p = atoi(argv[2]);
    p = atoi(argv[1]);

    int* v = create_array(n);
    
    printf("Unsorted array with %d elements: ", n);
    print_array(v, n);
    odd_even_sort(v, n, p);
    printf("Sorted array with %d elements:   ", n);
    print_array(v, n);

    free(v);
    return 0;
}
