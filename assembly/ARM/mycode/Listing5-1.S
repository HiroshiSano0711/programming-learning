// Listing5-1.S 
//
// Simple procedure call example 

#include "aoaa.inc"

stackSpace  =       64 
saveLR      =       56 

.section .rodata, ""
ttlStr:     .asciz   "Listing 5-1"


.data
wArray:     .space   256 * (4), 0xff // Fill with 0xFF.

.text
.align   2

// getTitle 
//
// Return program title to C++ program: 

            .global getTitle 
getTitle: 
            lea     x0, ttlStr 
            ret 

// zeroBytes 
//
// Here is the user-written procedure 
// that zeros out a 256-word buffer. 
// On entry, X0 contains the address 
// of the buffer. 

zeroBytes: 
            mov     x1, #256 * 4

repeatlp:   subs    x1, x1, #4 
            str     wzr, [x0, x1] // Store *after* subtraction! 
            bne     repeatlp      // Repeat while X1 != 0. 
            ret 

// Here is the asmMain function: 

            .global asmMain 
asmMain: 
            sub     sp, sp, #stackSpace // Reserve stack storage. 
            str     lr, [sp, #saveLR] 

            lea     x0, wArray 
            bl      zeroBytes 

            ldr     lr, [sp, #saveLR]   // Restore return address. 
            add     sp, sp, #stackSpace // Clean up stack. 
            ret     // Returns to caller
