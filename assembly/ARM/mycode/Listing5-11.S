// Listing 5-11.S
//
// Accessing a reference parameter on the stack

#include "aoaa.inc"

.data
value1: .word 20
value2: .word 30

ttlStr:  .asciz "Listing 5-11"
fmtStr1: .asciz "Value of reference parameter: %d\n"

.code
.extern printf

// getTitle
//
// return program title to C++ program.

proc getTitle, public
    lea x0, ttlStr
    ret
endp getTitle

// refParm
//
// Expects a pass-by-reference parameter on the stack
proc refParm
    args rp
    dword rp.theParm
    enda rp

    enter 64

    lea x0, fmtStr1
    ldr x1, [fp, #rp.theParm]
    ldr w1, [x1] // 参照渡し
    mstr x1, [sp]

    bl printf

    leave
endp refParm

proc asmMain, public
    enter 64

    lea x0, value1
    str x0, [sp]
    bl refParm

    lea x0, value2
    str x0, [sp]
    bl refParm

    leave
endp asmMain
