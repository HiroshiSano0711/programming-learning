#include <stdio.h>

void func(int *a, double *b){
    *a = 5;
    *b = 3.5;
}

int main(int argc, char const *argv[]){
    int a;
    double b;

    func(&a, &b);
    printf("a..%d b..%f", a, b);
    return 0;
}
