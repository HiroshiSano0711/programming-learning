#include "9cc.h"

Token *token;
char *user_input;

void error(char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  fprintf(stderr, "\n");
  exit(1);
}

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
bool consume(char *op){
  // expect_number()関数でtoken->nextを実行しているので、この関数のtokenは次のトークンを指している
  if ((token->kind != TK_RETURN && token->kind != TK_RESERVED) || strlen(op) != token->len || memcmp(token->str, op, token->len)){
    return false;
  }
  token = token->next;
  return true;
}

bool consume_return(int kind){
  // expect_number()関数でtoken->nextを実行しているので、この関数のtokenは次のトークンを指している
  if (token->kind != TK_RETURN || token->len != 6 || memcmp(token->str, "return", token->len)){
    return false;
  }
  token = token->next;
  return true;
}

Token *consume_ident(){
  if (token->kind != TK_IDENT){
    return NULL;
  }

  Token *t = token;
  token = token->next;
  return t;
}

// 次のトークンが期待している記号の時は、トークンを１つ読み進めて真を返す。それ以外はエラー。
void expect(char *op) {
  if (token->kind != TK_RESERVED ||
      strlen(op) != token->len ||
      memcmp(token->str, op, token->len)){
    error_at(token->str, "'%c'ではありません。");
  }
  token = token->next;
}

// 次のトークンが数値の時は、トークンを１つ読み進める。現在の数値を返す。
int expect_number(){
  if (token->kind != TK_NUM){ // トークンの種類が数値出ない場合、エラー
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
Token *new_token(TokenKind kind, Token *cur, char *str, int len){
  Token *tok = calloc(1, sizeof(Token));
  tok->kind = kind; // 種類を代入
  tok->str = str; // 文字を代入
  tok->len = len;
  cur->next = tok; // curの次につなげる
  return tok;
}

bool startswith(char *p, char *q) {
  return memcmp(p, q, strlen(q)) == 0;
}

bool is_alpha(char c) {
  return ('a' <= c && c <= 'z') ||
         ('A' <= c && c <= 'Z') ||
         (c == '_');
}

bool is_alnum(char c) {
  return is_alpha(c) || ('0' <= c && c <= '9');
}

// 入力文字列pをトークナイズしてそれを返す
Token *tokenize(){
  char *p = user_input;
  Token head;
  head.next = NULL; // 次のトークンは最初ないのでNULLで初期化しておく
  Token *cur = &head; // cur変数を生成。新しいトークンをポインタ経由で操作するため。

  while (*p){
    if (isspace(*p)){
      p++;
      continue;
    }

    if (strncmp(p, "return", 6) == 0 && !is_alnum(p[6])){
      cur = new_token(TK_RETURN, cur, p, 6);
      p += 6;
      continue;
    }

    if (is_alpha(*p)) {
      char *q = p++;
      while (is_alnum(*p))
        p++;
      cur = new_token(TK_IDENT, cur, q, p - q);
      continue;
    }

    if (startswith(p, "==") || startswith(p, "!=") ||
        startswith(p, "<=") || startswith(p, ">=")) {
      cur = new_token(TK_RESERVED, cur, p, 2);
      p += 2;
      continue;
    }

    if (strchr("+-*/()<>", *p)) {
      cur = new_token(TK_RESERVED, cur, p++, 1);
      continue;
    }

    if (ispunct(*p)) {
      cur = new_token(TK_RESERVED, cur, p++, 1);
      continue;
    }

    if (isdigit(*p)){
      cur = new_token(TK_NUM, cur, p, 0);
      char *q = p;
      // 文字列中に変換不可能な文字があった場合，その文字列へのポインタを endptr（第2引数 &p） に格納する
      // strtol: string to long 文字列を10進数を基数にロング型の数値へ変換する関する
      cur->val = strtol(p, &p, 10); // この処理で10+300のような一桁以上の数字もトークン化できる
      cur->len = p - q;
      continue;
    }

    error_at(token->str, "トークナイズできません。");
  }

  new_token(TK_EOF, cur, p, 0);
  token = head.next;
  return token;
}
