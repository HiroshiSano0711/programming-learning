#include <stdio.h>

int func1(int a){
  printf("func1_variable: %d\n", a);
  printf("func1_variable: %p\n", &a);
  return a;
}

int main(){
  func1(100);
  return 0;
}
