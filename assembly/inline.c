#include <stdio.h>


int main() {
    int a, b, x;

    a = 3;
    b = 5;

    // c = add(a, b);
    asm("movl %0, %eax"::"g"(a));
    asm("movl %0, %eax");
    
    printf("x=%d\n", x);
    return 0;
}
