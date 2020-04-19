#include <stdio.h>

int equalseq(int *p, int *q, int n) {
  int temp, *qn;
  qn = q + n;
  temp = *qn;
  *qn = *(p + n) + 1;

  while (*p == *q){
    p++;
    q++;
  }
  *qn = temp;
  return q == qn;
}

int a[100] = {1, 2, 3, 5, 5, 1, 2, 3, 4};

int main(){
  int *p1, *p2, *q1, *q2;
  p1 = a;
  q1 = &a[5];
  p2 = &a[1];
  q2 = &a[6];
  int r1 = equalseq(p1, q1, 0);
  int r2 = equalseq(p2, q2, 0);
  printf("r1 =%d r2=%d\n", r1, r2);
  return 0;
}
