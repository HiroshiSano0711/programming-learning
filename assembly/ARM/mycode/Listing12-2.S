// Listing12-2.S
//
// Demonstration of bit string searching

#include    "aoaa.inc"

.text
.pool
ttlStr: wastr  "Listing 12-2"
noMatchStr:
        wastr   "Did not find bit string\n"

matchStr:
        wastr   "Found bit string at posn %d\n"


proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


proc    asmMain, public

    locals  am
        word    pattern
        word    source
        word    mask
        byte    am.stk, 64
    endl    am

    enter   am.size

    mov     w0, #0b1011110101101100
    str     w0, [fp, #source]
    mov     w0, #0b1011
    str     w0, [fp, #pattern]
    mov     w0, #0b1111
    str     w0, [fp, #mask]


    mov     w2, #28             // ループ回数。32 - 4 = 28 (len(src) - len(pat)).
    ldr     w3, [fp, #mask]     // 比較のためのマスクの読み込み
    ldr     w0, [fp, #pattern]  // パターンの読み込み
    and     w0, w0, w3          // 不要なbitのマスク
    ldr     w1, [fp, #source]   // ソースの読み込み
ScanLp:
    mov     w4, w1              // w1の下位4bitのコピー
    and     w4, w4, w3          // 必要ないbitのマスク
    cmp     w0, w4              // パターンとマッチしてるか比較
    beq     Matched
    sub     w2, w2, #1          // (len(src) - len(pat))回の繰り返し
    lsr     w1, w1, #1          // 右に1つシフトして次のbit列へ

    // cbnz（Compare and Branch if Not Zero）
    // 形式
    //  cbnz  <reg>, <label>
    // 意味
    //  <reg> != 0 なら ジャンプ
    //  <reg> == 0 なら 次の命令へ進む

    cbnz    w1, ScanLp

    // not match

    lea     x0, noMatchStr
    bl      printf
    b.al    Done

Matched:
    mov     x1, #28
    sub     x1, x1, x2      // ループ回数から比較回数を引くことでマッチしたときの開始位置を指す
    mstr    x1, [sp]
    lea     x0, matchStr
    bl      printf
Done:
    leave
endp    asmMain
