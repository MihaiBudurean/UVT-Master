#include <iostream>
#include <cstdlib>
#include <mpi.h>

void alloc(int n, int m, int*& v)
{
    v = new int[n * m];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            v[i * m + j] = rand() % 10;
}

void matmul(int n, int* a, int* b, int *c)
{
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
        {
            int sum = 0;
            for (int k = 0; k < n; k++)
                sum += a[i * n + k] * b[k * n + j];
            c[i * n + j] = sum;
        }
}

void print(int n, int *v)
{
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            std::cout << v[i * n + j] << ' ';
        std::cout << std::endl;
    }
}

int main(int argc, char** argv)
{
    int n, p, myrank, myn;
    int *a = nullptr, *b = nullptr, *c = nullptr;
    int *allB, start, sum, *allC, sumdiag;

    std::cout << "n = ";
    std::cin >> n;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD,&p);
    MPI_Comm_rank(MPI_COMM_WORLD,&myrank);
    myn = n / p;

    alloc(myn, n, a);
    alloc(myn, n, b);
    alloc(myn, n, c);
    alloc(n, n, allB);

    MPI_Barrier(MPI_COMM_WORLD);

    if (myrank == 0)
        start = MPI_Wtime();

    for (int i = 0; i < p; i++)
        MPI_Gather(b, myn * n, MPI_DOUBLE, allB, myn * n,
                MPI_DOUBLE, i, MPI_COMM_WORLD);

    for (int i = 0; i < myn; i++)
        for (int j = 0; j < n; j++)
        {
            sum = 0.;
            for (int k = 0; k < n; k++)
                sum += a[i * n + k] * allB[k * n + j];
            c[i * n + j] = sum;
        }
    delete[] allB;
    MPI_Barrier(MPI_COMM_WORLD);

    if (myrank == 0)
        std::cout << "It took " << MPI_Wtime() - start << " seconds to multiply 2 " << n << " x " << n << " matrices." << std::endl;

    if (myrank == 0)
        alloc(n, n, allC);

    MPI_Gather(c, myn * n, MPI_DOUBLE, allC, myn * n,
            MPI_DOUBLE, 0, MPI_COMM_WORLD);

    if (myrank == 0)
    {
        for (int i = 0, sumdiag = 0.; i < n; i++)
            sumdiag += allC[i * n + i];
        std::cout << "The trace of the resulting matrix is " <<  sumdiag << std::endl;
    }

    if (myrank == 0)
        free(allC);

    MPI_Finalize();

    std::cout << "a:\n";
    print(n, a);
    std::cout << std::endl;

    std::cout << "b:\n";
    print(n, b);
    std::cout << std::endl;

    //matmul(n, a, b, c);

    std::cout << "c:\n";
    print(n, c);
    std::cout << std::endl;

    delete[] a;
    delete[] b;
    delete[] c;

    return 0;
}