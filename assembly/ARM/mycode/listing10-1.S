// Listing 10-1
//
// Lower-to-upper case conversion


#include    "aoaa.inc"


.section    .rodata, ""

ttlStr:     .asciz      "Listing 10-1"

textStr:    .ascii      "abcdefghijklmnopqrstuvwxyz\n"
            .ascii      "ABCDEFGHIJKLMNOPQRSTUVWXYZ\n"
            .asciz      "0123456789\n"


// 配列のインデックス ＝ ASCIIコードとなるように配置されている。
// 0–31	制御文字
// 32	' '（スペース）
// 33–47	記号
// 48–57	'0'–'9'
// 65	'A'
// 65–90	'A'–'Z'
// 91–96	記号
// 97–122	'a'–'z'
// 123–127	記号
//
// 関係するのは65バイト目から
// .ascii      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
// は大文字をそのまま返す
// 配列[65] = 'A'
// 配列[66] = 'B'
// ...
// 配列[90] = 'Z'
//
// .byte       91,92,93,94,95,96
// .ascii      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
// ここが大文字への変換する部分。
//
// 配列[97] = 'A' → 'a'→'A'
// 配列[98] = 'B' → 'b'→'B'
// ...
// 配列[122] = 'Z' → 'z'→'Z'
// となるようにデータ配置を行いテーブルを作成している

xlatTbl:    .byte       0,1,2,3,4,5,6,7
            .byte       8,9,10,11,12,13,14,15
            .byte       16,17,18,19,20,21,22,23
            .byte       24,25,26,27,28,29,30,31
            .byte       32,33,34,35,36,37,38,39
            .byte       40,41,42,43,44,45,46,47
            .byte       48,49,50,51,52,53,54,55
            .byte       56,57,58,59,60,61,62,63
            .byte       64
            .ascii      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            .byte       91,92,93,94,95,96
            .ascii      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            .byte       123,124,125,126,127

fmtStr1:    .asciz      "Standard conversion:\n"
fmtStr2:    .asciz      "\nConversion via lookup table:\n"
fmtStr:     .asciz      "%c"

.code
.extern     printf


////////////////////////////////////////////////////////////////////
//
// Return program title to C++ program:

proc        getTitle, public
    lea         x0, ttlStr
    ret
endp        getTitle



////////////////////////////////////////////////////////////////////
//
// Here is the "asmMain" function.

proc    asmMain, public

    locals  am
        dword   am.x20
        dword   am.x21
        byte    am.shadow, 64
    endl    am

    enter   am.size
    str     x20, [fp, #am.x20]
    str     x21, [fp, #am.x21]

    lea     x0, fmtStr1
    bl      printf

    lea     x20, textStr
    mov     x21, #'z'
    b.al    testNot0

// いままで使ってきた通常の大文字に変換するループ
stdLoop:
    cmp     w1, #'a'
    ccmp    w1, w21, #0b0010, hs
    bhi     notLower
    eor     w1, w1, #0x20

notLower:
    lea     x0, fmtStr
    mstr    x1, [sp]
    bl      printf

testNot0:
    ldrb    w1, [x20], #1
    cmp     w1, #0
    bne     stdLoop

    lea x0, fmtStr2
    bl      printf

    lea     x20, textStr
    lea     x21, xlatTbl
    b.al    testNot0a

// テーブルを使った大文字に変換するループ
xlatLoop:
    // ldrb Wt, [Xn, Xm, extend #shift]
    // Effective address = Xn + (zero/sign-extended Xm << shift)
    //
    // uxtw #0 : ゼロ拡張 (32bit → 64bit) を行い、シフトは行わない
    //         : つまりインデックス値をそのままオフセットとして使用する
    //
    // このテーブルは 1バイト単位の配列なので、インデックスは「バイト単位」でアドレス計算する必要がある。
    //
    // AArch64 のアドレッシングモードでは
    // 64bit + 32bit の加算は直接できないため、
    // 32bit レジスタを uxtw によって 64bit に拡張してから使用する。

    ldrb    w1, [x21, w1, uxtw #0]

    lea     x0, fmtStr
    mstr    x1, [sp]
    bl      printf

testNot0a:
    ldrb    w1, [x20], #1
    cmp     w1, #0
    bne     xlatLoop

allDone:
    ldr     x20, [fp, #am.x20]
    ldr     x21, [fp, #am.x21]
    leave
endp    asmMain
