#include <stdio.h>
#define N 10
int a[N+1] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

int main() {
  int x = 11;
  int i = 0;

  a[N] = x;
  // 条件が真　なら(and && ) 実行
  // 条件が偽　なら(or || ) 実行
  while (a[i] != x) {
    i++;
  }
  printf("i = %d\n", i);
  return 0;
}
