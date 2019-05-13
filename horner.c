#include <stdio.h>
double P(double, double *, int);

int main() {
  static double a[3] = {5, 15, 25};
  double x = 0.5;
  printf("%f", P(x, a, 2));
  return 0;
}

double P(double x, double *a, int n) {
  return n ? P(x, a + 1, n -1) * x + *a : *a;
}

// double P(double x, double *a, int n) {
//   double s = a[n];
//   while(--n >= 0) {
//     s = s * x + a[n];
//   }
//   return s;
// }
// 0.5 * 0.5 = 0.25 * 25 = 6.25
// 15 * 0.5 = 7.5
// 5