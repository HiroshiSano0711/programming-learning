#include <stdio.h>

int main() {
    register int i;
    register double v;

    v = 0.0;

    for (i = 0; i < 100; i++) {
        v += (double)i * 0.1;
    }
    
    printf("v=%lf\n", v);
    return 0;
}
