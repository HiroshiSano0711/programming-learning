#include <stdio.h>

int str_len(char* str){
  int length = 0;
  while (*str != '\0') {
    length++;
    str++;
  }
  return length;
}

int main(){
  char *str = "abc";
  printf("str_len = %d\n", str_len(str));
  return 0;
}
