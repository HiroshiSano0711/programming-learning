// Listing 16-2
//
// Simple shell program that calls exit()

// ----------------- macOS版 -----------------
//
// SYS_exit = 1
// syscall番号は x16 に入れる
// svc #0 で呼び出し

.text
.global _main
.align  2

_main:
    mov     x0, #123        // return code = 0 (success)
    mov     x16, #1       // sys_exit (macOS)
    svc     #0            // OSへ制御移す（戻ってこない）


// ----------------- Linux版 -----------------
//
// SYS_exit = 93
// syscall番号は x8 に入れる
// svc #0 で呼び出し

//.text
//.global _start
//.align  2

//_start:
//    mov     x0, #0        // return code = 0
//    mov     x8, #93       // sys_exit
//    svc     #0            // OSへ戻る（戻らない）
