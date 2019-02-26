#include <stdio.h>
#include <time.h>

int main()
{
  clock_t start, stop;
  double diff;
  int n, k, i;

  double f , recfac(), itfac();

  printf("Enter the value of n, to compute n!: ");
  scanf("%d", &n);

  printf("How many times do you want %d! to be computed? : ", n);
  scanf("%d", &k);

  // time0 = time(NULL);
  start = clock();
  for(i = 0 ; i < k; i++){
    f = recfac(n);
  }
  // time1 = time(NULL);
  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;
  // diff = difftime(time1, time0);

  printf("Recursion: %d! = %1.0f time = %1.10f s\n", n, f, diff);

  // time0 = time(NULL);
  start = clock();
  for(i = 0 ; i < k; i++){
    f = itfac(n);
  }

  // time1 = time(NULL);
  // diff = difftime(time1, time0);
  // time1 = time(NULL);
  stop = clock();
  diff = (double)(stop - start) / CLOCKS_PER_SEC;

  printf("Iteration: %d! = %1.0f time = %1.10f s\n", n, f, diff);
  return 0;
}

double recfac(int n){
  return n > 1 ? n * recfac(n - 1) : 1.0;
}

double itfac(int n){
  double product = 1.0;
  while(n > 1){
    product *= n--;
  }
  return product;
}
