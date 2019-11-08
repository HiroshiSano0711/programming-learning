#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

char *read_file(char *path) {
  // ファイルを開く
  FILE *fp = fopen(path, "r");
  if (!fp)
    printf("cannot open %s", path);

  // ファイルの長さを調べる
  if (fseek(fp, 0, SEEK_END) == -1)
    printf("%s: fseek", path);
  size_t size = ftell(fp);
  if (fseek(fp, 0, SEEK_SET) == -1)
    printf("%s: fseek", path);

  // ファイル内容を読み込む
  char *buf = calloc(1, size + 2);
  fread(buf, size, 1, fp);

  // ファイルが必ず"\n\0"で終わっているようにする
  if (size == 0 || buf[size - 1] != '\n')
    buf[size++] = '\n';
  buf[size] = '\0';
  fclose(fp);
  return buf;
}

typedef enum {
  NUMBER,
  ADD
} TokenKind;

typedef struct Token Token;
struct Token {
  TokenKind kind;
  Token     *next;
  int       value;
  char      str[100];
};

Token *token;

Token *new_token(TokenKind kind, Token *list) {
  Token *tok = calloc(1, sizeof(Token));
  tok->kind = kind;
  list->next = tok;
  return tok;
}
void tokenize(char *p);

int main(int argc, char const *argv[]) {
  char *file_contents = read_file("main.txt");
  tokenize(file_contents);
  program();
  return 0;
}

/*

文法規則
stmt     = expr ";"
expr     = add
add      = num ("+" num)*

*/
void statement(){
  // 式が１つ以上
  Node *node = expr();
  // 次の文字がセミコロン

}

void tokenize(char *p) {
  Token head;
  head.next = NULL;
  Token *list = &head;

  while(*p){
    if(isspace(*p)){
      p++;
      continue;
    }
    if (strchr("+", *p)) {
      list = new_token(ADD, list);
      strncpy(list->str, p, 1);
      p++;
      continue;
    }
    if (isdigit(*p)){
      list = new_token(NUMBER, list);
      list->value = strtol(p, &p, 10);
      continue;
    }
    printf("文法エラー： この文字は使えません。 %s", p);
    exit(1);
  }
  token = head.next;
}
