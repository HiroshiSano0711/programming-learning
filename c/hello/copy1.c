#include <stdio.h>

int main(){
  char *src = "abc\n";
  char dest1[100];
  char dest2[100];
  char *p, *q;
  p = dest1;
  q = src;

  while ('\n' != (*p++ = *q++)){
    printf("%s\n", dest1);
  }
  q = src;
  p = dest2;
  while ('\n' != (*++p = *++q)){
    printf("%s\n", &dest2[1]);
  }
  return 0;
}

// 式文
// 式 = 値をもつ
// 例 1 + 1
// 2という値をもつ

// 文 = 実行の単位
// 例 a = 1 + 1
// aに2を代入する。代入"文"
// C言語では「;」をつけることで文が値を持つようになる＝＞式文

// while ('\n' != (*++p = *++q))
// ↓
// while (1){
//   *p = *q;
//   if(*p == '\n') {
//     break;
//   }
//   p++;
//   q++;
// }

// 仮想メモリ
// セグメンテーションフォルトは自分のプロセスのOS部分の論理アドレスに書き込もうとした場合に起こる
// マッピングテーブル＝＞実メモリの上でOSが持っている
