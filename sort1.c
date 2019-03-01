#include <stdio.h>

void sort1(float [], int);

int main()
{
  float a[] = { 109, 75, 200, 15, 38, 19, 150, 11, 20 };
  sort1(a, 9);
  return 0;
}

void sort1(float a[], int n){
  int i, j, k;
  float min;

  for(i = 0; i < n - 1; i++){
    k = i; min = a[k];

    for(j = i + 1; j < n; j++){
      if(a[j] < min){
        k = j; min = a[k];
      }
    }
    a[k] = a[i]; a[i] = min;
  }

  for(i = 0; i < n; i++){
    printf("%f\n", a[i]);
  }
}