// Listing5-3.S
//
// Preserving registers (failure) example

#include "aoaa.inc"

stackSpace = 64
saveLR     = 56
saveX19    = 48

.section  .rodata, ""
ttlStr:   .asciz "Listing 5-3"
space:    .asciz " "
asterisk: .asciz "*, %d\n"

.data
loopIndex: .word .-.

.code
.extern printf

proc getTitle, public
    lea x0m ttlStr
    ret
endp getTitle

proc print40Spaces
    sub sp, sp, #stackSpace
    str lr, [sp, #saveLR]

    // ここでw19の値を上書きしてレジスタを破壊しているため無限ループになる
    // x19からx29はcallee-savedで破壊してはいけないレジスタ
    // これらのレジスタを操作する場合はcallee側で退避し、復元してからretする必要がある
    // ARMの呼び出し規約、ABI（AAPCS64）定義に則る
    mov w19, #40
printLoop:
    lea x0, #40
    bl printf
    subs w19, w19, #1
    bne printLoop
    ldr lr, [sp, #saveLR]
    add sp, sp, #stackSpace
    ret
endp print40Spaces

proc asmMain, public
    sub sp, sp, #stackSpace
    str lr, [sp, #saveLR]
    str x19, [sp, #saveX19]

    mov w19, #20
astLp:
    bl print40Spaces
    lea x0, loopIndex
    str w19, [x0]
    lea x0, asterisk
    vparm2 loopIndex
    bl printf
    subs w19, w19, #1
    bne astLp

    ldr x19, [sp, #saveX19]
    ldr lr, [sp, #saveLR]
    add sp, sp, #stackSpace
    ret
endp asmMain
