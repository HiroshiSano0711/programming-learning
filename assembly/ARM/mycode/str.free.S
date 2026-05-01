// str.free.S
//
// A str.free string memory free function

#include    "aoaa.inc"
#include    "strings.inc"

.code

///////////////////////////////////////////////////////////
//
// str.free:
//
// Allocates storage for an assembly language string
// object that was previously allocated via str.alloc.
//
// On entry:
//
//  W0- Pointer to string object to deallocate.


// str.allocで保存していた構造体のフィールドraw_pointerを渡してfreeを呼ぶだけ
// 後の処理はstr.allocと同じなので説明コメントは省略

proc    str.free, public

    locals  str_free
    dword   str_free.maxlen
    dword   str_free.saveX1

    // NEON（q0〜q15）の保存は 16バイトアライン必須
    // NEON レジスタは 128bit（16バイト）で str q0, [addr] を実行するとき、
    // addr が 16バイト境界でないと未定義動作になる可能性がある（アーキによっては例外 or 大幅スローダウン）
    salign  4

    byte    str_free.vsave, volatile_save.size
    byte    str_free.stkSpace,64
    endl    str_free

    enter   str_free.size

    str     x1, [fp, #str_free.saveX1]
    add     x1, fp, #str_free.vsave

    stp     x2,  x3,  [x1, #16]!
    stp     x4,  x5,  [x1, #16]!
    stp     x6,  x7,  [x1, #16]!
    stp     x8,  x9,  [x1, #16]!
    stp     x10, x11, [x1, #16]!
    stp     x12, x13, [x1, #16]!
    stp     x14, x15, [x1, #16]!

    str     q0,  [x1, #16]!
    str     q1,  [x1, #16]!
    str     q2,  [x1, #16]!
    str     q3,  [x1, #16]!
    str     q4,  [x1, #16]!
    str     q5,  [x1, #16]!
    str     q6,  [x1, #16]!
    str     q7,  [x1, #16]!
    str     q8,  [x1, #16]!
    str     q9,  [x1, #16]!
    str     q10, [x1, #16]!
    str     q11, [x1, #16]!
    str     q12, [x1, #16]!
    str     q13, [x1, #16]!
    str     q14, [x1, #16]!
    str     q15, [x1, #16]!

    ldr     x1, [x0, #string.allocPtr]

    cbz     x1, str.free.done


    // 二重 free を防ぐために free 前に構造体のallocPtrフィールドを NULL にする
    // free(NULL)の実行は何もしない

    str     xzr, [x0, #string.allocPtr]

    mov     x0, x1
    bl      free

str.free.done:
    add     x1, fp, #str_free.vsave
    ldp     x2,  x3,  [x1, #16]!
    ldp     x4,  x5,  [x1, #16]!
    ldp     x6,  x7,  [x1, #16]!
    ldp     x8,  x9,  [x1, #16]!
    ldp     x10, x11, [x1, #16]!
    ldp     x12, x13, [x1, #16]!
    ldp     x14, x15, [x1, #16]!

    ldr     q0,  [x1, #16]!
    ldr     q1,  [x1, #16]!
    ldr     q2,  [x1, #16]!
    ldr     q3,  [x1, #16]!
    ldr     q4,  [x1, #16]!
    ldr     q5,  [x1, #16]!
    ldr     q6,  [x1, #16]!
    ldr     q7,  [x1, #16]!
    ldr     q8,  [x1, #16]!
    ldr     q9,  [x1, #16]!
    ldr     q10, [x1, #16]!
    ldr     q11, [x1, #16]!
    ldr     q12, [x1, #16]!
    ldr     q13, [x1, #16]!
    ldr     q14, [x1, #16]!
    ldr     q15, [x1, #16]!

    ldr     x1, [fp, #str_free.saveX1]
    leave
endp    str.free
