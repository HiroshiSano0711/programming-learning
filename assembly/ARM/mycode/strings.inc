// strings.inc (Listing15-1)
//
//==================================================
// strings.inc
// String library header for GAS
// Contains:
//   - string struct offsets
//   - helper macros
//   - extern declarations
//==================================================


#ifndef strings_inc
#define strings_inc 1


// 文字列の構造体のオフセット計算
// 読みやすさのためのマクロ定義

struct  string, -16
    dword   string.allocPtr // at offset -16
    word    string.maxlen   // at offset -8
    word    string.len      // at offset -4
    byte    string.chars    // at offset 0
ends    string


// str.buf:

.macro  str.buf strName, maxSize
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   \maxSize
    .word   0
    \strName:   .space  ((\maxSize+16) & 0xFFFFFFF0), 0
.endm


// str.literal:

.macro  str.literal strName, strChars
    .align  4   //Align on 16-byte boundary
    .dword  0   //NULL ptr for allocation ptr
    .word   len_\strName    //string.maxlen
    .word   len_\strName    //string.len

    \strName:   .ascii  "\strChars"
    len_\strName=       .-\strName
    .byte   0   // Zero-terminating byte

    .align  4
.endm


// str.len
// input
//      x0: 文字列構造体のポインタ
// output
//      w0: 構造体のstring.len

.macro  str.len
    ldr     w0, [x0, #string.len]
.endm



// External declarations:

.extern str.cpy
.extern str.cmp
.extern str.substr
.extern str.bufInit
.extern str.alloc
.extern str.free

// string functinの宣言を追加する場合はここに追加していけばよい

#endif
