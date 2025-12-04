// Listing 14-4
//
// A str.cmp string comparison function.

#include    "aoaa.inc"


// Assembly language string data structure:

struct  string, -16
    dword   string.allocPtr // at offset -16
    word    string.maxlen   // at offset -8
    word    string.len      // at offset -4
    byte    string.chars    // at offset 0
ends    string


// str.buf:
//
// Allocate storage for an empty string
// with the specified maximum size:

.macro  str.buf strName, maxSize
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   \maxSize
    .word   0
    \strName:   .space  ((\maxSize+16) & 0xFFFFFFF0), 0
.endm


// str.literal:
//
// Allocate storage for a string buffer and initialize
// it with a string literal:

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
str.buf     destination, 256
str.literal left,   "some string"
str.literal right1, "some string"
str.literal right2, "some string."
str.literal right3, "some strin"
str.literal right4, ""
str.literal right5, "t"
str.literal right6, " "

str.literal left2,  "some string 16.."
str.literal right7, "some string 16.."
str.literal right8, "some string 16."
str.literal right9, "some string 16..."



.code

ttlStr:     wastr  "Listing14-4"

// Standard getTitle function.
// Returns pointer to program name in X0

proc    getTitle, public
    lea    x0, ttlStr
    ret
endp    getTitle


///////////////////////////////////////////////////////////
//
// str.cmp:
//
// Compares two string objects.
//
// On entry:
//
//  X0- Pointer to left string.
//  X1- Pointer to right string.
//
//      left op right
//
//  where op is the string comparison operation
//
// On exit:
//
//  Condition code flags contain state of comparison.

proc    str.cmp

    locals  str_cmp
        qword   str_cmp.saveX2X3
        dword   str_cmp.saveX4X5
        dword   str_cmp.saveX6X7
        byte    str_cmp.stkSpace,64
    endl    str_cmp

    enter   str_cmp.size

    // Preserve X2...X5:

    stp     x2, x3, [fp, #str_cmp.saveX2X3]
    stp     x4, x5, [fp, #str_cmp.saveX4X5]
    stp     x6, x7, [fp, #str_cmp.saveX6X7]

    mov     x2, x0  // Preserve X0 and X1
    mov     x3, x1

    ldr     w6, [x2, #string.len]
    ldr     w7, [x3, #string.len]

    // 文字列の長さが短い方を計算する
    cmp     w6, w7
    csel    w6, w6, w7, hs

    b.al    cmpLen
cmp8:
    ldr     x4, [x2], #8
    ldr     x5, [x3], #8

    // 文字列のバイトオーダーは逆順なのでrevを行わないと、文字列の後ろから比較しているのと同じになる
    // 大小関係が逆転してしまい返り値の意味が逆になってしまう
    rev     x4, x4
    rev     x5, x5
    cmp     x4, x5
    bne     str.cmp.done
cmpLen:
    subs    w6, w6, #8
    bhs     cmp8    // w6 >= 8

    // substract-first方式のループ
    // bhsでジャンプする条件は w6 = 8 も含まれる（残りがぴったり8文字）
    // そのとき、subsの結果は w6 = 0 になって最後のループ入るので
    // ループをぬけたときは
    //    w6 = -8
    // になってることを考慮する
    adds    w6, w6, #8
    beq     str.cmp.done	// -8 + 8 = 0 : Z = 1になるのでジャンプ

cmp1:
    // 8バイト未満の文字列を1バイトずつ処理する
    ldrb    w4, [x2], #1
    ldrb    w5, [x3], #1
    cmp     w4, w5
    bne     str.cmp.done
    subs    w6, w6, #1
    bne     cmp1

cmpLens:
    // cmpLens に来る条件は
    //      短い方の文字数分はすべて一致した
    // というとき。
    // 8バイト比較 → 全部一致
    // 残り 0〜7 バイト比較 → 全部一致
    // 途中で bne（不一致）で抜けなかった
    // ということ
    // そのため、あとは文字数を比較するだけで返り値とできる
    ldr     w6, [x0, #string.len]
    cmp     w6, w7

str.cmp.done:
    ldp     x2, x3, [fp, #str_cmp.saveX2X3]
    ldp     x4, x5, [fp, #str_cmp.saveX4X5]
    ldp     x6, x7, [fp, #str_cmp.saveX6X7]
    leave
endp    str.cmp


///////////////////////////////////////////////////////////
//
// Some read-only strings:

ltFmtStr:   wastr   "Left ('%s') is less than right ('%s')\n"
gtFmtStr:   wastr   "Left ('%s') is greater than right ('%s')\n"
eqFmtStr:   wastr   "Left ('%s') is equal to right ('%s')\n"


///////////////////////////////////////////////////////////
//
// prtResult-
//
//  Utility function to print the result of a string
// comparison.

proc    prtResult

    mov     x2, x1
    mov     x1, x0
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    beq     strsEQ
    bhi     strGT

            // Must be LT at this point

    lea     x0, ltFmtStr
    b       printf

strsEQ:
    lea     x0, eqFmtStr
    b       printf

strGT:
    lea     x0, gtFmtStr
    b       printf

endp    prtResult


///////////////////////////////////////////////////////////
//
// Main program to test the code:

// 順番にも文字列を読み込んでテストしてるだけだから解説は省略でいいかな
proc    asmMain, public

    locals  lcl
    byte    stkSpace, 64
    endl    lcl

    enter   lcl.size      //Reserve space for locals

    lea     x0, left
    lea     x1, right1
    bl      str.cmp
    bl      prtResult

    lea     x0, left
    lea     x1, right2
    bl      str.cmp
    bl      prtResult

    lea     x0, left
    lea     x1, right3
    bl      str.cmp
    bl      prtResult

    lea     x0, left
    lea     x1, right4
    bl      str.cmp
    bl      prtResult

    lea     x0, left
    lea     x1, right5
    bl      str.cmp
    bl      prtResult

    lea     x0, left
    lea     x1, right6
    bl      str.cmp
    bl      prtResult

    lea     x0, left2
    lea     x1, right7
    bl      str.cmp
    bl      prtResult

    lea     x0, left2
    lea     x1, right8
    bl      str.cmp
    bl      prtResult

    lea     x0, left2
    lea     x1, right9
    bl      str.cmp
    bl      prtResult


AllDone:    leave
endp    asmMain
