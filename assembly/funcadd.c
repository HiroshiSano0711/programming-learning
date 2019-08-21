#include <stdio.h>

int add(int x, int y) {
    int z;
    z = x + y + 10;

    return z;
}

int main(void) {
    int a, b, c;

    a = 5;
    b = 3;
    c = add(a, b);

    printf("c=%d\n", c);
    return 0;
}
