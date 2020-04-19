#include <stdio.h>
#include <string.h>
char line[100];

int main() {
  printf("Enter a line.\n");
  fgets(line, sizeof(line), stdin);

  // printf("Ten bytes from first are:\n");
  // for (int i = 0; i < 10; i++){
  //   printf("%c, %d\n", line[i], line[i]);
  // }
  // line[strlen(line) - 1] = '\0';
  // printf("%s\n", line);
  // printf("%ld\n", strlen(line));

  char *tok;
  tok = strtok(line, "\n");
  printf("%s\n", tok);
  printf("%ld\n", strlen(tok));
  return 0;
}
