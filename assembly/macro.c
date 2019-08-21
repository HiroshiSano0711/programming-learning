#include <stdio.h>

#define add(n1, n2) (n1 + n2) 

int main() {
    int a, b, x;

    a = 3;
    b = 5;

    x = add(a, b);
    
    printf("x=%d\n", x);
    return 0;
}
