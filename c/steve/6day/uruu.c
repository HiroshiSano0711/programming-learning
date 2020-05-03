#include <stdio.h>
char line[80];
int year;

int main() {
  printf("西暦を入力してください。");
  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d", &year);

  // 閏年＝地球の自転と365日の差を埋めるため
  if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
    printf("閏年です\n");
  } else {
    printf("閏年ではない\n");
  }
  return 0;
}

// if(year % 400 == 0) {
  // 閏年
// } else if(year % 100 == 0)) {
  // 閏年でない
// } else if(year % 4 == 0) {
  // 閏年
// } else {
  // 閏年でない
// }
