#include <stdio.h>
#include <stdlib.h>

int main(){
    int *int_p, *after_free;

    int_p = malloc(sizeof(int));

    *int_p = 12345;

    printf("before free %p\n", int_p);

    free(int_p);

    printf("after free  %p\n", int_p);
    after_free = malloc(sizeof(int));
    printf("next malloc %p\n", after_free);
    return 0;
}
