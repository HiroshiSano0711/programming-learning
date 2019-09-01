#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int gcd(int x, int y);

int main(){
  int n;
  n = gcd(2400, 400);
  printf("%d\n", n);
  return 0;
}

int gcd(int x, int y){
  int r;
  if (x < 0) {
    x = -x;
  }
  if (y < 0) {
    y = -y;
  }
  while(y){
    r = x % y;
    x = y;
    y = r;
  }
  return x;
}

// 再帰版
int gcd(int x, int y){
  return y ? gcd(y, x % y) : x; // 最適化なし
}
