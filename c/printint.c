#include <stdio.h>

void printint(int w, int x);

int main()
{
  printint(10, 5482);
  return 0;
}

void printint(int w, int x){
  int n = 0, i, neg = x < 0;

  char digs[30];

  if(neg){
    x = -x;
  }

  do {
    digs[n++] = '0' + x % 10;
    x /= 10;
  } while(x);

  i = w - n; // i = 空き文字数
  if(neg){
    i--; // マイナスの場合は「-」の記号を入れないといけないので空き文字を1文字減らしている
  }

  while(i-- > 0){
    putchar(' ');
  }

  if(neg){
    putchar('-');
  }

  for(i = n - 1; i >= 0; i--){
    putchar(digs[i]);
  }
}
