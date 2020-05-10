#include <stdio.h>

char buff[100];
int result;
char operator;
int value;

int main(){
  result = 0;

  while (1){
    printf("結果： %d\n", result);
    printf("演算子と数字を入力してね。qを入力すると止まるよ。\n");

    fgets(buff, sizeof(buff), stdin);
    sscanf(buff, "%c %d", &operator, &value);

    if (operator == '+'){
      result += value;
    }else if(operator == '-') {
      result -= value;
    }else if(operator == '*') {
      result *= value;
    }else if(operator == '/') {
      if (value == 0) {
        printf("0では割れません。");
        continue;
      }
      
      result /= value;
    }else if(operator == 'q') {
      break;
    }else{
      printf("演算子は+, -, *, /のどれかを入力してね");
    }
  }
  return 0;
}
