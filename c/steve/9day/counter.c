#include <stdio.h>
#define SQR(x) ((x) * (x))

int main(){
    int counter = 0;
    while(counter < 5){
      printf("x = %d, x sequence = %d\n", counter, SQR(++counter));
      // printf("x = %d, x sequence = %d\n", counter, SQR(counter++));
    }
    return 0;
}
