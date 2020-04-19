#include <stdio.h>
#define N 3
int equalseq(int *p, int *q, int n);
int p[5] = {1,2,3,4,5};
int q[5] = {1,2,3,6,7};

int main(){
  printf("%d\n", equalseq(p, q, 3));
  return 0;
}

int equalseq(int *p, int *q, int n) {
  int temp, *qn;
  qn = q + n;
  temp = *qn;
  *qn = *(p + n) + 1;

  while (*p++ == *q++){
    ;
  }
  *qn = temp;
  return q > qn;
}
