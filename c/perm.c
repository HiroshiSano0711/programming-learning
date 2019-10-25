#include <stdio.h>
#include <stdlib.h>

#define LEN 11

int n, r[LEN];
void permut(int);
void action();

int main(){
  int i;
  printf("Enter n (< %d)", LEN);
  scanf("%d", &n);

  if(n >= LEN){
    printf("Too large number\n");
    exit(1);
  }
  for(i = 1; i <= n; i++){
    r[i] = i;
  }
  printf("\nOutput: \n\n");
  permut(1);
  return 0;
}

void permut(int k){
  int i, j, aux;

  if(k == n){
    action(); return;
  }

  for(i = k; i <= n; i++){
    aux = r[i];

    for(j = i; j > k; j--){
      r[j] = r[j - 1];
    }
    r[k] = aux;

    permut(k + 1);

    for(j = k; j < i; j++){
      r[j] = r[j + 1];
    }
    r[i] = aux;
  }
}

void action(){
  int i;
  for(i = 1; i <= n; i++){
    printf("%3d", r[i]);
  }
  printf("\n");
}
