#include <iostream>

using namespace std;
void addVectors(int size, int * a, int * b, int * dest) {
    for (int i=0; i < size; ++i) {
        dest[i] = a[i] + b[i];
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
    addVectors(N, a, b, sum);
    if (sum[10] == 200) {
        return 0;
    }
    else {
        cout << "SEMANTIC ERROR" << endl;
    }
}