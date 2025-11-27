// Listing 9-15
//
// Hexadecimal string to numeric conversion

#include    "aoaa.inc"

false       =       0
true        =       1
tab         =       9

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-15"
fmtStr1:    .ascii      "strtoh: String='%s' "
            .asciz      "value=%llx\n"

fmtStr2:    .asciz      "Error, str='%s', x0=%lld\n"

fmtStr3:    .ascii      "Error, expected overflow: x0=%llx, "
            .asciz      "str='%s', error code=%ld\n"

fmtStr4:    .ascii      "Error, expected bad char: x0=%llx, "
            .asciz      "str='%s', error code=%ld\n"

hexStr:     .asciz      "1234567890abcdef"
hexStrOVFL: .asciz      "1234567890abcdef0"
hexStrBAD:  .asciz      "x123"


.code
.extern     printf

/////////////////////////////////////////////////////////////
//
// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


/////////////////////////////////////////////////////////////
//
// strtoh-
//  文字列データを 64 ビットの符号なし整数に変換する。
//
// 入力:
//   x1 - 変換対象の文字列が格納されているバッファへのポインタ
//
// 出力:
//   x0 - 変換成功時は変換された数値、
//        エラー時はエラーコードが入る。
//
//   x1 - 16進数文字列の末尾の次の文字を指す。
//        エラー発生時は、x1 の値は元の値に復元される。
//        呼び出し側は、変換成功時に [x1] の文字を調べることで、
//        数値の直後の文字が正しい区切り文字かどうかを確認できる。
//
//   C フラグ (キャリーフラグ)
//        エラー発生時にセットされ、変換成功時はクリアされる。
//        エラー時、x0 には以下の値が入る：
//          0  : 不正な先頭文字
//         -1  : 0xffffffffffffffff（オーバーフロー）
//

proc    strtoh

    // 処理の流れはListing9-14とだいたい同じ
    // 16進数だと
    //  乗算部分
    //  有効文字の範囲
    //  文字→数値の変換
    //  オーバーフロー判定の違い
    // が少し変わるだけ

    stp     x3, x4, [sp, #-16]!
    stp     x1, x2, [sp, #-16]!


    // This code will use the value in x3 to test
    // and see if overflow will occur in x0 when
    // shifting to the left 4 bits:

    mov     x3, 0xF000000000000000
    mov     x0, xzr //Zero out accumulator

    // 0x5f is used to convert lowercase to
    // upper case:

    mov     x4, 0x5f

    sub     x1, x1, #1  //Because of inc below
skipWS:
    ldrb    w2, [x1, #1]!
    cmp     w2, #' '
    beq     skipWS
    cmp     w2, #tab
    beq     skipWS

    cmp     w2, #'0'
    blo     badNumber
    cmp     w2, #'9'
    bls     convert

    // ASCIIの英字
    // 大文字
    //  'A' = 0x41 = 0100 0001
    //  'Z' = 0x5A = 0101 1010
    // 小文字
    //  'a' = 0x61 = 0110 0001
    //  'z' = 0x7A = 0111 1010
    //
    // 差はこのビット：
    //  bit5が立っているかどうか
    // 0x20 = 0010 0000   (bit5)
    // x4 = 0x5f = 0101 1111によってbit5だけ0にして大文字に変換してる

    and     x2, x2, x4
    cmp     w2, #'A'
    blo     badNumber
    cmp     w2, #'F'
    bhi     badNumber
    sub     w2, w2, #7 // A~Fに関しては7を引いたら数値に変換できた。はじめの方の章でやったこと

convert:
    // 上位4ビットが「全て0」ならOK
    // 1ビットでも立っていたらオーバーフロー
    // 16倍するから4ビット単位でシフトするため

    ands    xzr, x3, x0
    bne     overflow

    and     x2, x2, #0xf    // 数値に変換


    // 16進数だから左に4つシフトすれば16倍になる。

    lsl     x0, x0, #4
    add     x0, x0, x2

    // 次の文字へ。この辺りの処理はListing9-14と同じ
    ldrb    w2, [x1, #1]!

    // 0~9の判定
    cmp     w2, #'0'
    blo     endOfNum
    cmp     w2, #'9'
    bls     convert

    // A~Fの判定
    and     x2, x2, x4  // 大文字に変換
    cmp     x2, #'A'
    blo     endOfNum
    cmp     x2, #'F'
    bhi     endOfNum
    sub     x2, x2, #7 // 10~15の数値に変換
    b.al    convert

endOfNum:
    // スタックの中身
    // (sp + 24)  : x4
    // (sp + 16)  : x3
    // (sp + 8)   : x2
    // (sp)       : x1（元の文字列ポインタ）

    //成功時は、x1の値は数字列の終端位置のまま返したいのでX3に読み捨て
    ldp     x3, x2, [sp], #16   // x1 → x3, x2 → x2
    ldp     x3, x4, [sp], #16
    msr     nzcv, xzr   //clr c = No error
    ret

badNumber:
    mov     x0, xzr
    b.al    errorExit

overflow:
    mov     x0, #-1  //Return -1 as error on overflow
errorExit:
    mrs     x1, nzcv    //Return error in carry flag
    orr     x1, x1, #(1 << 29)
    msr     nzcv, x1    // set c=error

    ldp     x1, x2, [sp], #16
    ldp     x3, x4, [sp], #16
    ret
endp    strtoh





/////////////////////////////////////////////////////////////
//
// Here is the "asmMain" function.


proc    asmMain, public

    locals  am
    byte    am.stack, 64
    endl    am

    enter   am.size


    // Test hexadecimal conversion:

    lea     x1, hexStr
    bl      strtoh
    bcs     error

    mov     x2, x0
    lea     x1, hexStr
    lea     x0, fmtStr1
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    // Test overflow conversion:

    lea     x1, hexStrOVFL
    bl      strtoh
    bcc     unexpected

    mov     x2, x0
    lea     x0, fmtStr2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    // Test bad character:

    lea     x1, hexStrBAD
    bl      strtoh
    bcc     unexp2

    mov     x2, x0
    lea     x0, fmtStr2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    b.al    allDone

unexpected:
    mov     x3, x0
    lea     x0, fmtStr3
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr	x3, [sp, #16]
    bl      printf
    b.al    allDone

unexp2:
    mov     x3, x0
    lea     x0, fmtStr4
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr	x3, [sp, #16]
    bl      printf
    b.al    allDone

error:
    mov     x2, x0
    lea     x0, fmtStr2
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

allDone:    leave
endp    asmMain
