#include <stdio.h>

void f(n) {
    if (n > 0){
        f(n - 3);
        printf("%3d\n", n);
        f(n - 2);
    }
}

int main(){
    f(6);
    return 0;
}
// ボトムアップ解析
// f(0): none
// f(1): f(-2) 1 f(-1)
// f(2): f(-1) 2 f(0)
// f(3): f(0) 3 1
// f(4): 1 4 2
// f(5): f(2) 5 f(3)
// f(6): f(3) 6 f(4) = 3 1 6 1 4 2
// 出力 = 3 1 6 1 4 2
