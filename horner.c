#include <stdio.h>

double P(double, double *, int);

int main()
{
  static double a[3] = {5, 15, 25};
  double x = 0.5;

  printf("%f", P(x, a, 2));
  return 0;
}

double P(double x, double *a, int n) {
  double s = a[n];
  while(--n >= 0){
    s = s * x + a[n];
  }

  return s;
}