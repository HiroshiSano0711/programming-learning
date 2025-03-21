#include <stdio.h>

void qsort1(float *left, float *right){
  float *p = left, *q = right, w, x = *(left + ((right - left) >> 1));

  do {
    while(*p < x)
      p++;
    while(*q > x)
      q--;
    if(p > q)
      break;
    w = *p; *p = *q; *q = w;
  } while(++p <= --q);
  if(left < q)
    qsort1(left, q);
  if(p < right)
    qsort1(p, right);
}

int main()
{
  // static float a[8] = {70, 80, 90, 100, 60, 50, 40, 30};
  // static float a[8] = {100, 100, 100, 100, 100, 100, 100, 100};
  // static float a[8] = {120, 120, 120, 100, 120, 120, 120, 120};
  static float a[8] = {120, 120, 120, 100, 90, 80, 70, 60};
  qsort1(a, a + 7);
  for(int i = 0; i < 8; i++){
    printf("%1.0f\n", a[i]);
  }
  return 0;
}
