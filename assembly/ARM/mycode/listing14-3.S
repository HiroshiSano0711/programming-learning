// Listing 14-4
// GNU GLibc strcmp function
//
// Copyright (C) 2013 ARM Ltd.
// Copyright (C) 2013 Linaro.
//
// This code is based on glibc cortex strings work originally
// authored by Linaro and re-licensed under GPLv2 for the
// Linux kernel. The original code can be found @
//
// http://bazaar.launchpad.net/~linaro-toolchain-dev/
// cortex-strings/trunk/
//
// files/head:/src/aarch64/
//
// This program is free software; you can redistribute it
// and/or modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software
// Foundation.
//
// This program is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.

#include <linux/linkage.h>
#include <asm/assembler.h>

// compare two strings
//
// Parameters:
// x0 - const string 1 pointer
//    x1 - const string 2 pointer
//
// Returns:
// x0 - an integer less than, equal to, or greater
// than zero if  s1  is  found, respectively, to be less
// than, to match, or be greater than s2.

#define REP8_01 0x0101010101010101
#define REP8_7f 0x7f7f7f7f7f7f7f7f
#define REP8_80 0x8080808080808080

// Parameters and result.

src1        .req    x0
src2        .req    x1
result      .req    x0

// Internal variables.

data1       .req    x2
data1w      .req    w2
data2       .req    x3
data2w      .req    w3
has_nul     .req    x4
diff        .req    x5
syndrome    .req    x6
tmp1        .req    x7
tmp2        .req    x8
tmp3        .req    x9
zeroones    .req    x10
pos         .req    x11

strcmp:
    // src1とsrc2のポインタがそれぞれ8バイト境界かどうかをチェックする
    eor tmp1, src1, src2

    // 後の "NULL検出トリック" のための定数セット
    mov zeroones, #REP8_01

    // XOR演算した結果を下位3bitだけにしぼる
    // 判定結果が0ならsrc1もsrc2も8バイト境界にあるデータということがわかる
    tst tmp1, #7

    // 0でないならsrc1とsrc2が別々のアラインなので遅い処理へ
    b.ne    .Lmisaligned8

    // この時点で、src1 と src2 は「同じアライメント」であることがわかっている
    // src1だけ８バイトアラインかどうかを確認すればいい
    ands    tmp1, src1, #7

    // src1の下位3bitが0でない → src1とsrc2が8バイト境界にない → アライン補正へ
    b.ne    .Lmutual_align

.Lloop_aligned:
    // 8バイト境界にアラインされてるから８バイトを一気に読み込む
    ldr data1, [src1], #8
    ldr data2, [src2], #8
.Lstart_realigned:
    // data1 の各バイトから 0x01 を引く。
    // もし data1 のバイトが 0x00 なら、借りが発生して 0xFF になる。
    // （NULL バイトだけが、subtraction の結果 MSB=1 になる可能性がある）
    sub tmp1, data1, zeroones    // zeroones = 0x0101010101010101


    // 各バイトの MSB を分類するためのビット操作。
    //
    // data1 のバイトが 0x00〜0x7F（ASCII, UTF-8 1バイト文字の範囲）なら：
    //      b | 0x7F = 0x7F   → MSB = 0
    //
    // data1 のバイトが 0x80〜0xFF（UTF-8 続きバイト、Shift-JIS 2バイト目など）なら：
    //      b | 0x7F = 0xFF   → MSB = 1
    //
    // → この処理によって「NULL ではないのに MSB が立っているバイト」を除外できる。
    orr tmp2, data1, #REP8_7f    // REP8_7F = 0x7F7F7F7F7F7F7F7F


    // XOR で data1 と data2 の差分を検出する。
    // どこかのバイトが違えば、そのビット位置が 1 になる。
    eor diff, data1, data2       // Non-zero = mismatch detected


    // NULL 検出トリック：
    // has_nul = tmp1 & ~tmp2
    //
    // tmp1 の MSB=1（＝借り発生）で、かつ tmp2 の MSB=0（＝0x00〜0x7F のバイト）
    // という条件を満たすバイトは **0x00 だけ** になる。
    //
    // 理由：
    //   0x00 → 0x00 - 0x01 = 0xFF   （MSB=1）
    //   tmp2 = 0x00 | 0x7F = 0x7F   （MSB=0）
    //
    // 一方、0x80〜0xFF は orr によって必ず MSB=1 になり除外される。
    //
    // 結果として、「NULL バイトだけが has_nul に残る」
    bic has_nul, tmp1, tmp2

    // 不一致 または NULL があったら 1 が立つ
    // syndrome == 0 なら、
    // 不一致がない（全 8 バイト一致）
    // NULL もない（終端に到達していない）
    // ということなので次の8バイトを読むループに戻る
    // 不一致とNULLを同時に判定してる
    orr syndrome, diff, has_nul
    cbz syndrome, .Lloop_aligned
    b   .Lcal_cmpresult
