// Listing12-1.S
//
// Demonstrate inserting bit strings into a register.
//

#include    "aoaa.inc"

.text
.pool

ttlStr:     wastr   "Listing 12-1"


// Sample input data for the main program:

Value2Merge:
    .dword  0x12, 0x1e, 0x5555
    .dword  0x1200, 0x120


MergeInto:
    .dword   0xffffffff, 0, 0x12345678
    .dword   0x33333333, 0xf0f0f0f

LenInBits:  .dword  5,     9,    16,    16,   12
szLenInBits =       (.-LenInBits)/8

StartPosn:  .dword  7,     4,     4,    12,   18


// Format strings used to print results:

fmtstr1:    wastr   "merge( %x, "
fmtstr2:    wastr   "%x, "
fmtstr3:    wastr   "%d ) = "
fmtstr4:    wastr   "%x\n"


// getTitle-
//
// Returns a pointer to the program's name in X0:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


// MergeBits( MergeWith, Val2Merge, Start, Length )
// X0: merged result
// ビット配列の中の start〜(start+length–1) の範囲を、指定した値で上書きする
//
// bfiの１命令で同じことができる。
// bfi x0, x1, x2, x3   ; x0 = result
// bit操作の学習用の関数だと思った方が良い。
//
// bfi Rd, Rs, #posn, #len
// これは次を自動でやる：
//  Rs の 下位 len ビット を取り出す
//  それを Rd の posn〜posn+len-1 に挿入
//  その範囲の既存のビットは 上書きされる
//  その他のビットは Rd の既存値のまま

proc    mergeBits

    locals  mb
        qword   mb.x1x2
        qword   mb.x3x4
        byte    mb.stk, 64
    endl    mb

    enter   mb.size

    stp     x1, x2, [fp, #mb.x1x2]
    stp     x3, x4, [fp, #mb.x3x4]

    // 0~n-1ビットに1をいれたマスクを生成する
    // 2^n − 1 で n ビットの 1 マスクが作れる

    mov     x4, #1
    lsl     x4, x4, x3  // x3 = length → x4 = 1 << length。2**nの計算と同じ
    sub     x4, x4, #1  // x4 = (1<<length) - 1 = 111...1 (length 個)。2**n - 1の計算と同じ

    // maskする位置にもってくる

    lsl     x4, x4, x2  // x2 = start → mask << start

    // 対象のビットをマスクする→0にする

    bic     x0, x0, x4  // x0 = x0 & ~mask

    // bitをマージする

    lsl     x1, x1, x2  // start位置を合わせて
    orr     x0, x0, x1  // or演算でマージ

    ldp     x3, x4, [fp, #mb.x3x4]
    ldp     x1, x2, [fp, #mb.x1x2]
    leave
endp    mergeBits



// Here is the "asmMain" function.

proc    asmMain, public

    locals  am
        qword   am.x20x21
        qword   am.x22x23
        dword   am.x24
        byte    am.stk, 256
    endl    am

    enter   am.size
    stp     x20, x21, [fp, #am.x20x21]
    stp     x22, x23, [fp, #am.x22x23]
    str     x24, [fp, #am.x24]

    mov     x20, #szLenInBits - 1

testLoop:
    lea     x1, MergeInto
    ldr     x1, [x1, x20, lsl #3]
    mstr    x1, [sp]
    mov     x21, x1
    lea     x0, fmtstr1
    bl      printf

    lea     x1, Value2Merge
    ldr     x1, [x1, x20, lsl #3]
    mstr    x1, [sp]
    lea     x0, fmtstr2
    mov     x22, x1
    bl      printf

    lea     x1, StartPosn
    ldr     x1, [x1, x20, lsl #3]
    mstr    x1, [sp]
    mov     x23, x1
    lea     x0, fmtstr2
    bl      printf

    lea     x1, LenInBits
    ldr     x1, [x1, x20, lsl #3]
    mstr    x1, [sp]
    mov     x24, x1
    lea     x0, fmtstr3
    bl      printf


    // MergeBits( MergeWith, Val2Merge, Start, Length )

    mov     x0, x21
    mov     x1, x22
    mov     x2, x23
    mov     x3, x24
    bl      mergeBits

    mov     x1, x0
    mstr    x1, [sp]
    lea     x0, fmtstr4
    bl      printf

    // Repeat for each element of the array.

    subs    x20, x20, #1
    bpl     testLoop

allDone:
    ldp     x20, x21, [fp, #am.x20x21]
    ldp     x22, x23, [fp, #am.x22x23]
    ldr     x24, [fp, #am.x24]
    leave
endp    asmMain
