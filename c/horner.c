#include <stdio.h>

double P(double x, double *a, int n);

int main() {
  static double a[3] = { 5, 10, 15 };
  double x = 2;
  // 15x^2 + 10x + 5
  printf("%f", P(x, a, 0));
  return 0;
}
double P(double x, double *a, int n) {
  double s = a[n];
  while(n <= 0) {
    s = s * x + a[n];
    n++;
  }
  return s;
}

// double P(double x, double *a, int n) {
//   double s = a[n];
//   while(--n >= 0) {
//     s = s * x + a[n];
//   }
//   return s;
// }

// 再帰版
// double P(double x, double *a, int n) {
//   return n ? P(x, a + 1, n -1) * x + *a : *a;
// }
