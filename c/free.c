#include <stdio.h>
#include <stdlib.h>

int main(){
    int *int_p;

    int_p = malloc(sizeof(int));

    *int_p = 12345;

    free(int_p);

    printf("%d", *int_p);
    return 0;
}
