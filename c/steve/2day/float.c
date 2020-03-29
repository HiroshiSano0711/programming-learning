#include <stdio.h>

int integer;
float floating;

int main(){
  // 型はどうなる？
  floating = 1.0 + 1;
  printf("%f\n", floating);
  printf("%f\n", 1.0 + 1);
  printf("%f\n", 1 + 1.0);
  printf("%f\n", 1.2 + 1);
  return 0;
}
