#include <stdio.h>
#include "header.h"

int main(){
    int index;
    index = 0;
    while (index < BIG_NUMBER){
      printf("%d\n", SQR(index));
      index++;
    }
    return 0;
}
