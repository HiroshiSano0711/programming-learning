// Listing5-8.S
//
// Demonstrate passing a local variable
// by reference to another procedure.

#include "aoaa.inc"

.data
staticVar: .word .-.

.code
.extern aSecondFunction

proc demoPassLclByRef
    locals ga
    word   ga.aLocalVariable
    endl   ga

    enter  ga.size
    // pass parameter in x0
    add    x0, fp, #ga.aLocalVariable
    bl aSecondFunction

    leave
endp demoPassLclByRef
