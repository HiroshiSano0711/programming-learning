// Listing 9-3
//
// 1バイトを2つの16進数に変換する
//  dtobuf（64bit → 16桁）
//  wtobuf（32bit → 8桁）
//  htobuf（16bit → 4桁）
//  btobuf（8bit → 2桁）
// という4つの関数が、1つのコードを下に向かって共有してる。
// dtobufを呼べば64bitの処理。wtobufを呼べば32bitの処理と切り替えられる
//
// 単位のところで関数を区切ってるだけdec15~dec0までは共通の処理
// wtobuf, htobuf, btobuf
//  dtobuf の中の特定ニブルからのエントリポイントを利用。
//  wtobuf → ニブル 7 から
//  htobuf → ニブル 3 から
//  btobuf → ニブル 1 から
//  これにより、同じ処理コードを共有し、重複コードを削減。
//
// 前提条件
//  これらの関数はスタックに push したり、特殊な環境変更をしていない。
//  だから「途中から関数として呼び出す」ことが安全にできる。

#include    "aoaa.inc"

.section    .rodata, ""
ttlStr:     .asciz      "Listing 9-2"
fmtStr:     .asciz      "result = '%s'\n"
fmtStr1:    .asciz      "Value=%x, as hex=%c%c\n"
fmtstr2:    .asciz      "X2=%x, X3=%x\n"

.data
.align      2
outBuf:     .space      256, 0


.code
.extern     printf

// Return program title to C++ program:

proc    getTitle, public
    lea     x0, ttlStr
    ret
endp    getTitle


// dtobuf
//
// Convert a dword to a string of 16 hexadecimal digits.
//
// Inputs:
//  X0-     Pointer to the buffer. Must have at least
//          17 bytes available.
//  X1-     Value to convert
//
// Outputs:
//  X0-     Points at zero-terminating byte at the end
//          of the converted string.
//
// Note:    This function does not preserve any registers.
//          It is the caller's responsibility to preserve
//          registers.
//
//          Registers modified: X0, X2


proc    dtobuf

// 'A' - ':'でも同じだけどコードの意図が少しわかりづらい
// この式は「‘9’の次の文字が‘A’ではない」ことを明示的に示していて、
// 「数字（0–9）」と「アルファベット（A–F）」の間に 1文字以上の隙間がある
// → だから −1 して補正する、という意図だと思われる
// '9' → 0x39
// ':' → 0x3A
// '@' → 0x40
// 'A' → 0x41

#define AtoF   ('A'-'9'-1)

            // HO nibble15の処理
            // 60bit右にシフトして、上位4bitだけとってくる。
            // 順番に4bitずつ上から処理をして1文字ずつ変換していってる。
            // ループを展開していることに注目
            // なぜかというと：
            //   ループ制御（subs＋bge）は比較的高コスト
            //   16回固定なので、展開した方が高速
            //   この章のテーマ（「効率的な if とループ」）に沿ってる

            lsr     x2, x1, #60
            orr     w2, w2, #'0'    // Convert to 0x30 to 0x3F
            cmp     w2, #'9'        // See if 0x3A to 0x3F
            bls     dec15           // Skip if 0 to 9
            add     w2, w2, #AtoF   // If it was A to F
dec15:
            // 後置インクリメント付きストア命令
            // 1byte書き込んだ後に1byteポインタを進める
            strb    w2, [x0], #1


            // Process nibble 14:
            // 上から4bitずつ処理するので、60→56→52→48→44→40→36→32
            // というふうに取得していく

            lsr     x2, x1, #56
            and     x2, x2, 0xf     // 下位4bitだけにマスクをして抽出
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec14
            add     w2, w2, #AtoF
dec14:      strb    w2, [x0], #1

            // Process nibble 13:
            // 以下同じように処理が進むのでコメントは上を読んでもらえばOK

            lsr     x2, x1, #52
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec13
            add     w2, w2, #AtoF
dec13:      strb    w2, [x0], #1

            // Process nibble 12:

            lsr     x2, x1, #48
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec12
            add     w2, w2, #AtoF
dec12:      strb    w2, [x0], #1

            // Process nibble 11:

            lsr     x2, x1, #44
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec11
            add     w2, w2, #AtoF
dec11:      strb    w2, [x0], #1

            // Process nibble 10:

            lsr     x2, x1, #40
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec10
            add     w2, w2, #AtoF
dec10:      strb    w2, [x0], #1

            // Process nibble 9:

            lsr     x2, x1, #36
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec9
            add     w2, w2, #AtoF
dec9:       strb    w2, [x0], #1

            // Process nibble 8:

            lsr     x2, x1, #32
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec8
            add     w2, w2, #AtoF
