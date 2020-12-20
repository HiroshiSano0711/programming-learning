#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
    // // 10進数xを左に1ビット巡回シフトさせてその結果を10進数で出力する
    unsigned short x = 100; // 1100100
    unsigned short lsb; // 最上位ビットを保持
    char *binary; // バイナリの文字列（0か1）
    int is_msb = 0; // 最上位ビットを必ず1にしたいので1が来るまでスキップする

    for (int i = 31; i >= 0; i--){
        lsb = (x >> i) & 1;
        if (lsb){
            is_msb = 1;
            strcat(binary, "1");
        } else {
            if (is_msb)
                strcat(binary, "0");
        }
    }
    printf("%s\n", binary); // "1100100"

    char *tmp; // 先頭の文字（最上位ビット）を逃す用
    tmp = binary[0] == '1' ? "1" : "0"; // 文字列に文字を連結する方法がわからん
    ++binary; // 先頭文字を消す
    strcat(binary, tmp); // 先頭の文字（最上位ビット）を末尾に連結
    printf("%s\n", binary); // "1001001"
    char *endptr;
    printf("%ld\n", strtol(binary, &endptr, 2)); // "73"が出るはず

    return 0;
}

int left_rotate(){
    int i = 11; // 00000000 00000000 00000000 00001011
    printf("%d\n", (i >> 1 & 0x7fffffff));
    printf("%d\n", (i & 1 ? 0x80000000 : 0));
    printf("%d\n", (i >> 1 & 0x7fffffff) | (i & 1 ? 0x80000000 : 0));
    return (i >> 1 & 0x7fffffff) | (i & 1 ? 0x80000000 : 0);
}
