// Listing 9-7
//
// Listing9-6のu64toStrを再帰ではなくループで書いたバージョン
//
// 方針：再帰版（各桁を下位→上位に取り出して、帰りがけに書く）をループ／アンローリングで実装して高速化している。
// 最大20桁（64bitの最大桁数）まで固定アンローリングしている。
//
// 主ループ：udiv（商）＋msub（余り = n - q*10）を繰り返し、
//  取り出した各桁（'0'..'9'）を ASCII にしてレジスタ x5/x6/x7 にバイト列としてパックする。
//
// パックの方針：各抽出した桁を「レジスタの下位バイト」に入れ、
//  既存の内容を左に 8 ビットシフトして上位に追いやる（orr x5, x3, x5, lsl #8）
//  → こうして同一レジスタに複数桁を低位→高位へ順に詰めていく。
//
// 書き出し：桁数に応じて複数の allDoneN ラベルへ飛び、
//  詰めたレジスタ群（x5/x6/x7）を適切な幅でメモリへ書き出し（str, strh, strb とポストインクリメント）することで
//  最終的に人間が読む左から右の文字列 を作る。
//
// なぜややこしい？：抽出は「下位桁から」行うため、メモリへ「上位桁から」並べるための工夫（パック／順序調整）が必要。

#include    "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-7"
fmtStr1:    .asciz      "low=%s, "
fmtStr2:    .asciz      "hi=%s\n"


// 処理するデータの定義。桁数の違う数値をそれぞれ適切に扱えるよう汎用的な処理を書いてテストするため

loData:     .dword      0, 1, 10, 100, 1000, 10000, 100000
            .dword      1000000, 10000000, 100000000
            .dword      1000000000, 10000000000, 100000000000
            .dword      1000000000000, 10000000000000
            .dword      100000000000000, 1000000000000000
            .dword      10000000000000000, 100000000000000000
            .dword      1000000000000000000, 10000000000000000000
            .equ        dataCnt, .-loData

hiData:     .dword      9, 9, 99, 999, 9999, 99999, 999999
            .dword      9999999, 99999999, 999999999
            .dword      9999999999, 99999999999, 999999999999
            .dword      9999999999999, 99999999999999
            .dword      999999999999999, 9999999999999999
            .dword      99999999999999999, 999999999999999999
            .dword      9999999999999999999
            .dword      -1


.data
buffer:     .space      256,0


.code
.extern     printf

// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle



// u64toBuf:
//
//  64bitの符号なし整数を文字列へ変換する
//
//  Inputs:
//      X0:     文字列を受け取るバッファーへのポインター
//      X1:     変換するunsigned 64bit整数
//
//  Outputs:
//      Buffer: ゼロ終端文字を受け取る
//      X0:     文字列のゼロ終端文字を指すポインター
//
//  Bufferは少なくともそれを配置するのに21byteなければならない
//  x0~x7のレジスタを保存するのはCaller（呼び出し側）の責任とする
//
// x5: 6桁+ゼロ終端=7桁  下位数桁
// x6: 8桁             次の数桁
// x7: 6桁             最上位の数桁
// x7に一番桁数を小さく割り当てていてx6に大きく割り当てている。
// 15桁以上の数字はなかなか出てこず、だいたいは億〜兆以下。
// 一般的な場合を最適化してできるだけ平均で少ないレジスタの使用数、分岐の数にしようとしている。

proc    u64ToBuf
    // 除数（10）を置く。x4は毎回使う

    mov     x4, #10

    // 取り出した桁を詰めるためのワークレジスタ。最初はゼロクリア。

    mov     x5, xzr
    mov     x6, xzr
    mov     x7, xzr

    // msub: multiply-substract
    // ARMでは商と余りを1つの命令で出すように設計されていない。
    // x86系ではdiv命令で可能だけど、ARMではシンプルさを重要視しているのが設計の方針だった
    // 10^0を処理

    udiv    x2, x1, x4      // x2 = x1 / x4  （商）
    msub    x3, x2, x4, x1  // x3 = x1 - x2*x4 （余り）
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x2, #0          // 商が0だったら10未満の数。一桁の数値ということになるので余りを返すだけ。処理を終了する
    beq     allDone1

    // 10^1を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x1, #0
    beq     allDone2

    // 10^2を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x2, #0
    beq     allDone3

    // 10^3を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x1, #0
    beq     allDone4

    // 10^4を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x2, #0
    beq     allDone5

    // 10^5を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8
    cmp     x1, #0
    beq     allDone6

    // 10^6を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x6, x3, #'0'
    cmp     x2, #0
    beq     allDone7

    // 10^7を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x1, #0
    beq     allDone8

    // 10^8を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x2, #0
    beq     allDone9

    // 10^9を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x1, #0
    beq     allDone10

    // 10^10を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x2, #0
    beq     allDone11

    // 10^11を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x1, #0
    beq     allDone12

    // 10^12を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x2, #0
    beq     allDone13

    // 10^13を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x1, #0
    beq     allDone14


    // 10^14を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x7, x3, #'0'
    orr     x6, x3, x6, lsl #8
    cmp     x2, #0
    beq     allDone15

    // 10^15を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x7, x3, x7, lsl #8
    cmp     x1, #0
    beq     allDone16

    // 10^16を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x7, x3, x7, lsl #8
    cmp     x2, #0
    beq     allDone17

    // 10^17を処理

    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x7, x3, x7, lsl #8
    cmp     x1, #0
    beq     allDone18

    // 10^18を処理

    udiv    x2, x1, x4      // X2=quotient
    msub    x3, x2, x4, x1  // X3=remainder
    orr     x3, x3, #'0'
    orr     x7, x3, x7, lsl #8
    cmp     x2, #0
    beq     allDone19

    // 最大桁数20桁目の処理
    udiv    x1, x2, x4      // X1=quotient
    msub    x3, x1, x4, x2  // X3=remainder
    orr     x3, x3, #'0'
    orr     x7, x3, x7, lsl #8

