// Listing9-2.S
//
//「分岐を減らす」「関数呼び出しを減らす」「命令を減らす」
// この3つ全部をトレードオフしながら測定してみるプログラム

#include "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-2"
fmtStr1:    .asciz      "Value=%x, as hex=%c%c\n"

.code
.extern     printf

// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


// btoh_simpleの主な処理はListing9-1と同じ
// stackを使ってx0レジスタの値を退避、復元しているのが違うのでそこだけ注意

proc    btoh_simple

    str     x0, [sp, #-16]!

    and     x1, x1, #0xFF
    mov     x0, x1

    lsr     x1, x1, #4
    orr     x1, x1, #'0'
    cmp     x1, #'9'
    bls     le9as
    add     x1, x1, #7

le9as:
    and     x0, x0, #0xF
    orr     x0, x0, #'0'
    cmp     x0, #'9'
    bls     le9bs
    add     x0, x0, #7

le9bs:
    orr     x1, x1, x0, lsl #8
    ldr     x0, [sp], #16 
    ret

endp    btoh_simple



// csel命令を使って、blの分岐なしに高速化したバージョン
// 条件分岐は実行するまでどこにジャンプするかわからない
// そのためCPUは分岐予測を行なってパイプラインを実行するが
// その予測が外れた場合は命令のフェッチからやり直す
// 分岐はパイプラインを阻害する場合が確率的に存在するため
// 総合的には分岐は少ない方が高速化しやすい
// ARMにはcselをはじめとしてif文を使わなくて済むような命令が用意されている
// 関数呼び出しも内部的には分岐の一種だけど、
// スタック操作 や レジスタ保存 を伴うため、 通常の分岐より重くなる

// 実際の実行結果
//  btoh_simple  3.65s user 0.01s system 94% cpu 3.890 total
//  btoh_nob 4.25s user 0.01s system 94% cpu 4.501 total
//  btoh_x1 3.20s user 0.01s system 93% cpu 3.439 total
//  btoh2 3.63s user 0.01s system 94% cpu 3.859 total
// Mac mini M2チップでの実行
// Apple Silicon の AArch64 コアは、
// メモリアクセス（特にペアロード／ペアストア）が思ったより遅い傾向があるかも
// M1/M2 の分岐予測精度は非常に高いみたい
// ここでは cmp の後の bls（小さいならジャンプ）という単純なパターンを毎回同じように繰り返してるので、
// CPUが完全に予測学習して外さない。
// つまり「分岐ペナルティ」自体がほとんどゼロ。
// なので、分岐を消した btoh_nob に有利な要素がなくなっていると推測できる。
// Apple以外のARMのCPUだとまた違った結果になる。
// Unified Memoryも影響している可能性が高い。
// L1、L2などのキャッシュラインも影響する
// 理論的には分岐の方が遅いという話だったけど、CPUやメモリによって実情は異なることがわかった
// 「分岐を減らす」「関数呼び出しを減らす」「命令を減らす」はトレードオフである
// どれかを減らせば必ず速くなるというわけではない。
// 関数をインライン化すると速くなる場合もあるが、やりすぎると可読性が下がる。

proc    btoh_nob
    // stp命令を使って2つの値を同時に保存して高速化を図っている

    stp     x0, x2, [sp, #-16]!
    and     x1, x1, #0xFF
    mov     x0, x1

    // Process the HO nibble:

    lsr     x1, x1, #4
    orr     x1, x1, #'0'
    add     x2, x1, #7
    cmp     x1, #'9'        // NZCVのフラグ更新。内部的にはsubs xzr, x1, #'9'と同じ動作。

    // ARMアセンブリの条件コードで、意味は lower or same
    // もし x1がls条件（lower or same）が成立したら、x1 = x1。
    // そうでなければ、x1 = x2
    // ls → (C == 0) || (Z == 1)
    csel    x1, x1, x2, ls

    // Process the LO nibble:

    and     x0, x0, #0xF    // Strip away HO nibble
    orr     x0, x0, #'0'    // Convert to 0x30 to 0x3F
    add     x2, x0, #7
    cmp     x0, #'9'        // See if 0x3A to 0x3F
    csel    x0, x0, x2, ls

    // Merge the two bytes into X0

    orr     x1, x1, x0, lsl #8
    ldp     x0, x2, [sp], #16
    ret

endp    btoh_nob


// 分岐は最小限にして論理演算やシフト演算のみで完結したバージョン。
// 自分のPCだとこのバージョンが一番速かった。
// ちょっとトリッキーなやり方しているのでコード読む時は注意して読む

proc    btoh_x1
    and     x1, x1, #0xFF       // 下位8bitに限定して残す
    add     x1, x1, x1, lsl #12 // 12ビットシフトして自身を加算。000xy -> xy0xy
    lsr     x1, x1, #4          // 右に4bitシフトして下位の値を確定。xy0xy -> 0xy0x
    and     x1, x1, #0xFFF      // 下位12bitに限定して上位4bitを捨てる。xy0x -> 0y0x

    // ここまででHO、LOビットを一つのジレスタで同時に扱う準備が完了する

    cmp     x1, #0xa00          // If y is >0xA,
    blo     not3a1              // add 7 to it
    add     x1, x1, #0x0700

not3a1:
    // rev16: 16bit単位でビットを入れ替える。
    // 0y0x -> 0x0y
    rev16   x1, x1

    cmp     x1, #0xa00          // If x is >0xA,
    blo     not3a2              // add 7 to it
    add     x1, x1, #0x0700

not3a2:
    add     x1, x1, #0x30       // Add 0x30 to LO nibble

    // もう一度ビットを反転させて元に戻す
    rev16   x1, x1              // xx0y -> 0yxx
    add     x1, x1, #0x30       // Add 0x30 to HO nibble
    ret                         // Return yyxx in X0
endp    btoh_x1


// btoh_simpleの綺麗な構造バージョン。
//   mov     x0, x1
// の処理がなくてコピー不要の形に改善している。
// x0、x1のレジスタの使い方、HO、LOの処理の順序が対称的になってるだけであとは同じ
// 値のコピーがどれだけ影響出るか？
// 同じアルゴリズムだけど綺麗な構造にして速度に影響でるか？
// を測定してみる、という目的だと思われる

proc    btoh2

    str     x0, [sp, #-16]!

    and     x0, x1, #0xF0
    lsr     x0, x0, #4
    orr     x0, x0, #0x30
    cmp     x0, #'9'
    bls     le9a
    add     x0, x0, #7

le9a:

    and     x1, x1, #0xF
    orr     x1, x1, #0x30
    cmp     x1, #'9'
    bls     le9b
    add     x1, x1, #7

le9b:

    lsl     x1, x1, #8
    orr     x1, x1, x0

    ldr     x0, [sp], #16
    ret
endp    btoh2






// btoh(byte to hex)系の関数のパフォーマンスを測定するためのasmMainプログラム
// ベンチマークのように正確な測定方法ではないけど、ざっと確認するには良い
// いろんな測定方法を知っておき、使い分けられるようにしておくと良い

proc    asmMain, public

    // ループを制御する変数としてx20,x21レジスタを使うので保存する
    locals  am
        dword   saveX20
        dword   saveX21
        byte    stackspace, 64
    endl    am

    enter   am.size    // activation recordの作成

    str     x20, [fp, #saveX20] // 現在のレジスタの値を退避
    str     x21, [fp, #saveX21]

    // outerは10,000,000回ループを実行

    ldr     x20, =10000000
outer:

// Innerは256回のループを実行, 各バイトの値につき1回
// 関数を呼ぶだけで返り値は無視してる。
// 関数の実行速度を測定する


// 呼び出す関数を簡単に切り替えられるようにするため。
// ループ処理自体は全く同じなので、マクロを書き換えるだけで、btoh_simple や btoh_nob
// など他の関数も検証できる
// この後で作成する関数を試していきパフォーマンスがどう変化するかをみていく。
#define funcToCall btoh_nob

    // innerのループカウンタの初期化。-1を行い0になるまで繰り返していく
    mov     x21, #256
inner:
    // outer→innerの二重ループだからinnerへのジャンプを先、その後にouterを実行することで実現

    add     x1, x20, #-1
    bl      funcToCall
    adds    x21, x21, #-1
    bne     inner
    adds    x20, x20, #-1
    bne     outer


    // これは値確認用の1回だけの呼び出し。
    // ループ中は結果を使わない（性能測定目的）けど、
    // 最後に printf で「実際の変換結果」を出して動作確認するため。
    mov     x1, #0x9a
    mov     x6, x1
    bl      funcToCall

    // btoh_*** 関数の結果を出力する

    and     x2, x1, #0xff   // HO nibbleを最初に出力する
    mstr    x2, [sp, #8] 
    lsr     x3, x1, #8      // LO nibbleを２番目に出力する
    mstr    x3, [sp, #16]
    mov     x1, x6          // 退避していたx1の値を復元
    mstr    x1, [sp]
    lea     x0, fmtStr1     // printfの第一引数。フォーマットの文字列
    bl      printf

    // nonvolatileレジスタの復元
    ldr     x21, [fp, #saveX21]
    ldr     x20, [fp, #saveX20]
    leave
    ret

endp    asmMain
