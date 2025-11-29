// Listing 11-2
//
// ./build Listing11-2
//
// A NEON implementation of the dtoStr function

#include    "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 11-2"
fmtStr:     .asciz      "Value(%lx) = string(%s)\n"

.data
.align      3
buffer:     .space      256,0

.code
.extern     printf

// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle

// 0x30 + 10 を A(=0x41) にするための差分を計算しているところ
// いままでの16進数変換で7を引いたりしていたけど、それのトリッキーな計算方法
// '0' = 0x30
// '0' + 10 = 0x3A   (ASCII ':' → nibble 10 を文字にした状態)
// 'A' = 0x41
// 'A' - ( '0' + 10 )
// = 0x41 - 0x3A
// = 0x07
.equ    convert0toA, 'A' - ('0' + 10)    // val+'0' to val+'A'
.equ    invert0ToA,  ~convert0toA & 0xFF // Invert the bits for BIC

// dtoStr
//
// 64bit値を16桁の16進ASCII文字列に NEON で一気に変換する処理
//
// ・NEON の zip / ushr / cmgt / bic を組み合わせた nibble 処理
// ・ASCII 変換用のマスク作成がビット単位のトリック
// ・通常はループでやる処理を 1 回で全部やるように最適化
// ・NEON のレジスタレベルの並び替えが直感に反する
// などが含まれているので、短いコードだけど理解するコストはかなり高い
//
// 全体の流れをざっくり
// 1. 入力の64bit値のバイト順を逆転して、見た目の並びに直す
// 2. High nibble / Low nibble を NEON 上で分離して v0/v1 にする
// 3. zip1 で [H,L,H,L,H,L…] の並びへ interleave
// 4. '0' を足して ASCII 化（0–9 だけ正しくなる）
// 5. >9 のニブルには 'A'-10 の補正を NEON で一気に足す
// 6. 16バイトの ASCII を buffer に書き出す

// Neon用の命令について復習
// 1. ushr（Unsigned Shift Right）
// ushr   vd.<T>, vn.<T>, #imm
//
// 動作
// 論理右シフト（0 を詰める）
// 各要素を「unsigned」として右へシフト
// つまり nibble 抽出に向いてる
//
// よくある使い方
// high nibble を取り出す
// ushr v1.8b, v0.8b, #4
// → バイト 0xAB → 0x0A
//
// float の指数を落とす、マスクを作るときなどにも使う
// 右シフトなので算術シフトではない（符号拡張しない）
//
// 2. bic（Bit Clear）
// bic   vd.<T>, vn.<T>, vm.<T>
// bic   vd.<T>, vn.<T>, #imm
//
// 動作
// vd = vn & (~vm)
// ビットクリア（AND with NOT）
//
// よくある用途
// マスクで nibble を抽出
// bic v0.4h, #0xF0
// → 上位 nibble を 0 にする
// A〜F 補正時の「一部だけ追加する値を残す」処理
// bic v1.8h, #mask
// → 条件が true の部分だけ値を残す
//
// NEON では「条件マスクを作って足す/引く」が鉄板。
//
// 3. zip1（Zip / Interleave）
// zip1  vd.<T>, vn.<T>, vm.<T>
//
// 動作
// vn と vm の 下位半分を、交互に interleave して並べる。
//
// vn = [a0, a1, a2, a3]
// vm = [b0, b1, b2, b3]
//
// zip1 = [a0, b0, a1, b1, a2, b2, a3, b3]
//
// dtoStr での用途
// high nibble → low nibble → high nibble → low nibble
// という並びにする（16文字出力の順番そのまま）
// つまり HEX 表示順を作るための必殺技。
//
// 4. movi（Move Immediate）
// movi  vd.<T>, #imm
//
// 動作
// NEON レジスタの全要素に即値を詰める。
//
// よくある用途
// 比較用しきい値（'9' や 0xF0 など）を入れる
// 0 埋め、FF埋めのマスクを作る
// A〜F 補正のための値を広める
// 例： movi v1.16b, #'9'
//
// 5. cmgt（Compare Greater Than）
// cmgt  vd.<T>, vn.<T>, vm.<T>
//
// 動作
// vn > vm の要素を 全ビット1 (0xFF) にして返す。
// false は 全ビット0 (0x00)。
//
// dtoStr での用途
// HEX ASCII 化のとき：
// '0' + nibble → '0'〜'9' or ':'〜'?'
//
//そこで：
// cmgt v1.16b, v0.16b, #'9'
// → '9' より大きいなら 0xFF、そうでなければ 0x00
//
// つまりA〜F に変換すべき nibble の位置を全部マスクで取得する。
//
// あとはこのマスクに'A' - ('0' + 10)を AND → add するだけで補正できる。

