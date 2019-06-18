#include<stdio.h>

int main() {
   unsigned int cpuid, result, physical_address_bits, linear_address_bits; 

   cpuid = 0x80000008;

   __asm__ ("cpuid": "=a"(result): "0"(cpuid));

   physical_address_bits = result & 0xFF;
   linear_address_bits = (result >> 8) & 0xFF;

   printf("result = 0x%x\n", result);

   printf("physical_address_bits = 0x%x, (%d)\n",
          physical_address_bits, physical_address_bits);

   printf("linear_address_bits = 0x%x, (%d)\n",
          linear_address_bits, linear_address_bits);

   return 0;
}
