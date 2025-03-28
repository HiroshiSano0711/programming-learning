package repl

import (
	"bufio"
	"fmt"
	"io"
	"monkey/lexer"
	"monkey/token"
)

// PROMPT indicates user type
const PROMPT = ">> "

// Start func start lexer input
func Start(in io.Reader, out io.Writer) {
	scanner := bufio.NewScanner(in)

	for {
		fmt.Printf(PROMPT)
		scanned := scanner.Scan()
		if !scanned {
			return
		}

		line := scanner.Text()
		l := lexer.New(line)

		for tok := l.NextToken(); tok.Type != token.EOF; tok = l.NextToken() {
			fmt.Printf("%+v\n", tok)
		}
	}
}