proc    dtoStr
    stp     q0, q1, [sp, #-32]!     // レジスタの退避

    // rev命令。バイトを逆順序に並べる
    // x1レジスタが対象なので64bit内でバイトを入れ替え
    // 0xfedcba9876543210→0x1032547698badcfeということ
    // 16進数表記なので、1桁の値は4bit（nibble）であることに注意。
    // 入れ替えは8bit単位 [ fe | dc | ba | 98 | 76 | 54 | 32 | 10 ]

    rev     x1, x1
    mov     v0.d[0], x1     // v0.d[0] = 下位64bit, v0.d[1] = 上位64bit
    rev     x1, x1

    // 書き方       意味
    // v0.16b   16個の 8bit 要素（0〜15番）として扱う
    // v0.8b    8個の 8bit 要素（0〜7番）として扱う（低レーン）
    //
    // high nibbleの抽出
    // v0.8b = [ 0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE ]
    // ushr #4 をすると：
    // v1.8b = [ 0x01, 0x03, 0x05, 0x07, 0x09, 0x0B, 0x0D, 0x0F ]

    ushr    v1.8b, v0.8b, #4

    // low nibbleの抽出を16bitずつまとめて行なって高速化している
    // v0.b = [ 10, 32, 54, 76, 98, BA, DC, FE ]
    // 16bitレーン (v0.4h) に区切るとこうなる
    // v0.h[0] = 0x3210
    // v0.h[1] = 0x7654
    // v0.h[2] = 0xBA98
    // v0.h[3] = 0xFEDC
    // ここから下位nibbleだけ抽出して
    // v0.h[0] = 0x0200
    // v0.h[1] = 0x0604
    // v0.h[2] = 0x0A08
    // v0.h[3] = 0x0E0C
    // にしたい

    bic     v0.4h, #0xf0
    // imm は 16bit 内ではこう広がる：
    // 00F0
    // ~imm：FF0F
    // 下位バイトの high nibbleだけ消える

    bic     v0.4h, #0xf0, lsl #8

    // 00F0 << 8 = F000
    // ~imm：0FFF
    // 上位バイトの high nibbleだけ消える

    // インターリーブして、HOとLOのデータを結合する
    // v1.b = [01, 03, 05, 07, 09, 0B, 0D, 0F]
    // v0.b = [00, 02, 04, 06, 08, 0A, 0C, 0E]
    // zip1 で interleave → nibble が byte として並ぶ
    // [v1.b0, v0.b0, v1.b1, v0.b1, ... v1.b7, v0.b7]
    // v0 = [ 01,00, 03,02, 05,04, 07,06, 09,08, 0B,0A, 0D,0C, 0F,0E ]
    // 結局ここまでの処理で行ったのはnibble単位のデータをバイト単位に置き直したってこと
    // Neonの最小単位はバイトなのでnibbleごとに操作する命令はない
    zip1    v0.16b, v1.16b, v0.16b

    // ここまでで1バイト*16個のデータに変換できたので、Neonの機能をつかって一括処理をしていく
    orr     v0.8h, #0x30            // low byteのascii文字への変換を一括で
    orr     v0.8h, #0x30, lsl #8    // high byteのascii文字への変換を一括で

    // NEON の制約で：
    // .16b（8bit × 16 要素）には即値が使えない
    // .8h（16bit × 8 要素）には即値が使える
    // というのがあるため8h単位で扱っている

    movi    v1.16b, #'9'            // '9'の1バイト文字*16レーン入ったv1レジスタを用意して
    cmgt    v1.16b, v0.16b, v1.16b  // '9'より大きいデータ（A-Fになるもの）だけを取り出す

    // データの状態
    // v0（ASCII化直後）
    // ['1','0','3','2','5','4','7','6','9','8',';',':', '=', '<','?','>']
    //
    // v1（cmgt後）
    // [ 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, FF, FF, FF, FF, FF, FF ]

    // FF & ~F8 = FF & 07 = 07
    // 16bit拡張
    // FF & ~00F8 = FF & FF07 = FF07
    // 00 & ~F8 = 00
    bic     v1.8h, #invert0ToA
    // →[ 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, FF, 07, FF, 07, FF, 07 ]

    bic     v1.8h, #invert0ToA, lsl #8
    // →[ 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 07, 07, 07, 07, 07, 07 ]

    add     v0.16b, v0.16b, v1.16b      // A~Fになる部分に7を足すことで一括補正

    // これで16進の文字列変換が完了したのであとは保存して返すだけ
    str     q0, [x0]                // バッファに16バイト出力
    strb    wzr, [x0, #16]          // ゼロ終端文字の書きこみ

    ldp     q0, q1, [sp], #32       // レジスタの復元
    ret
endp    dtoStr


// Here is the "asmMain" function.

proc    asmMain, public

    locals  am
    byte    stackspace, 64
    endl    am

    enter   am.size             // Create activation record

    ldr     x1, =0xfedcba9876543210
    lea     x0, buffer

    bl      dtoStr

    mov     x2, x0
    lea     x0, fmtStr
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    bl      printf

    leave
endp    asmMain
