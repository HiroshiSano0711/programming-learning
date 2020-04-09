#include <stdio.h>

char *str_cpy(char* dest, char* src){
  char *temp = dest;
  while ('\0' != (*dest++ = *src++));
  return temp;
}

int main(){
  char buff[10];
  char *p = "def";
  printf("str_cpy = %s\n", str_cpy(buff, p));
  printf("buff= %s\n", buff);
  return 0;
}
