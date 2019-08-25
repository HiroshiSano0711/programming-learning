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
  TK__NUM, // 整数トークン
  TK_EOF, // 入力の終わりを表すトークン
} TokenKind;

// トークン保持のために使用。現在の入力トークンが入る
typedef struct Token Token;
struct Token {
  TokenKind kind; // トークンの型
  Token *next; // 次の入力トークン
  int val; // kindがTK_NUMの場合、その数値
  char *str; // トークン文字列
};
Token *token;

char *user_input;

void error_at(char *loc, char *format, ...){
  va_list ap; // 可変長引数を受け取る va_listの中身＝＞ typedef char* va_list
  va_start(ap, format); // 可変長引数を１個の変数にまとめる

  int pos = loc - user_input;
  fprintf(stderr, "%s\n", user_input);
  fprintf(stderr, "%*s", pos, " ");
  fprintf(stderr, "^");
  vfprintf(stderr, format, ap); // まとめられた変数で出力する
  fprintf(stderr, "\n"); // 改行を出力して
  exit(1); // 異常終了する
}

// 次のトークンが期待している記号の時は、トークンを１つ読み進めて真を返す。それ以外は偽を返す。
bool consume(char op){
  // expect_number()関数でtoken->nextを実行しているので、この関数のtokenは次のトークンを指している
  if (token->kind != TK_RESERVED || token->str[0] != op){
    return false;
  }
  token = token->next;
  return true;
}

// 次のトークンが期待している記号の時は、トークンを１つ読み進めて真を返す。それ以外はエラー。
void expect(char op) {
  if (token->kind != TK_RESERVED || token->str[0] != op){
    error_at(token->str, "'%c'ではありません。");
  }
  token = token->next;
}

// 次のトークンが数値の時は、トークンを１つ読み進める。現在の数値を返す。
int expect_number(){
  if (token->kind != TK__NUM){ // トークンの種類が数値出ない場合、エラー
    error_at(token->str, "数ではありません。");
  }
  int val = token->val; // 現在の数値を保持する
  token = token->next; // トークンを１つ読み進める
  return val; // 数値を返す
}

// 終端かどうかを判定する
bool at_eof(){
  return token->kind == TK_EOF;
}

// 新しいトークンを生成して、curにつなげる
Token *new_token(TokenKind kind, Token *cur, char *str){
  Token *tok = calloc(1, sizeof(Token));
  tok->kind = kind; // 種類を代入
  tok->str = str; // 文字をを代入
  cur->next = tok; // curの次につなげる
  return tok;
}

// 入力文字列pをトークナイズしてそれを返す
Token *tokenize(char *p){
  Token head;
  head.next = NULL; // 次のトークンは最初ないのでNULLで初期化しておく
  Token *cur = &head; // cur変数を生成。新しいトークンをポインタ経由で操作するため。

  while (*p){
    if (isspace(*p)){
      p++;
      continue;
    }

    if (*p == '+' || *p == '-' || *p == '*' || *p == '/' || *p == '(' || *p == ')'){
      cur = new_token(TK_RESERVED, cur, p++); // 新しいトークンを作成して、かえってきた新しいトークンをcurに代入
      continue;
    }

    if (isdigit(*p)){
      cur = new_token(TK__NUM, cur, p);
      cur->val = strtol(p, &p, 10); // strtol: string to long 文字列を10進数を基数にロング型の数値へ変換する関する
      continue;
    }

    error_at(token->str, "トークナイズできません。");
  }

  new_token(TK_EOF, cur, p);
  return head.next;
}

typedef enum {
  ND_ADD, // +
  ND_SUB, // -
  ND_MUL, // *
  ND_DIV, // /
  ND_NUM, // 整数
} NodeKind;

typedef struct Node Node;

struct Node {
  NodeKind kind; // ノードの型
  Node *lhs; // 左辺 left hand side(自己参照ポインタ)
  Node *rhs; // 右辺 right hand side(自己参照ポインタ)
  int val; // kindがND_NUMの場合のみ使う。演算する数字の値が入る
};

Node *new_node(NodeKind, Node *, Node *);
Node *new_node_num(int);
Node *expr();
Node *mul();
Node *unary(); // 単項演算子か二項演算子を判別する
Node *term();

// 新しいノードを作成して、型と左辺、右辺を代入する
Node *new_node(NodeKind kind, Node *lhs, Node *rhs){
  Node *node = calloc(1, sizeof(Node));
  node->kind = kind;
  node->lhs = lhs;
  node->rhs = rhs;
  return node;
}

Node *new_node_num(int val){
  Node *node = calloc(1, sizeof(Node));
  node->kind = ND_NUM;
  node->val = val;
  return node;
}

// EBNF expr = mul ("+" mul | "-" mul)* のコード化
Node *expr(){
  Node *node = mul();

  for (;;){
    if (consume('+')){ // consume()関数でtoken->nextを実行しているので+の次のトークンを指す
      node = new_node(ND_ADD, node, mul());
    }else if(consume('-')){
      node = new_node(ND_SUB, node, mul());
    }else{
      return node;
    }
  }
}

// EBNF mul = term ("*" term | "/" term)* のコード化
Node *mul(){
  Node *node = unary();

  for (;;){
    if (consume('*')){
      node = new_node(ND_MUL, node, unary());
    }else if(consume('/')){
      node = new_node(ND_DIV, node, unary());
    }else{
      return node;
    }
  }
}

Node *unary(){
  if (consume('+')){
    return term();
  }
  if (consume('-')){
    return new_node(ND_SUB, new_node_num(0), term());
  }
  return term();
}

// EBNF term = "(" expr ")" | num のコード化
Node *term(){
  if (consume('(')){
    Node *node = expr();
    expect(')');
    return node;
  }
  return new_node_num(expect_number());
}

void gen(Node *node){
  if (node->kind == ND_NUM){
    printf("  push %d\n", node->val);
    return;
  }

  gen(node->lhs);
  gen(node->rhs);

  printf("  pop rdi\n");
  printf("  pop rax\n");

  switch (node->kind){
  case ND_ADD:
    printf("  add rax, rdi\n");
    break;
  case ND_SUB:
    printf("  sub rax, rdi\n");
    break;
  case ND_MUL:
    printf("  imul rax, rdi\n");
    break;
  case ND_DIV:
    printf("  cqo\n");
    printf("  idiv rdi\n");
    break;
  }

  printf("  push rax\n");
}

int main(int argc, char *argv[]){
  if(argc != 2){
    fprintf(stderr, "引数の個数が正しくありません");
    return 1;
  }

  user_input = argv[1];
  token = tokenize(user_input);
  Node *node = expr();

  printf(".intel_syntax noprefix\n");
  printf(".global main\n");
  printf("main:\n");

  // 構文木を下りながらコード生成
  gen(node);

  // 最終的に計算結果がraxにあるはずなので関数の返り値とする
  printf("  pop rax\n");
  printf("  ret\n");
  return 0;
}
