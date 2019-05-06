#include <stdio.h>
#include <stdlib.h>

int gcd(int, int);

int main(){
  int n;
  n = gcd(4300, 400);

  printf("%d\n", n);

  return 0;
}

// 整数型だから繰り返しの方が圧倒的に速い
int gcd(int x, int y){
  int r;
  x = abs(x);
  y = abs(y);

  // yが0になるまで繰り返す
  while(y){
    r = x % y; // xをyで割り剰余を出す
    x = y; // rはyより必ず小さくなるのでxとyの位置を入れ替える
    y = r; // yにrを代入する
  }
  return x;
}

// 再帰版
// int gcd(int x, int y){
//   return y ? gcd(y, x % y) : x;
// }
