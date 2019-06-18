#include <stdio.h>

void sort2(char [], int);

int main()
{
  char a[21] = 'ABCDAGRGARGAR';
  sort2(a, 9);
  return 0;
}

void sort2(char a[], int n){
  int i, j;
  char *p, min[21];

  for(i = 0; i < n - 1; i++){
    p = a[i];

    for(j = i + 1; j < n; j++){
      if(strcmp(a[i], p < 0)){
        p = a[j];
      }
    }
    strcpy(min, p);
    strcpy(p, a[i]);
    strcpy(a[i], min);
  }

  for(i = 0; i < n; i++){
    printf("%f\n", a[i]);
  }
}