#include <stdio.h>
#include <sys/resource.h>

char line[80];
double result;
int depth;
double *before;
struct rusage usage;
long int usage_memory;

double factorial(double n) {
  depth++;
  // 戻りアドレス4バイト
  // 引数のint4バイト
  // BPの退避で4バイト
  printf("フレーム=%ld\n", before - &n);
  printf("アドレス=%p\n", &n);
  before = &n;
  // メモリの使用量を測る
  getrusage(RUSAGE_SELF, &usage);
  usage_memory = usage.ru_maxrss;
  printf("メモリ使用量: %ld MB\n", usage_memory / 1024);
  printf("深さ=%d\n", depth);
  if (n > 1){
    return n * factorial(n - 1);
  } else {
    depth--;
    return 1.0;
  }
}

int main() {
  int input_n;
  printf("数字を入力してください。");
  fgets(line, sizeof(line), stdin);
  sscanf(line, "%d", &input_n);

  result = factorial(input_n);
  printf("result = %lf\n", result);
  return 0;
}
