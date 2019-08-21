#include <stdio.h>

int main(void){
    int i, n, sum;

    printf("Enter 1...9 number=>");
    scanf("%d", &n);

    sum = 0;
    for (i = 1; i <= n; i++){
        sum += i;   
    }

    printf("%d", sum);

    return 0;
}
