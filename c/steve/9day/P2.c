#include <stdio.h>

//// 下記の再帰処理を繰り返し処理に書き直す ////
// 関数名をつけるなら「スペースを読み飛ばす」的な処理→skip_space
// 機能名とロジックは異なる
// 意味を書くというのは機能名や意図を書くこと→変数名や関数名とか
// void f() {
//     if (getchar() == ' '){
//         // printf("*\n");
//         f();
//     }
// }
// 繰り返し処理
// void f2() {
//     // 先に処理を抽象化しておけば書き換えも簡単になる。違う書き方もできるようになる
//     while (getchar() == ' ')
//         printf("*\n");
// }
// int main(){
//     f2();
//     return 0;
// }

/* 
下記の再帰処理を繰り返し処理に書き直す
n < 100と考えて良い

パターン1
①行きがけ順
②再帰f()
③帰りがけ順

パターン2
①行きがけ順
②再帰f()
③真ん中
④再帰f()
⑤帰りがけ順

*/
// void g(n) {
//     int i;
//     if (n > 0){
//         scanf("%d", &i);
//         g(n - 1);
//     }
// }

// 繰り返し処理
// void g(n) {
//     int number[100], j;
//     for (j = 0; j < n; j++){
//         scanf("%d", &number[j]);
//     }
//     for(j = n - 1; j >= 0; j--){
//         printf("%d\n", number[j]);
//     }
// }

// int main(){
//     g(3);
//     return 0;
// }

//// 下記の再帰処理を繰り返し処理に書き直す ////
int h(n) {
    return n < 0 ? 0 : n == 0 ? 1 : h(n - 1) + h(n - 2);
}
int h(n) {
    if (n < 0){
        return 0;
    }else if(n == 0){
        return 1;
    }else{
        return h(n - 1) + h(n - 2);
    }
}

// 繰り返し処理
int h(n) {
    int first, second, next_second;
    first = 0;
    second = 1;

    if (n < 0){
        return 0;
    }else if(n == 0){
        return 1;
    }
    for (int i = 1; i <= n; i++){
        next_second = first + second;
        first = second;
        second = next_second;
    }
    return next_second;
}

int main(){
    int a = h(5);
    printf("%d\n", a);
    return 0;
}

// フィボナッチ数列
// h(10): h(9) + h(8)
// h(9): h(8) + h(7)
// h(8): h(7) + h(6) 21 + 13
// h(7): h(6) + h(5) 13 + 8
// h(6): h(5) + h(4) 8 + 5
// h(5): h(4) + h(3) 5 + 3
// h(4): h(3) + h(2) 3 + 2
// h(3): h(2) + h(1) 2 + 1
// h(2): h(1) + h(0) 1 + 1
// h(1): h(0) + h(-1) 1 + 0
// h(0): 1
// h(-1): 0