.Lmutual_align:
    // それぞれのアドレスを8バイト境界に切り捨てしてアラインする
    bic src1, src1, #7
    bic src2, src2, #7

    // tmp1には
    // ands    tmp1, src1, #7
    // の結果が入ってる。
    // 下位3bitの値を抽出していて、8バイト境界から何バイトずれているかを意味する
    // あとでビットマスクを作るために（バイト数）× 8 = 「ビット数」に変換している
    lsl tmp1, tmp1, #3

    // 先頭にゴミを含めたデータの読み込み
    ldr data1, [src1], #8

    // ビット数に変換したのを負の数に
    // 例：3バイトずれてるんだったら
    //  tmp1 = 3*8 = 24
    //  neg 24 → -24
    neg tmp1, tmp1

    // 先頭にゴミを含めたデータの読み込み
    ldr data2, [src2], #8

    // 下位のアドレスにゴミが入ってるのはFFにマスクして不一致やNULL判定に影響がでないようにマスクしたい
    // 0xFFFFFFFFFFFFFFFF を右シフトしてマスクにするのは
    // 任意バイト位置を動的にマスクするための、高速で分岐のないビット生成テクニック
    mov tmp2, #~0       // tmp2 = 0xFFFFFFFFFFFFFFFF

    // s : 下位 s ビットをマスク（1 に書き換え）して、
    //     比較前のゴミ部分を完全に無効化するためのシフト量とする。
    //     （つまり s は「先頭の不要バイトを潰すためのビット数」）
    //
    // 目的：s = 64 - n*8 を作りたい。
    //     n は src のアラインずれバイト数（0〜7）。
    //   例：先頭3バイトがゴミであるなら3*8 = 下位24ビットをマスクしたい
    //     64 - 24 = 40ビット
    //     tmp2 = 0xFFFFFFFFFFFFFFFF
    //     を右に40ビットシフトすれば下位24ビットのゴミの部分だけマスクできる
    //
    // ARM64 の 2 の補数表現を使うと、負数 -x は
    //     2^64 - x
    // としてレジスタに表現される。
    // したがって tmp1 = -(n*8) は
    //     tmp1 = 2^64 - (n*8)
    // となる。
    //
    // ARM64 のシフト量は「レジスタ下位6bit」＝「値 mod 64」で決まる。
    // よって tmp1 のシフト量は：
    //
    //     (2^64 - n*8) mod 64
    //
    // ここで 2^64 mod 64 = 0 なので
    //
    //     s = -(n*8) mod 64
    //
    // mod の性質：
    //     -a mod m = m - (a mod m)
    // を使うと、
    //
    //     (-(n*8)) mod 64 = 64 - ((n*8) mod 64)
    //
    // n*8 は 0〜56 の範囲なので (n*8 mod 64) = n*8。
    // よって：
    //
    //     s = 64 - n*8
    //
    // これは下位 s ビットをマスク（1 を立てる）するための
    // マスク生成シフト量となる。
    //
    // よって tmp1 & 63（下位6bit）は正しい s を与える。

    lsr tmp2, tmp2, tmp1 // Shift (tmp1 & 63)

    // data1,data2は同じアラインなので同じシフト量でマスクすれば良い
    orr data1, data1, tmp2
    orr data2, data2, tmp2
    b   .Lstart_realigned
