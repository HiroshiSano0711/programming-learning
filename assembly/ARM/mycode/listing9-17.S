// Listing 9-17
//
// 文字列で表現された浮動小数点数を、double（64-bit浮動小数）に変換する

#include    "aoaa.inc"

false = 0
true  = 1
tab   = 9

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-17"
fmtStr1:    .asciz      "strToR64: str='%s', value=%e\n"
errFmtStr:  .asciz      "strToR64 error, code=%ld\n"

// テスト用のサンプルデータ

fStr1a:     .asciz      " 1.234e56"
fStr1b:     .asciz      "\t-1.234e+56"
fStr1c:     .asciz      "1.234e-56"
fStr1d:     .asciz      "-1.234e-56"
fStr2a:     .asciz      "1.23"
fStr2b:     .asciz      "-1.23"
fStr2c:     .asciz      "001.23"
fStr2d:     .asciz      "-001.23"
fStr3a:     .asciz      "1"
fStr3b:     .asciz      "-1"
fStr4a:     .asciz      "0.1"
fStr4b:     .asciz      "-0.1"
fStr4c:     .asciz      "0000000.1"
fStr4d:     .asciz      "-0000000.1"
fStr4e:     .asciz      "0.1000000"
fStr4f:     .asciz      "-0.1000000"
fStr4g:     .asciz      "0.0000001"
fStr4h:     .asciz      "-0.0000001"
fStr4i:     .asciz      ".1"
fStr4j:     .asciz      "-.1"
fStr5a:     .asciz      "123456"
fStr5b:     .asciz      "12345678901234567890"
fStr5c:     .asciz      "0"
fStr5d:     .asciz      "1."
fStr6a:     .asciz      "0.000000000000000000001"


// .dword が8バイト(64bit)データだから、8バイト境界に揃える

.align      3
values:     .dword      fStr1a, fStr1b, fStr1c, fStr1d
            .dword      fStr2a, fStr2b, fStr2c, fStr2d
            .dword      fStr3a, fStr3b
            .dword      fStr4a, fStr4b, fStr4c, fStr4d
            .dword      fStr4e, fStr4f, fStr4g, fStr4h
            .dword      fStr4i, fStr4j
            .dword      fStr5a, fStr5b, fStr5c, fStr5d
            .dword      fStr6a
            .dword      0


PotTbl:     .double     1.0e+256
            .double     1.0e+128
            .double     1.0e+64
            .double     1.0e+32
            .double     1.0e+16
            .double     1.0e+8
            .double     1.0e+4
            .double     1.0e+2
            .double     1.0e+1
            .double     1.0e+0

.data
r8Val:      .double     0.0


.code
.extern     printf

///////////////////////////////////////////////////////////
//
// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


//*********************************************************
//
// strToR64
//
// 【入力】
//
//  X0: 浮動小数点数を表す文字列へのポインタ
//
// 【出力】
//
//  D0: 変換された浮動小数点値
//  X0:（正常終了時）変換できなかった最初の文字を指す
//
//  C:  キャリーフラグ
//      正常時はクリア、エラー時はセットされる。
//      エラー発生時は X0 の値は保存される。
//      エラー時は X1 にエラーコードが格納される
//      （正常時は X1 の値は保持される）。
//
//*********************************************************

