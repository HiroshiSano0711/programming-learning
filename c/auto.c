#include <stdio.h>

void func(int a, int b){
    int c, d;

    printf("func a,b %p %p\n", &a, &b);
    printf("func c,d %p %p\n", &c, &d);
}

int main(int argc, char const *argv[]){
    int a , b;

    printf("main a,b %p %p\n", &a, &b);

    func(1, 2);
    return 0;
}
