#include <stdio.h>

//// 下記の再帰処理を繰り返し処理に書き直す ////
// void f() {
//   if (getchar() == ' '){
//     f();
//   }
// }
// 繰り返し処理
// void f() {
//   while (getchar() != ' ')
//     ;
// }
// int main(){
//   f();
//   return 0;
// }

/* 
下記の再帰処理を繰り返し処理に書き直す
n < 100と考えて良い
*/
// void g(n) {
//     int i;
//     if (n > 0){
//         scanf("%d", &i);
//         g(n - 1);
//         printf("%d\n", i);
//     }
// }

// 繰り返し処理
// void g(n) {
//     int i[100], j;
//     for (j = 0; j < n; j++){
//         scanf("%d", &i[j]);
//     }
//     for(j = n - 1; j >= 0; j--){
//         printf("%d\n", i[j]);
//     }
// }

// int main(){
//     g(10);
//     return 0;
// }

//// 下記の再帰処理を繰り返し処理に書き直す ////
// int h(n) {
//     return n < 0 ? 0 : n == 0 ? 1 : h(n - 1) + h(n - 2);
// }

// 繰り返し処理
int h(n) {
    int first, second, next_second;
    first = 0;
    second = 1;

    for (int i = 0; i < n; i++){
        next_second = first + second;
        first = second;
        second = next_second;
    }
    return next_second;
}

int main(){
    int a = h(10);
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

