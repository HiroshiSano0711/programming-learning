#include <stdio.h>

// 繰り返し版
// a = 2個前、b = 1個前
int fib(int n, int a, int b){
  if (n == 0)
    return b;
  if (n == 1)
    return b;
  return fib(n - 1, b, a + b);
}

int main(){
  int n;
  n = fib(6, 0, 1);
  printf("result %d\n", n);
  return 0;
}
