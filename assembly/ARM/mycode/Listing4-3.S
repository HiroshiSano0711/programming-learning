// Listing4-3.S 
//
// Uninitialized pointer demonstration 
// This program will not run properly. 

#include "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 4-3"
fmtStr:     .asciz      "Pointer value= %p\n"

.data
// .-. : 現在位置-現在位置。GAS特有の書き方。
// 初期化はしないけど8バイトだけ（dword）確保するという意味。
// .dword . と書いたら現在位置のアドレスで初期化の意味になる。
// 「初期化しない」と言っているのは、プログラムから値を使うまで何が入っているか分からない、という意味
// 内部的にはアセンブラやリンカがその領域をどう扱うかで変わる：
//   .bss セクションに置かれる場合 → 実行時に OS が 0 でクリアしてくれることが多い
//   .data セクションや .dword .-. のような書き方 → アセンブル時点で数値を決めない限り、値は未定義で、読み出すとゴミが入る可能性あり
// 現在位置-現在位置=0だから0で初期化されると考えるかもしれないが上記の理由から初期化されないと考えた方が良い。
ptrVar:     .dword      .-.

.text 
.align      2 
.extern     printf 

// Return program title to C++ program: 

.global     getTitle 
getTitle: 
            lea         x0, ttlStr 
            ret 

// Here is the "asmMain" function: 

.global     asmMain 
asmMain: 
            sub         sp, sp, #64     // Stack storage 
            str         lr, [sp, #56]   // Save return address. 

            // 未定義のアドレスから読み込もうとしているのでクラッシュすることになる
            // error segmentation fault
            lea         x0, ptrVar 
            ldr         x1, [x0]        // Get ptrVar into X1. 
            ldr         x2, [x1]        // Will crash the system 

            ldr         lr, [sp, #56]   // Retrieve return adrs. 
            add         sp, sp, #64     // Restore stack. 
            ret

// .data セクションの変数でも、ポインタは有効なアドレスで初期化されないことがある
//    静的初期化を行っても、この例ではポインタには 0（NULL）が入るだけで、有効なメモリアドレスではない
//    ARM 上で「真に未初期化の変数」は存在しないが、実際には「初期値を与えていない変数は、その領域に残っていたビットパターンを持つ」
// ゴミ値の危険性
//    そのゴミ値が無効なアドレスであれば dereference すると セグメンテーションフォルト が起こる
//    逆に、偶然有効なアドレスに一致すると、CPU は何も警告せずアクセスしてしまう
//    その場合、他の変数の値を書き換えるなどの致命的なバグを引き起こす可能性がある
// まとめ：
//    未初期化ポインタを使うと、クラッシュする場合とクラッシュせずにメモリ破壊する場合の両方がある
//    だから常に、ポインタ変数は有効なアドレスで初期化することが安全
