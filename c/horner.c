#include <stdio.h>

double P(double x, double *a, int n);

int main() {
  static double a[3] = {5, 10, 15};
  double x = 2;
  printf("%f", P(x, a, 2));
  return 0;
}

// n = 1
// s = 15.000000
// a[n] = 10.000000

// n = 0
// s = 40.000000
// a[n] = 5.000000

// 85.000000
double P(double x, double *a, int n) {
  double s = a[n]; // 15
  while(--n >= 0) {
    printf("n = %d\n", n);
    printf("s = %f\n", s);
    printf("a[n] = %f\n", a[n]);
    printf("s * x + a[n] = %f\n", s * x + a[n]);
    s = s * x + a[n];
  }
  return s;
}

// 再帰版
// double P(double x, double *a, int n) {
//   return n ? P(x, a + 1, n -1) * x + *a : *a;
// }
