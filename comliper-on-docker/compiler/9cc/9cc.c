#include "9cc.h"

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
