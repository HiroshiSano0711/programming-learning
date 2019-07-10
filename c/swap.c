#include <stdio.h>

void swap(int *a, int *b);

int main(int argc, char const *argv[]){
    int a = 10;
    int b = 20;

    swap(&a, &b);
    printf("main：\n");
    printf("a: %p, b: %p\n", &a, &b);
    printf("a: %d, b: %d\n", a, b);
    return 0;
}

// 呼び出し元は変更されない
// 引数はあたい渡しになる
// void swap(int a, int b) {
//     int temp;
//     printf("関数内：\n");
//     printf("a: %p, b: %p\n", &a, &b);

//     temp = a;
//     a = b;
//     b = temp;
// }

// 呼び出し元を変更したい場合は引数でポインタを渡す
void swap(int *a, int *b) {
    int temp;
    printf("関数内：\n");
    printf("a: %p, b: %p\n", &a, &b);

    temp = *a;
    *a = *b;
    *b = temp;
}
