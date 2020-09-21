#include <stdio.h>

unsigned int PAGE_UNIT = 8192;
unsigned int PAGE_BLOCK = 64;
unsigned int BLOCK_UNIT = 128;
unsigned int BIT_MASK = 8191;

#define PAGE_COUNT 8
#define CONVERT_TO_PHYSICAL_ADDR(v_addr) PAGE_BLOCK * PAR[(v_addr) >> 13] + ((v_addr) & BIT_MASK)

int main(){
  unsigned int virtual_addr;

  // PARは全て0。 全て0〜8191の範囲にマッピングされる
  unsigned int PAR[PAGE_COUNT] = {
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 1,
    BLOCK_UNIT * 2,
    BLOCK_UNIT * 3,
    BLOCK_UNIT * 4,
    BLOCK_UNIT * 5,
    BLOCK_UNIT * 6,
    BLOCK_UNIT * 7
  };

  for (virtual_addr = 0; virtual_addr < 65536; virtual_addr++){
    printf("ページ数 = %d, PAR = %d, 物理アドレス = %d \n",
      virtual_addr >> 13,
      PAR[virtual_addr >> 13],
      CONVERT_TO_PHYSICAL_ADDR(virtual_addr)
    );
  }

  return 0;
}
