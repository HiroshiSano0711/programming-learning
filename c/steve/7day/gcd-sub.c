#include <stdio.h>

int gcd(int x, int y){
  int sub, tmp;

  if (x < 0)
    x = -x;
  if (y < 0)
    y = -y;
  if (x < y){
    tmp = x;
    x = y;
    y = tmp;
  }

  sub = x - y; // 1200 = 1900 - 700
  while (sub != 0){
    printf("x = %d y = %d\n", x, y);
    if (sub < y) {
      x = y; // x = 200
      y = sub; // y = 100
    } else {
      x = sub; // x = 100 y = 100
    }
    sub = x - y; // 0 = 100 - 100
  }
  return x;
}

int main(){
  printf("%d\n", gcd(1900, 700));
  return 0;
}
