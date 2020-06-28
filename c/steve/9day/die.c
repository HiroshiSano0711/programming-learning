#include <stdio.h>
#include <stdlib.h>
#define DIE \
fprintf(stderr, "Fatal Error: Abort\n"); exit(8);

int main(){
    int value;
    value = 3;
    int x = 1+ +1;
    
    printf("%d\n", x);
    return 0;
}
