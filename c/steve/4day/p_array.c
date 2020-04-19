#include <stdio.h>
int array[3][3];

int main(int argc, char const *argv[]){
  int i, j;
  array[0][0] = 1;
  array[0][1] = 2;
  array[0][2] = 3;
  array[1][0] = 4;
  array[1][1] = 5;
  array[1][2] = 6;
  array[2][0] = 7;
  array[2][1] = 8;
  array[2][2] = 9;
  int array_2[3][3] = {
    {1,2,3},
    {4,5,6},
    {7,8,9}
  };

  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      printf("array = %d\n", array_2[i][j]);
      printf("array p = %p\n", &array_2[i][j]);
    }
  }
  
  return 0;
}
