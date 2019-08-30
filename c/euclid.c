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

// 擬似コード（効率の悪いコード）＝＞　効率の良いコード
// 5箇所？
// int gcd(int x, int y){
//   int temp, r;
//   if (x < 0) {
//     x = -x;
//   }
//   if (y < 0) {
//     y = -y;
//   }
//   if (x <= y) {
//     temp = x; x = y; y = temp;
//   }
//   if (y == 0) {
//     return x;
//   }

//   while(1){
//     r = x % y;
//     if (r == 0) {
//       return y;
//     }
//     x = y;
//     y = r;
//   }
// }

// int gcd(int x, int y){
//   int r;

//   while(y){
//     r = x % y;
//     x = y;
//     y = r;
//   }
//   return x;
// }

// 再帰版
int gcd(int x, int y){
  return y ? gcd(y, x % y) : x;
}
