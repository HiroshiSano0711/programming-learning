#include <stdio.h>
#include <ctype.h>
#define SWAP(a, b) \
  { \
    int tmp = a;\
    a = b;\
    b = tmp;\
  }
// #define SWAP(a, b) { a = a ^ b; b = a ^ b; a = a ^ b; }

int main(){
    int a = 1;
    int b = 2;
    printf("before %d %d\n", a, b);
    SWAP(a, b);
    printf("after %d %d\n", a, b);
    return 0;
}
