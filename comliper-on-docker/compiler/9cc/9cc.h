/*
参考サイト

低レイヤを知りたい人のためのCコンパイラ作成入門
Rui Ueyama <ruiu@cs.stanford.edu>
https://www.sigbus.info/compilerbook

*/

/*
文法の優先順位（低い順）
  1. == !=
  2. < <= > >=
  3. + -
  4. * /
  5. 単項+ 単項-
  6. ()
*/

#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// トークナイズで使用する。トークンの種類を表す
typedef enum {
  TK_RESERVED, // 記号
  TK_NUM, // 整数
  TK_IDENT, // 識別子
  TK_EOF, // 入力の終わりを表すトークン
} TokenKind;

// トークン保持のために使用。現在の入力トークンが入る
typedef struct Token Token;
struct Token {
  TokenKind kind; // トークンの型
  Token *next; // 次の入力トークン
  int val; // kindがTK_NUMの場合、その数値
  char *str; // トークン文字列
  int len;
};
extern Token *token;
extern char *user_input;

typedef enum {
  ND_ADD, // +
  ND_SUB, // -
  ND_MUL, // *
  ND_DIV, // /
  ND_ASSIGN, // =
  ND_LVAR, // 変数
  ND_EQ,  // ==
  ND_NE,  // !=
  ND_LT,  // <
  ND_LE,  // <=
  ND_NUM, // 整数
} NodeKind;

typedef struct Node Node;

struct Node {
  NodeKind kind; // ノードの型
  Node *lhs; // 左辺 left hand side(自己参照ポインタ)
  Node *rhs; // 右辺 right hand side(自己参照ポインタ)
  int val; // kindがND_NUMの場合のみ使う。演算する数字の値が入る
  int offset; // kindがND_LVARの場合のみ使う
};

extern Node *code[100];
Node *new_node(NodeKind, Node *, Node *);
Node *new_node_num(int);
void program();
Node *stmt();
Node *assign();
Node *expr();
Node *equality();
Node *relational();
Node *add();
Node *mul();
Node *unary();
Node *term();

void error_at(char *loc, char *format, ...);
bool startswith(char *p, char *q);
bool consume(char *op);
Token *consume_ident();
void expect(char *op);
int expect_number();
bool at_eof();
Token *new_token(TokenKind kind, Token *cur, char *str, int len);
Token *tokenize();
void gen(Node *node);
