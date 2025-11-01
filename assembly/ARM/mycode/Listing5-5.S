// Listing5-5.S
//
// Accessing local variables
// このコードはローカル変数操作のサンプルでbuildで実行はできない

#include "aoaa.inc"

.text

// local_vars
//
// Word a is at offset -4 from FP
// Word bb is at offset -8 from FP
//
// On entry, w0 and w1 contain values to store
// into the local variables a & bb (respectively)

proc local_vars
    // ローカル変数は負のオフセット、パラメータは正のオフセットになる。
    //   callerが積むのがパラメータ、blで戻りアドレス
    //   そのあとcallee側でold FPを積む。
    //   ローカル変数を積む場合はFPより上に積まれることになる
    //   スタックは高位→下位のアドレスに伸びることに注意
    enter 8
    str w0, [fp, #-4] // a = w0
    str w1, [fp, #-8] // bb = w1

    leave // aoaa.incで提供されているマクロ。
endp local_vars
