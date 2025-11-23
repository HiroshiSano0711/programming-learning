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
DBGfmt:     .asciz  "DBG: x0=%p  x2=%p  decDigits=%llu  exponent=%llu\n"


// r64str_1: グローバルな文字の配列。変換した文字列を保持する。
// 32バイト以内にすべての変換結果（＋終端文字）を収めるのはプログラムの責任とする

.data
r64str_1:   .space      32, 0

.code
.extern     printf

// tenTo15: 1.0 <= value < 2.0 の値に乗算することで
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
// 整数化すれば「誤差が増えない」範囲で桁取りできる
// 1.12345 × 1e15 → 1123450000000000
//
// こうやって小数点を右にずらして整数化すると、丸めの影響を小さく抑えられるうえに、
//
// 桁を1つずつ取り出す（÷10）アルゴリズムが使える
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
// 指数の部分が2^nで階段上になっている。
// このテーブルは順番に線形での比較を行っていくが、データが2^nになっているので
// 擬似的な二分探索のように機能する。対数的時間O(log2 n)で検索が可能
// だいたいどの指数の範囲かどうかを判定するために使用する

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
// 指数部の調整で直接計算する用に定義

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


// C++のタイトル出力用のプログラム

proc    getTitle
    lea     x0, ttlStr
    ret
endp    getTitle


// u53toStr
//
//  53bitのunsigned integerを16桁(固定幅)の数値の文字列に変換する。
//
// Inputs:
//  X0-     文字列を受けとるバッファーへのポインタ
//  X1-     変換するnsigned 53-bit整数
//
// Outputs:
//  X0-     ゼロ終端文字を指すポインタ
//
// この関数を呼び出すときは、少なくとも 17バイト分のバッファを確保しておくこと
//   数字16桁 → 16バイト（'0'〜'9' 各1バイト）
//   そのあとに 終端文字（\0） を付ける → +1バイト
//   [0][1][2][3][4][5][6][7][8][9][10][11][12][13][14][15]['\0']
//   合計17バイト必要になる。
//
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

    // 各ビットの繰り返し処理をループアンローリングで高速化
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
//  D0レジスタ内の浮動小数点数の値を数値の文字列に変換する
//
// Inputs:
//  D0-     変換する倍精度の値
//  X0-     文字を受け取るバッファーへのポインタ
//
// Outputs:
//  X0-     バッファーへのポインタ
//  X1-     指数の値
//  X2-     符合文字

