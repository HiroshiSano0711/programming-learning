#include <stdio.h>

// 対応するカッコ同士でまとめる
int main(int argc, char const *argv[])
{
  char *paren = "((()((())())))";
  int stack[100];
  int result[15];
  int i = 0;
  int j = 0;
  while (*paren != '\0'){
    printf("%s\n", paren);
    if (*paren == '('){
      stack[i] = 40;
      i++;
    } else if (*paren == ')'){
      i--;
      result[j] = stack[i]; j++;
      result[j] = 41; j++;
    }
    paren++;
  }
  for (int k = 0; k < 14; k++){
     printf("%d\n", result[k]);
  }
  return 0;
}
