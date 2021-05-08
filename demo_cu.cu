
#include <iostream>

#define numBlocks 512
#define numThreads 1024

using namespace std;

__global__
void addVectors(int blockSize, int totalSize, int * a, int * b, int * dest) {
    int idxBlock = blockIdx.x;
    int idx = blockIdx.x * blockSize + threadIdx.x;
    while (idx < (idxBlock+1)*blockSize && idx < totalSize) {
                 dest[idx] = a[idx] + b[idx];
                 idx+=numThreads;
             }
}

int main() {
    int N = 100000000;
    int * a = new int[N]; // declared on heap so no segfault
    int * b = new int[N];
    int * sum = new int[N];
    for (int i = 0; i < N; ++i) {
        a[i] = i*i;
        b[i] = i*i;
    }
    int *d_a, *d_b, *dest;
    cudaMalloc((void**)&d_a, N*sizeof(int));
    cudaMalloc((void**)&d_b, N*sizeof(int));
    cudaMalloc((void**)&dest, N*sizeof(int));
    cudaMemcpy(d_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N*sizeof(int), cudaMemcpyHostToDevice);
    int blockSize = (N + numBlocks - 1)/numBlocks;
    addVectors<<<numBlocks, numThreads>>>(blockSize, N, d_a, d_b, dest);
    cudaMemcpy(sum, dest, N * sizeof(int), cudaMemcpyDeviceToHost);
    if (sum[10] == 200) {
        return 0;
    }
    else {
        cout << "SEMANTIC ERROR" << endl;
    }
}