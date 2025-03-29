#include <stdio.h>
#include <stdlib.h>

int global_variable; 
static int file_static_variable;

int fibo(int n){
    printf("fibo arg %d\n", n);
    printf("fibo arg %p\n", &n);
    if(n == 1 || n == 2){
        return 1;
    }
    return fibo(n-1) + fibo(n-2);
} 

int main(int argc, char const *argv[]){
    printf("global_variable %p\n", &global_variable);
    printf("file_static_variable %p\n", &file_static_variable);
    printf("fibo func %p\n", &fibo);

    fibo(4);

    int *p, *p2, *p3,*p4;
    p = malloc(sizeof(int));
    printf("malloc 1 %p\n", &p);
    p2 = malloc(sizeof(int));
    printf("malloc 2 %p\n", &p2);
    p3 = malloc(sizeof(int));
    printf("malloc 3 %p\n", &p3);
    p4 = malloc(sizeof(int));
    printf("malloc 4 %p\n", &p4);

    return 0;
}
