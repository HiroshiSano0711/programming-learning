// Listing7-2
//
//  Demonstrate indirect jumps to
// control flow through a program.

#include    "aoaa.inc"

maxLen      =       256
EINVAL      =       22      // "Magic" C stdlib constant, invalid argument
ERANGE      =       34      // Value out of range

.text
.pool
ttlStr:     wastr   "Listing 7-2"

fmtStrA:    wastr   "value=%d, error=%d\n"

fmtStr1:    .ascii  "Enter an integer value between "
            wastr   "1 and 10 (0 to quit): "

badInpStr:  .ascii  "There was an error in readLine "
            wastr   "(ctrl-D pressed?)\n"

invalidStr: wastr   "The input string was not a proper number\n"

rangeStr:   .ascii  "The input value was outside the "
            wastr   "range 1-10\n"

unknownStr: .ascii  "The was a problem with strToInt "
            wastr   "(unknown error)\n"

goodStr:    wastr   "The input value was %d\n"

fmtStr:     wastr   "result:%d, errno:%d\n"


// getTitle-
// Return pointer to program title
// to the C++ code.

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle

// strToInt-
//
//  Converts a string to an integer, checking for errors.
//
// Argument:
//    X0-   Pointer to string containing (only) decimal 
//           digits to convert to an integer.
//
// Returns:
//    X0-    Integer value if conversion was successful.
//    X1-    Conversion state. One of the following:
//           0- Conversion successful
//           1- Illegal characters at the beginning of the 
//                   string (or empty string).
//           2- Illegal characters at the end of the string
//           3- Value too large for 32-bit signed integer.


