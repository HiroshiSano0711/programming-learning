#include <stdio.h>
#include <stdlib.h>

int exactsum(int, int);
int *d, n;

int main(){
  int s, i;

  printf("Enter the desired sum: ");
  scanf("%d", &s);

  printf("Enter n, followed by the n given ");
  printf("Integers themselves\n");
  scanf("%d", &n);

  d = (int *)malloc(n * sizeof(int));
  if(d == NULL){
    printf("Not enough memory"); exit(1);
  }

  for (i = 0; i < n; i++)
    scanf("%d", d + i); // scanf("%d", d[i]); 配列の場合

  printf("\nOutput:\n");

  if(exactsum(s, 0))
    printf("\nThe problem has been solved\n");
  else
    printf("\nNo solution\n");

  return 0;
}

int exactsum(t, i) {
  if (t == 0)
    return 1;
  else if (t < 0 || i == n)
    return 0;
  else if (exactsum(t - d[i], i + 1)) {
    printf("%d ", d[i]);
    return 1;
  } else
    return exactsum(t, i + 1);
}
