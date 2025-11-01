// Listing 6-2.S
//
// Demonstrate comparing two floating-point
// values for equality by using a difference
// and error range comparison.

#include "aoaa.inc"

// The following bit mask will keep the
// exponent bits in a 64-bit double-precision
// floating-point value. It zeros out the
// remaining sign and significand bits.

// 倍精度なので符号部（1ビット） | 指数部（11ビット） | 仮数部（52ビット）
// このビットパターンは最上位ビットを除いた上位11ビットだけを取り出すマスクの役割
maskFP = 0x7FF0000000000000

// bits is the number of bits you want to
// mask out at the bottom of the significand.
// it must be greator than 0:
// bits = 4 は「下位4ビットを操作対象にする」という意味
// (1 << bits) は 2^bits を計算しているので 1 << 4 = 16 = 0b10000
// -1 を引くことで 下位4ビットが 1 のビットマスク が作れる
// bitMask = 0b1111

bits    = 4 // 比較する精度の粒度
bitMask = (1 << bits)-1 // その粒度に対応するビットパターン

// expPosn is the position of the first
// exponent bit in the double-precision format:
// 指数部の最下位ビットを示している。マスクして値を求めるときにシフト用に使う
expPosn = 52 

.text
.pool
ttlStr: wastr "Listing 6-2"
fmtStr: wastr "error for (%24.16e) = %e\n"
difMsg: wastr "Difference:%e\n"
values: wastr   "Value1=%23.16e, Value2=%23.16e\n"
eqMsg:  wastr   "Value1 == Value2\n"
neMsg:  wastr   "Value1 != Value2\n"

value1: .double 1.0e-323
value2: .double 9e-323

// Generic values to compare:

// value1: .double   1.2345678901234567
// value2: .double   1.234567890123456

// getTitle 
//
// Return pointer to program title 
// to the C++ code: 

proc    getTitle, public 
    lea     x0, ttlStr 
    ret 
endp    getTitle 


// computeError 
//
// Given a double-precision floating-point 
// value in D0, this function computes an 
// error range value for use in comparisons. 
// If the difference between two FP values
// (one of which is the value passed in D0) 
// is less than the error range value, you 
// can consider the two values equal.

proc computeError
    // Preserve all registrs this code modifies:

    locals ce
    qword  ce.saveX01 // レジスタ退避用のローカル変数
    byte   stack, 64  // 汎用作業領域（局所変数や一時計算用）
    endl   ce

    enter  ce.size
    stp    x0, x1, [fp, #ce.saveX01] // レジスタの退避

    // Move the FP number into X0 so you can mask bits:

    fmov x0, d0

    // Generata mask to extract exponent:

    and  x0, x0, #maskFP  // Extract exponent bits.
    lsr  x1, x0, #expPosn // Put exponent in bits 0-1

    // We need to normalize the value, if possible:

    cmp x1, #(expPosn - bits - 1)
    blo willBeDenormal

    // If the result won't be a subnormal
    // (denormalized value), then set
    // the significand bits to all 0s
    // (plus the implied 1 bit) and
    // decrement the exponent to move
    // the "bits" position up to the implied bit:

    sub     x1, x1, #(expPosn - bits) // Adjust exponent
    lsl     x0, x1, #expPosn      // Put exponent back
    b.al    allDone

    // If the result we be denormalized, handle that
    // situation down here:

willBeDenormal:
    mov     x0, #bitMask
    lsl     x0, x0, x1  // Shift as much as we can

allDone:
    fmov    d0, x0      // Return in D0
    ldp     x0, x1, [fp, #ce.saveX01]
    leave
endp    computeError

/////////////////////////////////////////////////////////
//        
// Here's the asmMain procedure:

proc    asmMain, public
    locals  am
    double  am.error
    double  am.diff
    byte    am.stackSpace, 64
    endl    am

    enter   am.size

    // Display the values we're going to compare:

    ldr     d0, value1
    str     d0, [sp]
    ldr     d1, value2
    str     d1, [sp, #8]
    lea     x0, values
    bl      printf

    // Compute the error value:

    ldr     d0, value1
    bl      computeError
    str     d0, [fp, #am.error]
    
    // Print the error value:

    str     d0, [sp]
    ldr     d1, value1
    str     d1, [sp, #8]
    lea     x0, fmtStr
    bl      printf

    // Compute the difference of the
    // two values we're going to compare
    // and print that difference:

    ldr     d0, value1
    ldr     d1, value2
    fsub    d0, d0, d1
    str     d0, [fp, #am.diff]
    str     d0, [sp]
    lea     x0, difMsg
    bl      printf

    // Compare the difference of the two
    // numbers against the error range.

    ldr     d1, [fp, #am.error]
    ldr     d0, [fp, #am.diff]
    fabs    d0, d0              // Must be abs(diff)!
    fcmp    d0, d1
    ble     isEqual

    // Print whether or not we should
    // treat these values as equal:

    lea     x0, neMsg
    b.al    printIt
isEqual:
        lea     x0, eqMsg
printIt:
        bl      printf
        leave                       // Return to caller
endp    asmMain 
