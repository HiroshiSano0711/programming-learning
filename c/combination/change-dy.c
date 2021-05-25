#include <stdio.h>
#include <string.h>

// ダイナミックプログラミング。ボトムアップでキャッシュを使い求めていく。
// n * exchange_moneyの計算量で求められるので、トップダウンから全パターンを出して求める手法より速い。

// 両替に使用できるコインの種類数
#define MAX_COIN_TYPE 9

// 両替に使用できる各コイン
int coins[MAX_COIN_TYPE] = { 1, 5, 10, 50, 100, 500, 1000, 5000, 10000 };

// 求めたコイン枚数をキャッシュしておくための配列 0 ≤ s ≤ 99
int store[10000]; 

// 両替に必要な最小のコイン枚数を求める関数F(s)
int change(int exchange_money) {
    int min;        // 両替に必要な最小のコイン数。両替パターンが複数ある場合に最小枚数を選択するため前回の結果を保持する。-1は解なし。
    int remaining;  // 両替する金額から使用するコインの金額を引いた残り。キャッシュからすでに求めた枚数を参照するために使う。
    int coin_count; // その金額を両替するのに必要なコイン数。キャッシュから取得した値を保持して使い回す。
    store[0] = 0;   // F(0) = 0 の定義。 0円は両替に必要なコインが0枚のため。

    // 1円から両替したい金額までボトムアップで求めていくループ
    // i = exchange_money。storeの配列のインデックスが各金額に対応している。
    for (int i = 1; i <= exchange_money; i++) {
        min = -1; // -1は解なし。両替できないことを示す。（例：5円を10円玉で両替しようとするなど）
        for (int j = 0; j < MAX_COIN_TYPE; j++){ // jは各コインのインデックス。各コインで両替できるかどうか探索するループ
            remaining = i - coins[j]; // あまりを求めて、0以上なら両替できる可能性がある。マイナスの場合は両替できない。
            if (remaining >= 0) {
                coin_count = store[remaining]; // キャッシュからすでに枚数を求めた値があるかどうかを調べる。
                if (coin_count >= 0 ) { // -1で初期化しているので、0以上なら解がある。0はF(0)に対応する。
                    if (min == -1) min = coin_count; // 解があったので、minを解なしの値から上書きする。
                    if (coin_count < min) min = coin_count; // 今までのminと比較して最小の方を選択する。
                }
            }
        }
        // minが-1でないということは解がある。minにはすでにi - coins[j]までの金額を両替できる枚数が入っている
        // それに自身（coins[j]）で両替するのでmin + 1枚を現在の金額の部分に入れる。
        if (min != -1) store[i] = min + 1;
    }
    return store[exchange_money]; // 最終的な枚数はstore[exchange_money]の部分に入っている。
}

int main(){
    for (int i = 1; i <= 10000; i++){
        memset(store, -1, sizeof(store)); // -1を解なしとする。全ての要素を-1で初期化する。
        printf("i = %d, result = %d\n", i, change(i));
    }
    return 0;
}
