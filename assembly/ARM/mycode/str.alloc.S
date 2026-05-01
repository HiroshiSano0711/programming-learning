// str.alloc.S
//
// A str.alloc string memory alloc function

#include    "aoaa.inc"
#include    "strings.inc"

.code

///////////////////////////////////////////////////////////
//
// str.alloc:
//
// Allocates storage for an assembly language string
// object on the heap (C stdlib malloc heap).
//
// On entry:
//
//  W0- Maximum string length for string object.
//
// On exit:
//
//  X0- Pointer to string object (NULL if error).
//
//  carry clear if successful, set if error.

proc    str.alloc, public

    locals  str_alloc
        dword   str_alloc.maxlen
        dword   str_alloc.saveX1

        // NEON（q0〜q15）の保存は 16バイトアライン必須
        // NEON レジスタは 128bit（16バイト）で str q0, [addr] を実行するとき、
        // addr が 16バイト境界でないと未定義動作になる可能性がある（アーキによっては例外 or 大幅スローダウン）
        salign  4
        byte    str_alloc.vsave, volatile_save.size
        byte    str_alloc.stkSpace, 64
    endl    str_alloc

    enter   str_alloc.size

    str     x1, [fp, #str_alloc.saveX1]

    add     x1, fp, #str_alloc.vsave // x1 = volatile_save.x0x1を指す


    // mallocは、標準ライブラリのコードでありブラックボックス
    // mallocの実装や仕様がかわって書き換えられた場合、どのレジスタを破壊するのかわからない
    // mallocの変更に伴ってこのコードも修正するのは面倒
    // だから全部退避、復元させておけば修正する必要がないし絶対に安全
    // 安全性100％・将来の変更にも強い・修正不要という設計思想
    // この関数は「汎用ライブラリとして使われる」前提の作りなのでARMの標準ABIに完全準拠させる
    // volatile_save.x0x1はx0,x1レジスタを退避させる領域だが今回使わないからプリインクリメントでスキップ

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

    str     w0, [fp, #str_alloc.maxlen]


    // malloc後に構造体内の chars フィールドを16バイト境界に置けるよう、
    // アライン調整で最大15バイト失われても maxlen 分が収まるように、
    // 余裕16バイト＋切り上げ用15バイト = 31 を事前に加算しておく。

    add     x0, x0, #31 + (string.chars - string.allocPtr)
    and     x0, x0, #0xffffffff
    bic     x0, x0, #0xf        // 要求サイズを16バイト境界に切り上げ


    bl      malloc
    cbz     x0, str.alloc.bad


    // 後で free するために保存している
    // free() は malloc が返したポインタそのものを渡さないといけないため

    mov     x1, x0              // mallocの返したraw pointerを保存


    // struct.chars のアドレスを16バイト境界に揃える
    // raw pointer + 構造体ヘッダ分 + アライン調整(15)
    // → 16バイト境界に切り捨てる

    add     x0, x0, #15+(string.chars - string.allocPtr)
    bic     x0, x0, #0xf        // x0 = アライン済みのstruct先頭

    // 構造体の初期化

    str     x1, [x0, #string.allocPtr]
    ldr     w2, [fp, #str_alloc.maxlen]
    str     w2, [x0, #string.maxlen]
    str     wzr, [x0, #string.len]
    strb    wzr, [x0, #string.chars]    //Zero terminator

    adds    xzr, xzr, xzr   // 成功したらフラグをリセットして正常終了通知

str.alloc.bad:
    // レジスタを復元させてret
    // キャリーフラグは成功時だけリセットする仕様なので、正常、例外ともに共通処理でOK

    add     x1, fp, #str_alloc.vsave
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

    ldr     x1, [fp, #str_alloc.saveX1]

    leave
endp    str.alloc
