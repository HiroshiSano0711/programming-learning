#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

// 入力された10進数の数字をどう扱うか？
// 例：整数5432を与えられた場合、最初の5を入力された時点では1000をかければいいとはわからない
// ホーナーの方法を用いると効率よく扱うことが可能
int rdint();

int main(){
  int i;
  i = rdint();
  printf("%d", i);
  return 0;
}

int rdint(void){
  int i, i0, k, neg, d; // getchar()の戻り値はunsigned charからintに変換されて渡される
  char number;

  do {
    number = getchar();
  } while(isspace(number)); // 文字が標準空白類文字（空白、スペース、タブなど）かどうかをチェックしてる

  neg = number == '-'; // '-''は文字コード45 getchar()が文字コードで返すので、文字コードで比較してる

  if(neg || number == '+'){ // '+''は文字コード43 符号の場合は次の数字を読み込む
    number = getchar();
  }

  if(!isdigit(number)){ // 文字数字じゃなかったら処理を終了する
    printf("Invalid number"); exit(1);
  }

  i = number - '0'; // 数字は文字コードが連番なので、'0'をひけば数値に変換できる
  while(number = getchar(), isdigit(number)){ //2文字目以降を読み込む
    d = number - '0'; // それぞれ数値に変換
    i0 = i;

    // 整数のオーバーフローテスト
    // i = 10 * i + dを分けて実行する
    for(k = 0; k < 5; k++){
      if(k == 2){
        i += i0;
      }else if(k == 4){
        i += d;
      }else{
        i <<= 1;
      }

      printf("number: %d\n", i);

      if(i < 0){
        printf("Too large number"); exit(1);
      }
    }

    // i = 10 * i + d; // 入力された数字の分だけ10をかけていって、どんどん桁数をあげていく（ホーナーの方法）
  }

  ungetc(number, stdin); // 入力ストリームに1文字返却
  return neg ? -i : i; // マイナスだったらプラスに変換してreturnする
}
