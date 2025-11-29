// Listing11-1.S
//
// Demonstrate a simple Bitonic sort
// of 8 elements using vector instructions.

#include    "aoaa.inc"
.text

.pool
ttlStr: wastr  "Listing 11-1"


// printfのフォーマット文字列:

fmtPV:  wastr   " %08lx %08lx %08lx %08lx"
nl:     wastr   "\n"


// ソート用のサンプルデータ
// 4バイト(32bit)*8個の符合なし整数

qval1:  .word   8, 7, 6, 4
qval2:  .word   3, 2, 1, 0

// tbl命令のためのLookupテーブル
// tblはバイト単位で動作するので、32bitの整数をあてるなら4バイトを1つのブロックとしてマッピングする

_a = 0x03020100
_b = 0x07060504
_c = 0x0b0a0908
_d = 0x0f0e0d0c
_e = 0x13121110
_f = 0x17161514
_g = 0x1b1a1918
_h = 0x1f1e1d1c

_e1 = 0x03020100
_f1 = 0x07060504
_g1 = 0x0b0a0908
_h1 = 0x0f0e0d0c

// 比較ネットワークを距離を半分にしていきならが比較、入れ替えを行うアルゴリズム→バイトニックソート
// lut1～10 は、bitonic merge の距離4→2→1 の比較順を再現するためのシャッフルテーブル(要素が8個の場合)
// 簡単にいうと、半分で比較をしていけば、それぞれ左半分は右半分より小さいのが集まる、右半分は大きいのが集まる
// それを距離を縮めて繰り返していけばソートできるという理論
// 数学的に証明されているが、証明までやると本題から外れるので割愛。
// 概要だけ知っていればいい。

// 距離4 のステージ
lut1:   .word   _f1, _e1, _h1, _g1
lut2:   .word   _a, _f, _c, _h
lut3:   .word   _b, _e, _d, _g

// 距離2 のステージ
lut4:   .word   _h1, _g1, _f1, _e1
lut5:   .word   _a, _b, _g, _h
lut6:   .word   _c, _d, _f, _e

// 距離1 のステージ
lut7:   .word   _a, _e, _b, _f
lut8:   .word   _c, _g, _d, _h
lut9:   .word   _a, _e, _b, _f
lut10:  .word   _c, _g, _d, _h


proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


