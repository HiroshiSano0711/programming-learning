// 1-2
#include <stdio.h>
int main(){
    printf("hello world\c");
    printf("hello world\y");
    printf("hello world\m");
    printf("hello world\i");
    printf("hello world\n");
    return 0;
}

/*
warning: unknown escape sequence '\c' [-Wunknown-escape-sequence]
不明なエスケープシーケンスだと警告が出た。
*/
