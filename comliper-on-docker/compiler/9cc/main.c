#include "9cc.h"

int main(int argc, char *argv[]){
  if(argc != 2){
    fprintf(stderr, "引数の個数が正しくありません");
    return 1;
  }

  user_input = argv[1];
  token = tokenize(user_input);
  Node *node = expr();

  printf(".intel_syntax noprefix\n");
  printf(".global main\n");
  printf("main:\n");

  // 構文木を下りながらコード生成
  gen(node);

  // 最終的に計算結果がraxにあるはずなので関数の返り値とする
  printf("  pop rax\n");
  printf("  ret\n");
  return 0;
}
