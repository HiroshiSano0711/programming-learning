    .data
    .byte 0xAA
    .align 4
label:
    .byte 0xBB

// 実行結果
// $ clang -c align_test.s -o align_test.o
// $ objdump -s align_test.o
//
// align_test.o:	file format mach-o arm64
// Contents of section __DATA,__data:
// 0000 aa000000 00000000 00000000 00000000  ................
// 0010 bb
//
// .align Nは環境によってNバイトか2^Nバイトか変わるんだけど、MacOSなら2^Nバイトの可能性大
// 自分の環境では
// 0000: aa 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
// 0010: bb
// なので15バイトのパディングが入ってる。
// 2^Nバイトであることが証明された。
