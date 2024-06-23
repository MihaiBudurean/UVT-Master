#include <iostream>
#include <cstdlib>

void alloc(int n, int*& v)
{
    v = new int[n * n];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            v[i * n + j] = rand() % 10;
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
    int n;
    int *a = nullptr, *b = nullptr, *c = nullptr;

    std::cout << "n = ";
    std::cin >> n;

    alloc(n, a);
    alloc(n, b);
    alloc(n, c);

    std::cout << "a:\n";
    print(n, a);
    std::cout << std::endl;

    std::cout << "b:\n";
    print(n, b);
    std::cout << std::endl;

    matmul(n, a, b, c);

    std::cout << "c:\n";
    print(n, c);
    std::cout << std::endl;

    delete[] a;
    delete[] b;
    delete[] c;

    return 0;
}