.Lmisaligned8:
    // src1 と src2 の8バイト境界からのズレが一致していない場合の処理
    // つまり：
    // src1 は 8 バイト境界から 3 バイトずれている
    // src2 は 8 バイト境界から 5 バイトずれている
    // みたいな 不一致のアライン のときに呼ばれる。


    // src1 が 8バイト境界に到達するまでのバイト数 = tmp1 を計算
    and tmp1, src1, #7
    neg tmp1, tmp1
    add tmp1, tmp1, #8

    // src2 が 8バイト境界に到達するまでのバイト数 = tmp2 を計算
    and tmp2, src2, #7
    neg tmp2, tmp2
    add tmp2, tmp2, #8

    // よりズレが大きい方を pos として選ぶ（最大のずれ量）
    subs    tmp3, tmp1, tmp2
    csel    pos, tmp1, tmp2, hi
.Ltinycmp:
    // メモ：コードの意図が理解できなかったので疑問点だけ残しておく
    //
    // この処理はアラインメント不一致状態から比較を開始するための
    // 特殊ロジックと見えるが、以下の点で一貫性が読み取りにくく、
    // 何を意図しているのか明確ではないように思えた
    //
    // 1. なぜ「pos = max(tmp1, tmp2)」だけ進めた時点で
    //    「8バイト比較が開始可能」と判断できるのか不明。
    //    src1 と src2 のアラインメントずれ自体は解消されることはない。
    //
    // 2. tinycmp 中に 1 バイトずつ比較する目的が、
    //    “安全性” の確保なのか “インデックス合わせ” なのか
    //    コードから明確に読み取れない。
    //
    // 3. tinycmp を抜けた直後に add src1/src2, tmp3 を行うが、
    //    これは片方をアラインに揃えるようにも見える一方で、
    //    両方に同じ値を加算しているため、アラインずれ補正には見えない。
    //    片方を合わせても、もう一方が必ずズレるから。
    //
    // 4. 続く負オフセット ldr ([srcX, pos]) によって
    //    どのように比較開始位置を揃えているのかが
    //    レジスタ間の関係から直感的に理解しづらい。
    //
    // 5. tinycmp を抜けた後の 8 バイトロードが
    //    NULL 終端を越えない保証はなく、
    //    本家コメントにある “avoid overrange access” が
    //    どの範囲を指しているのか曖昧。
    //
    // 6. 「アライン補正」「安全化」「インデックス調整」など、
    //    複数の目的が混在して見え、どの命令がどの目的なのか
    //    コード上から一意に判断しにくい。
    //
    // 7. C言語の文字列は「NULL終端で長さ情報がない」仕様のため、
    //    8バイトずつ読み込むのであれば、どれだけ工夫しても
    //      “NULL直後の未定義領域”
    //    を読み越す可能性は本質的に排除できないのではないか。
    //    tinycmp が部分的に安全化しているように見えても、
    //    8バイト単位の比較を行う以上は、
    //    論理上の文字列境界を越えた読み取りが起き得る点は変わらない。
    //    （この仕様上の限界が、処理意図をさらに曖昧にしているように見える）
    //
    // ※ 歴史的な最適化やパッチが混在している可能性が多々あり、
    //    純粋にコードを読むだけでは意図を断定しにくいため、疑問点としてまとめておく。


    ldrb    data1w, [src1], #1
    ldrb    data2w, [src2], #1

    // 最大のズレが0になるまで続ける
    //
    // C = 1 → 借りが発生しなかった（= pos >= 1 の状態だった）
    // C = 0 → 借りが発生した（= pos が 0 だった → pos - 1 で underflow）
    subs    pos, pos, #1

    // pos ≠ 0 の間に「NULL (0) だったら即終了する」ために使われている
    //  pos ≠ 0（NE のとき）だけ、data1w と 1 を比較し、NZCV を更新する
    //  pos = 0（EQ のとき）は比較せず、NZCV に #0（=0000）をセットする
    ccmp    data1w, #1, #0, ne      //NZCV = 0b0000

    // pos がまだ残っている（C=1）なら、data1w と data2w の比較を実行する
    // pos が 0 になった（C=0）なら NZCV を #0 にリセットする
    ccmp    data1w, data2w, #0, cs  //NZCV = 0b0000

    // data1wとdata2wのデータが等しい＝文字が一致なら繰り返す
    b.eq    .Ltinycmp

    // pos = 0だったら以下の2行は実行されなくてフラグはクリアされてる
    //      ccmp data1w, #1, #0, ne //NZCV = 0b0000
    //      ccmp data1w, data2w, #0, cs //NZCV = 0b0000
    // b.eq .LtinycmpはZ=1のときにジャンプだからフラグが0b0000だと実行されない
    // この地点で比較のスタート地点でとめて次の特殊処理へ移る準備が完了したということ
    // また、NULLの場合は
    //      ccmp data1w, #1, #0, ne
    // でCフラグがリセットされるから
    //      ccmp data1w, data2w, #0, cs
    // が実行されなくてフラグはリセットされる
    // そのためNULLでも b.eq .Ltinycmp は実行されない
    // さらに、文字の不一致でもb.eq .Ltinycmpは実行されない
    // 本当うまいこと処理書いてるよね

    // pos = 0 | null | 不一致
    // のどれか
    // pos ≠ 0(nullか不一致の場合)は次に出てくる "1:" のラベルへジャンプして処理を終了する
    cbnz    pos, 1f // compare and branch if not zero

    // ループ最後の1バイトを
    //      ① NULL か
    //      ② 不一致か
    //      ③ 一致してるか
    // を判定して、一致してるなら 8バイト比較フェーズに移動する。
    // そうじゃなければ終了処理へ
    cmp data1w, #1
    ccmp    data1w, data2w, #0, cs
    b.eq    .Lstart_align
