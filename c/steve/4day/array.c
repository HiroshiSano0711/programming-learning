#include <stdio.h>
#include <stdlib.h>
static const int a = 100;
static int c = 300;
int *d;

int main() {
  const int b = 200;
  d = (int *)malloc(sizeof(int));
  d[0] = 400;
  printf("a = %p\n", &a);
  printf("b = %p\n", &b);
  printf("c = %p\n", &c);
  printf("d = %p\n", &d);
  return 0;
}
