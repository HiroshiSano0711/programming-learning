#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// 入力された10進数の数字をどう扱うか？
// 例：整数5432を与えられた場合、最初の5を入力された時点では1000をかければいいとはわからない
// ホーナーの方法を用いると効率よく扱うことが可能
int rdint();

int main(){
  int i;
  i = rdint();
  printf("i = %d\n", i);
  return 0;
}

int rdint(void){
  int i, neg, d; // getchar()の戻り値はunsigned charからintに変換されて渡される
  char ch;

  do {
    ch = getchar();
  } while(isspace(ch)); // 文字が標準空白類文字（空白、スペース、タブなど）かどうかをチェックしてる

  neg = ch == '-'; // '-''は文字コード45 getchar()が文字コードで返すので、文字コードで比較してる

  if(neg || ch == '+'){ // '+''は文字コード43 符号の場合は次の数字を読み込む
    ch = getchar();
  }

  if(!isdigit(ch)){ // 文字数字じゃなかったら処理を終了する
    printf("Invalid number"); exit(1);
  }

  i = ch - '0'; // 数字は文字コードが連番なので、'0'をひけば数値に変換できる
  while(ch = getchar(), isdigit(ch)){ //2文字目以降を読み込む
    d = ch - '0'; // それぞれ数値に変換
    i = 10 * i + d;
  }

  ungetc(ch, stdin); // 入力ストリームに1文字返却
  return neg ? -i : i; // マイナスだったらプラスに変換してreturnする
}