proc strToInt
    locals  sti
        dword   sti.saveX19
        dword   sti.endPtr
        word    sti.value
        byte    sti.stackSpace, 64
    endl    sti

    enter   sti.size

    // readLineで入力を受け取って、その値がx0に代入されてこのプロシージャーに渡される
    mov     x19, x0         // x0は文字列の先頭ポインタ。変換が最後までできたかどうかをあとでテストするために保持しておく。

    // x0レジスタのはすでに整数に変換するための文字列パラメータが入っている。
    // strtol(char *nptr, char **endptr, int base) の第2引数(x1)は char **なので
    // x2レジスタにポインタを渡す。
    add     x1, fp, #sti.endPtr // 文字列の変換終了位置を示すポインタを保持する
    mov     x2, #10             // strtolの第3引数。10進数をベースにするという意味
    bl      strtol

    // strtolの返り値
    //
    //    X0レジスタ→成功したら変換された値がはいる。
    //    endPtr-Pointer→変換終了位置が1（endPtr == strToConv）ならば、文字列の先頭に不正な文字はなかったことになる

    mov     x1, #1                  // エラーコード 1 = 先頭が不正/空
    ldr     x2, [fp, #sti.endPtr]   // 保持していたendPtrを読み込み
    cmp     x19, x2                 // startPtr=endPtrかどうかを比較
    beq     returnValue             // 等しいならreturnValueでエラーコードに沿ったメッセージを出力する処理へ


    mov     x1, #2              // エラーコード 2 = 末尾に不正文字
    ldrb    w3, [x2]            // endPtr が指すバイトをロード（8ビット）
    cmp     x3, #0              // endPtr が終端（'\0'）を指しているなら w3 == 0
    bne     returnValue         // endPtr が \0 を指していなければ、変換後にゴミが残っている（例："123abc" なら endPtr は 'a' を差す）


    // If the return result is 0x7fff_ffff or 0x8000_0000 (max long and
    // min long, respectively), and the C global _errno variable 
    // contains ERANGE, then we've got a range error.

    // C言語のerrnoを取得するためにw0レジスタの値を退避。errnoの処理を実行するとw0に値が格納されるため
    str     w0, [fp, #sti.value]

    // getErrnoマクロ： __errno_location() を呼び出して errno の値をレジスタに読み込む
    // __errno_location(): その errno の実体のポインタを返す関数
    // errnoはC言語の標準ライブラリ <errno.h> にて定義されているグローバル変数
    // EINVAL(22)やERANGE(34)は <errno.h> にて、こういうエラーはこの数値で返すと定義されている

    getErrno                     // Magic macro in aoaa.inc

    mov     x2, x0               // errnoの実体のポインタをx2レジスタの代入、比較用
    ldr     w0, [fp, #sti.value] // strtolで変換された値をスタックに保持
    mov     x1, 0                // 0は正常に処理が完了したコード
    cmp     w2, #ERANGE
    bne     returnValue

    mov     x1, #3          //Assume out of range
    mov     x2, 0xffff
    movk    x2, 0x7fff, lsl #16
    cmp     w0, w2
    beq     returnValue

    mvn     w2, w2          // w2=0x8000_0000
    cmp     w0, w2
    beq     returnValue

    // If we get to this point, it's a good number

    mov     x0, #0

returnValue:
    leave
endp    strToInt


proc asmMain, public
    locals  am
        dword   am.saveX19              //Non-volatile
        byte    am.buffer, maxLen
        byte    am.stackSpace, 64
    endl    am

    enter   am.size

    str     x19, [fp, #am.saveX19]  //Must preserve X19


    // Prompt the user to enter a value between 1 and 10:

repeatPgm:
    lea     x0, fmtStr1
    bl      printf

    // Get user input:

    add     x0, fp, #am.buffer // lea x0, buffer
    mov     x1, #maxLen
    bl      readLine

    lea     x19, badInput   //Initialize state machine
    ands    w0, w0, w0      //X0 is -1 on bad input
    bmi     hadError        //(only neg value readLine returns)

    //Call strtoint to convert string to an integer and
    //check for errors:

    add     x0, fp, #am.buffer // Ptr to string to convert
    bl      strToInt
    lea     x19, invalid
    cmp     w1, #1
    beq     hadError
    cmp     w1, #2
    beq     hadError

    lea     x19, range
    cmp     w1, #3
    beq     hadError

    lea     x19, unknown
    cmp     w1, #0
    bne     hadError


    // At this point, input is valid and is sitting in X0.
    //
    // First, check to see if the user entered 0 (to quit
    // the program).

    ands    x0, x0, x0     //Test for zero
    beq     allDone

    // However, we need to verify that the number is in the
    // range 1-10. 

    lea     x19, range
    cmp     x0, #1
    blt     hadError
    cmp     x0, #10
    bgt     hadError

    // Pretend a bunch of work happens here dealing with the
    // input number.

    lea     x19, goodInput

// The different code streams all merge together here to
// execute some common code (we'll pretend that happens//
// for brevity, no such code exists here).

hadError:

// At the end of the common code (which doesn't mess with
// RBX), separate into five different code streams based
// on the pointer value in RBX:

    br      x19

// Transfer here if readLine returned an error:

badInput:   lea     x0, badInpStr
            bl      printf
            b.al    allDone

// Transfer here if there was a non-digit character:
// in the string:

invalid:    lea     x0, invalidStr
            bl      printf
            b.al    repeatPgm

// Transfer here if the input value was out of range:

range:      lea     x0, rangeStr
            bl      printf
            b.al    repeatPgm

// Shouldn't ever get here. Happens if strToInt returns
// a value outside the range 0-3.

unknown:    lea     x0, unknownStr
            bl      printf
            b.al    repeatPgm

// Transfer down here on a good user input.

goodInput:  mov     w1, w0
            lea     x0, goodStr
            mstr    w1, [sp]
            bl      printf
            b.al    repeatPgm

    // Branch here when the user selects "quit program" by
    // entering the value zero:

allDone:  ldr     x19, [fp, #am.saveX19] //Must restore before returning
          leave
endp    asmMain
