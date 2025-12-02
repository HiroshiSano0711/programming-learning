// Listing14-1.S
//
// String initialization, allocation, and deallocation functions and macros.

#include    "aoaa.inc"

// Assembly language string data structure:

struct  string, -16
    dword   string.allocPtr // at offset -16
    word    string.maxlen   // at offset -8
    word    string.len      // at offset -4
    byte    string.chars    // at offset 0
ends    string

// str.buf:
//
// Allocate storage for an empty string with the specified maximum size:

.macro  str.buf strName, maxSize
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   \maxSize
    .word   0
    \strName:   .space  ((\maxSize+16) & 0xFFFFFFF0), 0
.endm


// str.literal:
//
// Allocate storage for a string buffer and initialize
// it with a string literal:

.macro  str.literal strName, strChars
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   len_\strName    //string.maxlen
    .word   len_\strName    //string.len

    // Emit the string data and compute the string's length:

    \strName:   .ascii  "\strChars"
    len_\strName=       .-\strName
    .byte   0   // Zero-terminating byte

    //Ensure object is multiple of 16 bytes:

    .align  4
.endm


.data



///////////////////////////////////////////////////////////

.code
.global malloc
.global free

ttlStr:     wastr  "listing14-1"

// Standard getTitle function.
// Returns pointer to program name in X0

proc    getTitle, public
    lea    x0, ttlStr
    ret
endp    getTitle

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

proc    str.bufInit

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


///////////////////////////////////////////////////////////
//
// str.alloc:
//
// Allocates storage for an assembly language string
// object on the heap (C stdlib malloc heap).
//
// On entry:
//
//  W0- Maximum string length for string object.
//
// On exit:
//
//  X0- Pointer to string object (NULL if error).
//
//  carry clear if successful, set if error.

