// int main() {
//   int i, s = 0;
//   while (scanf("%d", &i) > 0) {
//     s += i;
//   }
//   printf("The sum is %d\n", s);
// }
#include <stdio.h>

int main() {
  char buff[100];
  int i, i1, i2, m, sum = 0;
  while (fgets(buff, sizeof(buff), stdin) !=  NULL) {
    m = sscanf(buff, "%d %d %d", &i, &i1, &i2);
    if (m <= 0)
      break;
    sum += i;
    sum += i1;
    sum += i2;
  }
  printf("The sum is %d\n", sum);
}