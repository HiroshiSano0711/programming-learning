#include <stdio.h>

int equalseq(int *p, int *q, int n) {
  int i = 0;
  while (i < n && *(p + i) == *(q + i))
    // while (i < n && p[i] == q[i])
    i++;
  // i = 3
  // n = 3
  return i == n;
}

int a[100] = {1, 2, 3, 5, 5, 1, 2, 3, 4};

int main(){
  int *p1, *p2, *q1, *q2;
  p1 = a;
  q1 = &a[5];
  p2 = &a[1];
  q2 = &a[6];
  int r1 = equalseq(p1, q1, 3);
  int r2 = equalseq(p2, q2, 3);
  printf("r1 =%d r2=%d\n", r1, r2);
  return 0;
}
