// Listing5-7.S
//
// Demonstrate obtaining the address
// of a variable by using the lea instruction.

#include "aoaa.inc"

.data
staticVar: .word .-.

.code
.extern someFunc

proc get_address
    enter 0
    lea x0, staticVar
    bl  someFunc
    leave
endp get_address
