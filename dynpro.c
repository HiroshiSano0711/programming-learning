#include <stdio.h>
#include <stdlib.h>

#define NULl 0

typedef int *pint;
int n, *d, *getints();
pint *p;

int *getints(int n);
int *solution(int s);

int main(int argc, char const *argv[]){
  int s, i, j, m, *row, *solution();

  printf("Enter the desired sum: "); scanf("%d", &s);
  printf("Enter n, followed by the n given  ");
  printf("intergers themselves:\n");
  scanf("%d", &n);

  d = getints(n);
  p = (pint *)malloc((s + 1)*sizeof(pint));

  if(p == NULL){
    printf("Not enough memory\n");
    exit(1);
  }

  for(i = 0; i < n; i++){
    scanf("%d", d + i);
  }
  row = solution(s);

  if(row == NULL){
    printf("\nNo solution");
  }else{
    printf("\nSolution:\n\n  %d = ", s);
    m = row[0];

    for(j = 1; j <= m; j++){
      printf("%d %s", row[j], j < m ? "+ " : "\n");
    }
  }

  return 0;
}

int *getints(int n){
  int *q;
  q = (int *)malloc(n * sizeof(int));
  if(q == NULL){
    printf("Not enough memory\n"); exit(1);
  }
  return q;
}

#define BIG 30000

int *solution(int s){
  int x, u, i, j, min, imin, *destin, *source, aux;
  p[0] = getints(1); p[0][0] = 0;

  for(x = 1; x <= s; x++){
    min = BIG;
    for(i = 0; i < n; i++){
      u = x - d[i];
      if(u >= 0 && p[u] != NULL && p[u][0] < min){
        min = p[u][0]; imin = i;
      }
    }
    if(min < BIG){
      p[x] = destin = getints(min + 2);
      aux = x - d[imin]; source = p[aux];
      destin[0] = min + 1;
      for(j = 1; j <= min; j++){
        destin[j] = source[j];
      }
      destin[min + 1] = d[imin];
    }else{
      p[x] = NULL;
    }
  }
  return p[s];
}













