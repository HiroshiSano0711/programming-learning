#include <stdio.h>
#include <stdlib.h>

#define LEN 100
int n, k, r[LEN];

void combine(int);
void action();

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
  combine(1);
  return 0;
}

void combine(int m){
  int i;

  if(m > k){
    action();
  }else{
    for(i = r[m - 1] + 1; i <= n - k + m; i++){
      r[m] = i;
      combine(m + 1);
    }
  }
}

void action(){
  int i;
  for(i = 1; i <= k; i++){
    printf("%3d", r[i]);
  }
  printf("\n");
}