1:
    sub result, data1, data2
    ret
.Lstart_align:
    // src1 が8バイト境界にアライン済みかどうかの判定
    ands    xzr, src1, #7

    // アライン済みなら特殊処理なしでそのまま比較処理へ
    b.eq    .Lrecal_offset

    // ここの処理の意図がよくわからなった
    add src1, src1, tmp3
    add src2, src2, tmp3

    // ここからは8バイト読んで一気に判定する処理
    // Lstart_realignedとロジックは同じなので説明は省略
    ldr data1, [src1], #8
    ldr data2, [src2], #8
    sub tmp1, data1, zeroones
    orr tmp2, data1, #REP8_7f
    bic has_nul, tmp1, tmp2
    eor diff, data1, data2
    orr syndrome, diff, has_nul
    cbnz    syndrome, .Lcal_cmpresult

    and tmp3, tmp3, #7
.Lrecal_offset:
    neg pos, tmp3
.Lloopcmp_proc:
    ldr data1, [src1,pos]
    ldr data2, [src2,pos]

    // ここからは8バイトずつループで読んで一気に判定する処理
    // Lstart_realignedとロジックは同じなので説明は省略
    sub tmp1, data1, zeroones
    orr tmp2, data1, #REP8_7f
    bic has_nul, tmp1, tmp2
    eor diff, data1, data2  // Non-zero if differences found
    orr syndrome, diff, has_nul
    cbnz    syndrome, .Lcal_cmpresult

    // ここからは8バイトずつループで読んで一気に判定する処理
    // Lstart_realignedとロジックは同じなので説明は省略
    ldr data1, [src1], #8
    ldr data2, [src2], #8
    sub tmp1, data1, zeroones
    orr tmp2, data1, #REP8_7f
    bic has_nul, tmp1, tmp2
    eor diff, data1, data2  // Non-zero if differences found
    orr syndrome, diff, has_nul
    cbz syndrome, .Lloopcmp_proc
.Lcal_cmpresult:
    // 文字列はバイトオーダーが逆なのでビットを反転させ
    // clzで左ビット（高位ビット）から0の個数をかぞえる
    // 不一致またはNULLの位置が何ビット目にあるかがわかる
    rev syndrome, syndrome
    rev data1, data1
    rev data2, data2

    clz pos, syndrome

    // 不一致またはNULLの位置をMSBにもってくる
    lsl data1, data1, pos
    lsl data2, data2, pos

    // 56bit右シフトすることで、不一致またはNULLの1バイトだけを抽出する
    // 数値として取り出し減算した結果を返り値とする
    lsr data1, data1, #56
    sub result, data1, data2, lsr #56
    ret
