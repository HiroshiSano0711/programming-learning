#include <stdio.h>

// 配列使ってボトムから計算する。
int fib_array[100];

void fib(int n, int max){
  if(n < 2 || n > max) return;
  fib_array[n] = fib_array[n - 1] + fib_array[n - 2];
  return fib(n + 1, max);
}

int main(){
  int start_index = 2, max = 10;
  fib_array[0] = 0;
  fib_array[1] = 1;
  fib_array[start_index] = 1;
  fib(start_index, max);
  printf("result %d\n", fib_array[max]);
  return 0;
}
