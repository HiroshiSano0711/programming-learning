#include <stdio.h>

int main() {
  int hoge = 5;
  int *hoge_p;

  printf("&hogeのアドレス %p\n", &hoge); // hoge変数のアドレス
  printf("hoge_pポインタの値 %p\n", hoge_p); // hoge_p変数の値
  printf("hoge_pの値（初期値） %d\n", *hoge_p); // hoge_p変数の値
  printf("hoge_pのアドレス %p\n", &hoge_p); // hoge_p変数の値

  hoge_p = &hoge;
  printf("&hoge_p = %p\n", hoge_p); // hogeのアドレスを代入したhoge_pのアドレス
  printf("hoge_p = %d\n", *hoge_p); // hoge_p変数の値
  printf("hoge_pのアドレス %p\n", &hoge_p); // hoge_p変数の値

  *hoge_p = 10;
  printf("hoge = %d\n", hoge); // hoge_pを経由してhogeに代入したあとのhoge変数の値
  return 0;
}

// ポインタ