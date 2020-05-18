#include <stdio.h>

// アセンブラで変数が配置される領域を確認する
extern int g_a;
int g_a = 10;
static int g_b = 3;
static int g_c = 4;
int g_d = 5;

int main(){
    printf("%d", g_a);
    printf("%d", g_b);
    printf("%d", g_c);
    printf("%d", g_d);
    return 0;
}
