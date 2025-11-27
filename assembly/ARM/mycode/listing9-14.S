// Listing 9-14
//
// String to numeric conversion

// 1. 数値→文字列変換と文字列→数値変換の違い
// 数値→文字列（Numeric-to-String）
// 基本的に「バッファサイズが足りていればエラーは発生しない」。
// バッファオーバーフローにだけ注意すればよい。
// 文字列→数値（String-to-Numeric）
// 実際にエラーが起こる可能性がある。
// 不正な文字
// オーバーフロー
// ユーザ入力や外部データから数値に変換する場合に必須の処理。

// 2. C++での例（cin >> i32;）
// 入力文字列の先頭にある空白やタブをスキップ。
// 数字列を内部の整数に変換。
// 途中で非数字文字が出た場合に変換を終了。
// 入力ストリームの残りの文字は変換対象外として残る。
// 数値が収まらない場合（オーバーフロー）はエラー扱い。

// 3. デリミタの扱い
// 数値列の終わりを検出するために非数字文字を使用。
// 空白、タブ、カンマ、句読点などもデリミタになり得る。

// 4. エラー条件
// 数字が1つも出てこない場合。
// 数字列が変換対象の型の範囲を超える場合。

// 5. 文字列→整数変換アルゴリズム（Decimal Strings → Integers）
// アキュムレータを0で初期化
// 空白/タブをスキップ
// 最初の文字を取得
// 数字でなければエラー
// 数字文字を値に変換（AND 0xf）
// accumulator = accumulator × 10 + currentValue
// オーバーフローならエラー
// 次の文字を取得
// 数字ならステップ5へ、そうでなければ次へ
// 成功時はアキュムレータに値が入る
// 符号付きの場合
// 最初の文字が - なら負数フラグをセットしてスキップ。
// 変換後、負数フラグがセットされていれば結果を反転（オーバーフロー確認必須）。
// つまり、数値→文字列変換はほぼ安全で、バッファサイズだけ意識すればよいのに対し、
// 文字列→数値変換は 不正文字列やオーバーフロー をしっかり検出する必要がある、という点が重要

#include    "aoaa.inc"

false       =       0
true        =       1
tab         =       9      // tabのASCII コードは 9 (0x09)

            .section    .rodata, ""
ttlStr:     .asciz      "Listing 9-14"
fmtStr1:    .ascii      "strtou: String='%s'\n"
            .asciz      "    value=%llu\n"

fmtStr2:    .ascii      "Overflow: String='%s'\n"
            .asciz      "    value=%llx\n"

fmtStr3:    .ascii      "strtoi: String='%s'\n"
            .asciz      "    value=%lli\n"

unexError:  .asciz      "Unexpected error in program\n"

value1:     .asciz      "  1"
value2:     .asciz      "12 "
value3:     .asciz      " 123 "
value4:     .asciz      "1234"
value5:     .asciz      "1234567890123456789"
value6:     .asciz      "18446744073709551615"
OFvalue:    .asciz      "18446744073709551616"
OFvalue2:   .asciz      "999999999999999999999"

ivalue1:    .asciz      "  -1"
ivalue2:    .asciz      "-12 "
ivalue3:    .asciz      " -123 "
ivalue4:    .asciz      "-1234"
ivalue5:    .asciz      "-1234567890123456789"
ivalue6:    .asciz      "-18446744073709551615"
OFivalue:   .asciz      "18446744073709551616"
OFivalue2:  .asciz      "-18446744073709551616"


.code
.extern     printf


////////////////////////////////////////////////////////////////////
//
// Return program title to C++ program:

proc    getTitle, public
    lea         x0, ttlStr
    ret
endp    getTitle


////////////////////////////////////////////////////////////////////
//
// strtou-
//  文字列データを 64 ビット符号なし整数に変換する。
//
// 入力-
//   X1-    変換対象となる文字列を含むバッファへのポインタ
//
// 出力-
//   X0-    変換後の数値（成功時）、エラー発生時はエラーコード
//
//   X1-    数値文字列の末尾（最初の非数字文字）を指す。
//           エラー時は X1 の値は元に戻される。
//           呼び出し側は成功後、[X1] の文字を確認することで
//           数値の後に続く文字が妥当なデリミタかどうか判定できる。
//
//   C       (キャリーフラグ) エラー発生時にセット、成功時はクリア。
//           エラー時、X0 には 0（不正な先頭文字）または
//           0ffffffffffffffffh（オーバーフロー）が格納される。

