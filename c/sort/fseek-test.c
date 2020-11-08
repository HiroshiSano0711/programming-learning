#include <stdio.h>
#include <stdlib.h>

// fqsort()を読むために、fseekとftellの動作確認。
int main(){
    FILE *fp;

    fp = fopen("tmp.txt", "rb");
    if (fp == NULL){
        printf("Unknown name\n");
        exit(1);
    }

    // ファイルの最後のポインタ=ファイルサイズを確認してみる。
    fseek(fp, 0, SEEK_END);
    printf("%ld\n", ftell(fp));
    fclose(fp);
    return 0;
}
