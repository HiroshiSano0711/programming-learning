// str.cpy.S
//
// A str.cpy string copy function

#include    "aoaa.inc"
#include    "strings.inc"

.code

///////////////////////////////////////////////////////////
//
// str.cpy:
//
// Copies the data from one string variable to another.
//
// On entry:
//
//  X0- Pointer to source string (string struct variable).
//  X1- Pointer to destination string.
//
// On exit:
//
//  Carry flag clear if no errors, carry is set if
//  the source string will not fit in the destination.

proc    str.cpy, public
    // ABIでは caller-saved レジスタは callee が保存する必要はない。
    // しかしこの書籍の関数は、安全性・汎用性のため、
    // caller-saved であっても関数内で使うレジスタは全て自分で退避・復元している。

    locals  str_cpy
        qword   str_cpy.saveV0
        qword   str_cpy.saveX2X3
        dword   str_cpy.saveX4
        byte    str_cpy.stkSpace,64
    endl    str_cpy

    enter   str_cpy.size

    // レジスタの退避
    str     q0,     [fp, #str_cpy.saveV0]
    stp     x2, x3, [fp, #str_cpy.saveX2X3]
    str     x4,     [fp, #str_cpy.saveX4]

    // コピー元の文字列とコピー先の最大長を比較して超えていないことを確認する
    // ソースがコピー先の長さより大きいとコピーできないから
    ldr     w4, [x0, #string.len]
    ldr     w3, [x1, #string.maxlen]
    cmp     w4, w3
    bhi     str.cpy.done

    // 文字列の長さをコピー
    str     w4, [x1, #string.len]

    // ループのための初期化
    mov     x2, x0
    mov     x3, x1

cpy16:
    // qNレジスタを使って16バイトずつ一気にコピー
    ldr     q0, [x2], #16
    str     q0, [x3], #16

    // W4 >= 16 の間 16 バイトコピーを続ける
    subs    w4, w4, #16
    bhi     cpy16

    // 実際はこの処理がなくても問題ない
    // 残り0バイトで、さらに16バイト読み込んでも
    // 文字列の長さが16バイトだった場合はゼロ終端の1バイトがデータ定義で追加されるので17バイト
    // そこからpaddingが15バイト入って16バイト境界になるのでオーバーランはしない
    // beq を入れるかどうかで性能が変わる可能性がある
    // → 分岐があると branch misprediction のリスク
    // → 分岐がないと 常に ldr/str が走るので命令数が増える可能性
    // だから どちらが速いかはケースによるから試してみないとわからない
    beq     setZByte    // 残りがゼロならスキップ

    // この時点では、0~15バイトが残ってるけど一気に16バイトをまとめてコピー
    // 文字列データを必ず16バイト境界から始めて、必ず16バイト境界で終わるようにパディングされるように設計してる
    // だから16バイト単位の NEON ロード/ストアがいつでも安全に行える。
    // バッファの文字列の先頭ポインタも16バイト境界に調整してるので問題ない。
    // オーバーランすることがないように安全にしてるってこと
    ldr     q0, [x2]
    str     q0, [x3]

setZByte:
    ldr     w4,  [x0, #string.len]
    strb    wzr, [x1, w4, uxtw]

    adds    wzr, wzr, wzr   // 処理が成功したのでキャリーフラグをクリア

str.cpy.done:
    ldr     q0,     [fp, #str_cpy.saveV0]
    ldp     x2, x3, [fp, #str_cpy.saveX2X3]
    ldr     x4,     [fp, #str_cpy.saveX4]
    leave
endp    str.cpy
