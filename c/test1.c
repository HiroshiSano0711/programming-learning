#include <stdio.h>

int main(int argc, char **argv){
    int *a;
    int b;

    b = 1;
    a = &b;

    printf("argv= %s\n", argv[1]);
    return 0;
}
