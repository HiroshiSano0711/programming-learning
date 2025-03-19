#include <stdio.h>
#include <stdlib.h>

int global_variable; // グローバル変数
static int file_static_variable; // ファイル静的変数

void func1(){
    int func1_variable = 1;
    printf("&func1 %p\n", &func1_variable);
}

void func2(int val1, int val2){
    int func2_variable = 2;

    printf("&func2 %p\n", &func2_variable);
    printf("&val1 %p\n", &val1);
    printf("&val2 %p\n", &val2);
}

int main(int argc, char const *argv[]){
    int *p, *p2, *p3,*p4, *p5,*p6, *p7,*p8, *p9;
    printf("global_variable %p\n", &global_variable);
    printf("file_static_variable %p\n", &file_static_variable);
    printf("&func1 a %p\n", &func1);
    printf("&func2 b %p\n", &func2);

    func1();
    func2(5,6);

    p = malloc(sizeof(long int));
    printf("malloc %p\n", &p);
    p2 = malloc(sizeof(long int));
    printf("malloc %p\n", &p2);
    p3 = malloc(sizeof(int));
    printf("malloc %p\n", &p3);
    p4 = malloc(sizeof(int));
    printf("malloc %p\n", &p4);
    p5 = malloc(sizeof(int));
    printf("malloc %p\n", &p6);
    p6 = malloc(sizeof(int));
    printf("malloc %p\n", &p6);
    p7 = malloc(sizeof(int));
    printf("malloc %p\n", &p7);
    p8 = malloc(sizeof(int));
    printf("malloc %p\n", &p8);
    p9 = malloc(sizeof(int));
    printf("malloc %p\n", &p9);

    return 0;
}
