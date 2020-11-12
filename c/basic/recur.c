#include <stdio.h>
void r(int);

int main(){
  r(4);
  return 0;
}

// 再帰（recursion）の省略形
void r(int n){
  if(n > 0){
    r(n - 2); // 再帰呼び出し
    printf("%3d", n); // 引数のnを出力するだけ
    r(n - 1); // 再帰呼び出し
  }
}
