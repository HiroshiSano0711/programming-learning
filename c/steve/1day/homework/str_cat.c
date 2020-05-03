#include <stdio.h>

char *str_cat(char* dest, char* src){
  char *top;
  top = dest;
  while ('\0' != *dest){
    dest++;
  }
  while ((*dest++ = *src++) != '\0');
  return top;
}

int main(){
  char buff[10] = "abc";
  char *p = "def";
  printf("p = %s q= %s str_cat = %s\n", buff, p, str_cat(buff, p));
  return 0;
}