#include <stdio.h>
#include <stdlib.h>
#define x(n) case n: goto L ## n

int main(int argc, char **argv){
  int n = argc > 1 ? atoi(argv[1]) : 100000000;
  int a = argc > 2 ? atoi(argv[2]) : 0;
  int b = argc > 3 ? atoi(argv[3]) : 0;
  
  switch (argc > 4 ? atoi(argv[4]) : 0){
    x(0); x(1); x(2); x(3); x(4);
    x(5); x(6); x(7); x(8); x(9);
  }
  do{
    asm("DUMMY1:");
    L0: a += b;
    L1: a += b;
    L2: a += b;
    L3: a += b;
    L4: a += b;
    L5: a += b;
    L6: a += b;
    L7: a += b;
    L8: a += b;
    L9: a += b;
    asm("DUMMY2:");
  } while (--n > 0);

  printf("a = %d\n", a);
  return 0;
}
