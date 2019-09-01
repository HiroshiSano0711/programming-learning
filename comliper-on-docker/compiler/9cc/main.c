/*
参考サイト

低レイヤを知りたい人のためのCコンパイラ作成入門
Rui Ueyama <ruiu@cs.stanford.edu>
https://www.sigbus.info/compilerbook

*/

/*
文法の優先順位（低い順）
  1. == !=
  2. < <= > >=
  3. + -
  4. * /
  5. 単項+ 単項-
  6. ()
*/

#include "9cc.h"

int main(int argc, char **argv){
  if(argc != 2){
    fprintf(stderr, "引数の個数が正しくありません\n");
    return 1;
  }

  user_input = argv[1];
  tokenize();
  program();

  printf(".intel_syntax noprefix\n");
  printf(".global main\n");
  printf("main:\n");

  printf("  push rbp\n");
  printf("  mov rbp, rsp\n");
  printf("  sub rsp, 208\n");

  // 構文木を下りながらコード生成
  for (int i = 0; code[i]; i++){
    gen(code[i]);
    printf("  pop rax\n");    
  }
  
  // 最終的に計算結果がraxにあるはずなので関数の返り値とする
  printf("  mov rsp, rbp\n");
  printf("  pop rbp\n");
  printf("  ret\n");
  return 0;
}
