// Listing 14-5
//
// A str.substr substring function.

#include    "aoaa.inc"

struct  string, -16
    dword   string.allocPtr // at offset -16
    word    string.maxlen   // at offset -8
    word    string.len      // at offset -4
    byte    string.chars    // at offset 0
ends    string




// str.buf:

.macro  str.buf strName, maxSize
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   \maxSize
    .word   0
    \strName:   .space  ((\maxSize+16) & 0xFFFFFFF0), 0
.endm


// str.literal:

.macro  str.literal strName, strChars
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   len_\strName    //string.maxlen
    .word   len_\strName    //string.len

    \strName:   .ascii  "\strChars"
    len_\strName=       .-\strName
    .byte   0   // Zero-terminating byte

    .align  4
.endm


///////////////////////////////////////////////////////////

.data
fmtStr:     .ascii      "Source string:\n\n"
            .ascii      "          1111111111222222222233333\n"
            .ascii      "01234567890123456789012345678901234\n"
            .asciz      "%s\n\n"

str.buf     smallDest, 32
str.literal dest,   "Initial destination string"

//                             1111111111222222222233333
//                   01234567890123456789012345678901234
str.literal source, "Hello there, world! How's it going?"



///////////////////////////////////////////////////////////

.code

ttlStr:     wastr  "Listing14-5"

proc    getTitle, public
    lea    x0, ttlStr
    ret
endp    getTitle


///////////////////////////////////////////////////////////
//
// str.substr:
//
// Extracts a substring.
//
// On entry:
//
//  X0- Pointer to source string.
//  w1- Starting index into source string.
//  w2- Length of substring.
//  X3- Destination string
//
// On exit:
//
//  Carry clear on success and result stored at X3.
//
//  If the substring will not fit in X3, return with
//  the carry set (and no data copied).

