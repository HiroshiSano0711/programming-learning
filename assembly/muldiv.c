#include <stdio.h>

int main(void){
    int a, b, c, d;

    a = 7;
    b = 2;

    printf("a*b=%d\n", a * b);

    c = a / b;
    d = a % b;

    printf("a/b=%d...%d\n", c, d);

    return 0;
}
