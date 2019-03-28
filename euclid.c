#include <stdio.h>

int gcd(int, int);

int main(){
  int n;
  n = gcd(2300, 400);

  printf("%d\n", n);

  return 0;
}
// 整数型だから繰り返しの方が圧倒的に速い
int gcd(int x, int y){
  int r;

  // マイナスの数字だったらプラスに変換する
  if(x < 0){
    x = -x;
  }
  if(y < 0){
    y = -y;
  }

  // yが0になるまで繰り返す
  while(y){
    // xをyで割った商を出す
    r = x % y;
    // rはyより必ず小さくなるのでxとyの位置を入れ替える
    x = y;
    y = r;
  }
  return x;
}

// 再帰版
// int gcd(int x, int y){
//   return y ? gcd(y, x % y) : x;
// }
