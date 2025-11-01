// Listing4-1.S 
//
// Pointer constant demonstration 

#include "aoaa.inc"

.section  .rodata, ""
ttlStr:   .asciz    "Listing 4-1"
fmtStr:   .ascii    "pb's value is %p\n"
          .asciz    "*pb's value is %d\n"

.data 
bb:       .byte     0 
          .byte     1, 2, 3, 4, 5, 6, 7
pb  =  bb + 2     // Address of "2" in bb 

pbVar:   .dword     pb 

pbValue: .word      0 

.text
.align     2
.extern    printf

// Return program title to C++ program: 

.global    getTitle 
getTitle: 
         lea        x0, ttlStr 
         ret 

// Here is the asmMain function: 

.global     asmMain 
asmMain: 
        // グローバル変数でlrを管理してきたけど、本来はスタックにpush,popで扱うのが良い方法。
        // スタックの学習をしたので、この章からスタックを使った操作方法に書き換えていく
        sub     sp, sp, #64     // スタック領域を確保する。
        str     lr, [sp, #56]   // 64バイト確保した中の一番下位にlrの値を保持する→C++からOSに処理を戻すため

        lea     x0, pbVar       // ラベルの値を読み込み 
        ldr     x0, [x0] 
        ldrb    w0, [x0]        // Fetch data at *pbVar. 
        lea     x1, pbValue     // Save in pbValue for now. 
        str     w0, [x1] 

        // Print the results:
        lea     x0, fmtStr
        vparm2  pbVar 
        vparm3  pbValue
        bl      printf 

        ldr     lr, [sp, #56]   // lrを元に戻す 
        add     sp, sp, #64     // スタックの状態を元に戻す
        ret     // caller(main関数)に処理を戻す
