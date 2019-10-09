#include <stdio.h>

int gcd(int x , int y);

int main() {
  int n;
  n = gcd(int, 2300);
  printf("%d\n", n);
  return 0;
}

int gcd(int x , int y) {
  int r, tmp;

  if (x < 0){
    x = -x;
  }
  if (y < 0){
    y = -y;
  }
  // if (x == 0){
  //   return y;
  // }
  if (y == 0){
    return x;
  }

  while (x){
    // 1回目：x = 2300, y = 400
    // 2回目：x = 400, y = 300
    // 3回目：x = 300, y = 100
    // 4回目：x = 100, y = 0
    if (y == 0){
      return x;
    }
    
    r = x % y; // 100 ÷ 0 => error
    x = y;
    y = r;
  }
  // return y;
}