proc    printV

    locals  p
        qword   p.v0
        qword   p.v1
        qword   p.v2
        qword   p.v3
        qword   p.v4
        byte    p.stk, 64
    endl    p

    enter   p.size

    str     q0, [fp, #p.v0]
    str     q1, [fp, #p.v1]
    str     q2, [fp, #p.v2]
    str     q3, [fp, #p.v3]
    str     q4, [fp, #p.v4]

    ldr		w1, [fp, #16]
    ldr		w2, [fp, #20]
    ldr		w3, [fp, #24]
    ldr		w4, [fp, #28]
    lea     x0, fmtPV
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr    x3, [sp, #16]
    mstr    x4, [sp, #24]
    bl      printf


    ldr		w1, [fp, #32]
    ldr		w2, [fp, #36]
    ldr		w3, [fp, #40]
    ldr		w4, [fp, #44]
    lea     x0, fmtPV
    mstr    x1, [sp]
    mstr    x2, [sp, #8]
    mstr    x3, [sp, #16]
    mstr    x4, [sp, #24]
    bl      printf


    lea     x0, nl
    bl      printf


    ldr     q0, [fp, #p.v0]
    ldr     q1, [fp, #p.v1]
    ldr     q2, [fp, #p.v2]
    ldr     q3, [fp, #p.v3]
    ldr     q4, [fp, #p.v4]
    leave
endp    printV

// Here's the main program.

proc    asmMain, public

    locals  am
        byte    am.stk, 64
    endl    am

    enter   am.size

    // v0とq0は同じ128itだが、v0レジスターは型のない総称を示す。
    // 128bitにデータを読み込む場合は型を指定したqNレジスターがを指定する必要がある
    ldr     q0, qval1
    ldr     q1, qval2

    // この時点でのレジスタの状態。SIMD視点
    // v0 = [ 8, 7, 6, 4 ]
    // v1 = [ 3, 2, 1, 0 ]

    // 8個の要素をBitnicソートする
    //
    // 構造を示す擬似コード
    // for (k = 2; k <= n; k *= 2) {        // ← ①
    //     for (j = k/2; j > 0; j /= 2) {   // ← ②
    //         for (i = 0; i < n; i++) {    // ← ③
    //             compare_and_swap(i, i^j);
    //         }
    //     }
    // }
    //
    // ループ	回数
    //  k のループ (①)	log n 回
    //  j のループ (②)	log n 回
    //  i のループ (③)	n 回
    // n×logn×logn=nlog2n
    // → O(n log² n)
    //
    // 普通に CPU上の単体コアでやると：
    //  バイトニックソートは遅い部類
    //  QuickSort などの方が圧倒的に速い。O(n log n)だから
    //
    // では、なぜBitnicSortを使うのか？
    // 1. 分岐ゼロ
    //  動きが完全固定：
    //  比較① → 比較② → 比較③ → …
    //  if 文なし、データ依存分岐なし。
    //  → SIMD や GPU で超重要。
    //
    // 2. 並列性が異常に高い
    //  普通のソート：
    //      1 個ずつ比較 → 分岐 → メモリ移動(値を入れ替え)
    //  バイトニック：
    //      複数ペアを同時比較
    //      複数ペアを同時交換
    //  これが GPUでは爆速になる。
    // 3. GPU では「事実上 O(log² n) に近い時間」に見える
    // GPU だと：
    //  1段を数千スレッドで同時実行できるので「段数」だけが時間になる
    // つまり実測時間は、ステージ数 ≒ log² n になるので、実運用では速くなる
    //
    // SIMD や GPU の世界では、Bitonic sort は理論上最速ではないけど、
    // 並列実行にかなり向いているテクニック
    // Bitonic sort は逐次アルゴリズムより理論オーダーは悪いが、
    // SIMD / GPU 環境では分岐の無さと固定パターンの強みで高速になるため、
    // 並列アルゴリズムの代表例として覚えておく価値がある
    // 並列アルゴリズムの引き出しの1つとして覚えておく
    // CPU と GPU の「速さ」の意味は違う
    // CPUとGPUではパフォーマンスの評価軸が違うということを頭に入れておく。
    // CPU の最適化軸
    //  レイテンシ重視（1つの処理をどれだけ速く終わらせるか）
    //  分岐予測が超重要
    //  キャッシュヒット率が超重要
    //  OoO実行（順不同実行）で命令を並び替えて短縮
    //
    // GPU / SIMD の最適化軸
    //  スループット重視（どれだけ多くのデータを同時にさばけるか）
    //  分岐はほぼ「敵」
    //  同じ命令を同時大量に実行できることが最重要
    //  メモリアクセスの“揃い方”（coalescing）が超重要

    // Step 1:

    // 各レーンの最小値を求める
    umin    v2.4s, v0.4s, v1.4s

    //  各レーンを独立に比較：
    //  lane0: min(8,3) = 3
    //  lane1: min(7,2) = 2
    //  lane2: min(6,1) = 1
    //  lane3: min(4,0) = 0
    //  → v2 = [ 3, 2, 1, 0 ]


    // 各レーンの最大値を求める
    umax    v3.4s, v0.4s, v1.4s

    // lane0: max(8,3) = 8
    // lane1: max(7,2) = 7
    // lane2: max(6,1) = 6
    // lane3: max(4,0) = 4
    // → v3 = [ 8, 7, 6, 4 ]


    // これで半分が小さい群、もう半分が大きい群でわけることができた
    // 半分ソートできたようなもの

    // Step 2:

    ldr     q4, lut1

    // tbl命令の動作が非常にわかりづらかったのでメモ。
    // v4.16b =
    //  [04 05 06 07 | 00 01 02 03 | 0c 0d 0e 0f | 08 09 0a 0b]
    //   ^^^^^^^^^^   ^^^^^^^^^^    ^^^^^^^^^^    ^^^^^^^^^^
    //     _f1            _e1          _h1            _g1
    // （※バイト並びの順序はリトルエンディアンであることに注意）
    // 10進数に変換すると
    // [4,5,6,7, 0,1,2,3, 12,13,14,15, 8,9,10,11]
    // lutN:の各テーブルは4バイト単位で作成されているので、qvalの各要素をそれぞれインデックスで指定できる
    // tbl命令はバイト単位でないと操作できないためこのような構成になってる
    // new_v3[i] = old_v3[ index[i] ]
    //
    // 出力byte位置	index	元のv3[index]
    // 0        	4	    07
    // 1        	5	    00
    // 2        	6   	00
    // 3        	7   	00
    // 4	        0	    08
    // 5	        1	    00
    // ...
    // 15           11      00
    // 結果
    //  [07 00 00 00 | 08 00 00 00 | 04 00 00 00 | 06 00 00 00]
    // がv3に格納される→ v3.4s = [ 7, 8, 4, 6 ]
    // v3 = [8,7,6,4] → [7,8,4,6]

    tbl     v3.16b, {v3.16b}, v4.16b

    umin    v0.4s, v2.4s, v3.4s
    umax    v1.4s, v2.4s, v3.4s

    ldr     q4, lut2            // lut2:   .word   _a, _f, _c, _h
    // lut2: .word _a, _f, _c, _h
    // lut3: .word _b, _e, _d, _g
    // 何をやってるのかわかりづらいので、lut2,lut3の中身を可視化
    // {v0.16b, v1.16b}はレジスタを結合して32バイトの配列として扱う命令式
    // _a   0x03020100  v0[0]（値=3）
    // _b   0x07060504  v0[1]（値=2）
    // _c   0x0b0a0908  v0[2]（値=1）
    // _d   0x0f0e0d0c  v0[3]（値=0）
    // _e   0x13121110  v1[0]（値=7）
    // _f   0x17161514  v1[1]（値=8）
    // _g   0x1b1a1918  v1[2]（値=4）
    // _h   0x1f1e1d1c  v1[3]（値=6）
    // 出力がv2.16bで16バイトなので、32バイトの中から16個のデータを抽出する動作になる

    tbl     v2.16b, {v0.16b, v1.16b}, v4.16b

    // lut2は _a, _f, _c, _h なので
    // v0[0]（値=3）
    // v1[1]（値=8）
    // v0[2]（値=1）
    // v1[3]（値=6）

    ldr     q4, lut3
    tbl     v3.16b, {v0.16b, v1.16b}, v4.16b

    // lut3は _b, _e, _d, _g なので
    // v0[1]（値=2）
    // v1[0]（値=7）
    // v0[3]（値=0）
    // v1[2]（値=4）
    //
    // 結果
    // v2 = [3, 8, 1, 6]
    // v3 = [2, 7, 0, 4]

    // Step 3:

    umin    v0.4s, v2.4s, v3.4s
    umax    v1.4s, v2.4s, v3.4s


    // ここまでで、tbl命令が何をやっているのかわかったので、あとは結果だけを示す
    // Step 4:

    ldr     q4, lut4            // lut4 = [ _h1, _g1, _f1, _e1 ]  逆順にする
    tbl     v1.16b, {v1.16b}, v4.16b
    // v1 = [3, 8, 1, 6]→ v1 = [6,1,8,3]

    // v0 = [2, 7, 0, 4]
    // v1 = [6, 1, 8, 3]

    umin    v2.4s, v0.4s, v1.4s
    // [min(2,6), min(7,1), min(0,8), min(4,3)]
    // v2 = [2, 1, 0, 3]

    umax    v3.4s, v0.4s, v1.4s
    // [max(2,6), max(7,1), max(0,8), max(4,3)]
    // v3 = [6, 7, 8, 4]

    ldr     q4, lut5    // lut5 = [ _a, _b, _g, _h ]
    tbl     v0.16b, {v2.16b, v3.16b}, v4.16b
    // v0 = [ v2[0], v2[1], v3[2], v3[3] ]
    // v0 = [ 2, 1, 8, 4 ]

    ldr     q4, lut6    // lut6 = [ _c, _d, _f, _e ]
    tbl     v1.16b, {v2.16b, v3.16b}, v4.16b
    // v1 = [ v2[2], v2[3], v3[1], v3[0] ]
    // v1 = [ 0, 3, 7, 6 ]

    // parewise min 隣同士で比較して最小
    uminp   v2.4s, v0.4s, v1.4s
    // v2[0] = min(2,1) = 1
    // v2[1] = min(8,4) = 4
    // v2[2] = min(0,3) = 0
    // v2[3] = min(7,6) = 6
    // → v2 = [1,4,0,6]

    // parewise min 隣同士で比較して最大
    umaxp   v3.4s, v0.4s, v1.4s
    // v3[0] = max(2,1) = 2
    // v3[1] = max(8,4) = 8
    // v3[2] = max(0,3) = 3
    // v3[3] = max(7,6) = 7
    // → v3 = [2,8,3,7]


    // v2 = [1,4,0,6]
    // v3 = [2,8,3,7]
    ldr     q4, lut7    // lut7 = [ _a,_e,_b,_f ] = lanes 0,4,1,5
    tbl     v0.16b, {v2.16b, v3.16b}, v4.16b
    // v0 = [ v2[0], v3[0], v2[1], v3[1] ]
    // v0 = [ 1,2,4,8 ]

    ldr     q4, lut8    // lut8 = [ _c,_g,_d,_h ] = lanes 2,6,3,7
    tbl     v1.16b, {v2.16b, v3.16b}, v4.16b
    // v1 = [ v2[2], v3[2], v2[3], v3[3] ]
    // v1 = [ 0,3,6,7 ]

    umin    v2.4s, v0.4s, v1.4s
    // [min(1,0), min(2,3), min(4,6), min(8,7)]
    // v2 = [0,2,4,7]

    umax    v3.4s, v0.4s, v1.4s
    // [max(1,0), max(2,3), max(4,6), max(8,7)]
    // v3 = [1,3,6,8]


    // 結果をマージする

    ldr     q4, lut9    // lut9 = [0,4,1,5]
    tbl     v0.16b, {v2.16b, v3.16b}, v4.16b
    // v0 = [ v2[0], v3[0], v2[1], v3[1] ]
    // v0 = [ 0,1,2,3 ]

    ldr     q4, lut10   // lut10 = [2,6,3,7]
    tbl     v1.16b, {v2.16b, v3.16b}, v4.16b
    // v1 = [ v2[2], v3[2], v2[3], v3[3] ]
    // v1 = [ 4,6,7,8 ]


    // 結果をprintfで表示
    str     q0, [sp]
    str     q1, [sp, #16]
    bl      printV

    leave
endp    asmMain
