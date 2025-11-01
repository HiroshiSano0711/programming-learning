// Listing 6-1.S
//
// Demonstrate using x28 as a "static base"
// register to convenientry access global variables.

#include "aoaa.inc"

#define sb x28 // Use x29 for sb register

// declaration of global variables:

struct globals_t
    word  g1
    dword g2
    hword g3
    byte  g4, 128
ends globals_t

.data
globals_t globals

.text
.pool
ttlStr: wastr "Listing 6-1"

proc getTitle, public
    lea x0, ttlStr
    ret
endp getTitle

proc asmMain, public
    locals am
        dword  saveSB
        byte stackSpace, 64
    endl am

    enter am.size
    str   sb, [fp, #saveSB]
    lea   sb, globals

    mov   w0, #55
    str   w0, [sp, #g1]
    add   x0, x0, #44
    str   x0, [sp, #g2]
    and   w0, w0, #0xff
    strh  w0, [sb, #g3]

    ldr   sb, [fp, #saveSB]
    leave
endp asmMain
