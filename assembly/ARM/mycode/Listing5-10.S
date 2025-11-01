// Listing 5-10.S
//
// Accessing a parameter on the stack

#include "aoaa.inc"

.data
value1: .word 20
value2: .word 30
pVar:   .word .-.

ttlStr:  .asciz "Listing 5-10"
fmtStr1: .asciz "Value of parameter: %d\n"

.code
.extern printf

// getTitle
//
// return program title to C++ program.

proc getTitle, public
    lea x0, ttlStr
    ret
endp getTitle

// valueParm
//
// passed a single parameter(vp.theParm) by value

proc valueParm
    // declare the parameter
    args vp
    word vp.theParm
    enda vp

    enter 64  // alloc space for printf

    // vparms macro aacepts only global variables.
    // must copy parameter to that global to print it:

    lea x0, fmtStr1
    ldr w1, [fp, #vp.theParm]
    lea x2, pVar
    str w1, [x2]
    vparm2 pVar
    bl printf

    leave
    ret
endp valueParm

proc asmMain, public
    enter 64

    lea x0, value1
    ldr w1, [x0]
    str w1, [sp]

    bl valueParm

    lea x0, value2
    ldr w1, [x0]
    str w1, [sp]

    bl valueParm

    leave
endp asmMain
