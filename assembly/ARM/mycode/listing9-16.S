// Listing 9-16
//
// 128-bit Hexadecimalを数値に変換する
// Listing9-15とほとんど同じ流れなので詳細解説は省略

#include    "aoaa.inc"

false       =       0
true        =       1
tab         =       9   // tabのASCIIコード

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-16"


// %llx%016llx
//  上位64bitの出力はそのままでいいけど、下位64bitは必ず16桁で出力しないと数値の桁がおかしくなる
//  016は0埋めを有効化して16桁で表示するというオプション
// 例：
//  hi	lo
//   1	2
// 普通に出力する→ダメ
// →12
// ゼロ埋め版
// →10000000000000002
// こうならないとダメだから

fmtStr1:    .asciz      "strtoh128: value=%llx%016llx, String='%s'\n"

hexStr:     .asciz      "1234567890abcdeffedcba0987654321"


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
// strtoh128-
//  文字列データを 128ビットの符号なし整数に変換する。
//
// 入力:
//   x2 - 変換対象となる文字列バッファへのポインタ
//
// 出力:
//   x1:x0 - 変換結果の数値（成功時）、またはエラーコード（失敗時）
//
//   x2 - 16進数文字列の終端の次の文字を指す。
//        エラー時には、x2 の値は元の値に復元される。
//        呼び出し側は、変換成功後に [x2] の文字を調べることで、
//        数値文字列の直後の文字が有効な区切り文字であるかを確認できる。
//
//   C (キャリーフラグ) - エラー発生時にセット、正常に変換できた場合はクリア。
//        エラー時、X0 には以下の値が格納される：
//          0  (最初の文字が不正な場合)
//         -1 = 0xFFFFFFFFFFFFFFFF（オーバーフロー）
//

proc    strtoh128

    stp     x4, x5, [sp, #-16]!
    stp     x2, x3, [sp, #-16]!

    mov     x4, 0xF000000000000000 // bitマスク
    mov     x0, xzr //LO accumulatorを0で初期化
    mov     x1, xzr //HO accumulatorを0で初期化

    mov     x5, 0x5f

    sub     x2, x2, #1
skipWS:
    ldrb    w3, [x2, #1]!
    cmp     w3, #' '
    beq     skipWS
    cmp     w3, #tab
    beq     skipWS

    cmp     w3, #'0'
    blo     badNumber
    cmp     w3, #'9'
    bls     convert
    and     x3, x3, x5
    cmp     w3, #'A'
    blo     badNumber
    cmp     w3, #'F'
    bhi     badNumber
    sub     w3, w3, #7

convert:
    ands    xzr, x4, x1
    bne     overflow

    and     x3, x3, #0xf //Convert to numeric in X3

    // Listing9-15と違う部分は主にここ
    // x1:x0と連結して128bitを表現してる
    lsl     x1, x1, #4              // 上位64bitを左に4bitシフトする
    orr     x1, x1, x0, lsr #60     // 下位64bitレジスタの、はみ出す4bitを合成
    lsl     x0, x0, #4              // 下位64bitを左に4bitシフトする
    add     x0, x0, x3              // 新しい16進1桁を足す


    ldrb    w3, [x2, #1]!
    cmp     w3, #'0'
    blo     endOfNum
    cmp     w3, #'9'
    bls     convert

    and     x3, x3, x5
    cmp     x3, #'A'
    blo     endOfNum
    cmp     x3, #'F'
    bhi     endOfNum
    sub     x3, x3, #7
    b.al    convert

endOfNum:
    ldp     x4, x3, [sp], #16   //X3 holds old X2
    ldp     x4, x5, [sp], #16
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
    ldp     x2, x3, [sp], #16
    ldp     x4, x5, [sp], #16
    ret
endp    strtoh128





/////////////////////////////////////////////////////////////
//
// Here is the "asmMain" function.


proc    asmMain, public

    locals  am
    byte    am.stack, 64
    endl    am

    enter   am.size


    // Test hexadecimal conversion:

    lea     x2, hexStr
    bl      strtoh128

    lea     x3, hexStr
    mov     x2, x0
    lea     x0, fmtStr1
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr    x3, [sp, #16]
    bl      printf

allDone:    leave
endp    asmMain
