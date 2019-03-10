#include <stdio.h>
#include <stdlib.h>

#define LEN 100
int n, k, r[LEN];

void exactsum(int);

int main(){
  printf("Enter n ( < %d)", LEN); scanf("%d", &n);
  if(n >= LEN){
    printf("Too large"); exit(1);
  }

  printf("Enter k ( < %d)", n + 1); scanf("%d", &k);
  if(k > n){
    printf("Too large"); exit(1);
  }
  printf("\nOutput\n\n");

  if(exactsum(int)){
    printf("\nThe problem has been solved");
  }else{
    printf("\nNo solution");
  }

  return 0;
}
