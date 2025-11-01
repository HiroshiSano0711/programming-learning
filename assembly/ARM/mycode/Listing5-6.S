// Listing5-6.S
//
// Accessing local variables #2

#include "aoaa.inc"

.code

// local_vars
//
// Word a is at offset -4 from FP
// Word bb is at offset -8 from FP
//
// On entry, w0 and w1 contain values to store
// into the local variables a & bb (respectively)

// 可読性を考えてマクロで定義するか、equを使って命名した方がベター
#define a [fp, #-4]
#define bb [fp, #-8]

proc local_vars
    enter 8
    str w0, a
    str w1, bb

    leave // aoaa.incで提供されているマクロ。
endp local_vars
