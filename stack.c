#include <sys/resource.h>
#include <stdio.h>

struct rusage usage;
long int usage_memory;
void r(int);

int main(){
  r(1000000);
  return 0;
}

// 10000〜1を出力する
// 再帰版
void r(int n){
  // メモリの使用量を測る
  getrusage(RUSAGE_SELF, &usage);
  usage_memory = usage.ru_maxrss;
  printf("メモリ使用量: %ld KB\n", usage_memory);

  if(n > 0){
    printf("%3d\n", n);
    r(n + 1); // 末尾再帰 コンパイラ最適化を行なっていないだけ
  }
}

// 繰り返し処理版
// void r(int n){
//   while(n > 0){
//     // メモリの使用量を測る
//     getrusage(RUSAGE_SELF, &usage);
//     usage_memory = usage.ru_maxrss;
//     printf("メモリ使用量: %ld KB\n", usage_memory);

//     printf("%3d\n", n);
//     n--;
//   }
// }
