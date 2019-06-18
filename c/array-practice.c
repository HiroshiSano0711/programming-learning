#include "stdio.h"

int main(int argc, char const *argv[])
{
  int array[5];
  int *p;
  int i;

  for(i = 0; i < 5; i++){
    array[i] = i;
  }

  for(p = &array[0]; p != &array[5]; p++){
    printf("%d\n", ++(*p));
    printf("%d\n", (*p)++);
    printf("%d\n", *(++p));
    printf("%d\n", *(p++));
    printf("%d\n", *p++);
    printf("%d\n", *++p);
    printf("%d\n", ++*p);
    printf("%d\n", ++*++p);
    printf("%d\n", (*++p)++);
  }

  return 0;
}
