#include <stdio.h>
#include <math.h>

char line[80];
double amount;
double cent_25_count;
double cent_10_count;
double cent_1_count;

int main() {
  double m;
  printf("1ドル以下の金額を入力してください。");
  fgets(line, sizeof(line), stdin);
  sscanf(line, "%lf", &amount);

  cent_25_count = (int)(amount / 0.25);
  m = fmod(amount, 0.25);
  if (m != 0) {
    cent_10_count = (int)(m / 0.10);
    m = fmod(m, 0.10);
  }
  if (m != 0) {
    cent_1_count = m / 0.01;
  }
  printf("25セント = %lf 枚\n", cent_25_count);
  printf("10セント = %lf 枚\n", cent_10_count);
  printf("1セント = %lf 枚\n", cent_1_count);
  return 0;
}