proc    strToR64

    locals  sr
        qword   sr.x1x2
        qword   sr.x3x4
        qword   sr.x5x6
        qword   sr.x7x0
        dword   sr.d1
        byte    sr.stack, 64    //Not really needed, but...
    endl    sr

    enter   sr.size

    // より意味のある名前をレジスタに定義

    #define mant    x1      // 仮数部の値
    #define sigDig  x2      // 仮数部の有効桁数
    #define expAcc  x2      // 指数の累積値
    #define sign    w3      // 仮数部の符号
    #define fpExp   x4      // 10進指数
    #define expSign w5      // 指数部の符号
    #define ch      w6      // 現在の文字
    #define xch     x6      // 現在の文字（64ビット）
    #define ten     x7      // 定数 10

    // このコードが変更するレジスターを退避

    stp     x1, x2, [fp, #sr.x1x2]
    stp     x3, x4, [fp, #sr.x3x4]
    stp     x5, x6, [fp, #sr.x5x6]
    stp     x7, x0, [fp, #sr.x7x0]
    str     d1,     [fp, #sr.d1  ]

    // 便利な初期化

    mov     fpExp, xzr      // 10進指数の値を 0 に初期化
    mov     mant, xzr       // 仮数部の値を 0 に初期化
    mov     sign, wzr       // 符号を「正」と仮定して初期化

    // sigDig を 16 に初期化（残りの有効桁数）

    mov     sigDig, #16     //X1

    // X0がNULLでないことを保証する

    cmp     x0, xzr
    beq     refNULL

    // スペースとタブ文字をスキップする

    sub     x0, x0, #1
whileWSLoop:
    ldrb    ch, [x0, #1]!
    cmp     ch, #' '
    beq     whileWSLoop
    cmp     ch, #tab
    beq     whileWSLoop

    // + か - をチェックする

    cmp     ch, #'+'
    beq     skipSign

    cmp     ch, #'-'
    cinc    sign, sign, eq  // if ch == sign, sign = sign + 1, else sign = sign
    bne     noSign

skipSign:
    ldrb    ch, [x0, #1]!   // 符号をスキップ
noSign:

    // この時点で符号まで読んだので、次の文字は数字か小数点でないといけない

    sub     ch, ch, #'0'
    cmp     ch, #9
    bls     scanDigits

    cmp     ch, #'.'-'0'    //Check for '.'
    bne     convError


    // 最初の文字が小数点だった場合は２番目の文字は数字であることが求められる

    ldrb    ch, [x0, #1]!   // Skip period
    cmp     ch, #'0'
    blo     convError
    cmp     ch, #'9'
    bhi     convError
    b.al    whileDigit2

// Scan for digits at the beginning of the number:

scanDigits:
    mov     ten, #10        // かける数

    // ループ開始時点では chはASCII 文字という構造を統一するために文字に直してる。
    // 文字→数値→文字って直していて一見無駄だけど
    add     ch, ch, #'0'

// 小数点より左側（整数部）の処理
whileADigit:
    sub     ch, ch, #'0'
    cmp     ch, #10
    bhs     notDigit

    // if (mant == 0 && ch == 0) { goto Beyond16 } と同じ
    // まだ数値が始まっていない間の 0 は無視する
    // 数値が始まった後の 0 は有効な桁として扱う
    // "001"の0は意味がないけど、"100"の0は桁数を示すので処理する、ということ
    // 整数部と仮数部もすべて同じ整数として詰め込み、fpExpで小数点の位置を計算している

    cmp     mant, xzr
    ccmp    ch, #0, #0, eq
    beq     Beyond16

    add     fpExp, fpExp, #1

    cmp     sigDig, xzr
    beq     Beyond16

    // 有効桁数のカウントダウン

    sub     sigDig, sigDig, #1

    madd    mant, mant, ten, xch    // mant = mant * ten + xch

    sub     fpExp, fpExp, #1        // 最終的にmant*10^fpExp を掛ける指数になる予定の値

Beyond16:
    ldrb    ch, [x0, #1]!
    b.al    whileADigit


// 小数点に達したら、仮数部の処理を始める
notDigit:
    cmp     ch, #'.'-'0'
    bne     whileDigit2

getNextChar:
    ldrb    ch, [x0, #1]!   // 小数点をスキップ

// 小数点より右側（小数部）の処理
whileDigit2:
    sub     ch, ch, #'0'
    cmp     ch, #10
    bhs     noDigit2

    // 0がひたすら続くだけで有効桁数を使い切ってしまうケースは省いて安全にするため。
    // 例：0.0000000000000000000001
    // if (mant==0 && ch==0 && sigDig==0) { goto getNextChar; }
    cmp     mant, xzr
    ccmp    ch, wzr, #0, eq
    ccmp    sigDig, xzr, #0, eq
    beq     getNextChar

    sub     fpExp, fpExp, #1

    sub     sigDig, sigDig, #1

    madd    mant, mant, ten, xch
    b.al    getNextChar

noDigit2:
    // 指数部があるかどうかのチェック。
    // 'e' か 'E' だったら exponent 処理へ
    // そうでなければ exponent なしという分岐。

    // 指数部の計算に入るので関連するレジスタを初期化
    mov     expSign, wzr
    mov     expAcc, xzr

    cmp     ch, #'e'-'0'
    beq     hasExponent
    cmp     ch, #'E'-'0'
    bne     noExponent

hasExponent:
    // 指数部の符合を判定して符号を設定する。
    //  正:expSign = 0
    //  負:expSign = 1

    ldrb    ch, [x0, #1]!           // Skip the "E"
    cmp     ch, #'-'
    cinc    expSign, expSign, eq
    beq     doNextChar_2
    cmp     ch, #'+'
    bne     getExponent

doNextChar_2:
    ldrb    ch, [x0, #1]!   //Skip '+' or '-'


// ここまできたら指数値を処理するだけ。
// 少なくとも1つの数字が求められる

getExponent:
    sub     ch, ch, #'0'    //W6
    cmp     ch, #10
    bhs     convError

    mov     expAcc, xzr   // Compute exponent value in X2
ExpLoop:
    ldrb    ch, [x0], #1
    sub     ch, ch, #'0'
    cmp     ch, #10
    bhs     ExpDone

    madd    expAcc, expAcc, ten, xch    // expAcc = expAcc * ten + xch
    b.al    ExpLoop


// 指数が負なら反転させる

ExpDone:
    // false = 0
    // expSign == false
    cmp     expSign, #false
    beq     noNegExp

    neg     expAcc, expAcc  // 負なら反転

noNegExp:
    // 仮数部の桁数と合わせて最終的な指数値を計算する
    add     fpExp, fpExp, expAcc

noExponent:
    // IEEE-754 double の10進指数の実用範囲（おおよそ -324 ～ +308）に収まっているかを確認。
    // 超えていれば voor（Value out of range）

    mov     x5, #308
    cmp     fpExp, x5
    bgt     voor
    mov     x5, #-324
    cmp     fpExp, x5
    blt     voor


    // 仮数（整数化された mant）を double に変換。
    // ucvtf: Unsigned Convert To Floating-point
    //  符号なし整数（unsigned integer）を浮動小数点数（float / double）に変換する命令
    ucvtf   d0, mant


    // やりたいこと
    // d0 = mant × 10^fpExpを できるだけ誤差少なく、かつ 高速に計算したい。
    // 「10回掛け算する」みたいな単純手段ではなく：
    // 10^256, 10^128, 10^64, 10^32, ... 10^1
    // という あらかじめ用意されたテーブルを使って、指数をビット走査型で適用する。
    // 指数変換でやった処理と同じ

    mov     x1, -8      // 10^n乗テーブルの初期インデックス
    cmp     fpExp, xzr
    bpl     positiveExponent

    // 負の指数の処理
    // fpExp の各ビットを上から順番に調べたい
    // if (exp & (1 << N)) { 掛ける / 割る }
    // という普通のビットテストをやりたいけど、それを 分岐なし + 高速で行いたい
    //
    // adds    fpExp, fpExp, fpExp
    // は fpExp <<= 1 だけど同時に
    // いちばん左のビット（bit63）が Carry フラグに出る。
    // Carryフラグが立ったかどうかを判定基準にしてる。
    //
    // 1回目のループ：
    // 最上位だった bit8 が Carry に出る
    // → 10^256 を使うかどうか判定
    //
    // 2回目：
    // 次の bit7 が Carry に出る
    // → 10^128 を使うかどうか判定
    // …と続く。

    neg     fpExp, fpExp
    lsl     fpExp, fpExp, #55 // Bits 0..8 -> 55..63
    lea     x6, PotTbl
whileExpNE0:
    add     x1, x1, #8          // PotTblの次のインデックス
    adds    fpExp, fpExp, fpExp // fpExp <<= 1
    bcc     testExp0            // Branch if Carry Clear → C = 0 のとき分岐

    ldr     d1, [x6, x1]
    fdiv    d0, d0, d1

testExp0:
    cmp     fpExp, xzr
    bne     whileExpNE0
    b.al    doMantissaSign


// Handle positive exponents here.

positiveExponent:
    lea     x6, PotTbl
    lsl     fpExp, fpExp, #55       // Bits 0..8 -> 55..63.
    b.al    testExpis0_2

whileExpNE0_2:
    add     x1, x1, #8
    adds    fpExp, fpExp, fpExp     // (LSL)
    bcc     testExpis0_2

    ldr     d1, [x6, x1]
    fmul    d0, d0, d1      // 負の指数の処理と違うのはここだけ

testExpis0_2:
    cmp     fpExp, xzr
    bne     whileExpNE0_2


// 仮数部の符合が負なら結果を反転させる

doMantissaSign:
    cmp     sign, #false
    beq     mantNotNegative

    fneg    d0, d0

// 正常終了処理。x0は復元しない

mantNotNegative:
    msr     nzcv, xzr   //clr c = No error
    ldp     x1, x2, [fp, #sr.x1x2]
    ldp     x3, x4, [fp, #sr.x3x4]
    ldp     x5, x6, [fp, #sr.x5x6]
    ldr     x7,     [fp, #sr.x7x0]
    ldr     d1,     [fp, #sr.d1  ]
    leave

// エラー処理。エラーコードを返す

refNULL:    mov     x1, #-3
    b.al    ErrorExit

convError:  mov     x1, #-2
    b.al    ErrorExit

voor:       mov     x1, #-1 //Value out of range
    b.al    ErrorExit

illChar:    mov     x1, #-4

// エラーではx0を復元する

ErrorExit:
    str     x1, [fp, #sr.x1x2]  // Return error code in X1
    mrs     x1, nzcv            //Return error in carry flag
    orr     x1, x1, #(1 << 29)
    msr     nzcv, x1            // set c=error
    ldp     x1, x2, [fp, #sr.x1x2]
    ldp     x3, x4, [fp, #sr.x3x4]
    ldp     x5, x6, [fp, #sr.x5x6]
    ldp     x7, x0, [fp, #sr.x7x0]
    ldr     d1,     [fp, #sr.d1  ]
    leave

endp    strToR64

// 第9章が終わるので所感
// 整数変換 (mant の蓄積)
// 有効桁管理 (sigDig)
// 指数部処理 (e±n)
// 範囲チェック
// ポテンステーブル
// Carry を使ったビット走査
// 最後の符号処理
// この章でやってきたことの集大成みたいなコードでした。
// 疲れた

//////////////////////////////////////////////////////////////
//
// Here is the "asmMain" function.


proc    asmMain, public

    locals  am
        dword   am.x20
        byte    stack, 64
    endl    am

    enter   am.size
    str     x20, [fp, #am.x20]


    // Test floating-point conversion:

    lea     x20, values
ValuesLp:   ldr     x0, [x20]
    cmp     x0, xzr
    beq     allDone

    bl      strToR64
    bcs     fpError


    lea     x0, fmtStr1
    ldr     x1, [x20]
    mstr    x1, [sp]
    mstr    d0, [sp, #8]
    bl      printf
    add     x20, x20, #8
    b.al    ValuesLp

fpError:
    lea     x0, errFmtStr
    mstr    x1, [sp]        // Error code from strToR64
    bl      printf

allDone:
    ldr     x20, [fp, #am.x20]
    leave
endp    asmMain
