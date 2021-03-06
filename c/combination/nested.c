#include <stdio.h>
#define LEN 10
// void lookfun(int);
void lookfun();
void action();
int n, r[LEN], lower[LEN], upper[LEN];

int main(){
    int i;
    printf("nの数値を入力してください (ただし %d より大きくない)", LEN);
    scanf("%d", &n);
    printf("ペアを入力してください (lower upper):\n");
    for(i = 0; i < n; i++)
        scanf("%d %d", lower + i, upper + i);
    printf("\n出力: \n\n");
    for(i = 0; i < n; i++)
        printf("  r[%d]", i);
    printf("\n");
    // lookfun(0);
    lookfun();
    return 0;
}

// 多重度がnのループ処理は再帰じゃないと難しい
// 再帰
void lookfun(int k){
    for(int i = 0; i < k; i++)
    if(k == n){
        action();
    } else {
        for(r[k] = lower[k]; r[k] <= upper[k]; r[k]++){
            lookfun(k + 1);
        }
    }
}

void action(){
    int i;
    for(i = 0; i < n; i++)
        printf("%6d", r[i]);
    printf("\n");
}

// 繰り返し処理
void lookfun(){
    int i, n1 = n - 1;
    for(i = 0; i < n; i++) { // 下限の数字をr[0] ~ r[n -1] まで代入する
        if((r[i] = lower[i]) > upper[i]) // 下限が上限より大きかったら不正な入力なので何もせずreturnする。
            return;
    }
    while(1) {
        action(); // まず下限を出力。最初の組み合わせを出力する。
        i = n1; // 配列の最後の要素から処理をする
        while(1) {
            if(r[i] < upper[i]){ // 5 2 8 → 5 2 9まで。最後の要素の下限から上限まで出力する
                r[i]++; break;
            }
            r[i] = lower[i]; // 上限まで出力したら最後の要素の数字を下限に戻す。
            if(--i < 0) // ひとつ前の要素に移る。配列の先頭は r[0]なので、--iの結果がマイナスなら全ての組み合わせが完了したことになる
                return;
        }
    }
}
