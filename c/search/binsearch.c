#include <stdio.h>
int binsearch(int, int[], int); // 二分探索を行う関数

/*
次の式で決まる整数iを返す

i = {
  0  →   x ≤ k[0]の時
  n  →   x > k[n-1]の時
  j  →   j(1≤j≤n-1)に対して、k[j-1] < x ≤ k[j]
}
*/

int main(){
    int x = 9;
    int k[15] = {5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140};

    int n = binsearch(x, k, 15);
    printf("xの位置は %d 番目の要素です\n", n + 1);
    return 0;
}

// xは検索する対象のデータ, kは検索される配列データ, nは配列の長さ
int binsearch(int x, int k[], int n){
    int middle, left, right; // 中間地点を表すmiddle, 左先端と右先端用の変数

    if(x <= k[0]) // 特別処理。対象のxが配列の一番小さいデータより小さい場合
        return 0;
    if(x > k[n - 1]) // 特別処理。対象のxが配列の一番大きなデータより大きい場合
        return n;
    left = 0; right = n - 1; // 開始地点と終了地点の設定。ここから範囲を狭めていく
    while(right - left > 1){ // 開始地点と終了地点の差分が1にまで続ける。1になったら検索が終わったことになる
        middle = (right + left) >> 1; // お互いの長さを足して半分にすることで中間地点を出してる
        if(x <= k[middle]){ // 中間地点より低いか大きいかを判定する
            right = middle; // 中間地点より小さいなら、終了地点を移動
        }else{
            left = middle; // 中間地点より大きいなら、開始地点を移動
        }
    }
    return right;
}
