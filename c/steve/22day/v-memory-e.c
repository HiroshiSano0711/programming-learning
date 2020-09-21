#include <stdio.h>

unsigned int PAGE_UNIT = 8192;
unsigned int PAGE_BLOCK = 64;
unsigned int BLOCK_UNIT = 128;
unsigned int BIT_MASK = 8191;

#define CONVERT_TO_PHYSICAL_ADDR(v_addr) PAGE_BLOCK * PAR[(v_addr) >> 13] + ((v_addr) & BIT_MASK)

int main(){
  unsigned int virtual_addr;

  unsigned int PAR[8] = {
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0,
    BLOCK_UNIT * 0
  };
  for (virtual_addr = 0; virtual_addr < 65536; virtual_addr++){
    printf("ページ数 = %d, PAR = %d, 物理アドレス = %d \n",
      virtual_addr >> 13,
      PAR[virtual_addr >> 13],
      CONVERT_TO_PHYSICAL_ADDR(virtual_addr) + 64
    );
  }

  return 0;
}
