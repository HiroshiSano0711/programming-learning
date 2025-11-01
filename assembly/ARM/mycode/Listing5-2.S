// Listing5-2.S
//
// A procedure without a ret instruction

#include "aoaa.inc"

stackSpace = 64
saveLR     = 56

.section .rodata, ""
ttlStr: .asciz "Listing 5-2"
fpMsg:  .asciz "followingProc was called\n"

.code           // macro .text .align 2
.extern printf

// proc~endpはaoaa.incが提供するシンタックスシュガー。
// どこからどこまでがプロシージャーか分かりやすくするためのもの。
// アセンブリ言語自体にはそういう構文は存在しない
// アセンブリ言語ではいかに可読性を上げるかが重要になる
proc getTitle, public
    lea x0, ttlStr
    ret
endp getTitle

// プロシージャーがreturn命令を使わないと何が起こるかのデモ

proc noRet
    // ret
endp noRet

proc followingProc
    sub sp, sp, #stackSpace  // スタックを64バイト下げて領域を確保
    str lr, [sp, #saveLR]    // LIFOで最後に取り出される位置に戻りアドレスを退避 sp + 56

    lea x0, fpMsg            // printf用のフォーマットを読み込み
    bl  printf               // printfをcall

    // スタックの状態を元に戻してcallerにリターン
    ldr lr, [sp, #saveLR]
    add sp, sp, #stackSpace
    ret
endp followingProc

// asmMain function
proc asmMain, public
    sub sp, sp, #stackSpace
    str lr, [sp, #saveLR]

    // returnをしないので続きの行が実行されてfollowingProcが実行されてしまうはず
    bl noRet

    ldr lr, [sp, #saveLR]
    add sp, sp, #stackSpace
    ret
endp asmMain
