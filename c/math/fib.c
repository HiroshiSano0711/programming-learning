#include <stdio.h>
#include <time.h>

// 再帰版
int fib(int n){
    if (n == 0)
        return 0;
    if (n == 1)
        return 1;
    return fib(n - 1) + fib(n - 2);
}

int main(){
    int n;
    long cpu_time;

    n = fib(40);
    printf("%d\n", n);

    // CPUの使用時間をチェック
    cpu_time = clock();
    printf("CPU時間： %ld\n", cpu_time);

    return 0;
}
