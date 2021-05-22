#include <stdio.h>
#include <time.h>

int result_store[100];

// キャッシュ版
int fib(int n){
    if (n == 0) return 0;
    if (n == 1) return 1;
    if(result_store[n]) return result_store[n];

    // 左側ノードを通る時にキャッシュされ、右側はキャッシュを使うようになる。
    result_store[n] = fib(n - 1) + fib(n - 2);

    return result_store[n];
}

int main(){
    int n;
    long cpu_time;

    n = fib(50); // nが大きくなっても実行時間があまり増えない。
    printf("%d\n", n);

    // CPUの使用時間をチェック
    cpu_time = clock();
    printf("CPU時間： %ld\n", cpu_time);

    return 0;
}
