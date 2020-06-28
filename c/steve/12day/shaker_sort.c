#include <stdio.h>

void shaker_sort(int a[], int length){
  /*
    *p, *q 現在どこまで比較を進めたか位置を保存する
    tmp 配列の値を入れ替える用
    *last_changed 各要素のソート完了時点の位置を管理する
    *left 左の開始ポインタ
    *right 左の開始ポインタ
  */
  int tmp, *p, *q;
  int *last_changed = a, *left = a, *right = a + length - 1;

  while(left < right) {
    for (p = left; p < right; p++){
      q = p + 1;

      if(*p > *q){
        tmp = *p;
        *p = *q;
        *q = tmp;
        last_changed = p;
      }
    }
    right = last_changed;

    for (p = right; p > left; p--){
      q = p - 1;

      if(*q > *p){
        tmp = *p;
        *p = *q;
        *q = tmp;
        last_changed = p;
      }
    }
    left = last_changed;
  }
}

int main(){
  int a[] = { 109, 75, 200, 15, 38, 19, 150, 11, 20 };
  shaker_sort(a, 9);

  for(int i = 0; i < 9; i++){
    printf("%d\n", a[i]);
  }

  return 0;
}
