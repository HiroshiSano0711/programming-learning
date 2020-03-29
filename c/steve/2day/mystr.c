#include <stdio.h>

char *my_cpy(char* dest, char* src){
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
  printf("p = %s q= %s my_cpy = %s\n", buff, p, my_cpy(buff, p));
  return 0;
}
