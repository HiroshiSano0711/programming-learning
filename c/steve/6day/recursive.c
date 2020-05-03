#include <stdio.h>

void p(n) {
  if (n > 0) {
    printf("%3d\n", n);
    p(n - 40);
    printf("%3d\n", n);
    p(n - 20);
    printf("%3d\n", n);
  }
}

int main() {
  p(80);
  return 0;
}
