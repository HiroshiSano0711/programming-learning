package main

import (
	"fmt"
	"os"
)

func main() {
	// ループで1つずつ文字列を連結するより効率的な方法
	for index, arg := range os.Args {
		fmt.Println(index, arg)
	}
}
