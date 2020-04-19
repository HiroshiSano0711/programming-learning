#include <stdio.h>

int main() {
  char array[3] = "abc";
  char *array_2 = "abc";
  printf("array = %s\n", array);
  printf("array = %ld\n", sizeof(array));
  printf("array_2 = %s\n", array_2);
  printf("array_2 = %ld\n", sizeof(array_2));
  return 0;
}
