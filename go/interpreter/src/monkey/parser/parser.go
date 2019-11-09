package parser

import (
	"monkey/ast"
	"monkey/lexer"
	"monkey/token"
)

type Parser struct {
	l *lexer.Lexer // 字句解析器へのポインタ

	curToken  token.Token // 現在のトークンを示す
	peekToken token.Token // 次のトークンを示す
}

func New(l *lexer.Lexer) *Parser {
	p := &Parser{l: l}

	// 2つのトークンを読み込む。これによってcurTokenとpeekTokenがセットされる。
	p.nextToken()
	p.nextToken()

	return p
}

// nextToken proceed curToken and peekToken
func (p *Parser) nextToken() {
	p.curToken = p.peekToken
	p.peekToken = p.l.nextToken()
}

func (p *Parser) ParseProgram() *ast.Program {
	return nil
}
