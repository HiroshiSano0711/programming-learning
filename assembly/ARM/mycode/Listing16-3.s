// Listing16-3-mac.S
// Pure macOS, no portability layer

// =======================================================
// macOS版
// =======================================================

// ※注意事項
// Apple は svc syscall を private / undocumented API 扱い
// 将来変更する可能性あり、App Store 審査では reject 対象
// Apple は 公式には libc 経由を推奨している
// しかし禁止ではないので、アセンブリで直接呼んでもコンパイル時エラーにも警告にもならない

.data

// .ascii   文字列をそのまま配置
// .asciz   Null 終端付き文字列を配置

hwStr:    .asciz  "Hello, world!\n"
len = . - hwStr

.text
.global _main
.align 2


_main:
    mov     x0, #1              // stdout (fd = 1)
    adrp    x1, hwStr@PAGE
    add     x1, x1, hwStr@PAGEOFF
    mov     x2, #len            // bytes to write
    mov     x16, #4             // SYS_write (macOS)
    svc     #0

    mov     x0, #0
    mov     x16, #1             // SYS_exit (macOS)
    svc     #0



// =======================================================
// Linux版（参考 / コメントアウト）たぶん動くけど動作は未確認
// =======================================================
//
// .data
// hwStr:    .asciz  "Hello, world!\n"
// len = . - hwStr
//
// .text
// .global _start
// .align 2
//
// _start:
//     mov     x0, #1              // stdout (fd = 1)
//     adrp    x1, hwStr           // PIE/ASLR対応
//     add     x1, x1, :lo12:hwStr
//     mov     x2, #len            // bytes to write
//     mov     x8, #64             // SYS_write (Linux, AArch64)
//     svc     #0
//
//     mov     x0, #0
//     mov     x8, #93             // SYS_exit (Linux, AArch64)
//     svc     #0
