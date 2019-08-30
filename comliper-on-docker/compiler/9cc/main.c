#include "9cc.h"

int main(int argc, char *argv[]){
  if(argc != 2){
    fprintf(stderr, "引数の個数が正しくありません\n");
    return 1;
  }
  printf("argv = %s\n", argv[1]); // ;が出力される
  user_input = argv[1]; // ここでSegmetation faultが出る
  tokenize();
  program();

  printf(".intel_syntax noprefix\n");
  printf(".global main\n");
  printf("main:\n");

  // 構文木を下りながらコード生成
  gen(*code);

  // 最終的に計算結果がraxにあるはずなので関数の返り値とする
  printf("  pop rax\n");
  printf("  ret\n");
  return 0;
}
