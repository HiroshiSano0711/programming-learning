#include <stdio.h>

double P(double x, double *a, int n) {
  int i = 0;
  double s = a[i];

  for (++i; i < n; i++)
    s = s * x + a[i];
  return s;
}

// 再帰版
// double P(double x, double *a, int n) {
//   return n ? P(x, a + 1, n -1) * x + *a : *a;
// }
 
int main() {
  // static double a[3] = {5, 15, 25};
  static double a[3] = {25, 15, 5};
  double x = 0.5;

  printf("%f\n", P(x, a, 3));
  return 0;
}
