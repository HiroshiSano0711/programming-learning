package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	// ループで1つずつ文字列を連結するより効率的な方法
	fmt.Println(strings.Join(os.Args[1:], " "))
	fmt.Println(os.Args[1:])
}
