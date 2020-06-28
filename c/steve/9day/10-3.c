#include <stdio.h>
#include <ctype.h>
#define IS_HEX(x) (isxdigit(x) != 0)

int main(){
    char *p = "1234567890abcdefgh";
    int a[3] = {1,2,3};
    while(*p != '\0'){
      printf("p = %p, p = %s, is_hex = %d\n", p, p, IS_HEX(*p));
      p++;
    }
    return 0;
}
