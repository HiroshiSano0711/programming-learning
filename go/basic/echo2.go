package main

import (
	"fmt"
	"os"
)

/*
for initialization; condition; post {
	// 0個以上の文
}

従来のwhileループ
for condition {
	// ...
}

従来の無限ループ
for condition {
	// ...
}
*/

func main() {
	var s, sep string

	// rangeは各繰り返しでインデックスとインデックスの位置にある要素の値の2つを生成する
	// Goは使われないローカル変数は許していない。ブランク識別子 _（アンスコ）を使う
	for _, arg := range os.Args[1:] {
		s += sep + arg
		sep = " "
	}
	fmt.Println(s)
}
