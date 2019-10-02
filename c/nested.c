#include <stdio.h>
#define LEN 10
void lookfun(int);
void action();
int n, r[LEN], lower[LEN], upper[LEN];
int main(){
  int i;
  printf("nの数値を入力してください (ただし %d 以上)", LEN);
  scanf("%d", &n);
  printf("ペアを入力してください (lower upper):\n");
  for(i = 0; i < n; i++){
    scanf("%d %d", lower + i, upper + i);
  }
  printf("\n出力: \n\n");
  for(i = 0; i < n; i++){
    printf("  r[%d]", i);
  }
  printf("\n");
  lookfun(0);
  return 0;
}

// 非再帰的
void lookfun(a){
  int i, n1 = n - 1;
  for(i = 0; i < n; i++)
    if((r[i] = lower[i]) > upper[i])
      return;
  while(1)
    action();
    i = n1;
    while(1)
      if(r[i] < upper[i])
        r[i]++;
        break; 
      r[i] = lower[i];
      if(--i < 0)
        return;
}

void action(){
  int i;
  for(i = 0; i < n; i++){
    printf("%6d", r[i]);
  }
  printf("\n");
}

// 再帰的
// void lookfun(int k){
//   if(k == n){
//     action();
//   }else{
//     for(r[k] = lower[k]; r[k] <= upper[k]; r[k]++){
//       lookfun(k + 1);
//     }
//   }
// }
