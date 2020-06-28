#include <stdio.h>
#define CAN_DIVIDE_TEN(x) (x % 10 == 0)

int main(){
    int counter = 0;
    while(counter < 50){
      printf("x = %d, x sequence = %d\n", counter, CAN_DIVIDE_TEN(counter));
      counter++;
    }
    return 0;
}