proc    FPDigits
    str     lr,       [sp, #-16]!
    str     d0,       [sp, #-16]!
    stp     d1, d2,   [sp, #-16]!
    stp     x22, x23, [sp, #-16]!
    stp     x24, x25, [sp, #-16]!
    stp     x26, x27, [sp, #-16]!

    mov     x2, #' '        // 符号は+であると仮定する

    #define fp1 d2          // D2 holds 1.0.

    fmov    fp1, #1.0


    // 値がゼロは特殊ケース
    // ゼロでない場合はジャンプ、ゼロの場合はそのまま特殊処理

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
    // 正負の判定。0以上ならジャンプ

    bge     fpIsPositive


    // 負の数は符合反転させてマイナスの符合をバッファに書き込む

    fabs    d0, d0
    mov     x2, #'-'

fpIsPositive:
    // 仮数部が 1.0 <= x < 10.0 におさまるように指数部を調整していく

    mov     x1, xzr         // 指数の初期値はゼロに設定

    // d0 >= 1.0 なら posExp にジャンプするという処理
    // fp1には1.0が設定されている。→ fmov    fp1, #1.0 の部分
    // d0 を 1.0 <= x < 10.0 の範囲に正規化するための"方向"を決めている
    //   d0 < 1.0 → 負の指数 → 10 をかけて大きくする方向へ
    //   d0 ≥ 1.0 → 正の指数 → 10 で割って小さくする方向へ

    fcmp    d0, fp1
    bge     posExp


    // potNeg：負の指数用の 10^n テーブル
    // potPos：正の指数用の 10^-n テーブル
    // expTbl：指数の段階的な増減値
    // expCnt：テーブルのサイズ
    // これらを読み込んで指数補正ループに入る準備。

    lea     x27, potNeg
    lea     x26, potPos
    lea     x25, expTbl
    mov     x24, #expCnt

cmpNegExp:
    // おおまかにどの指数の範囲にある値なのかを絞り込む。

    subs    x24, x24, #1
    blt     test1       // Branch if X24 < 1.

    ldr     d1, [x27, x24, lsl #3]  // D1 = potNeg[X24 * 8]
    fcmp    d1, d0      // table - value
    ble     cmpNegExp   // table <= valueなら繰り返す


    // 指数の範囲を絞り込めたので、おおまかに正規化する
    // テーブルの指数が2^n乗の階段になっているので対数時間的に検索できる

    ldr     x22, [x25, x24, lsl #3] // X22 = expTbl[X24 * 8]
    sub     x1, x1, x22             // 負の指数なので減算
    ldr     d1, [x26, x24, lsl #3]  // D1 = potPos[X24 * 8]
    fmul    d0, d0, d1              // d1(10^n)を乗算しておおまかに正規化
    b.al    cmpNegExp

    // このループを抜けた直後の d0 は 「0.1 ≤ d0 < 1.0」程度の範囲に収まることが保証される
    // なので10をかけることで1.0 <= d0 < 10.0の範囲になり、正規化が完了する
test1:
    // ちょうど1.0の場合は正規化済みなので追加の処理は不要になる

    fcmp    d0, fp1
    beq     inRange1_10

    // 10をかけて正規化を完了させる
    fmov    d1, #10.0
    fmul    d0, d0, d1
    sub     x1, x1, #1      // 10をかけたので指数は1減らさないとダメ
    b.al    inRange1_10

posExp:
    // 正の指数の場合なので、potNeg は使わず potPos テーブルだけを利用すれば良い。

    lea     x26, potPos
    lea     x25, expTbl
    mov     x24, #expCnt

cmpPosExp:
    // sub が add に、mul が div に逆になっているだけで、処理内容は負の指数ループ(cmpNegExp)と同じ
    // コードの解説は省略。cmpNegExpのコードが理解できていればすぐにわかる

    subs    x24, x24, #1
    blt     inRange1_10     // If X24 < 1

    ldr     d1, [x26, x24, lsl #3]  // D1 = potPos[X24 * 8]
    fcmp    d1, d0
    bgt     cmpPosExp

    ldr     x22, [x25, x24, lsl #3] // X22 = expTbl[X24 * 8]
    add     x1, x1, x22
    fdiv    d0, d0, d1
    b.al    cmpPosExp

inRange1_10:
    // 値が1 <= x < 10 の範囲になったので15乗して整数化（unsigned integer）する
    // 仮数部を整数化して丸め誤差を抑える
    // これで 16 桁の整数が得られる（IEEE 754 doubleの精度内）

    ldr     d1, tenTo15
    fmul    d0, d0, d1
    fcvtau  x22, d0     // unsigned integerに変換

    // 整数化した仮数部を数字の文字列に変換する

    stp     x0, x1, [sp, #-16]!
    mov     x1, x22
    bl      u53toStr
    ldp     x0, x1, [sp], #16

fpdDone:
    // 処理が終わったのでスタックを復元してret

    ldp     x26, x27,   [sp], #16
    ldp     x24, x25,   [sp], #16
    ldp     x22, x23,   [sp], #16
    ldp     d1, d2,     [sp], #16
    ldr     d0,         [sp], #16
    ldr     lr,         [sp], #16
    ret
endp    FPDigits


// chkNaNINF
//
// r64ToStr関数とe64ToStr関数に使われるNaNとINFをチェックするユーティリティ関数
//
// Inputs:
//  D0:     NaNとINFをチェックする数値
//  X19:    出力するフィールドの幅
//  X21:    埋める文字
//  X22:    出力するバッファーへのポインター(outBuf)
//  X25:    数値が不正だったときに使うためのReturn address
//
// Outputs:
//  Buffer: 数値が不正だったときにNaN, INFまたは-INFをセットする
//
//  Note: Modifies value in X0.

proc    chkNaNINF

    // IEEE 754に沿った判定処理。
    //  指数部のビットが全て１→±INFかNaN
    //  指数部のビットが全て１、仮数部のビットが全て0                  →±INF
    //  指数部のビットが全て１、仮数部のビットが全て0、符合ビットが0       →+INF
    //  指数部のビットが全て１、仮数部のビットが全て0、符合ビットが1       →-INF
    //  指数部のビットが全て１、仮数部が0でない（符合ビットは無視してよい）  →NaN

    fmov    x0, d0
    lsr     x0, x0, #52     // d0 の bit[63:52]（符号 + 指数部）を右に寄せる処理。
    and     x0, x0, #0x7ff  // 指数部だけ抽出
    cmp     x0, #0x7ff      // 指数部が全部1でないかどうかをチェック
    blo     notINFNaN       // 全部１でないならINFでもNaNでもないので通常処理でOK

    // 指数部がすべて1 → NaN か INF のどちらか確定
    fmov    x0, d0
    ands    x0, x0, #0x000fffffffffffff     // 仮数部だけ抽出。抽出結果が 0 かどうかで Z フラグをセット
    beq     isINF                           // 仮数部が0の場合は±INFが確定。Z = 1（抽出結果 = 0） → ±INF

    // ±INFでないならNaNで確定。
    //
    // 'N'         → 0x4E
    // ('a' << 8)  → 0x61 << 8  = 0x6100
    // ('N' << 16) → 0x4E << 16 = 0x4E0000
    // → 0x004E614E

    ldr     w0, ='N' + ('a' << 8) + ('N' << 16)
    str     w0, [x22]                               // バッファに "NaN" 書き込む
    mov     x0, #3                                  // 現在の文字数 = 3

    // fillSpecial で残りをスペースで埋めるのでヌル終端は不要（固定幅出力だから）。
    b.al    fillSpecial                             // パディング処理へ

isINF:
    fmov    x0, d0
    ands    x0, x0, #0x8000000000000000 // 符号ビットの判定。符号ビットが1なら-INF
    bne     minusINF

    ldr     w0, ='I' + ('N' << 8) + ('F' << 16)
    str     w0, [x22]
    mov     x0, #3
    b.al    fillSpecial

minusINF:
    ldr     w0, ='-' + ('I' << 8) + ('N' << 16) + ('F' << 24)
    str     w0, [x22]

    // 実用上は固定幅出力なのでヌル文字は不要だけど、念のため入れてあるだけだと思われる。
    strb    wzr, [x22, #4]
    mov     x0, #4

// 状況に応じて適切に残りの文字を埋める

fillSpecial:
    mov     w1, #' '
    b.al    whlLTwidth

fsLoop:
    strb    w1, [x22, x0]
    add     x0, x0, #1
whlLTwidth:
    cmp     x0, x19
    blo     fsLoop

    // NaN/INF の場合は「通常の戻り先」ではなく、特別処理が終わった地点にジャンプして戻る
    mov     lr, x25

notINFNaN:  ret

endp    chkNaNINF


//***********************************************************
//
// r64ToStr
//
// REAL64（倍精度浮動小数点）値を文字列に変換する。
// 出力は常に **10進数表記（通常表記）** を用いる。
// 科学技術表記（指数表記）が必要な場合は e10ToBuf を使用すること。
//
// 【入力レジスタ】
//
//  D0:         (r64) 変換する REAL64 値
//
//  X0:         (outBuf) 出力先の文字列バッファ
//
//  X1:         (fWidth) 表示幅（※最小幅ではなく “固定の表示幅”）
//
//  X2:         (decDigits) 小数点以下に表示する桁数
//
//  X3:         (fill) 幅に満たない場合のパディング文字
//
//  X4:         (maxLength) outBuf の最大文字列長
//
//
// 【出力】
//
// outBuf にフォーマット済みの文字列が書き込まれる。
// 指定幅に収まらない場合、エラー表示としてバッファ全体が
// '#' で埋められる（幅内に入らないという意味）。
//
// 【ステータス（Carryフラグ）】
//
//   Carry = 0 : 正常終了
//   Carry = 1 : 例外発生
//      - 表示幅が maxLength を超えた場合などは Carry がセットされる
//
//***********************************************************

proc    r64ToStr

    // ローカル変数を宣言するマクロ（aoaa.inc）

    locals  rts
        qword   rts.x0x1
        qword   rts.x2x3
        qword   rts.x4x5
        qword   rts.x19x20
        qword   rts.x21x22
        qword   rts.x23x24

        dword   rts.x25
        byte    rts.digits, 80
        byte    rts.stk, 64
    endl    rts
    enter   rts.size


    // 可読性をあげるため、non-volatileレジスタに意味のある名前を使う
    // レジスタはローカル／パラメータの値を保持する

    #define fpVal d0
    #define fWidth x19      // chkNaNINF関数で必要
    #define decDigits x20
    #define fill w21        // chkNaNINF関数で必要
    #define outBuf x22      // chkNaNINF関数で必要
    #define maxLength x23
    #define exponent x24
    #define sign w25
    #define failAdrs x25    // chkNaNINF関数で必要


    // レジスタの値をスタックへ退避

    stp     x0,   x1, [fp, #rts.x0x1]
    stp     x2,   x3, [fp, #rts.x2x3]
    stp     x4,   x5, [fp, #rts.x4x5]
    stp     x19, x20, [fp, #rts.x19x20]
    stp     x21, x22, [fp, #rts.x21x22]
    stp     x23, x24, [fp, #rts.x23x24]
    str     x25,      [fp, #rts.x25]

    mov     outBuf, x0
    mov     fWidth, x1
    mov     decDigits, x2
    mov     fill, w3
    mov     maxLength, x4


    // fWidth > maxLength なら、バッファに入りきらないのでエラーを返す
    //  呼び出し元のミス
    //  バッファサイズ計算ミス
    //  フォーマット指定が間違っている
    // などを検出し、安全に落とす

    cmp     fWidth, maxLength
    bhs     strOverflow


    // 長さが0の数値文字列は存在しないので明確にエラーとする

    cmp     fWidth, #0
    beq     valOutOfRange


    // r64ToStr関数が自身でこの2つのチェックをすべき理由
    //  安全性の確保（バッファオーバーラン防止）
    //  呼び出し側が正確にチェックしている保証がない
    //  関数単体の堅牢性を保つため
    //  他の人が使う可能性のあるライブラリコードであるため
    //  API としての契約（contract）を守るため
    // などが考えられる。
    // この関数が「自分の仕事の範囲内で可能なあらゆるチェックを行う」のは正しい設計
    // よって、呼び出し元でわかる情報ではあるが、この関数に責任を持たせている


    // NaN/INF の場合は精度計算・丸め・指数処理など一切スキップ
    // 専用文字列（"NaN" "INF" "-INF"）を書き込み、必要なら fill 文字でパディング
    // 最後に failAdrs（clcAndRet）にもどる → 正常扱い

    lea     failAdrs, clcAndRet
    bl      chkNaNINF


    // ここまでで例外処理は終わったので変換処理に入る
    // 仮数部の数値処理から始める

    add     x0, fp, #rts.digits // lea x0, rts.digitsと同じ。fp → フレームポインタ
    bl      FPDigits            // 文字列に変換
    mov     exponent, x1        // FPDigits関数の返り値 x1 → 指数
    mov     sign, w2            // FPDigits関数の返り値 w2 → 符合をしめすchar


    // maxDigitsは16。16桁まで表示可能
    // ここでexponentは10^n乗を表すので、16より大きいと17桁以上になるので扱わないことにする

    cmp     exponent, #maxDigits
    ble     dontForceWidthZero     // exponent <= maxDigits


    // 有効桁数を超える場合は、丸め開始位置を0（先頭）に設定する。
    // そうすることで、後続の丸め処理やフォールバック処理で「どこから丸めればいいか」という基準がはっきりする。

    mov     x0, xzr

dontForceWidthZero:
    // decDigitsはprintfでいう"%5f"の"5"のようなフォーマットで表示する桁数を指定する値
    // 有効桁数以上の値は丸めないという仕様

    add     x2, x0, decDigits // 丸め開始位置からindexを計算する
    cmp     x2, #maxDigits
    bhs     dontRound         // x2 >= maxDigits ならジャンプ


    // ***************************************************************
    // ※注意：おそらく書籍の間違いだと思われる。これ以降dontRoundまでは実際に実行されることはない
    //
    // ここから下のコードは四捨五入を処理する例。
    //
    // 上記のコードでx2がアドレスになってることに注意。
    //  add     x2, x0, decDigits
    //  x0がバッファーへのポインタなので、ポインタ演算になっている
    //  よって
    //  cmp     x2, #maxDigits
    //  bhs     dontRound
    // の処理は必ずtrueになる。
    // アドレスを整数値としてみなして計算されるが、アドレス >= 数値に必ずなるから
    //
    // また、この後に出てくる[x1, x2]はおかしい。x1は指数を示す整数値なのでアドレスではない
    //  w1, [x0, x2]
    // の間違いの可能性。
    // 書籍では丸め処理を行うと説明がある適切に動作することが想定されていそう。
    // なので、教育用で使われる書籍だから、教授が
    //  「ここは実際には通らないけど、流れとしてはこうなる」
    // と説明しているようなパターンではないと考えられる。
    // 単純に著者の勘違い、ソースコードの間違いの可能性が高い
    // ちゃんと動作するように修正するのはちょっと大変なのでコード読み終わった後に余裕があれば

    // 値を指定された有効桁数に丸めるために、まず「丸め対象となる最後の桁の **次の桁**」へ移動する
    // （この時点で X2 には小数点以下の桁数が入っている）。
    // その桁の値に 5 を加えて四捨五入を行う。
    // もし桁が繰り上がる場合は、繰り上がりが収まるまで前の桁にキャリーを伝播させる。

    add     x2, x2, #1          // 丸め開始位置の次の数字を指すように
    ldrb    w1, [x0, x2]        // その値を読み込む

    add     w1, w1, #5          // 5を足して四捨五入の準備
    cmp     w1, #'9'            // 9より大きいなら繰り上げ
    bls     dontRound           // w0 <= #'9'


    // この桁は繰り上げが必要なので、いったん 0 にリセットしないといけない
    // その準備として '0' + 10 のような特別フラグ値を入れている
    // フラグだけ設定しておいて、実際の繰り上げ処理はこの後の繰り返し処理で行う
    // 繰り返し処理の初期化の値でもある

    mov     x1, #('0' + 10)
whileDigitGT9:
    // 四捨五入するので'0'に戻す
    sub     w1, w1, #10

    // '0'を書き込む
    strb    w1, [x0, x2]


    // indexを-1して1つ前の桁へ。
    // x2が負の値になったら最上位桁も繰り上がったことになるので特殊処理へ移る

    subs    x2, x2, #1
    bmi     hitFirstDigit

    // 前の桁を読み込む
    ldrb    w1, [x0, x2]

    // 1足して、その値を書き込む
    add     w1, w1, #1
    strb    w1, [x0, x2]

    // 1足した結果が9より大きいならさらに繰り上がりが発生したので、この処理を繰り返す
    cmp     w1, #'9'
    bhi     whileDigitGT9       // if w0 > '9'
    b.al    dontRound

hitFirstDigit:
    // 最上位桁が繰り上がってるので、各数字をひとつ後ろの位置にずらし先頭に1を追加する処理を行う
    // 例：999+1=000になってるので、先頭に1を書き込んで後ろの文字列をずらし1000にしないといけない

    // 最後尾から後ろにずらすので最大値のインデックスから始める
    mov     x2, #maxDigits

repeatUntilX2eq0:
    ldrb    w1, [x0, x2]        // 現在の値を読み込む
    add     x2, x2, #1          // インデックスを1つ後ろにずらす
    strb    w1, [x0, x2]        // 1つ後ろの位置に書き込む
    subs    x2, x2, #2          // 1つ進んでるので2つ戻すことで現在の値の1つ前の値を指す
    bne     repeatUntilX2eq0    // インデックスが0になるまで続ける

    ldrb    w1, [x0, x2]
    strb    w1, [x0, x2, #1]

    mov     w1, #'1'            // 先頭に書くための'1'を用意
    strb    w1, [x0, x2]        // indexは0を指してるので先頭にそのまま書き込み

    // 最上位桁が繰り上がったので桁がひとつ増える。そのため指数部の値を1増やす必要がある
    add     exponent, exponent, #1

dontRound:

    // 指数が正と負かで処理を切り分ける

    mov     x5, xzr             // 出力バッファへのインデックスの初期化
    cmp     exponent, #0
    bge     positiveExponent    // exponent >= 0

    // 負の指数の処理
    // 0 ～ 1.0 の値をここで処理する（負の指数は10の負の累乗を意味する）
    //
    // 数値の幅（表示桁数）を計算する。
    // この値は 0 ～ 1 の範囲なので計算は簡単で、指定された小数点以下の桁数に 3 を足すだけでよい。
    // 3の意味は、先頭の "-0." の3文字を表示するためのスペースを確保するということ
    // x2は "." の後に出力する数字の桁数を示す

    mov     x4, #4
    add     x2, decDigits, #3
    cmp     x2, x4
    csel    x2, x2, x4, hs      // If x2 < x4, x2 = x4

    cmp     x2, fWidth
    bhi     widthTooBig

    // This number will fit in the specified field
    // width, so output any necessary leading pad
    // characters. X3=number of padding characters
    // to output.

    sub     x3, fWidth, x2
    b.al    testWhileX3ltWidth


whileX3ltWidth:
    strb    fill, [outBuf, x5]
    add     x5, x5, #1          // Index
    add     x2, x2, #1          // Digits processed
testWhileX3ltWidth:
    cmp     x2, fWidth
    blo     whileX3ltWidth

    // Output " 0." or "-0.", depending on
    // the sign of the number.

    strb    sign, [outBuf, x5]
    add     x5, x5, #1
    mov     w0, #'0'
    strb    w0, [outBuf, x5]
    add     x5, x5, #1
    mov     w0, #'.'
    strb    w0, [outBuf, x5]
    add     x5, x5, #1
    add     x3, x3, #3

    // Now output the digits after the decimal point:

    mov     x2, xzr             // Count the digits here
    add     x1, fp, #rts.digits // lea x1, rts.digits

    // If the exponent is currently negative, or if
    // we've output more than 16 significant digits,
    // just output a zero character.

repeatUntilX3geWidth:
    mov     x0, #'0'
    adds    exponent, exponent, #1
    bmi     noMoreOutput

    cmp     x2, #maxDigits
    bge     noMoreOutput

    ldrb    w0, [x1]
    add     x1, x1, #1

noMoreOutput:
    strb    w0, [outBuf, x5]
    add     x5, x5, #1          // Index
    add     x2, x2, #1          // Digits processed
    add     x3, x3, #1          // Digit count
    cmp     x3, fWidth
    blo     repeatUntilX3geWidth
    b.al    r64BufDone

widthTooBig:
    // 数値が特定のfield幅に合わないなら、"#"の文字で埋めてエラーを示すように返す

    mov     x2, fWidth
    mov     w0, #'#'
fillPound:
    strb    w0, [outBuf, x5]
    add     x5, x5, #1          // Index
    subs    x2, x2, #1
    bne     fillPound
    b.al    r64BufDone


// Handle numbers with a positive exponent here.
//
// Compute # of print positions consumed by output string.
// This is given by:
//
//                   Exponent     // # of digits to left of "."
//           +       2            // Sign + 1's digit
//           +       decDigits    // Add in digits right of "."
//           +       1            // If there is a decimal point

positiveExponent:

    mov     x3, exponent    // Digits to left of "."
    add     x3, x3, #2      // sign posn.
    cmp     decDigits, #0   // See if any fractional
    beq     decPtsIs0       // part

    add     x3, x3, decDigits // Digits to right of "."
    add     x3, x3, #1         // Make room for the "."

decPtsIs0:

    // Make sure the result will fit in the
    // specified field width.

    cmp     x3, fWidth
    bhi     widthTooBig
    beq     noFillChars

    // If the actual number of print positions
    // is less than the specified field width,
    // output leading pad characters here.

    subs    x2, fWidth, x3
    beq     noFillChars


fillChars:
    strb    fill, [outBuf, x5]
    add     x5, x5, #1
    subs    x2, x2, #1
    bne     fillChars

noFillChars:

    // Output the sign character.

    strb    sign, [outBuf, x5]
    add     x5, x5, #1

    // Okay, output the digits for the number here.

    mov     x2, xzr             // Counts  # of output chars.
    add     x1, fp, #rts.digits // lea x1, rts.digits


    // Calculate the number of digits to output
    // before and after the decimal point.


    add     x3, decDigits, exponent
    add     x3, x3, #1          // Always one digit before "."


// If we've output fewer than 16 digits, go ahead
// and output the next digit.  Beyond 16 digits,
// output zeros.

repeatUntilX3eq0:

    mov     w0, #'0'
    cmp     x2, #maxDigits
    bhs     putChar

    ldrb    w0, [x1]
    add     x1, x1, #1

putChar:    strb    w0, [outBuf, x5]
    add     x5, x5, #1

    // If the exponent decrements down to zero,
    // then output a decimal point.

    cmp     exponent, #0
    bne     noDecimalPt

    cmp     decDigits, #0
    beq     noDecimalPt

    mov     w0, #'.'
    strb    w0, [outBuf, x5]
    add     x5, x5, #1

noDecimalPt:
    sub     exponent, exponent, #1  // Count down to "." output
    add     x2, x2, #1    // # of digits thus far
    subs    x3, x3, #1    // Total # of digits to output
    bne     repeatUntilX3eq0


// Zero-terminate string and leave:

r64BufDone:
    strb    wzr, [outBuf, x5]
clcAndRet:
    msr     nzcv, xzr    //clc = No error
    b.al    popRet

strOverflow:
    mov     x0, #-3 //String overflow
    b.al    ErrorExit

valOutOfRange:
    mov     x0, #-1 //Range error
ErrorExit:
    mrs     x1, nzcv
    orr     x1, x1, #(1 << 29)
    msr     nzcv, x1        // stc=error
    strb    wzr, [outBuf]   // Just to be safe.

    // Change X0 on return:

    str     x0, [fp, #rts.x0x1]

popRet:
    ldp     x0, x1, [fp, #rts.x0x1]
    ldp     x2, x3, [fp, #rts.x2x3]
    ldp     x4, x5, [fp, #rts.x4x5]
    ldp     x19, x20, [fp, #rts.x19x20]
    ldp     x21, x22, [fp, #rts.x21x22]
    ldp     x23, x24, [fp, #rts.x23x24]
    ldr     x25,      [fp, #rts.x25]
    leave
endp    r64ToStr



//*************************************************************
//
// expToBuf
//
// Unsigned integer to buffer.
// Used to output up to 3-digit exponents.
//
// Inputs:
//
//  X0:   Unsigned integer to convert
//  X1:   Exponent print width 1-3
//  X2:   Points at buffer (must have at least four bytes).
//
// Outputs:
//
//  Buffer contains the string representing the converted
//  exponent.
//
//  Carry is clear on success, set on error.

            proc    expToBuf
            stp     x0, lr, [sp, #-16]!
            stp     x1, x3, [sp, #-16]!
            stp     x4, x5, [sp, #-16]!

            mov     x5, xzr     // Initialize output string
            mov     x4, #10     // For division by 10

// Verify exponent digit count is in the range 1-3:

            cmp     x1, #1
            blo     badExp
            cmp     x1, #3
            bhi     badExp

// Verify the actual exponent will fit in the number of digits:

            cmp     x1, #2
            blo     oneDigit
            beq     twoDigits

            // Must be 3:

            cmp     x0, #1000
            bhs     badExp

// Convert 3-digit value to a string:

            udiv    x1, x0, x4      // X1=quotient
            msub    x3, x1, x4, x0  // X3=remainder
            orr     x3, x3, #'0'
            orr     x5, x3, x5, lsl #8

            udiv    x0, x1, x4      // X0=quotient
            msub    x3, x0, x4, x1  // X3=remainder
            orr     x3, x3, #'0'
            orr     x5, x3, x5, lsl #8

            udiv    x1, x0, x4      // X1=quotient
            msub    x3, x1, x4, x0  // X3=remainder
            orr     x3, x3, #'0'
            orr     x5, x3, x5, lsl #8

            b.al    outputExp

// Single digit is easy:

oneDigit:
            cmp     x0, #10
            bhs     badExp

            orr     x5, x0, #'0'
            b.al    outputExp

// Convert value in the range 10-99 to a string
// containing two characters:

twoDigits:
            cmp     x0, #100
            bhs     badExp

            udiv    x1, x0, x4      // X1=quotient
            msub    x3, x1, x4, x0  // X3=remainder
            orr     x3, x3, #'0'
            orr     x5, x3, x5, lsl #8

            udiv    x0, x1, x4      // X0=quotient
            msub    x3, x0, x4, x1  // X3=remainder
            orr     x3, x3, #'0'
            orr     x5, x3, x5, lsl #8


// Store the string into the buffer (includes a zero
// byte in the HO positions of W5):

outputExp:
            str     w5, [x2]
            ldp     x4, x5, [sp], #16
            ldp     x1, x3, [sp], #16
            ldp     x0, lr, [sp], #16
            msr     nzcv, xzr    //clc = No error
            ret
            leave

badExp:
            ldp     x4, x5, [sp], #16
            ldp     x1, x3, [sp], #16
            ldp     x0, lr, [sp], #16
            mrs     x0, nzcv
            orr     x0, x0, #(1 << 29)
            msr     nzcv, x0        // stc=error
            mov     x0, #-1      // Value out of range
            ret
            endp    expToBuf



//***********************************************************
//
// e64ToStr
//
// Converts a REAL64 floating-point number to the
// corresponding string of digits.  Note that this
// function always emits the string using scientific
// notation, use the r64ToStr routine for decimal notation.
//
// On Entry:
//
//  D0:     (e64) Double-precision value to convert.
//
//  X0:     (buffer) e64ToStr stores the resulting characters in
//          this buffer.
//
//  X1:     (width) Field width for the number (note that this
//          is an *exact* field width, not a minimum
//          field width).
//
//  X2:     (fill) Padding character if the number is smaller
//          than the specified field width.
//
//  X3:     (expDigs) Number of exponent digits (2 for real32
//          and 3 for real64).
//
//  X4:     (maxLength) Maximum buffer size.
//
// On Exit:
//
//  Buffer contains the newly formatted string.  If the
//  formatted value does not fit in the width specified,
//  e64ToStr will store "#" characters into this string.
//
//  carry:  clear if no error, set if error.
//          If error, X0 is
//              -3 if string overflow
//              -2 if bad width
//              -1 if value out of range
//
//-----------------------------------------------------------
//
// Unlike the integer to string conversions, this routine
// always right justifies the number in the specified
// string.  Width must be a positive number, negative
// values are illegal (actually, they are treated as
// *really* big positive numbers which will always raise
// a string overflow exception.
//
//***********************************************************

            proc        e64ToStr

#define     e2sWidth   x19      // chkNaNINF expects this here
#define     e2sExp     x20
#define     e2sFill    x21      // chkNaNINF expects this here
#define     e2sBuffer  x22      // chkNaNINF expects this here
#define     e2sMaxLen  x23
#define     e2sExpDigs x24

#define     e2sSign    w25
#define     eFailAdrs  x25      // chkNaNINF expects this here
#define     e2sMantSz  x26

            locals  e2s
            qword   e2s.x1x2
            qword   e2s.x3x4
            qword   e2s.x5x19
            qword   e2s.x20x21
            qword   e2s.x22x23
            qword   e2s.x24x25
            qword   e2s.x26x27
            dword   e2s.x0
            dword   e2s.d0
            byte    e2s.digits, 64
            byte    e2s.stack, 64
            endl    e2s

            // Build activation record and preserve registers:

            enter   e2s.size
            str     x0,       [fp, #e2s.x0]
            stp     x1,  x2,  [fp, #e2s.x1x2]
            stp     x3,  x4,  [fp, #e2s.x3x4]
            stp     x5,  x19, [fp, #e2s.x5x19]
            stp     x20, x21, [fp, #e2s.x20x21]
            stp     x22, x23, [fp, #e2s.x22x23]
            stp     x24, x25, [fp, #e2s.x24x25]
            stp     x26, x27, [fp, #e2s.x26x27]
            str     d0,       [fp, #e2s.d0]

            // Move important data to non-volatile registers:

            mov     e2sBuffer, x0
            mov     e2sWidth, x1
            mov     e2sFill, x2
            mov     e2sExpDigs, x3
            mov     e2sMaxLen, x4

            // See if the width is greater than the buffer size:

            cmp     e2sWidth, e2sMaxLen
            bhs     strOvfl

            strb    wzr, [e2sBuffer, e2sWidth]  // 0-terminate str

// First, make sure the width isn't zero.

            cmp     e2sWidth, #0
            beq     valOutOfRng

// Just to be on the safe side, don't allow widths greater
// than 1024:

            cmp     e2sWidth, #1024
            bhi     badWidth

// Check for NaN and INF

            lea     failAdrs, exit_eToBuf   // Note: X25, used before
            bl      chkNaNINF               // e2sSign (also X25).

// Okay, do the conversion.

            add     x0, fp, #e2s.digits // lea x1, e2s.digits
            bl      FPDigits        // Convert D0 to digit str
            mov     e2sExp, x1      // Save away exponent result
            mov     e2sSign, w2     // Save mantissa sign char

// Verify that there is sufficient room for the mantissa's sign,
// the decimal point, two mantissa digits, the "E",
// and the exponent's sign.  Also add in the number of digits
// required by the exponent (2 for single, 3 for double).
//
// -1.2e+00    :real4
// -1.2e+000   :real8

            add     x2, e2sExpDigs, #6    // Minimum number of posns
            cmp     x2, e2sWidth
            bls     goodWidth

// Output a sequence of "#...#" chars (to the specified width)
// if the width value is not large enough to hold the
// conversion:

            mov     x2, e2sWidth
            mov     x0, #'#'
            mov     x1, e2sBuffer
fillPnd:    strb    w0, [x1]
            add     x1, x1, #1
            subs    x2, x2, #1
            bne     fillPnd
            b.al    exit_eToBuf

// Okay, the width is sufficient to hold the number, do the
// conversion and output the string here:

goodWidth:
            // Compute the # of mantissa digits to display,
            // not counting mantissa sign, decimal point,
            // "E", and exponent sign.

            sub     e2sMantSz, e2sWidth, e2sExpDigs
            sub     e2sMantSz, e2sMantSz, #4

            // Round the number to the specified number of
            // print positions. (Note: since there are a
            // maximum of 16 significant digits, don't
            // bother with the rounding if the field width
            // is greater than 16 digits.)

            cmp     e2sMantSz, #maxDigits
            bhs     noNeedToRound

            // To round the value to the number of
            // significant digits, go to the digit just
            // beyond the last one we are considering (e2sMantSz
            // currently contains the number of decimal
            // positions) and add 5 to that digit.
            // Propagate any overflow into the remaining
            // digit positions.

            add     x1, e2sMantSz, #1
            add     x2, fp, #e2s.digits // lea x2, e2s.digits
            ldrb    w0, [x2, x1]        // Get least sig digit + 1.
            add     w0, w0, #5          // Round (e.g., +0.5 ).
            cmp     w0, #'9'
            bhi     whileDigGT9
            b.al    noNeedToRound

// Sneak this code in here, after a branch, so the
// loop below doesn't get broken up.

firstDigitInNumber:

            // If we get to this point, then we've hit the
            // first digit in the number.  So we've got to
            // shift all the characters down one position
            // in the string of bytes and put a "1" in the
            // first character position.

            ldr     x0, [x2, #8]
            str     x0, [x2, #9]
            ldr     x0, [x2]
            str     x0, [x2, #1]

            mov     x0, #'1'        // Store '1' in 1st
            strb    w0, [x2]        // digit position

            // Bump exponent by one as the shift did
            // a divide by 10.

            add     e2sExp, e2sExp, #1
            b.al    noNeedToRound

// Subtract out overflow and add the carry into the previous
// digit (unless we hit the first digit in the number).

whileDigGT9:
            sub     w0, w0, #10
            strb    w0, [x2, x1]
            subs    x1, x1, #1
            bmi     firstDigitInNumber

            // Add in carry to previous digit:

            ldrb    w0, [x2, x1]
            add     w0, w0, #1
            strb    w0, [x2, x1]
            cmp     w0, #'9'        // Overflow if char > '9'
            bhi     whileDigGT9

noNeedToRound:
            add     x2, fp, #e2s.digits // lea x2, e2s.digits


// Okay, emit the string at this point.  This is pretty easy
// since all we really need to do is copy data from the
// digits array and add an exponent (plus a few other simple chars).

            mov     x1, #0      // Count output mantissa digits.
            strb    e2sSign, [e2sBuffer], #1

// Output the first character and a following decimal point
// if there are more than two mantissa digits to output.

            ldrb    w0, [x2]
            strb    w0, [e2sBuffer], #1
            add     x1, x1, #1
            cmp     x1, e2sMantSz
            beq     noDecPt

            mov     w0, #'.'
            strb    w0, [e2sBuffer], #1

noDecPt:

// Output any remaining mantissa digits here.
// Note that if the caller requests the output of
// more than 16 digits, this routine will output zeros
// for the additional digits.

            b.al    whileX2ltMantSizeTest

whileX2ltMantSize:

            mov     w0, #'0'
            cmp     x1, #maxDigits
            bhs     justPut0

            ldrb    w0, [x2, x1]

justPut0:
            strb    w0, [e2sBuffer], #1
            add     x1, x1, #1

whileX2ltMantSizeTest:

            cmp     x1, e2sMantSz
            blo     whileX2ltMantSize

// Output the exponent:

            mov     w0, #'e'
            strb    w0, [e2sBuffer], #1
            mov     w0, #'+'
            mov     w4, #'-'
            neg     x5, e2sExp

            cmp     e2sExp, #0
            csel    w0, w0, w4, ge
            csel    e2sExp, e2sExp, x5, ge

            strb    w0, [e2sBuffer], #1


            mov     x0, e2sExp
            mov     x1, e2sExpDigs
            mov     x2, e2sBuffer
            bl      expToBuf
            bcs     error

exit_eToBuf:
            msr     nzcv, xzr    //clc = No error
            ldr     x0, [fp, #e2s.x0]

returnE64:
            ldp     x1,  x2,  [fp, #e2s.x1x2]
            ldp     x3,  x4,  [fp, #e2s.x3x4]
            ldp     x5,  x19, [fp, #e2s.x5x19]
            ldp     x20, x21, [fp, #e2s.x20x21]
            ldp     x22, x23, [fp, #e2s.x22x23]
            ldp     x24, x25, [fp, #e2s.x24x25]
            ldp     x26, x27, [fp, #e2s.x26x27]
            ldr     d0,       [fp, #e2s.d0]
            leave


strOvfl:    mov     x0, #-3
            b.al    error

badWidth:   mov     x0, #-2
            b.al    error

valOutOfRng:
            mov     x0, #-1
error:
            mrs     x1, nzcv
            orr     x1, x1, #(1 << 29)
            msr     nzcv, x1        // stc=error
            b.al    returnE64

            endp    e64ToStr



/////////////////////////////////////////////////////////
//
// Utility functions to convert Real64 values and print
// the string results:

            proc    r64Print
            stp     x0, x1, [sp, #-16]!
            stp     x2, x3, [sp, #-16]!
            stp     x4, x5, [sp, #-16]!
            stp     x6, x7, [sp, #-16]!
            stp     x8, lr, [sp, #-16]!
            sub     sp, sp, #64

            lea     x0, fmtStr1
            lea     x1, r64str_1
            mstr    x1, [sp]
            bl      printf

            add     sp, sp, #64
            ldp     x8, lr, [sp], #16
            ldp     x6, x7, [sp], #16
            ldp     x4, x5, [sp], #16
            ldp     x2, x3, [sp], #16
            ldp     x0, x1, [sp], #16
            ret
            endp    r64Print

            proc    e64Print
            stp     x0, x1, [sp, #-16]!
            stp     x2, x3, [sp, #-16]!
            stp     x4, x5, [sp, #-16]!
            stp     x6, x7, [sp, #-16]!
            stp     x8, lr, [sp, #-16]!
            sub     sp, sp, #64

            lea     x0, fmtStr3
            lea     x1, r64str_1
            mstr    x1, [sp]
            bl      printf

            add     sp, sp, #64
            ldp     x8, lr, [sp], #16
            ldp     x6, x7, [sp], #16
            ldp     x4, x5, [sp], #16
            ldp     x2, x3, [sp], #16
            ldp     x0, x1, [sp], #16
            ret
            endp    e64Print


/////////////////////////////////////////////////////////

r64_1:      .double  1.234567890123456
            .double  0.0000000000000001
            .double  1234567890123456.0
            .double  1234567890.123456
            .double  99499999999999999.0
            .dword   0x7ff0000000000000
            .dword   0xfff0000000000000
            .dword   0x7fffffffffffffff
            .dword   0xffffffffffffffff
            .double  0.0
            .double  -0.0
fCnt         =       (. - r64_1)

rSizes:     .word    12, 12, 2, 7, 0, 0, 0, 0, 0, 2, 2

e64_1:      .double  1.234567890123456e123
            .double  1.234567890123456e-123
e64_3:      .double  1.234567890123456e1
            .double  1.234567890123456e-1
            .double  1.234567890123456e10
            .double  1.234567890123456e-10
            .double  1.234567890123456e100
            .double  1.234567890123456e-100
            .dword   0x7ff0000000000000
            .dword   0xfff0000000000000
            .dword   0x7fffffffffffffff
            .dword   0xffffffffffffffff
            .double  0.0
            .double  -0.0
eCnt         =       (. - e64_1)

eSizes:     .word    6, 9, 8, 12, 14, 16, 18, 20, 12, 12, 12, 12, 8, 8
expSizes:   .word    3, 3, 2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2

// Here is the "asmMain" function.

proc    asmMain, public

    locals  am
        dword   am.x8x9
        dword   am.x27
        byte    am.stk, 64
    endl    am

    enter   am.size     // Activation Record

    stp     x8, x9, [fp, #am.x8x9]
    str     x27,    [fp, #am.x27]

    // F output

    mov     x2, #16         //decDigits
fLoop:
    ldr     d0, r64_1
    lea     x0, r64str_1    //Buffer
    mov     x1, #30         //fWidth
    mov     x3, #'.'        //Fill
    mov     x4, 32          //maxLength
    bl      r64ToStr
    bcs     fpError
    bl      r64Print
    subs    x2, x2, #1
    bpl     fLoop

    lea     x0, newlines
    bl      printf

    lea     x5, r64_1
    lea     x6, rSizes
    mov     x7, #fCnt/8
f2Loop:
    ldr     d0, [x5], #8
    lea     x0, r64str_1    //Buffer
    mov     x1, #30         //fWidth
    ldr     w2, [x6], #4    //decDigits
    mov     x3, #'.'        //Fill
    mov     x4, #32         //maxLength
    bl      r64ToStr
    bcs     fpError
    bl      r64Print
    subs    x7, x7, #1
    bne     f2Loop

    //// E output

    lea     x0, expStr
    bl      printf

    lea     x5, e64_1
    lea     x6, eSizes
    lea     x7, expSizes
    mov     x8, #eCnt/8
eLoop:
    ldr     d0, [x5], #8
    lea     x0, r64str_1    //Buffer
    ldr     w1, [x6], #4    //fWidth
    mov     x2, #'.'        //Fill
    ldr     w3, [x7], #4    //expDigits
    mov     x4, #32         //maxLength
    bl      e64ToStr
    bcs     fpError
    bl      e64Print
    subs    x8, x8, #1
    bne     eLoop
    b.al    allDone

fpError:
    mov     x1, x0
    lea     x0, fmtStr2
    mstr    x1, [sp]
    bl      printf

allDone:
    ldp     x8, x9, [fp, #am.x8x9]
    ldr     x27,    [fp, #am.x27]
    leave
endp    asmMain
