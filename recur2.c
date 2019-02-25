#include <stdio.h>

void addnumbers();

int s = 0;

int main()
{
  addnumbers();

  return 0;
}

// void addnumbers(){ // 再帰版
//   int x = 0;
//   if(scanf("%d", &x)){
//     s += x; printf("%3d\n", s); addnumbers();
//   }
// }

void addnumbers(){ // 非再帰版
  int x = 0;
  while(scanf("%d", &x) > 0){
    s += x;
    printf("%3d\n", s);
  }
}