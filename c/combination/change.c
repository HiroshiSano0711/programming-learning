#include <stdio.h>

int n = 4; // コインの種類数
int d[4] = { 2, 10, 25, 40 }; // 各コイン

// 両替したときの最小枚数を返す
int change(int s){
    int min = -1;

    if(s < 0) return -1;
    if(s == 0) return 0;

    for (int i = 0; i < n; i++){
        int ret = change(s - d[i]);
        if(ret != -1) {
            if (min == -1) min = ret;
            if (ret < min) min = ret;
        }
    }
    return min == -1 ? min: min + 1;
}

int main(){
    int s = 42;

    int result = change(s);
    printf("result = %d\n", result);
    return 0;
}
