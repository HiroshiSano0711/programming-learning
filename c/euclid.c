#include <stdio.h>
#include <stdlib.h>

int gcd(int x, int y);

int main(){
  int n;
  n = gcd(2300, 400);
  printf("%d\n", n);
  return 0;
}

int gcd(int x, int y){
  int r; 
  x = abs(x);
  y = abs(y);
  while(y){
    r = x % y;
    x = y;
    y = r;
  }
  return x;
}

// 再帰版
int gcd(int x, int y){
  return y ? gcd(y, x % y) : x;
}