proc    str.substr

    locals  str_substr
    qword   str_substr.saveV0
    qword   str_substr.saveX0X1
    qword   str_substr.saveX2X3
    qword   str_substr.saveX6X7
    byte    str_substr.stkSpace,64  //Not needed
    endl    str_substr

    enter   str_substr.size

    str     q0,     [fp, #str_substr.saveV0]
    stp     x0, x1, [fp, #str_substr.saveX0X1]
    stp     x2, x3, [fp, #str_substr.saveX2X3]
    stp     x6, x7, [fp, #str_substr.saveX6X7]


    // 例外処理
    // Index >= source.len
    // 一般的に要素数とインデックスは1違う
    // 要素数は1からはじまり、インデックスは0から始まる
    // そのためhigher or sameの条件でないといけない
    // どの文字にもマッチしないので空文字で返す処理

    ldr     w6, [x0, #string.len]
    cmp     w1, w6
    bhs     returnEmpty

    // index + substr length > source length
    // なら文字列の末尾にマッチするように長さを減らす

    add     w7, w1, w2      // w7 = index + substr length
    cmp     w6, w7
    csel    w6, w6, w7, ls  // w6 = min(source len, index + substr length)
    sub     w6, w6, w1      // w6 = 実際にコピーする長さ

    // 3. Substr length > destination maxlen
    // コピーできないのでfailとしてエラー終了

    ldr     w7, [x3, #string.maxlen]
    cmp     w6, w7          // Carry set
    bhi     str.sub.exit    // w6 >= w7

    // w6が実際にコピーする長さ。ループカウンタとして使うので保存しておく
    str     w6, [x3, #string.len]

    add     x0, x0, w1, uxtw  // uxtw = 32-bit を符号なし拡張して64bitにする
    b.al    test16

// Neonを使い16バイト未満になるまで16バイトずつコピーする
copy16:
    ldr     q0, [x0], #16
    str     q0, [x3], #16
test16:
    // カウンタを減算してからループなので、ループ抜けるときは負の数になる
    subs    w6, w6, #16
    bhs     copy16  // w6 >=16

    add     w6, w6, #16          // 0 〜 15にする

    // 上位 32bit を 強制的に 0 にする。実質 ゼロ拡張と同じ
    and     x6, x6, #0xFFFFFFFF

    // ジャンプテーブルの先頭アドレスを読み込む
    adr     x7, JmpTbl

    ldr     w6, [x7, x6, lsl #2] // .wordで定義されてるので4バイト単位に直してoffsetを計算
    add     x7, x7, w6, sxtw     // 相対ラベルは 負値も取り得るので符号は維持して拡張
    br      x7

JmpTbl:
    .word   str.sub.success-JmpTbl  //If zero bytes to copy
    .word   _1byteToCopy-JmpTbl
    .word   _2bytesToCopy-JmpTbl
    .word   _3bytesToCopy-JmpTbl
    .word   _4bytesToCopy-JmpTbl
    .word   _5bytesToCopy-JmpTbl
    .word   _6bytesToCopy-JmpTbl
    .word   _7bytesToCopy-JmpTbl
    .word   _8bytesToCopy-JmpTbl
    .word   _9bytesToCopy-JmpTbl
    .word   _10bytesToCopy-JmpTbl
    .word   _11bytesToCopy-JmpTbl
    .word   _12bytesToCopy-JmpTbl
    .word   _13bytesToCopy-JmpTbl
    .word   _14bytesToCopy-JmpTbl
    .word   _15bytesToCopy-JmpTbl

_14bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
_6bytesToCopy:
    ldr     w7, [x0], #4
    str     w7, [x3], #4
_2bytesToCopy:
    ldrh    w7, [x0], #2
    strh    w7, [x3], #2
    b.al    str.sub.success

_13bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
_5bytesToCopy:
    ldr     w7, [x0], #4
    str     w7, [x3], #4
    ldrb    w7, [x0], #1
    strb    w7, [x3], #1
    b.al    str.sub.success

_12bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
_4bytesToCopy:
    ldr     w7, [x0], #4
    str     w7, [x3], #4
    b.al    str.sub.success

_11bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
    ldrh    w7, [x0], #2
    strh    w7, [x3], #2
    ldrb    w7, [x0], #1
    strb    w7, [x3], #1
    b.al    str.sub.success

_10bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
    ldrh    w7, [x0], #2
    strh    w7, [x3], #2
    b.al    str.sub.success

_9bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
    ldrb    w7, [x0], #1
    strb    w7, [x3], #1
    b.al    str.sub.success

_8bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
    b.al    str.sub.success

_15bytesToCopy:
    ldr     x7, [x0], #8
    str     x7, [x3], #8
_7bytesToCopy:
    ldr     w7, [x0], #4
    str     w7, [x3], #4
_3bytesToCopy:
    ldrh    w7, [x0], #2
    strh    w7, [x3], #2
_1byteToCopy:
    ldrb    w7, [x0], #1
    strb    w7, [x3], #1

str.sub.success:
    strb    wzr, [x3]       //Zero-terminating byte
    adds    wzr, wzr, wzr   //Clear carry for success

str.sub.exit:
    ldr     q0,     [fp, #str_substr.saveV0]
    ldp     x0, x1, [fp, #str_substr.saveX0X1]
    ldp     x2, x3, [fp, #str_substr.saveX2X3]
    ldp     x6, x7, [fp, #str_substr.saveX6X7]
    leave

returnEmpty:
    // string構造体の lenを0に設定して終了
    strh    wzr, [x3, #string.len]
    b.al    str.sub.success

endp    str.substr


///////////////////////////////////////////////////////////
//
// testSubstr-
//
//  Utility function to test call to str.substr
//
// On entry:
//  X0, X1, X2, X3 -- str.substr parameters

successStr: wastr   "substr( '%s', %2d, %3d )= '%s'\n"
failureStr: wastr   "substr( '%s', %2d, %3d ) failed\n"

proc    testSubstr

    locals  testSS
    byte    testSS.stkspace, 64
    endl    testSS

    enter   testSS.size

    lea     x5, successStr
    bl      str.substr
    bcc     success
    lea     x5, failureStr

success:
    mov     x4, x3
    mov     x3, x2
    mov     x2, x1
    mov     x1, x0
    mov     x0, x5
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr    x3, [sp, #16]
    mstr    x4, [sp, #24]
    bl      printf
    leave
endp    testSubstr


///////////////////////////////////////////////////////////
//
// Main program to test the code:

proc    asmMain, public

    locals  lcl
    byte    stkSpace, 64
    endl    lcl

    enter   lcl.size      //Reserve space for locals

    lea     x0, fmtStr
    lea     x1, source
    mstr    x1, [sp]
    bl      printf

    lea     x0, source
    mov     x1, #0
    mov     x2, #11
    lea     x3, dest
    bl      testSubstr

    lea     x0, source
    mov     x1, #20
    mov     x2, #15
    lea     x3, dest
    bl      testSubstr

    lea     x0, source
    mov     x1, #20
    mov     x2, #20
    lea     x3, dest
    bl      testSubstr

    lea     x0, source
    mov     x1, #40
    mov     x2, #20
    lea     x3, dest
    bl      testSubstr

    lea     x0, source
    mov     x1, #0
    mov     x2, #100
    lea     x3, smallDest
    bl      testSubstr

AllDone:
    leave
endp    asmMain
