#include <stdio.h>

int main(){
  double r = power5(2, 100);
  printf("%f", r);
  return 0;
}

double power5(double x, int n){
  int towpower = 1, negexp = n < 0;
  double y = x;

  if (n == 0)
    return 1.0;
  if (negexp)
    n = -n;
  while(towpower <= n)
    towpower <<= 1;
  towpower >>= 1;

  while (towpower >>= 1){
    y *= y;
    if (n & towpower)
      y *= x; 
  }
  return negexp ? 1.0 / y : y;
}
