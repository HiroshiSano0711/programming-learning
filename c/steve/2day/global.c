#include <stdio.h>
char arr[10];
char tmpl[10] = "%s %s";
static int g_int1 = 10;
int g_int2 = 9;
int main(){
    int local_int = 9;
    static int static_local_int = 10;
    char arr2[10];
    printf("%s %s", arr, arr2);
    printf(tmpl, arr, arr2);
}

// .data 読み書き可能セグメント
// .text 読み込みのみ可能セグメント
