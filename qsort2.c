#include <stdio.h>

void qsort2(float *, float *);

int main()
{
  static float a[8] = {23, 398, 34, 100, 57, 67, 55, 320};
  qsort2(a, a + 7);
  for(int i = 0; i < 8; i++){
    printf("%1.0f\n", a[i]);
  }
  return 0;
}

void qsort2(float *left, float *right){
  float *p = left, *q = right, w, x;

  do {
    x = *(left + ((right - left) >> 1));

    printf("left: %f\n", *left);
    printf("right: %f\n", *right);
    printf("x: %f\n", x);
    printf("p: %f\n", *p);
    printf("q: %f\n", *q);

    do{
      while(*p < x){
        p++;
      }
      while(*q > x){
        q--;
      }

      if(p > q){
        break;
      }
      w = *p; *p = *q; *q = w;
    }while(++p <= --q);

    if(left < q){
      qsort2(left, q);
    }

    left = p; q = right;
  }while(left < right);
}