dec8:       strb    w2, [x0], #1


// Entry point for wtobuf
//
// wtobuf
//
// Convert a word to a string of 8 hexadecimal digits.
//
// Inputs:
//  X0-     Pointer to the buffer. Must have at least
//          9 bytes available.
//  X1-     Value to convert
//
// Outputs:
//  X0-     Points at zero-terminating byte at the end
//          of the converted string.
//
// Note:    This function does not preserve any registers.
//          It is the caller's responsibility to preserve
//          registers.
//
//          Registers modified: X0, X2

wtobuf:
            // Process nibble 7:

            lsr     x2, x1, #28 // See comments for nibble 15
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec7
            add     w2, w2, #AtoF
dec7:       strb    w2, [x0], #1

            // Process nibble 6:

            lsr     x2, x1, #24
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec6
            add     w2, w2, #AtoF
dec6:       strb    w2, [x0], #1

            // Process nibble 5:

            lsr     x2, x1, #20
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec5
            add     w2, w2, #AtoF
dec5:       strb    w2, [x0], #1

            // Process nibble 4:

            lsr     x2, x1, #16
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec4
            add     w2, w2, #AtoF
dec4:       strb    w2, [x0], #1

// Entry point for htobuf:
//
// htobuf
//
// Convert a halfword to a string of 4 hexadecimal digits.
//
// Inputs:
//  X0-     Pointer to the buffer. Must have at least
//          5 bytes available.
//  X1-     Value to convert
//
// Outputs:
//  X0-     Points at zero-terminating byte at the end
//          of the converted string.
//
// Note:    This function does not preserve any registers.
//          It is the caller's responsibility to preserve
//          registers.
//
//          Registers modified: X0, X2

htobuf:
            // Process nibble 3:

            lsr     x2, x1, #12 // See comments for nibble 15
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec3
            add     w2, w2, #AtoF
dec3:       strb    w2, [x0], #1

            // Process nibble 2:

            lsr     x2, x1, #8
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec2
            add     w2, w2, #AtoF
dec2:       strb    w2, [x0], #1

// Entry point for btobuf:
//
// btobuf
//
// Convert a byte to a string of 2 hexadecimal digits.
//
// Inputs:
//  X0-     Pointer to the buffer. Must have at least
//          3 bytes available.
//  X1-     Value to convert
//
// Outputs:
//  X0-     Points at zero-terminating byte at the end
//          of the converted string.
//
// Note:    This function does not preserve any registers.
//          It is the caller's responsibility to preserve
//          registers.
//
//          Registers modified: X0, X2

            // Process nibble 1:

btobuf:
            lsr     x2, x1, #4  // See comments for nibble 15
            and     x2, x2, 0xf
            orr     w2, w2, #'0'
            cmp     w2, #'9'
            bls     dec1
            add     w2, w2, #AtoF
dec1:       strb    w2, [x0], #1

            // Process LO nibble:

            and     x2, x1, 0xf
            orr     x2, x2, #'0'
            cmp     w2, #'9'
            bls     dec0
            add     w2, w2, #AtoF
dec0:       strb    w2, [x0], #1

            strb    wzr, [x0]       // Zero-terminate
            ret
            endp    dtobuf



// Here is the "asmMain" function.


            proc    asmMain, public

            locals  am                  // Preserve the X20 and
            dword   saveX20             // X21 registers, that
            dword   saveX21             // this program uses
            byte    stackspace, 64      // as loop-control
            endl    am                  // variables


            enter   am.size             // Create activation record

            str     x20, [fp, #saveX20] // Preserve non-volatile
            str     x21, [fp, #saveX21] // registers.


// Outer loop executes 10,000,000 times

            ldr     x20, =10000000
outer:

// Inner loop executes 256 times, once for each byte value.
// It just calls the btoh_*** function and ignores the
// return value. Do this to measure the speed of the
// function.

            mov     x21, #256
            ldr     x7, =0x0a1b2c3d4f5a6b9c
inner:      lea     x0, outBuf
            mov     x1, x7
            //add     x1, x20, #-1
            bl      dtobuf
            adds    x21, x21, #-1
            bne     inner
            adds    x20, x20, #-1
            bne     outer



            ldr     x1, =0x0123456789abcdef       // Value to test
            lea     x0, outBuf
            bl      dtobuf

            lea     x0, fmtStr
            lea     x1, outBuf
            mstr    x1, [sp]
            bl      printf


            ldr     x21, [fp, #saveX21] // Restore non-volatile
            ldr     x20, [fp, #saveX20] // registers
            leave
            ret

            endp    asmMain
