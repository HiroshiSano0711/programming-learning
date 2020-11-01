package main

import (
	"flag"
	"fmt"
	"strings"
)

/*
flag.Bool()
Bool関数はbool型の新たなフラグ変数を生成する

3つの引数とる
flag.Bool(フラグの名前、変数のデフォルト値、メッセージ)
メッセージは不正な引数、不正なフラグ、あるいは-h -helpのどちらかを渡した場合に表示される

flag.String(名前、デフォルト値、メッセージ)
string型の変数を生成する

フラグ変数へのアクセスは*sepや*nのように間接的になされる必要がある

プログラムが実行されるとき、フラグ変数をそのデフォルト値から更新するためにフラグを使う前に
flag.Parseを呼び出す必要がある。
*/
var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "separator")

func main() {
	flag.Parse()
	fmt.Print(strings.Join(flag.Args(), *sep))

	if !*n {
		fmt.Println()
	}
}
