// Listing9-13.S
//
// 浮動小数点数(double)を文字列へ変換する
//
// 科学記数法と小数の出力フォーマットの両方を提供する
//


#include    "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-13"
fmtStr1:    .asciz      "r64ToStr: value='%s'\n"
fmtStr2:    .asciz      "fpError: code=%lld\n"
fmtStr3:    .asciz      "e64ToStr: value='%s'\n"
newlines:   .asciz      "\n\n"
expStr:     .asciz      "\n\nTesting e64ToStr:\n\n"

// r64str_1: グローバルな文字の配列。変換した文字列を保持する。
// 32バイト以内にすべての変換結果（＋終端文字）を収めるのはプログラムの責任とする

.data
r64str_1:   .space      32, 0

.code
.extern     printf

// tenTo15: 1.0<= value < 2.0の値に乗算することで
// 仮数部の値を整数化するためのスケール定数。
//
// 仮数部を整数化する目的は、以下の理由が考えられる
//
// 例：2進数での「1.12345」は有限桁では表せない
// 10進の 1.12345 は、2進数で表すと：
// 1.000111111001101010...（ずっと続く）
// つまり 循環または無限桁の2進小数。
//
// → だから、IEEE754形式では「近似値」でしか持てない。
//（仮数部が53ビットしかないので、途中で丸められる）
//
// そのまま文字列にすると、1.1234499999999999 みたいな微妙なズレが出てしまう。
//
// ② 整数化すれば「誤差が増えない」範囲で桁取りできる
// 1.12345 × 1e15 → 1123450000000000
//
// こうやって小数点を右にずらして整数化すると、丸めの影響を小さく抑えられるうえに、
//
// 桁を1つずつ取り出す（÷10）処理ができる
//
// 「文字列化処理（printfなど）」が整数処理で済む
//
// つまり、「浮動小数点のまま扱うと誤差や丸めが入る」
// → 「整数に直して扱えば桁が安定する」
//
// また汎用の整数to文字列ルーチンを流用することも可能になる。
//
// IEEE 754 の 倍精度浮動小数点数（double） は最大で 16 桁の有効数字を正確に表せる。
// 仮数部では最大15桁を表せるので10^15乗をかけることで仮数部を整数化できる。

tenTo15:    .double     1.0e+15

// 正の 10 の累乗（1.0e+0〜1.0e+256）。指数を正方向に調整する（大きくする）
potPos:     .double     1.0e+0
            .double     1.0e+1
            .double     1.0e+2
            .double     1.0e+4
            .double     1.0e+8
            .double     1.0e+16
            .double     1.0e+32
            .double     1.0e+64
            .double     1.0e+128
            .double     1.0e+256
expCnt      =           (.-potPos) / 8

// 負の 10 の累乗（1.0e–0〜1.0e–256）。指数を負方向に調整する（小さくする）
potNeg:     .double     1.0e-0
            .double     1.0e-1
            .double     1.0e-2
            .double     1.0e-4
            .double     1.0e-8
            .double     1.0e-16
            .double     1.0e-32
            .double     1.0e-64
            .double     1.0e-128
            .double     1.0e-256

// それぞれに対応する指数の絶対値

expTbl:     .dword      0
            .dword      1
            .dword      2
            .dword      4
            .dword      8
            .dword      16
            .dword      32
            .dword      64
            .dword      128
            .dword      256

// 最大桁数。倍精度の浮動小数点では値は16桁まで表せる。
// 仮数では15桁、暗黙の1bitで1桁で合計最大16桁

maxDigits   =           16

// Return program title to C++ program:

proc    getTitle
    lea     x0, ttlStr
    ret
endp    getTitle


// u53toStr
//
//  Converts a 53-bit unsigned integer to a string containing
//  exactly 16 digits (technically, it does 64-bit arithmetic,
//  but is limited to 53 bits because of the 16-digit output
//  format)
//
// Inputs:
//  X0-     文字列を受けとるバッファーへのポインタ
//  X1-     変換するnsigned 53-bit整数
//
// Outputs:
//  Buffer- Receives the zero-terminated string
//  X0-     Points at zero-terminating byte in string
//
// この関数を呼び出すときは、少なくとも 17バイト分のバッファを確保しておくこと
//   数字16桁 → 16バイト（'0'〜'9' 各1バイト）
//   そのあとに 終端文字（\0） を付ける → +1バイト
//   [0][1][2][3][4][5][6][7][8][9][10][11][12][13][14][15]['\0']
//   合計17バイト必要になる。
// この関数は r64ToStr（double→string変換）の一部として呼ばれる。
// 呼び出し側ではあらかじめ 仮数部を 1.0 ≤ value < 2.0 に正規化して
// 1.0e+15 を掛けて整数化された値が渡される。
// なので、必ず 1*10^15 〜 1.999999999999999*10^15 の範囲。つまり、16桁になることが保証されてる。
// 桁数が足りなくて先頭を0埋めするような処理は必要ない
//

