#include <stdio.h>

int main(){
  short s = 32767;
  printf("s = %hd\n", s + 1);
  printf("s = %hd\n", 32767 + 32768);
  return 0;
}
