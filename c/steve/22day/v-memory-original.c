#include <stdio.h>

unsigned int PAGE_UNIT = 8192;
unsigned int PAGE_BLOCK = 64;
unsigned int BLOCK_UNIT = 128;
unsigned int BIT_MASK = 8191;

typedef struct {
  int base_addr; // ブロックのベースアドレス
} Par;
Par par[8];

#define CONVERT_TO_PHYSICAL_ADDR(v_addr) PAGE_BLOCK * par[(v_addr) >> 13].base_addr + ((v_addr) & BIT_MASK)

int main(){
  unsigned int virtual_addr;

  // Parの値を初期化。
  for (int i = 0; i < 8; i++){
    par[i].base_addr = BLOCK_UNIT * i;
  }
  
  for (virtual_addr = 0; virtual_addr < 65536; virtual_addr++){
    printf("ページ数 = %d, PAR = %d, 物理アドレス = %d \n",
      virtual_addr >> 13,
      par[virtual_addr >> 13].base_addr,
      CONVERT_TO_PHYSICAL_ADDR(virtual_addr)
    ); 
  }

  return 0;
}
