#include <stdio.h>
#include <stdlib.h>

typedef struct Token Token;
struct Token {
  Token *next;
  char str;
};
Token *token;

Token *new_token(Token *current, char str)
{
  Token *token = malloc(1, sizeof(Token));
  token->str = str;
  current->next = token;
  return token;
}

int main()
{
  char *user_input = "((()((())())))";
  Token head;
  head.next = NULL;
  Token *current = &head;

  while (*user_input){
    if (*user_input == '('){
      current = new_token(current, *user_input);
      user_input++;
      continue;
    }

    if (*user_input == ')'){
      current = new_token(current, *user_input);
      user_input++;
      continue;
    }
  }

  // 動作確認用の出力
  char result[6][1];
  int i = 0;
  for (Token *test = &head; test != NULL; test = test->next)
  {
    printf("%c\n", test->str);
    result[i][0] = test->str;
    i++;
  }
  return 0;
}
