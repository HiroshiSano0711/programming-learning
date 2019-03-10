#include <stdio.h>
#include <time.h>

int recfac(int);
int itfac(int);

int main()
{
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
    f = recfac(n);
  }
  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;

  printf("Recursion: %d! = %1.0f time = %1.10f s\n", n, f, diff);

  start = clock();
  for(i = 0 ; i < k; i++){
    f = itfac(n);
  }

  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;

  printf("Iteration: %d! = %1.0f time = %1.10f s\n", n, f, diff);
  return 0;
}

int recfac(int n){
  return n > 1 ? n * recfac(n - 1) : 1;
}

int itfac(int n){
  int d = 1;
  while(n > 1){
    d *= n--;
  }
  return d;
}
