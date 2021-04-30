#include <stdio.h>
#include <stdlib.h>

// 順列
// 表示する最大の組み合わせの要素数10個 （互いに異なる数字を10進数で扱うため。同じ数字は扱わない）
#define LEN 11

int n, r[LEN];
void permut(int);
void action();

int main(){
  int i;
  printf("Enter n (< %d)", LEN);
  scanf("%d", &n);

  if(n >= LEN){
    printf("Too large number\n");
    exit(1);
  }
  // 1~nまで初期値をセットする。例：i=4なら1,2,3,4がセットされる。
  for(i = 1; i <= n; i++)
    r[i] = i;
  printf("\nOutput: \n\n");
  permut(1);
  return 0;
}

void permut(int k){
  // iは入れ替える要素のインデックス、jはr[k]になる要素以外を入れ替えるためのループカウンタ。
  // auxは要素を入れ替えるために一時的に値を保持していく変数
  int i, j, aux;

  // 最後の要素まで処理をできたので、組み合わせの内容を出力する
  if(k == n){
    action(); return;
  }

  // kを基点としてnまで
  for(i = k; i <= n; i++){
    /* ローテーションの処理 */
    aux = r[i]; // kとiを入れ替えるために一時変数にとっておく

    // k以外をローテーションする
    for(j = i; j > k; j--)
      r[j] = r[j - 1];

    r[k] = aux; // kとなる値（iの値だったもの）を先頭に代入
    /* ローテーションの処理終了 */

    // 再帰呼び出しで、（k + 1）クラスを処理する
    /* ローテーションしたのを元に戻す処理開始 */
    for(j = k; j < i; j++)
      r[j] = r[j + 1];

    r[i] = aux;
    /* ローテーションしたのをもとに戻す処理終了 */
  }
}

void action(){
  int i;

  for(i = 1; i <= k; i++)
    printf("%3d", r[i]);
  printf("\n");
}
