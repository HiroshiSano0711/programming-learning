#include <stdio.h>

int main(){
    float fahr, celsius;
    int lower, upper, step;
    lower = -273;
    upper = 148;
    step = 20;

    celsius = lower;
    printf("%6s %3s\n", "摂氏", "華氏");
    while (celsius <= upper){
        fahr = 1.8 * celsius + 32.0;
        printf("%6.2f %3.2f \n", celsius, fahr);
        celsius = celsius + step;
    }
    return 0;
}
