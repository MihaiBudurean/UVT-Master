#include <iostream>
#include <fstream>

using namespace std;

ifstream fin("input.txt");
ofstream fout("output.txt");

int main()
{
    int n;
    fin >> n;
    fout << n << endl;
    return 0;
}