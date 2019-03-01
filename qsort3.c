#include <stdio.h>

void qsort3(float *, float *);

int main()
{
  static float a[8] = {23, 398, 34, 100, 57, 67, 55, 320};
  qsort3(a, a + 7);
  for(int i = 0; i < 8; i++){
    printf("%1.0f\n", a[i]);
  }
  return 0;
}

void qsort3(float *left, float *right){
  float *p = left, *q = right, w, x;

  do {
    x = *(left + ((right - left) >> 1));

    printf("left: %f\n", *left);
    printf("right: %f\n", *right);
    printf("x: %f\n", x);

    // do{
    //   while(*p < x){
    //     p++;
    //   }
    //   while(*q > x){
    //     q--;
    //   }

    //   if(p > q){
    //     break;
    //   }
    //   w = *p; *p = *q; *q = w;
    // }while(++p <= --q);

    // if(q - left < right - p){
    //   if(left < q){
    //     // qsort3(left, q);
    //     left = p; q = right;
    //   }
    // }else{
    //   if(p < right){
    //     // qsort3(p, right);
    //   }
    //   right = q; p = left;
    // }
  }while(left < right);
}