allDone20:
    str     x7, [x0], #6
    str     x6, [x0], #8
    str     x5, [x0], #7
    ret

allDone1:   strh    w5, [x0], #1
            ret

allDone2:   strh    w5, [x0], #2
            strb    wzr, [x0]
            ret

allDone3:   str     w5, [x0], #3
            ret

allDone4:   str     w5, [x0], #4
            strb    wzr, [x0]
            ret

// 8バイト丸ごと書くと、実際に必要なデータより多く書いてしまう
// ちょうど5桁、6桁にしたいので個別で必要最低限の処理になるようにしている
allDone5:   str     x5, [x0], #4    // 書き込みは8バイトだけどポインターは4バイトだけポストインクリメントしていることに注意。
            lsr     x5, x5, #32     // 上位４バイトを下位にもってくる。

            // まだ書き込んでいない5桁目を処理。
            // ハーフワード（２バイト）単位で書き込んで１バイトだけポインターを進める。ゼロ終端も同時に書き込む常套手段
            strh    w5, [x0], #1
            ret

// allDone5と同じ
allDone6:   str     w5, [x0], #4
            lsr     x5, x5, #32
            strh    w5, [x0], #2
            strb    wzr, [x0]
            ret

// 7桁目からはx5,x6の2つのレジスタを使うので両方の処理が必要になる
allDone7:   strb    w6, [x0], #1
            str     x5, [x0], #7
            ret

allDone8:   strh    w6, [x0], #2
            str     x5, [x0], #7
            ret

allDone9:   str     w6, [x0], #3
            str     x5, [x0], #7
            ret

allDone10:  str     w6, [x0], #4
            str     x5, [x0], #7
            ret

allDone11:  str     x6, [x0], #5
            str     x5, [x0], #7
            ret

allDone12:  str     x6, [x0], #6
            str     x5, [x0], #7
            ret

allDone13:  str     x6, [x0], #7
            str     x5, [x0], #7
            ret

allDone14:  str     x6, [x0], #8
            str     x5, [x0], #7
            ret

// 15桁目からはx5,x6,x7の全てのレジスタを使うので全部処理する
allDone15:  strb    w7, [x0], #1
            str     x6, [x0], #8
            str     x5, [x0], #7
            ret

allDone16:  strh    w7, [x0], #2
            str     x6, [x0], #8
            str     x5, [x0], #7
            ret

allDone17:  str     w7, [x0], #3
            str     x6, [x0], #8
            str     x5, [x0], #7
            ret

allDone18:  str     w7, [x0], #4
            str     x6, [x0], #8
            str     x5, [x0], #7
            ret

allDone19:  str     x7, [x0], #5
            str     x6, [x0], #8
            str     x5, [x0], #7
            ret
endp    u64ToBuf

// u64ToStr
//
//  呼び出し側がレジスタを退避されるルールにした

proc    u64ToStr

    // レジスタの退避

    stp     x0, x1, [sp, #-16]!
    stp     x2, x3, [sp, #-16]!
    stp     x4, x5, [sp, #-16]!
    stp     x6, x7, [sp, #-16]!
    str     lr, [sp, #-16]!

    bl      u64ToBuf

    ldr     lr, [sp], #16

    // レジスタの復元

    ldp     x6, x7, [sp], #16
    ldp     x4, x5, [sp], #16
    ldp     x2, x3, [sp], #16
    ldp     x0, x1, [sp], #16
    ret
endp    u64ToStr

// Here is the "asmMain" function.

proc    asmMain, public
    locals  am
    qword   am.x20_x21
    dword   am.x22
    byte    stk, 64
    endl    am

    enter   am.size

    // Preserve non-volatile registers:

    stp     x20, x21, [fp, #am.x20_x21]
    str     x22, [fp, #am.x22]

    lea     x20, loData
    lea     x21, hiData
    mov     x22, xzr
loop:
    lea     x0, buffer
    ldr     x1, [x20, x22, lsl #3]
    bl      u64ToStr

    lea     x0, fmtStr1
    lea     x1, buffer
    mstr    x1, [sp]
    bl      printf


    lea     x0, buffer
    ldr     x1, [x21, x22, lsl #3]
    bl      u64ToStr

    lea     x0, fmtStr2
    lea     x1, buffer
    mstr    x1, [sp]
    bl      printf

    add     x22, x22, #1
    cmp     x22, #(dataCnt / 8)
    blo     loop

    ldr     x22, [fp, #am.x22]
    ldp     x20, x21, [fp, #am.x20_x21]

    leave
endp    asmMain
