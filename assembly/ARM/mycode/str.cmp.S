// str.cmp.S
//
// A str.cmp string compare function

#include    "aoaa.inc"
#include    "strings.inc"

.code

//////////////////////////////////////////////////////////
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

proc    str.cmp, public

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
