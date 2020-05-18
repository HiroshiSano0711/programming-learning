#include <stdio.h>
char buff[100];

int main(){
  int s = 0;
  int d, n;
  printf("n個の数値の平均値を計算します。nを入力してね\n");
  fgets(buff, sizeof(buff), stdin);
  sscanf(buff, "%d", &n);

  printf("数値を%d回入力してね\n", n);
  for (int i = 0; i < n; i++){
    fgets(buff, sizeof(buff), stdin);
    sscanf(buff, "%d", &d);
    s += d;
  }
  printf("平均値 = %f\n", (float)s / n);

  return 0;
}
