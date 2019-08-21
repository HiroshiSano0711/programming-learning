#include <stdio.h>

int main(void){
    int n[] = { 1, 3, 5, 7, 11, -1};
    int *p;

    p = n;

    while( *p != -1){
        printf("%p", p++);
    }

    return 0;
}
