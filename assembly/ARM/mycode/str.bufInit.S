// str.bufInit.S
//
// A str.bufInit string buffer init function

#include    "aoaa.inc"
#include    "strings.inc"

.code

///////////////////////////////////////////////////////////
//
// str.bufInit:
//
// 生のメモリバッファを「アセンブリ言語用の文字列オブジェクト」
// として使用できるように初期化する。
//
// 【呼び出し時の入力】
//
//   X0 … バッファの先頭アドレス
//   W1 … バッファ全体のサイズ（バイト数）
//
// 【関数からの戻り値】
//
//   X0 … 初期化済みの文字列オブジェクトの先頭アドレス
//   X1 … 文字列として利用できる最大長（maxlen）
//
//   Carryフラグ … 成功でクリア（0）、エラーでセット（1）
//
//   ※ エラーは、バッファが小さすぎて文字列オブジェクト
//     （ヘッダ + 文字列領域）を割り当てられない場合など。
//
///////////////////////////////////////////////////////////

proc    str.bufInit, public

    locals  str_bufInit_l
        dword   str_bufInit_l.saveX2
        byte    str_bufInit_l.stkSpace, 64
    endl    str_bufInit_l

    enter   str_bufInit_l.size
    str     x2, [fp, #str_bufInit_l.saveX2]

    // w1が引数で渡されるんだからw1を使えばこの処理は不要なんだけど
    // 下位32bitだけを使うという意図を明確にするってことで書かれてると思われる

    and     x1, x1, #0xFFFFFFFF

    // ポインターのアドレスを16バイト境界にアラインする。
    // 15を足して下位4bitを切り捨て

    add     x2, x0, #15
    bic     x2, x2, #0xf

    // chars の開始位置（構造体オフセット 0）へポインタ x2 を合わせるための補正。
    // string.allocPtr = -16, string.chars = 0 なので
    // string.chars - string.allocPtr = 16
    // これにより x2 は次のメモリ構造の chars を指す：
    // ... padding ... (0〜15 バイト)
    // +-------------------------------+
    // | allocPtr |   (x2 - 16)       |  ← offset -16
    // +-------------------------------+
    // | maxlen   |   (x2 - 8)        |  ← offset -8
    // +-------------------------------+
    // | len      |   (x2 - 4)        |  ← offset -4
    // +-------------------------------+
    // | chars    |   (x2)            |  ← offset 0  (ここを x2 が指す)
    // +-------------------------------+
    // | chars+1  |   (x2 + 1)        |
    // | chars+2  |   (x2 + 2)        |
    // |    ...                           （maxlen バイト分）
    //
    // 以後：
    //   [x2]         → chars の文字列の先頭
    //   [x2, #-4]    → len
    //   [x2, #-8]    → maxlen
    //   [x2, #-16]   → allocPtr
    //
    // という形で構造体定義どおりにアクセスできるようにする。

    add     x2, x2, #string.chars - string.allocPtr

    // x2 = アライン後の string.chars の実際の開始アドレス
    // x0 = 元のバッファ先頭アドレス
    //
    // x0 = x2 - x0 で、
    //   • アラインまでの padding 分
    //   • + ヘッダ 16バイト
    // の合計「使用不可領域」を算出する
    //
    // 例：buffer=58 バイト、アドレス 0x1003 の場合
    //   アライン後の string.chars = 0x1020
    //   padding + header = 0x1020 - 0x1003 = 29
    //
    // subs x1, x1, x0 で
    //   58 - 29 = 29 （文字列データに使えるバイト数）
    // これが負なら、ヘッダすら置けないのでエラー
    //
    // Neonを使って処理をするから16バイト境界に揃える
    // mallocが返してくるアドレスは16バイト境界を保証しないため

    sub     x0, x2, x0
    subs    x1, x1, x0
    bmi     str.bufInit.bad

    // maxlenを16バイト境界にする
    // 理由
    // ① Neon が 16 バイト単位なので高速化。1回のロードで 16 バイト読める
    // ② 末尾処理が不要になりコードが単純化。残り 1〜15 バイト処理が消える
    // ③ 構造体全体の整合性を保てる。chars が常に 16 バイト境界
    // ④ malloc のアライン保証が無いので自前で統一する。16 バイト境界の確保を構造体側で強制

    bic     x1, x1, #0xf

    // maxlenがゼロならエラーにする
    // 16 バイト未満しか残っていないっていうこと

    cbz     x1, str.bufInit.bad

    // string structのフィールドを初期化する
    // strb    wzr, [x2, #string.chars]
    // について。
    // これはNULL文字をいれてるとみなせるけど
    // null終端を使う設計ではなくても
    //  デバッグのしやすさ
    //  ユーティリティ関数との互換性
    //  不正な文字列読み出しを避ける安全性
    // のために「空文字列の開始はゼロ」がよく使われる。
    // 理由1：空文字のときに「バッファの中身が未定義」だと危険
    // 空文字（len = 0）のときに chars[0] に何が入っているかわからないと…
    // このバッファに文字を書き込むびにstring.lenを計算するんだろうけど
    // その場合に0文字（空文字）ってどうやって判定するの？って話になるから
    // NULL文字を使わない方針だけど、それはゼロ終端文字として使わないという話
    // strlenで線形探査しなくちゃいけないから遅いよねって話であって
    // 空文字判定にNULL=0を入れておくことは高速に判定できて良いと考えられる

    str     xzr, [x2, #string.allocPtr] //NULL
    str     w1,  [x2, #string.maxlen]
    str     wzr, [x2, #string.len]      // 0: empty str
    strb    wzr, [x2, #string.chars]    // 0: Zero byte

    // 返り値の設定。文字列の先頭ポインタを返す
    mov     x0, x2

    ldr     x2, [fp, #str_bufInit_l.saveX2]
    adds    xzr, x1, #0     //Clear the carry flag
    leave

// キャリーフラグを立ててエラーをして返す
// エラーがある場合はキャリーフラグを立てることで呼び出し元に知らせる仕様

str.bufInit.bad:
    ldr     x2, [fp, #str_bufInit_l.saveX2]
    cmp     x2, #0
    leave
endp    str.bufInit
