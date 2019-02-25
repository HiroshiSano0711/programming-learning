#include <stdio.h>

void p(int);

int main()
{
  p(4);

  return 0;
}

void p(int n){
  if(n > 0){
    p(n - 2);
    p(n -1);
    printf("%3d", n);
  }
}