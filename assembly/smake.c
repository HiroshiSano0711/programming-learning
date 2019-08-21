#include <stdio.h>

int main(void){
    char str[10];
    int i, n;

    n = 9;
    for (i = 0; i < n; i++){
        str[i] = 0x41 + i;   
    }
    str[i] = '\0';

    printf("%s", str);

    return 0;
}
