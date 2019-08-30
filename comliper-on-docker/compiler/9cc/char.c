
#include <stdio.h>

int main(void){
  char *word = "abcde";

  while(*word){
    printf("%s\n", word);
    word++;
  }
}
