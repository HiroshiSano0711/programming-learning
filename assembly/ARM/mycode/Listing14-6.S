/// Listing 14-6
//
// Simple program to demonstrate UTF-8 output


// ===================== Unicode 基本まとめ（実装者向け） =====================
//
// • Unicode は「文字集合の仕様」。UTF-8/UTF-16/UTF-32 は「符号化方式」。
// • UTF のバイト列の中には glyph や grapheme cluster の情報は含まれない。
// • 1 “文字” = 1 glyph = 1 code point ではない点が最大の落とし穴。
//
// --- Terminology ---
// • code point = Unicode が定義する整数ID (U+XXXX)
// • glyph = フォントが描画する見た目。Unicode とは別物。
// • grapheme cluster = 見た目上の1文字（複数 code point の組み合わせ）。
//
// --- Canonical Equivalence ---
// • 見た目が同じ文字でも code point 列が異なる場合がある。
//   例: "é" → U+00E9 と [U+0065, U+0301] は見た目同じ。
// • 正規化をしない限り等価比較はバイト列が異なり false になる。
//
// --- UTF-8 ---
// • ASCII と完全互換。非ASCIIは 2〜4バイト可変長。
// • substring を byte index で切ると文字を破壊する可能性がある。
// • length は「バイト数」ではあっても「文字数」にはならない。
//
// --- UTF-16 ---
// • BMP(基本多言語面)は 2Byte、BMP外はサロゲートペアで 4Byte。
// • 4Byte の中に "複合文字の情報" は入っておらず、単なる code point。
//
// --- Grapheme cluster ---
// • 1 “表示文字” は複数の code point で構成され得る。
// • 字消し(BACKSPACE)や cursor 移動は cluster 単位で処理すべきだが、
//   自作実装は非常に難しい（UAX#29 の実装が必要）。
//
// --- 比較と文字数の罠 ---
// • strlen はバイト数。ユーザーが期待する「文字数」ではない。
// • cluster を数えるには Unicode の複雑なルールを実装する必要がある。
// • Swift などは cluster と正規化を処理するが、低レベルでは非現実的。
//
// --- 実装方針（低レベル/ASM での現実解） ---
// • UTF-8 を「単なるバイト列」として扱うのが最も実用的。
// • grapheme cluster, 正規化, 等価判定は実装しない（コストが高すぎる）。
// • substring, length, index は byte 単位で扱う（破壊 risk は許容）。
//
// ===========================================================================
// 低レベル実装で「完全なUnicode対応」は現実的でないため、
// UTF-8 のバイト列として処理し、クラスタや正規化は扱わない方針が最適。
// ===========================================================================
//
//
//
// ================= UTF-8 最低限の実装ルール（低レベル用） ==========================
//
// • UTF-8 は ASCII 互換の可変長エンコード（1〜4バイト）
//
// --- バイト列として扱うこと ---
// • UTF-8 の途中バイトで切ると文字破壊（invalid UTF-8）。
// • しかし低レベルでは「byte index でsubstring」は普通に許容される。
// • “文字数”は byte count ではないが、実用上は byte count で良い。
//
// --- 先頭バイトの判定（1〜4byteの区別） ---
// • UTF-8 の先頭バイトは以下の形式：
//
//   0xxxxxxx          (1 byte ASCII)
//   110xxxxx 10xxxxxx (2 byte)
//   1110xxxx 10xxxxxx 10xxxxxx (3 byte)
//   11110xxx 10xxxxxx 10xxxxxx 10xxxxxx (4 byte)
//
// • 先頭バイトの HO ビットパターン：
//   0xxxxxxx → ASCII（高速処理）
//   110xxxxx → 2バイト文字
//   1110xxxx → 3バイト文字
//   11110xxx → 4バイト文字
//
// --- スキャン（次の文字に進む） ---
// • 先頭バイトを見て長さを決める：
//     if (b & 0x80) == 0        → 1 byte
//     else if (b & 0xE0) == 0xC0 → 2 bytes
//     else if (b & 0xF0) == 0xE0 → 3 bytes
//     else if (b & 0xF8) == 0xF0 → 4 bytes
//     else → invalid UTF-8
//
// • 低レベルでは invalid UTF-8 を無視する方針が一般的。
//
// --- substring（安全なやり方の最低限） ---
// • byte index をそのまま使うと破壊される可能性あり。
// • “安全にやりたい”場合は：
//     1)先頭から UTF-8 を decode しながら進む
//     2)要求の文字数ぶん先頭バイト位置を記録
//     3)その位置から丸ごとコピー
// • 完全対応は高コストなので通常は行わない。
//
// --- length（文字数） ---
// • strlen / byte count = “バイト長”であって“文字数”ではない。
// • UTF-8 の文字数を正確に数えるには UTF-8 decode が必要（重い）。
// • 低レベル実装では「byte length でOK」という運用が最適解。
//
// --- comparison（比較） ---
// • UTF-8 の byte 列比較は“見た目の等価性”と一致しない。
// • 正規化（NFC/NFD）を扱わない限り、同一視できない。
// • 低レベルでは “バイト列が一致すれば equal” で十分。
//
// --- まとめ ---
// • UTF-8 は「ASCII拡張バイト列」と割り切って使うのが現実的。
// • grapheme cluster・正規化は扱わない。
// • substring / length / index は byte-based でOK。
// • 必要なら先頭バイト識別で “1文字” の境界だけ簡易取得可能。
// ======================================================================

#include    "aoaa.inc"

.data
fmtStr:
    .ascii  "Unicode='"

    // e followed by U+301 (0xcc, 0x81 in UTF-8)

    .ascii  "e"
    .byte   0xCC, 0x81

    .asciz  "'\n"


.code
ttlStr:     wastr  "Lising14-6.S"

proc    getTitle, public
    lea    x0, ttlStr
    ret
endp    getTitle


proc    asmMain, public

    locals  lcl
    qword   saveX20_X21
    byte    stkSpace, 64
    endl    lcl

    enter   lcl.size      // Reserve space for locals

    lea     x0, fmtStr
    bl      printf

AllDone:    leave
endp    asmMain
