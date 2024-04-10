#include <stdio.h>
#include <stdlib.h>

FILE* open_file()
{
    FILE* file = fopen("input.txt", "r");
    if (file == NULL)
    {
        printf("File not found or cannot be opened!\n");
        exit(1);
    }
    return file;
}

int* create_array(int n)
{
    int *v = (int *)malloc(n * sizeof(int));
    if (v == NULL)
    {
        printf("Memory allocation failed.\n");
        exit(1);
    }

    for (int i = 0; i < n; i++)
        v[i] = rand();

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

int partition(int* v, int low, int high)
{
    int pivot = v[high];
    int i = (low - 1);

    for (int j = low; j <= high; j++)
        if (v[j] < pivot)
            swap(&v[++i], &v[j]);

    swap(&v[i + 1], &v[high]);
    return (i + 1);
}

void quick_sort(int* v, int low, int high)
{
    if (low < high)
    {
        int pi = partition(v, low, high);
        quick_sort(v, low, pi - 1);
        quick_sort(v, pi + 1, high);
    }
}

int main(int argc, char* argv[])
{
    if (argc != 2)
    {
        printf("Incorrect number of arguments!\n");
        exit(1);
    }

    int n = atoi(argv[1]);

    int* v = create_array(n);

    printf("Unsorted array with %d elements: ", n);
    print_array(v, n);
    quick_sort(v, 0, n - 1);
    printf("Sorted array with %d elements:   ", n);
    print_array(v, n);

    free(v);
    return 0;
}
