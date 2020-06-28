#include <stdio.h>

double power6(double x, int n){
  int negexp = n < 0;
  double y;
  if (n == 0)
    return 1.0;
  if (negexp)
    n = -n;
  while(!(n & 1)){
    x *= x;
    n >>= 1;
  }
  y = x;
  while (n >>= 1){
    x *= x;
    if (n & 1)
      y *= x; 
  }
  return negexp ? 1.0 / y : y;
}

int main(){
  double r = power6(2, 10);
  printf("%f\n", r);
  return 0;
}

