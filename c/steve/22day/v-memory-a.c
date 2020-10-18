#include <stdio.h>

unsigned int PAGE_UNIT = 8192;
unsigned int BLOCK_UNIT = 64;
unsigned int MAX_BLOCK_PER_PAGE = 128;
unsigned int BIT_MASK = 8191;

#define PAGE_COUNT 8
#define CONVERT_TO_PHYSICAL_ADDR(v_addr) BLOCK_UNIT * PAR[(v_addr) >> 13] + ((v_addr) & BIT_MASK)

int main(){
  unsigned int virtual_addr;

  unsigned int PAR[PAGE_COUNT] = {
    MAX_BLOCK_PER_PAGE * 0, // 128 * 64 → 8192 * ページ数
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0,
    MAX_BLOCK_PER_PAGE * 0
  };
  for (virtual_addr = 0; virtual_addr < 65536; virtual_addr++){
    printf("ページ数 = %d, 仮想アドレス = %d, 物理アドレス = %d \n",
      virtual_addr >> 13,
      virtual_addr,
      CONVERT_TO_PHYSICAL_ADDR(virtual_addr)
    );
  }

  return 0;
}
