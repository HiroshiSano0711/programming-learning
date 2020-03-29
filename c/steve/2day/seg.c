#include <stdio.h>
char *p = "abc";

int main(){
  printf("1\n");
  p[1] = '3';
  printf("%s", p);
  return 0;
}
