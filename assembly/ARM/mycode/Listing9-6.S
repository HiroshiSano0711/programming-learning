// Listing9-6.S
//
// u64toBuf function

#include    "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-6"
fmtStr1:    .asciz      "Value(%llu) = string(%s)\n"

.align      3
qwordVal:   .dword      0x1234567890abcdef
            .dword      0xfedcba0987654321

.data
buffer:     .space      256,0

.code
.extern     printf

// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle

// u64ToStr
//
//  Converts a 64-bit unsigned integer to a string.
//
//  Inputs:
//      X0:     pointer to buffer to receive string.
//      X1:     unsigned 64-bit integer to convert.
//
//  Outputs:
//      X0:     points at zero-terminating byte.
//      Buffer: receives the zero-terminated string.
//
//  Buffer must have at least 21 bytes allocated for it.
//  This function preserves all registers.

proc    u64ToStr
    stp     x0, x1, [sp, #-16]!
    stp     x2, x3, [sp, #-16]!
    str     lr, [sp, #-16]!

    bl      u64ToBuf

    ldr     lr, [sp], #16
    ldp     x2, x3, [sp], #16
    ldp     x0, x1, [sp], #16
    ret
endp    u64ToStr

// u64ToBuf
//
//  Converts a 64-bit unsigned integer to a string.
//
//  Inputs:
//      X0:     pointer to buffer to receive string.
//      X1:     unsigned 64-bit integer to convert.
//
//  Outputs:
//      X0:     points at zero-terminating byte.
//      Buffer: receives the zero-terminated string.
//
//  Buffer must have at least 21 bytes allocated for it.
//
//  Caller must preserve X0, X1, X2, and X3!


proc    u64ToBuf
    // 渡されたパラメータが0でないかどうかをチェックする。
    // 0ならそのまま'0'を出力する準備をしてそれ以外はu64ToBufRecへジャンプで変換処理
    cmp     x1, xzr
    bne     u64ToBufRec

    // strhは２バイトを書き込む命令。0x0030を書き込むということ。
    // x0のバッファーはスタックではなく.data領域に確保された静的領域であることに注意
    // メモリは下位→高位へ扱う。
    // ARMはリトルエンディアンなので下位アドレスを低位アドレスに書き込む
    // つまり0x0030の30が[x0]、00を[x0+1]の位置に書き込まれる。
    // そしてw1, [x0], #1で書き込んだ後、後置インクリメントで[x0+1]を指すようにしているため
    // 終端文字を指してることになる。
    // この「strh で '0' + NUL を一発で書く」テクニックは、
    // 1命令で終端処理まで完結するのでC文字列出力関数の高速化でよく使われる。

    mov     w1, #'0'
    strh    w1, [x0], #1    // Also emits zero byte
    ret
endp    u64ToBuf

// 再帰処理バージョン
// 再帰で呼ばれた全ての関数は allDone: を帰りがけに通る
// 数字を小さい桁から（逆順）に処理していくが、帰りがけに処理するようになってるので
// 最後に呼ばれたリーフ関数から書き込まれる。

proc    u64ToBufRec
    stp     x2, lr, [sp, #-16]! // Preserve remainder

    // Divide X1 by 10 and save quotient and remainder.

    mov     x2, #10
    udiv    x3, x1, x2      // X3=quotient（商）
    msub    x2, x3, x2, x1  // X2=remainder（余り）


    // Make recursive call if quotient is not zero:

    cmp     x3, xzr
    beq     allDone

    mov     x1, x3               // Set up for call
    bl      u64ToBufRec

allDone:
    orr     w2, w2, #'0'    // Convert to char.
    strh    w2, [x0], #1    // Bump pointer after store.
    ldp     x2, lr, [sp], #16
    ret
endp    u64ToBufRec



// Here is the "asmMain" function.

proc    asmMain, public

    enter   64              // Reserve space on stack

    // AArch64 のレジスタ (x0〜x30) は 64bit ですが、
    // 1命令でロードできる即値は最大16bit です。
    // なので、大きい数値（例えば 0xFFFFFFFFFFFFFFFF）をロードしたい場合、
    // 複数命令で「16bit単位」に分割して入れていきます。
    // movz	Move with Zero	指定した 16bit 値を挿入して、残りは 0埋め	新しい値を作る（初期化）
    // movk	Move with Keep	指定した 16bit 値を挿入して、他のビットは 保持	既存のレジスタに一部上書き
    // movn	Move with Not	指定した 16bit 値の ビット反転値を挿入	movz の NOT バージョン（補数表現などに便利）

    mov     x1, 0xFFFF
    movk    x1, 0xFFFF, lsl #16
    movk    x1, 0xFFFF, lsl #32
    movk    x1, 0xFFFF, lsl #48
    lea     x0, buffer
    bl      u64ToStr

    lea     x2, buffer
    mstr    x2, [sp, #8]
    mov     x1, 0xFFFF
    movk    x1, 0xFFFF, lsl #16
    movk    x1, 0xFFFF, lsl #32
    movk    x1, 0xFFFF, lsl #48
    mstr    x1, [sp]
    lea     x0, fmtStr1
    bl      printf

    leave
    ret
endp    asmMain