proc    str.alloc

    locals  str_alloc
        dword   str_alloc.maxlen
        dword   str_alloc.saveX1

        // NEON（q0〜q15）の保存は 16バイトアライン必須
        // NEON レジスタは 128bit（16バイト）で str q0, [addr] を実行するとき、
        // addr が 16バイト境界でないと未定義動作になる可能性がある（アーキによっては例外 or 大幅スローダウン）
        salign  4
        byte    str_alloc.vsave, volatile_save.size
        byte    str_alloc.stkSpace, 64
    endl    str_alloc

    enter   str_alloc.size

    str     x1, [fp, #str_alloc.saveX1]

    add     x1, fp, #str_alloc.vsave // x1 = volatile_save.x0x1を指す


    // mallocは、標準ライブラリのコードでありブラックボックス
    // mallocの実装や仕様がかわって書き換えられた場合、どのレジスタを破壊するのかわからない
    // mallocの変更に伴ってこのコードも修正するのは面倒
    // だから全部退避、復元させておけば修正する必要がないし絶対に安全
    // 安全性100％・将来の変更にも強い・修正不要という設計思想
    // この関数は「汎用ライブラリとして使われる」前提の作りなのでARMの標準ABIに完全準拠させる
    // volatile_save.x0x1はx0,x1レジスタを退避させる領域だが今回使わないからプリインクリメントでスキップ

    stp     x2,  x3,  [x1, #16]!
    stp     x4,  x5,  [x1, #16]!
    stp     x6,  x7,  [x1, #16]!
    stp     x8,  x9,  [x1, #16]!
    stp     x10, x11, [x1, #16]!
    stp     x12, x13, [x1, #16]!
    stp     x14, x15, [x1, #16]!

    str     q0,  [x1, #16]!
    str     q1,  [x1, #16]!
    str     q2,  [x1, #16]!
    str     q3,  [x1, #16]!
    str     q4,  [x1, #16]!
    str     q5,  [x1, #16]!
    str     q6,  [x1, #16]!
    str     q7,  [x1, #16]!
    str     q8,  [x1, #16]!
    str     q9,  [x1, #16]!
    str     q10, [x1, #16]!
    str     q11, [x1, #16]!
    str     q12, [x1, #16]!
    str     q13, [x1, #16]!
    str     q14, [x1, #16]!
    str     q15, [x1, #16]!

    str     w0, [fp, #str_alloc.maxlen]


    // malloc後に構造体内の chars フィールドを16バイト境界に置けるよう、
    // アライン調整で最大15バイト失われても maxlen 分が収まるように、
    // 余裕16バイト＋切り上げ用15バイト = 31 を事前に加算しておく。

    add     x0, x0, #31 + (string.chars - string.allocPtr)
    and     x0, x0, #0xffffffff
    bic     x0, x0, #0xf        // 要求サイズを16バイト境界に切り上げ


    bl      malloc
    cbz     x0, str.alloc.bad


    // 後で free するために保存している
    // free() は malloc が返したポインタそのものを渡さないといけないため

    mov     x1, x0              // mallocの返したraw pointerを保存


    // struct.chars のアドレスを16バイト境界に揃える
    // raw pointer + 構造体ヘッダ分 + アライン調整(15)
    // → 16バイト境界に切り捨てる

    add     x0, x0, #15+(string.chars - string.allocPtr)
    bic     x0, x0, #0xf        // x0 = アライン済みのstruct先頭

    // 構造体の初期化

    str     x1, [x0, #string.allocPtr]
    ldr     w2, [fp, #str_alloc.maxlen]
    str     w2, [x0, #string.maxlen]
    str     wzr, [x0, #string.len]
    strb    wzr, [x0, #string.chars]    //Zero terminator

    adds    xzr, xzr, xzr   // 成功したらフラグをリセットして正常終了通知

str.alloc.bad:
    // レジスタを復元させてret
    // キャリーフラグは成功時だけリセットする仕様なので、正常、例外ともに共通処理でOK

    add     x1, fp, #str_alloc.vsave
    ldp     x2,  x3,  [x1, #16]!
    ldp     x4,  x5,  [x1, #16]!
    ldp     x6,  x7,  [x1, #16]!
    ldp     x8,  x9,  [x1, #16]!
    ldp     x10, x11, [x1, #16]!
    ldp     x12, x13, [x1, #16]!
    ldp     x14, x15, [x1, #16]!

    ldr     q0,  [x1, #16]!
    ldr     q1,  [x1, #16]!
    ldr     q2,  [x1, #16]!
    ldr     q3,  [x1, #16]!
    ldr     q4,  [x1, #16]!
    ldr     q5,  [x1, #16]!
    ldr     q6,  [x1, #16]!
    ldr     q7,  [x1, #16]!
    ldr     q8,  [x1, #16]!
    ldr     q9,  [x1, #16]!
    ldr     q10, [x1, #16]!
    ldr     q11, [x1, #16]!
    ldr     q12, [x1, #16]!
    ldr     q13, [x1, #16]!
    ldr     q14, [x1, #16]!
    ldr     q15, [x1, #16]!

    ldr     x1, [fp, #str_alloc.saveX1]

    leave
endp    str.alloc




///////////////////////////////////////////////////////////
//
// str.free:
//
// Allocates storage for an assembly language string
// object that was previously allocated via str.alloc.
//
// On entry:
//
//  W0- Pointer to string object to deallocate.


// str.allocで保存していた構造体のフィールドraw_pointerを渡してfreeを呼ぶだけ
// 後の処理はstr.allocと同じなので説明コメントは省略

proc    str.free

    locals  str_free
    dword   str_free.maxlen
    dword   str_free.saveX1

    // NEON（q0〜q15）の保存は 16バイトアライン必須
    // NEON レジスタは 128bit（16バイト）で str q0, [addr] を実行するとき、
    // addr が 16バイト境界でないと未定義動作になる可能性がある（アーキによっては例外 or 大幅スローダウン）
    salign  4

    byte    str_free.vsave, volatile_save.size
    byte    str_free.stkSpace,64
    endl    str_free

    enter   str_free.size

    str     x1, [fp, #str_free.saveX1]
    add     x1, fp, #str_free.vsave

    stp     x2,  x3,  [x1, #16]!
    stp     x4,  x5,  [x1, #16]!
    stp     x6,  x7,  [x1, #16]!
    stp     x8,  x9,  [x1, #16]!
    stp     x10, x11, [x1, #16]!
    stp     x12, x13, [x1, #16]!
    stp     x14, x15, [x1, #16]!

    str     q0,  [x1, #16]!
    str     q1,  [x1, #16]!
    str     q2,  [x1, #16]!
    str     q3,  [x1, #16]!
    str     q4,  [x1, #16]!
    str     q5,  [x1, #16]!
    str     q6,  [x1, #16]!
    str     q7,  [x1, #16]!
    str     q8,  [x1, #16]!
    str     q9,  [x1, #16]!
    str     q10, [x1, #16]!
    str     q11, [x1, #16]!
    str     q12, [x1, #16]!
    str     q13, [x1, #16]!
    str     q14, [x1, #16]!
    str     q15, [x1, #16]!

    ldr     x1, [x0, #string.allocPtr]

    cbz     x1, str.free.done


    // 二重 free を防ぐために free 前に構造体のallocPtrフィールドを NULL にする
    // free(NULL)の実行は何もしない

    str     xzr, [x0, #string.allocPtr]

    mov     x0, x1
    bl      free

str.free.done:
    add     x1, fp, #str_free.vsave
    ldp     x2,  x3,  [x1, #16]!
    ldp     x4,  x5,  [x1, #16]!
    ldp     x6,  x7,  [x1, #16]!
    ldp     x8,  x9,  [x1, #16]!
    ldp     x10, x11, [x1, #16]!
    ldp     x12, x13, [x1, #16]!
    ldp     x14, x15, [x1, #16]!

    ldr     q0,  [x1, #16]!
    ldr     q1,  [x1, #16]!
    ldr     q2,  [x1, #16]!
    ldr     q3,  [x1, #16]!
    ldr     q4,  [x1, #16]!
    ldr     q5,  [x1, #16]!
    ldr     q6,  [x1, #16]!
    ldr     q7,  [x1, #16]!
    ldr     q8,  [x1, #16]!
    ldr     q9,  [x1, #16]!
    ldr     q10, [x1, #16]!
    ldr     q11, [x1, #16]!
    ldr     q12, [x1, #16]!
    ldr     q13, [x1, #16]!
    ldr     q14, [x1, #16]!
    ldr     q15, [x1, #16]!

    ldr     x1, [fp, #str_free.saveX1]
    leave
endp    str.free



///////////////////////////////////////////////////////////
//
// Some read-only strings:

fmtStr:     wastr   "hwStr=%s"
fmtStr2:    wastr   "hwDynamic=%s"
fmtStr3:    wastr   "strBufInit error\n"

str.literal hwLiteral, "Hello, world!\n"


///////////////////////////////////////////////////////////
//
// Main program to test the code:

proc    asmMain, public

    locals  lcl
    qword   hwStr
    qword	hwDynamic
    byte    hwBuffer, 256
    byte    stkSpace, 64
    endl    lcl

    enter   lcl.size      //Reserve space for locals

    // Demonstrate call to str.bufInit:

    // Initialze hwBuffer as a string object and
    // save pointer in hwStr:

    add     x0, fp, #hwBuffer
    mov     x1, #256    // buffer size
    bl      str.bufInit
    str     x0, [fp, #hwStr]

    // Force copy of hwLiteral into hwStr:

    lea     x2, hwLiteral
    ldr     w3, [x2, #string.len]   // Get length
    str     w3, [x0, #string.len]   // Save as hwStr length

    // Cheesy string copy. We know the length is less
    // that 16 bytes and both string objects have a
    // minimum of 16 character locations avaiable.

    ldr     q0, [x2]    // Copy "Hello, world!\n" string
    str     q0, [x0]

    // Now, hwStr contains a copy of hwLiteral.
    // Print hwStr (because the assembly language
    // string format always includes a zero-terminating
    // byte, we can just call printf to print the string.
    // Note that X0 still contains the hwStr pointer.

    mov     x1, x0
    lea     x0, fmtStr
    mstr    x1, [sp]
    bl      printf


    // Demonstrate call to str.alloc and str.free:

    mov     x0, #256    // string size
    bl      str.alloc
    bcs     badAlloc
    str     x0, [fp, #hwDynamic]

    // Force copy of hwLiteral into hwDynamic:

    lea     x2, hwLiteral
    ldr     w3, [x2, #string.len]   // Get length
    str     w3, [x0, #string.len]   // Save as hwDynamic length

    // Cheesy string copy. We know the length is less
    // that 16 bytes and both string objects have a
    // minimum of 16 character locations avaiable.

    ldr     q0, [x2]    // Copy "Hello, world!\n" string
    str     q0, [x0]

    // Now, hwDynamic contains a copy of hwLiteral.
    // Print hwDynamic (because the assembly language
    // string format always includes a zero-terminating
    // byte, we can just call printf to print the string.
    // Note that X0 still contains the hwDynamic pointer.

    mov     x1, x0
    lea     x0, fmtStr2
    mstr    x1, [sp]
    bl      printf

    // Free the string storage

    ldr     x0, [fp, #hwDynamic]
    bl      str.free

AllDone:    leave

badAlloc:
    lea     x0, fmtStr3
    bl      printf
    leave
endp    asmMain
