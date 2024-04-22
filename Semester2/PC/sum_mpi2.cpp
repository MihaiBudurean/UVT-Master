#include <iostream>
#include <mpi.h>

int main(int argc, char** argv)
{
    int mynode, totalnodes;
    int sum, startval, endval, accum;
    MPI_Status status;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &totalnodes); // get totalnodes
    MPI_Comm_rank(MPI_COMM_WORLD, &mynode); // get mynode

    sum = 0; // zero sum for accumulation
    startval = 1000 * mynode / totalnodes + 1;
    endval = 1000 * (mynode + 1) / totalnodes;

    for(int i = startval; i <= endval; i++)
        sum = sum + i;

    MPI_Reduce(&sum, &accum, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if(mynode == 0)
        std::cout << "The sum from 1 to 1000 is: " << accum << std::endl;
    
    MPI_Finalize();
}
