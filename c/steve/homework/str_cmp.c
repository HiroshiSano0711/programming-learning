#include <stdio.h>

int str_cmp(const char* str_1, const char* str_2){
  unsigned char *temp_str_1, *temp_str_2;

  // 符号付きのchar型は符号拡張によって予期せぬ変換が行われる場合があるのとunsigned char*にキャストする
  // intを返すためでもある
  for (temp_str_1 = (unsigned char*)str_1, temp_str_2 = (unsigned char*)str_2;
      *temp_str_1 == *temp_str_2 && *temp_str_1 != '\0';
      temp_str_1++, temp_str_2++) {
    ;
  }

  // 両方の文字が等しいなら'\0' - '\0'となるので0が返る('\0'（16進数では0x00)のため）
  // '\0' - 文字 = マイナスの値となるので、この場合はstr_2の方が文字列が長い
  // 文字 - '\0'= プラスの値となるので、この場合はstr_1の方が文字列が長い
  // 文字 - 文字 = 文字列中の一部の文字が違う場合は文字コードの引き算になるのでプラスかマイナスの値となる。
  // 等しい場合以外はマイナスか1以上の値が返される
  return *temp_str_1 - *temp_str_2;
}

int main(){
  char *str_1 = "abb";
  char *str_2 = "abc";
  char *str_3 = "abc123";
  char *str_4 = "abb";
  printf("%d\n", str_cmp(str_1, str_2));
  printf("%d\n", str_cmp(str_1, str_3));
  printf("%d\n", str_cmp(str_1, str_4));
  return 0;
}
