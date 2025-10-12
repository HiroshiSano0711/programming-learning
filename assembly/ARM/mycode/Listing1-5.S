// Listing1-5.S
//
// The venerable "Hello, world!" program, written
// in ARM assembly by calling the C stdlib printf
// function
//
// aoaa.inc is the Art of ARM Assembly include file.
// This makes asmMain global and automatically converts it
// to _asmMain if assembling under macOS.
// It also converts printf to _printf for macOS.

#include "aoaa.inc"

.data
title:      .asciz  "Listing 1-5"
saveLR:     .dword  0            // Save LR here
hwStr:      .asciz  "Hello, world!\n"

.text

// getTitle function, required by c.cpp
// Returns the name of this program
// The title string must be in the .text section
.align  2               // Code must be 4-byte aligned

getTitle:
    lea     x0, title
    ret


// Main function called by c.cpp
asmMain:

    // saveLRは保存用。どこに保存するかをx0に保存している。その後にstr命令でその場所にOSの戻りアドレスを保存
    lea     x0, saveLR
    str     lr, [x0]

    // AppleABIではprintf関数の第一引数はx0レジスタに入れるルール。
    lea     x0, hwStr       // hwStr must be in .text
    bl      printf          // Print the string

    // Restore LR to return to the OS
    lea     x0, saveLR
    ldr     lr, [x0]

    // Return to the OS
    ret
