// 各ファイルはどのパッケージに一部であるかを示す宣言
package main

import "fmt"

/*
関数内で宣言された変数はローカル。
関数の外で宣言されてものは、それが属するパッケージの全てのファイルから見える。
名前が大文字から始まる場合はパッケージの外からも公開されてアクセス可能。

Goプログラマはキャメルケースをつかう
*/
const boilingF = 212.0

func main() {
	var f = boilingF
	var c = (f - 32) * 5 / 9
	fmt.Printf("boiling point = %g°F or %g°C\n", f, c)
}
