#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

#define LEN 30000
#define NNAMES 2000

char a[LEN], *ptr[NNAMES];

void strqsort(int, int);

int main()
{
  int n = 0, i; // nは要素数、iは〇番目、p,qはポインタが多い
  char *q;
  FILE *fpin, *fpout;

  fpin = fopen("unsorted.txt", "r");
  if(fpin == NULL){
    printf("???"); exit(1);
  }
  q = a;

  while(fscanf(fpin, "%s", q) > 0){
    ptr[n++] = q;
    q += strlen(q) + 1;
    if(q - a + 50 > LEN){
      printf("FILE too large\n"); exit(1);
    }
  }
  fclose(fpin);
  printf("Total string length: %ld\n There are %d keywords\n", q - a + 1, n);

  strqsort(0,  n - 1);
  fpout = fopen("sorted.txt", "w");

  for(i = 0; i < n; i++){
    fprintf(fpout, "%s\n", ptr[i]);
  }

  fclose(fpout);
  return 0;
}

void strqsort(int left, int right){
  int i, j; char *px, *pw;

  do {
    px = ptr[(left + right) / 2]; i = left; j = right;

    do{
      while(strcmp(ptr[i], px) < 0){
        i++;
      }
      while(strcmp(ptr[j], px) > 0){
        j--;
      }

      if(i > j){
        break;
      }
      pw = ptr[i]; ptr[i] = ptr[j]; ptr[j] = pw;
    }while(++i <= --j);

    if(j - left < right - i){
      if(left < j){
        strqsort(left, j);
      }
      left = i; j = right;
    } else {
       if(i < right){
        strqsort(i, right);
      }
      right = j; i = left;
    }
  }while(left < right);
}
