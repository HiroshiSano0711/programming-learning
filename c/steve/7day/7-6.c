#include <stdio.h>

char buff[100];

int main() {
  int p_count;
  int n_count;
  printf("素数判定。1以上の数字を入力してね。\n");
  fgets(buff, sizeof(buff), stdin);
  sscanf(buff, "%d", &number);

}
