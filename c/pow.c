#include <stdio.h>

double power4(double x, int n);

int main()
{
  double r = power4(2, 100);
  printf("%f", r);
  return 0;
}

double power4(double x, int n){
  if(n < 2){
    return (n == 0 ? 1.0 : n == 1 ? x : 1.0 / power4(x, -n));
  }else{
    double y = power4(x, (n >> 1));
    y = y * y;
    return n & 1 ? y * x : y;
  }
}