proc    strtou
    // レジスタの退避

    str x5, [sp, #-16]!
    stp x3, x4, [sp, #-16]!
    stp x1, x2, [sp, #-16]!


    // 初期化

    mov x3, xzr
    mov x0, xzr
    mov x4, #10     // 割る数


    // 補足。違う実装方法。
    // アドレス固定＋インデックス（オフセット）で行う → 字句解析でいう先読み（lookahead）
    //  純粋 lookahead をやると、
    // 読み取りごとに [x1+offset] を毎回指定する必要があってコード量が増えたり、
    // 複雑なケースで offset 管理が大変になったりする。
    //
    // 今回の実装は単に1文字ずつ読み進めていくだけなのでロジックは簡単になってる
    // ただし、「先読み」という概念が出てきた場合は
    // "current" と "next" の文字を2つ保持した、字句解析で使われる技術を指すことが多い
    // 文字列の処理なので一応メモ
    // 1つ戻してから以下のループで、1つ足してから読み込むようにしているが、
    // これはポストインクリメントに書き換えても等価なので、実装のスタイルによる

    sub     x1, x1, #1
skipWS:
    // 先頭にあるスペースとタブをスキップ。それ以外の文字に到達するまで繰り返す

    ldrb    w2, [x1, #1]!   // 次の文字を読み込む。現在のポインタが指している先頭の1文字だけ
    cmp     w2, #' '        // スペースでないか判定
    beq     skipWS          // 等しいからこの処理を繰り返し次の文字の判定へ
    cmp     w2, #tab        // tabでないか確認
    beq     skipWS          // 等しいからこの処理を繰り返し次の文字の判定へ


    // この時点で数字がないならエラーを返す
    // '0'~'9'の文字であることを確認する
    // メモ： '0' < '1' < ... < '9'

    cmp     w2, #'0'
    blo     badNumber
    cmp     w2, #'9'
    bhi     badNumber

// 最初の数字は問題なしなので、数字を数値に変換していく
//
// ここで符号なし整数（unsigned integer）のオーバーフローを確認する必要がある。
// 残念ながら、madd（乗算して加算する命令）はキャリー（C）フラグやオーバーフロー（V）フラグを設定しない。
// そのため、乗算後にオーバーフローが発生したかどうかを確認するにはumulh を使う必要がある。
// また、桁の加算処理にはmadd の代わりに通常の add 命令を使って明示的に加算を行う。

convert:
    // umulh: Unsigned Multiply High
    // 符号なし 64bit × 64bit → 128bit の上位 64bit だけを取得する命令。
    //
    // 上位64bitがゼロでなければオーバーフロー
    // x0 * 10 が 64bit に収まらないことを検出している

    umulh   x5, x0, x4
    cmp     x5, xzr
    bne     overflow


    // 数字を数値に直すのは
    // sub  x2, x2, #'0'
    // が教科書的な方法。
    // and #0xF はちょっとビットトリック寄り。伝統的なやり方に近い

    and     x2, x2, #0xf
    mul     x0, x0, x4      // madd命令はフラグを更新しないため、オーバーフロー検出ができないので使用しない
    adds    x0, x0, x2      // 乗算した結果に数値を足してフラグ更新

    // Carryフラグが立った場合は符号なし加算で桁あふれが発生したことを意味する→オーバーフロー
    bcs     overflow

    ldrb    w2, [x1, #1]!   // 次の文字を取得
    cmp     w2, #'0'        // 数字かどうかチェック
    blo     endOfNum        // '0'より小さいなら数字の終わり
    cmp     w2, #'9'
    bls     convert         // '9'以下なら変換処理を繰り返す


// この時点で数字を数値へ変換する処理は成功している
// レジスタを復元してReturn without restoring
// the value in X1 (X1 points at end of digits).

endOfNum:
    // x1の値はエラーが発生した場合に元にもどしてからretするため、はじめにスタックへ退避させておく必要がある
    // 成功時は末尾を指したポインタを返すのでx1は復元しない。

    ldp     x3, x4, [sp], #16   // x1→x3,  x2 → x4
    mov     x2, x4              // x2 = x4 x2の値を復元
    ldp     x3, x4, [sp], #16   // x3,x4の値を復元
    ldr     x5, [sp], #16       // x5の値を復元

    // Because the conversion was successful, this
    // procedure leaves RDI pointing at the first
    // character beyond the converted digits. As
    // such, we don't restore RDI from the stack.
    // Just bump the stack pointer up by 8 bytes to
    // throw away RDI's saved value.


    // システムフラグを全て0にリセット。エラーがないことも通知
    msr     nzcv, xzr    //clr c = No error
    ret

badNumber:
    mov     x0, xzr
errorRet:
    mrs     x1, nzcv              //Return error in carry flag
    orr     x1, x1, #(1 << 29)
    msr     nzcv, x1              // set c=error

    // エラーの場合はレジスタを全て復元して元に戻す

    ldp     x1, x2, [sp], #16
    ldp     x3, x4, [sp], #16
    ldr     x5, [sp], #16
    ret

overflow:
    mov     x0, #-1  //0xFFFFFFFFFFFFFFFF
    b.al    errorRet
endp    strtou


////////////////////////////////////////////////////////////////
//
// strtoi-
//  Converts string data to a 64-bit signed integer.
//
// Input-
//   X1-    Pointer to buffer containing string to convert
//
// Output-
//   X0-    Contains converted string (if success), error code
//           if an error occurs.
//
//   X1-    Points at first char beyond end of numeric string.
//           If error, X1's value is restored to original value.
//           Caller can check character at [X1] after a
//           successful result to see if the character following
//           the numeric digits is a legal numeric delimiter.
//
//   C       (carry flag) Set if error occurs, clear if
//           conversion was successful. On error, RAX will
//           contain 0 (illegal initial character) or
//           0ffffffffffffffffh (overflow).

tooBig:     .dword  0x7fffffffffffffff

proc    strtoi

    locals  si
    qword   si.saveX1X2
    endl    si

    enter   si.size


    // x1は復元が必要なケースがあるので退避する
    // x2は符号のフラグ

    stp     x1, x2, [fp, #si.saveX1X2]


    // 負でない数と仮定しておく

    mov     x2, #false


    // strtouと同じ処理なので解説は省略

    sub     x1, x1, #1
skipWSi:
    ldrb    w0, [x1, #1]!
    cmp     w0, #' '
    beq     skipWSi
    cmp     w0, #tab
    beq     skipWSi


    // 負の数の場合は、最初にマイナスの符合があるのでスキップする

    cmp     w0, #'-'
    bne     notNeg
    mov     w2, #true
    add     x1, x1, #1  // '-' の符号文字をスキップする

notNeg:
    bl     strtou       //Convert string to integer
    bcs    hadError

    // strtou returned success. Check the negative
    // flag and negate the input if the flag
    // contains true.

    cmp     w2, #true
    bne     itsPosOr0

    // neg は内部的には 0 - x0による符号反転と同じ扱いができる
    // 64bit符号つき整数の範囲
    // 最小値: -2^63   = -9223372036854775808 = 0x8000000000000000
    // 最大値:  2^63-1 =  9223372036854775807 = 0x7FFFFFFFFFFFFFFF
    // 9223372036854775808という正の最大値を超えた値をnegしようとすると符号が変わらずVフラグが立つ
    // それによって負のオーバーフローを検出している
    // Vフラグ判定 = (A_sign == B_sign) && (Result_sign != A_sign)
    // Vフラグは符号遷移をみている

    neg     x0, x0
    bvs     overflowi
    ldr     x2, [fp, #si.saveX1X2+8]
    msr     nzcv, xzr    //clr c = No error
    leave


itsPosOr0:
    ldr     x2, tooBig
    cmp     x0, x2     //number is too big
    bhi     overflowi
    ldr     x2, [fp, #si.saveX1X2+8]
    msr     nzcv, xzr    //clr c = No error
    leave

overflowi:
    mov     x0, #-1 // overflowを示すエラーコード
hadError:
    // Carryフラグをセットしてエラー通知
    mrs     x2, nzcv
    orr     x2, x2, #(1 << 29)
    msr     nzcv, x2

    ldp     x1, x2, [fp, #si.saveX1X2]
    leave
endp    strtoi



////////////////////////////////////////////////////////////////////
//
// Here is the "asmMain" function.


proc    asmMain, public

    locals  am
    byte    am.shadow, 64
    endl    am

    enter   am.size


// Test unsigned conversions:

    lea     x1, value1
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value1
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, value2
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, value3
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value3
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, value4
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value4
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, value5
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value5
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, value6
    bl      strtou
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr1
    lea     x1, value6
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, OFvalue
    bl      strtou
    bcc     UnexpectedError
    cmp     x0, xzr        //Non-zero for overflow
    beq     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr2
    lea     x1, OFvalue
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, OFvalue2
    bl      strtou
    bcc     UnexpectedError
    cmp     x0, xzr        //Non-zero for overflow
    beq     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr2
    lea     x1, OFvalue2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

// Test signed conversions:

    lea     x1, ivalue1
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue1
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, ivalue2
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, ivalue3
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue3
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    lea     x1, ivalue4
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue4
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    lea     x1, ivalue5
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue5
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    lea     x1, ivalue6
    bl      strtoi
    bcs     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr3
    lea     x1, ivalue6
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, OFivalue
    bl      strtoi
    bcc     UnexpectedError
    cmp     x0, xzr        //Non-zero for overflow
    beq     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr2
    lea     x1, OFivalue
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf


    lea     x1, OFivalue2
    bl      strtoi
    bcc     UnexpectedError
    cmp     x0, xzr        //Non-zero for overflow
    beq     UnexpectedError

    mov     x2, x0
    lea     x0, fmtStr2
    lea     x1, OFivalue2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    b.al    allDone

UnexpectedError:
    lea     x0, unexError
    bl      printf


allDone:    leave   //Returns to caller
endp    asmMain
