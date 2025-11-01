// Listing7-4.S
//
// StateMachine プロシージャ自身は「状態機械」ではない
// 実際の状態管理は、state 変数と cmp/bne 命令によって行われています。
// StateMachine は単なる「if…then…elseif」構造で、呼び出し回数（mod 4）によって挙動が変わるだけです。
// 現状の実装の特徴と問題点
//   呼び出し回数を覚えることで状態を管理。
//   ただし、if…then…elseif で状態を選択しているため、処理効率は最適ではない。
//   もっと速くするには、例えば「switch 文（ジャンプテーブル）」を使った方がよい
//   間接ジャンプ（indirect jump）を使った効率的な実装をこの次のListing7-5で行う
//   state に 0,1,2,3 の値ではなく、実行すべきコードのアドレスを入れる。
// プロシージャ呼び出し時にそのアドレスにジャンプすれば、状態選択のテスト（cmp/bne）を省略できる。
// つまり「状態変数＝コードアドレス」とすることで、状態遷移の分岐をなくす方法。

#include    "aoaa.inc"

#define     state   x19

.code
.extern printf

ttlStr:     wastr   "Listing 7-4"

fmtStr0:    .ascii  "Calling StateMachine, "
            wastr   "state=%d, W20 = 5, W21 = 6\n"

fmtStr0b:   .ascii  "Calling StateMachine, "
            wastr   "state=%d, W20 = 1, W21 = 2\n"

fmtStrx:    .ascii  "Back from StateMachine, "
            wastr   "state=%d, W20=%d\n"

fmtStr1:    .ascii  "Calling StateMachine, "
            wastr   "state=%d, W20 = 50, W21 = 60\n"

fmtStr2:    .ascii  "Calling StateMachine, "
            wastr   "state=%d, W20 = 10, W21 = 20\n"

fmtStr3:    .ascii  "Calling StateMachine, "
            wastr   "state=%d, W20 = 50, W21 = 5\n"

// getTitle
//
// Return pointer to program title to the C++ code.

proc getTitle, public
    adr x0, ttlStr
    ret
endp getTitle

// State machineはリーフのプロシージャーなのでLRをスタックに保存しなくてよい
// state(状態)は技術的にはnonvolvatileレジスタだけど、このプロシージャーの全体のポイントは
// それを変更するためにあるので、保存しない
// 同様に、x20はこのコードによって変更されるがどちらの値も保存しない

proc StateMachine
    cmp  state, #0 // 状態を0（最初の状態）と比較してフラグセット
    bne  TryState1  // Zフラグが立っていなければじゃなければジャンプ

    add  w20, w20, w21 // State 0: w21をw20に加算
    add  state, state, #1 // stateは0から1になる
    b.al exit

TryState1:
    cmp  state, #1 // 状態を1と比較してフラグセット
    bne  TryState2  

    sub  w20, w20, w21 // State 1: w20からw21を減算
    add  state, state, #1 // stateは1から2になる
    b.al exit

TryState2:
    cmp  state, #2 // 状態を2と比較してフラグセット
    bne  MustBeState3 // Zフラグが1でなければジャンプ

    mul  w20, w20, w21 // State 1: w20とw21を乗算
    add  state, state, #1 // stateは2から3になる
    b.al exit

// 最後の状態
MustBeState3:
    sdiv w20, w20, w21
    mov  state, #0 // 初期状態へ戻す

exit: ret
endp StateMachine

// asmMain
proc asmMain, public
    locals am
        dword savex19
        dword savex2021
        byte stackSpace, 64
    endl am

    enter am.size

    str state, [fp, #savex19]      // state=x19レジスタを状態保持で使うので退避
    stp x20, x21, [fp, #savex2021] // x20,x21レジスタを計算結果保持で使うので退避
    mov state, #0                  // 状態を0で初期化

    // state 0

    lea x0, fmtStr0
    mov x1, state
    mstr x1, [sp]
    bl printf

    mov x20, #5
    mov x21, #6
    bl StateMachine

    lea x0, fmtStrx
    mov x1, state
    mov x2, x20
    mstr x1, [sp]
    mstr x2, [sp, #8]
    bl printf

    // state 1
    lea  x0, fmtStr1
    mov  x1, state
    mstr x1, [sp]
    bl   printf

    mov  x20, #50
    mov  x21, #60
    bl   StateMachine

    lea  x0, fmtStrx
    mov  x1, state
    mov  x2, x20
    mstr x1, [sp]
    mstr x2, [sp, #8]
    bl   printf

    // state 2

    lea     x0, fmtStr2
    mov		x1, state
    mstr	x1, [sp]
    bl      printf

    mov     x20, #10
    mov     x21, #20
    bl      StateMachine

    lea     x0, fmtStrx
    mov		x1, state
    mov     x2, x20
    mstr	x1, [sp]
    mstr	x2, [sp, #8]
    bl      printf

    // state 3

    lea     x0, fmtStr3
    mov     x1, state
    mstr	x1, [sp]
    bl      printf

    mov     x20, #50
    mov     x21, #5
    bl      StateMachine

    lea     x0, fmtStrx
    mov		x1, state
    mov     x2, x20
    mstr	x1, [sp]
    mstr	x2, [sp, #8]
    bl      printf

    // back in state 0

    lea     x0, fmtStr0b
    mov     x1, state
    mstr	x1, [sp]
    bl      printf

    mov     x20, #1
    mov     x21, #2
    bl      StateMachine

    lea     x0, fmtStrx
    mov		x1, state
    mov		x2, x20
    mstr	x1, [sp]
    mstr	x2, [sp, #8]
    bl      printf

    ldr state, [fp, #savex19]
    ldp x20, x21, [fp, #savex2021]
    leave
endp    asmMain
