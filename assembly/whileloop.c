#include <stdio.h>

int main(void){
    int n;
    printf("Enter 1...9 number=>");
    scanf("%d", &n);

    while (1){
        n += n;
        if (n > 100) {
            break;
        }
    }

    printf("%d", n);

    return 0;
}