proc    u53toStr
    stp     x1, x2, [sp, #-16]!
    stp     x3, x4, [sp, #-16]!
    str     x5, [sp, #-16]!

    mov     x4, #10     // 10進数にするので10で割っていく
    mov     x5, xzr     // 0で初期化

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'    // 文字コードに変換

    // 左に8bitシフトしてから文字を書き込む
    //  x5 =  [00 00 00 00 00 00 00 10⁰]
    //  x5 =  [00 00 00 00 00 00 10⁰ 10¹]
    //  x5 =  [00 00 00 00 00 10⁰ 10¹ 10²]
    //  ...
    //  x5 =  [10⁰ 10¹ 10² 10³ 10⁴ 10⁵ 10⁶ 10⁷]
    // まで処理する流れ。

    orr     x5, x3, x5, lsl #8

    // The following is an unrolled loop
    // (for speed) that processes the
    // remaining 15 digits.
    //
    // Handle digit 1 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 2 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 3 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 4 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 5 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 6 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 7 here:
    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // 8文字詰めたら一旦書き出す。
    // 1文字が8bit*8文字＝64bitなので、64bitレジスタで詰められる最大の文字数が8文字だから
    // この段階ではx5レジスタには
    //   x5 =  [10⁰ 10¹ 10² 10³ 10⁴ 10⁵ 10⁶ 10⁷]
    // の並びで各バイトが保持されている。
    // ARMはリトルエンディアンなので、下位バイト→下位アドレスへ書き込まれる。
    // strを使ってx0のバッファーに書き込むと
    //   x+8 10⁷
    //   x+9 10⁶
    //   x+10 10⁵
    //   x+11 10⁴
    //   x+12 10³
    //   x+13 10²
    //   x+14 10¹
    //   x+15 10⁰
    // という逆順になり、１バイトずつ読み込んで出力すれば人間が読む順番と同じになる。
    // ここで使っているx0が参照するバッファー変数は、スタック上ではなく静的変数であることに注意。高位→下位の流れではない

    str     x5, [x0, #8]
    mov     x5, xzr

    // Handle digit 8 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 9 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 10 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 11 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 12 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 13 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 14 here:

    udiv    x2, x1, x4      // X2 = quotient
    msub    x3, x2, x4, x1  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Handle digit 15 here:

    udiv    x1, x2, x4      // X1 = quotient
    msub    x3, x1, x4, x2  // X3 = remainder
    orr     x3, x3, #'0'
    orr     x5, x3, x5, lsl #8

    // Store away HO 8 digits:

    str     x5, [x0]
    strb    wzr, [x0, #maxDigits]!  // Zero-terminating byte

    ldr     x5, [sp], #16
    ldp     x3, x4, [sp], #16
    ldp     x1, x2, [sp], #16
    ret
endp    u53toStr


// FPDigits
//
//  Used to convert a floating-point value
//  in D0 to a string of digits
//
// Inputs:
//  D0-     Double-precision value to convert
//  X0-     Pointer to buffer to receive chars
//
// Outputs:
//  X0-     Still points at buffer
//  X1-     Contains exponent of the number
//  X2-     Contains sign (space or '-')

proc    FPDigits
    str     lr,       [sp, #-16]!
    str     d0,       [sp, #-16]!
    stp     d1, d2,   [sp, #-16]!
    stp     x22, x23, [sp, #-16]!
    stp     x24, x25, [sp, #-16]!
    stp     x26, x27, [sp, #-16]!

    mov     x2, #' '        // 符号は+であると仮定する

#define fp1 d2                      // D2 holds 1.0.

    fmov    fp1, #1.0

    // 値がゼロは特殊ケース

    fcmp    d0, #0.0
    bne     d0not0

    // 浮動小数点の場合は、0は-0.0と+0.0の2つがありえる。
    // マイナスの場合は符号の文字列をレジスタにセット

    fmov    x1, d0
    ands    x1, x1, #0x8000000000000000     // 最上位の符号ビットとAND演算。+0.0の場合はフラグがZ=1になる。

    // andsの結果は 0x8000000000000000 か 0x0のどちらか。
    //   Zフラグ = 1 のとき → 結果がゼロ（つまり符号ビット=0）
    //   Z = 0 のとき     → 結果が非ゼロ（符号ビット=1）

    beq     posZero
    mov     x2, #'-'

posZero:
    // 0x30は文字コードの'0'
    // 8バイト（8文字）分のゼロを書き込む。
    // 0x3030303030303030

    mov     x1, #0x3030
    movk    x1, #0x3030, lsl #16
    movk    x1, #0x3030, lsl #32
    movk    x1, #0x3030, lsl #48

    // 16バイト分ゼロを書き込む。値はゼロなので下位バイト、上位バイトに同じ値を2回書き込むだけ。

    str     x1, [x0]
    str     x1, [x0, #8]

    // このプロシージャーは値が1.0<= value < 10.0の間におさまるように正規化する
    // 指数部もスケールによって加減する必要がある
    // ゼロのとき、10^0（=1）スケールのままだから指数には0をセットする

    mov     x1, #0

    // ゼロ終端文字の書き込み。ただしprintfでデバッグするとき用コード。
    // C言語で出力して値を確認するときはゼロ終端文字が必要になるため。
    // 本番ではこのコードは使われない。16文字（Null文字を含まない）を返すことを想定してるから。

    mov     w3, #0
    strb    w3, [x0, #16]

    b.al    fpdDone

    // ここまででゼロだった場合の処理が完了。以下からはゼロでない場合の通常処理

d0not0:
    bge     fpIsPositive    // 正負の判定。

    // If negative, negate and change the sign
    // character to '-'.

    fabs    d0, d0
    mov     x2, #'-'

    // Get the number from 1.0 to <10.0 so you can figure out
    // what the exponent is. Begin by checking to see if you have
    // a positive or negative exponent.

fpIsPositive:
    mov     x1, xzr         // Initialize exponent.
    fcmp    d0, fp1
    bge     posExp

    // The value is in the range 0.0 to 1.0,
    // exclusive, at this point. That means this
    // number has a negative exponent. Multiply
    // the number by an appropriate power of 10
    // until you get it in the range 1 through 10.

    lea     x27, potNeg
    lea     x26, potPos
    lea     x25, expTbl
    mov     x24, #expCnt

// Search through the potNeg table until you find a power
// of 10 that is less than the value in D0:

cmpNegExp:
    subs    x24, x24, #1
    blt     test1       // Branch if X24 < 1.

    ldr     d1, [x27, x24, lsl #3]  // D1 = potNeg[X24 * 8]
    fcmp    d1, d0      // Repeat while
    ble     cmpNegExp   // table <= value.

    // Eliminate the current exponent indexed by
    // X24 by multiplying by the corresponding
    // entry in potPos:

    ldr     x22, [x25, x24, lsl #3] // X22 = expTbl[X24 * 8]
    sub     x1, x1, x22
    ldr     d1, [x26, x24, lsl #3]  // D1 = potPos[X24 * 8]
    fmul    d0, d0, d1
    b.al    cmpNegExp


// If you get to this point, you've indexed through
// all the elements in the potNeg and it's time to stop.
//
// If the remainder is *exactly* 1.0, you can branch
// on to InRange1_10; otherwise, you still have to multiply
// by 10.0 because you've overshot the mark a bit.

test1:
    fcmp    d0, fp1
    beq     inRange1_10

    fmov    d1, #10.0
    fmul    d0, d0, d1
    sub     x1, x1, #1      // Decrement exponent.
    b.al    inRange1_10

// At this point, you have a number that is 1 or greater.
// Once again, your task is to get the value from 1.0 to <10.0.

posExp:
    lea     x26, potPos
    lea     x25, expTbl
    mov     x24, #expCnt

cmpPosExp:
    subs    x24, x24, #1
    blt     inRange1_10     // If X24 < 1

    ldr     d1, [x26, x24, lsl #3]  // D1 = potPos[X24 * 8]
    fcmp    d1, d0
    bgt     cmpPosExp

    ldr     x22, [x25, x24, lsl #3] // X22 = expTbl[X24 * 8]
    add     x1, x1, x22
    fdiv    d0, d0, d1
    b.al    cmpPosExp

// Okay, at this point the number is in the range 1 <= x < 10.
// Let's multiply it by 1e+15 to put the most significant digit
// into the 16th print position, then convert the result to
// a string and store away in memory.

inRange1_10:
    ldr     d1, tenTo15
    fmul    d0, d0, d1
    fcvtau  x22, d0     // Convert to unsigned integer.

    // Convert the integer significand to a
    // string of digits:

    stp     x0, x1, [sp, #-16]!
    mov     x1, x22
    bl      u53toStr
    ldp     x0, x1, [sp], #16

fpdDone:
    ldp     x26, x27,   [sp], #16
    ldp     x24, x25,   [sp], #16
    ldp     x22, x23,   [sp], #16
    ldp     d1, d2,     [sp], #16
    ldr     d0,         [sp], #16
    ldr     lr,         [sp], #16
    ret
endp    FPDigits
