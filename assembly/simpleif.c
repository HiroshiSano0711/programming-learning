#include <stdio.h>

int main(void){
    int a;
    a = 10;

    switch (a){
    case 0:
        printf("zero\n");
        break;
    case 1:
        printf("one\n");
        break;
    case 10:
        printf("ten\n");
        break;
    default:
        printf("error\n");
        break;
    }
    return 0;
}
