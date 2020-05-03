#include <stdio.h>

double factorial(int n) {
  printf("フレーム=%d size=%d\n", &n, sizeof(int));  
  return n > 1 ? n * factorial(n - 1) : 1.0; 
}

int main() {
  factorial(10);
  return 0;
}
