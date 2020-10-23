package main

// osパッケージはプラットフォームから独立した形式でOSを扱うための関数と値を提供する
import (
	"fmt"
	"os"
)

// os.Args[0]はコマンド自身の名前
// os.Args[m:n]の形をしたスライス式は、m番目からn-1番目の要素を参照するスライスを生成する
// Goではすべてのインデックスの指定は半開区間で、最初のインデックスを含み最後のインデックスを含まない
func main() {
	var s, sep string
	for i := 1; i < len(os.Args); i++ {
		s += sep + os.Args[i]
		sep = " "
	}
	fmt.Println(s)
	fmt.Println(os.Args[1:4])
}
