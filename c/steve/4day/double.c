#include <stdio.h>
char line[100];
int value;
int main() {
  // printf("Enter a String: ");
  // fgets(line, sizeof(line), stdin);
  // // sscanf(line, "%d", &value);
  // printf("Twice %d is %d\n", value, value * 2);
  // printf("%d\n", sizeof(char));
  // printf("%d\n", sizeof(short));
  // printf("%d\n", sizeof(int));
  printf("%d\n", sizeof(float));
  printf("%d\n", sizeof(double));
  printf("%d\n", sizeof(long double));
  return 0;
}

// #include <stdio.h>
// #include <stdlib.h>
// #define N 256

// int main(void) {
//     char s[] = "チャーリー・ブラウン   4     男性";
//     char name[N] = {'\0'};
//     char sex[N] = {'\0'};
//     int age;

//     sscanf(s, "%s %d %s", name, &age, sex);
//     printf("%s,%d,%s\n", name, age, sex);

//     return EXIT_SUCCESS;
// }
