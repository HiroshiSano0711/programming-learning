#include <stdio.h>
#include <time.h>

double recursion(double);
double iteration(double);

int main(){
  clock_t start, stop;
  double diff;
  int n, k, i;
  double f;

  printf("Enter the value of n, to compute n!: ");
  scanf("%d", &n);

  printf("How many times do you want %d! to be computed? : ", n);
  scanf("%d", &k);

  start = clock();
  for(i = 0 ; i < k; i++){
    f = recursion(n);
  }
  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;

  printf("Recursion: %d! = %1.0f time = %1.10f s\n", n, f, diff);

  start = clock();
  for(i = 0 ; i < k; i++){
    f = iteration(n);
  }
  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;

  printf("Iteration: %d! = %1.0f time = %1.10f s\n", n, f, diff);
  return 0;
}

// nの階乗をk回計算し続けるプログラム
// 再帰版
double recursion(double n){
  return n > 1 ? n * recursion(n - 1) : 1.0;
}

// 繰り返し版
double iteration(double n){
  double d = 1.0;
  while(n > 1){
    d *= n--;
  }
  return d;
}
