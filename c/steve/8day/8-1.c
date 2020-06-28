#include <stdio.h>
#include <stdlib.h>
char buff[100];

// '+' = (col + 1) * (row + 1);
// '-' = 5 * col * (row + 1);
// '|' = 3 * row * (col + 1);

// void write_col_cell(int col) {
//   int i;
//   for (i = 1; i <= col + 1; i++){
//     if (i == col + 1){
//       printf("+");
//       printf("\n");
//     } else {
//       printf("+");
//       printf("-----");
//     }
//   }
// }

// void write_row_cell(int col) {
//   int i, j;
//   for (i = 0; i < 3; i++){
//     for (j = 0; j < col + 1; j++){
//       printf("|     ");
//     }
//     printf("\n");
//   }
// }

// // 繰り返し版
// void write_square(int col, int row) {
//     write_col_cell(col);
//     for(int i = 0; i < row; i++) {
//         write_row_cell(col);
//         write_col_cell(col);
//     }
// }


// 再帰版
// void write_square(int col, int row, int i) {
//   if(i < row + 1) {
//     if(i == 1)
//       write_col_cell(col);
//     write_row_cell(col);
//     write_col_cell(col);
//     write_square(col, row, i + 1);
//   }
// }

void write_line(int col, char a, char b) {
    printf("%c", a);
    for(int i = 0; i < col; i++) {
        for(int j = 0; j < 5; j++) {
            printf("%c", b);
        }
        printf("%c", a);
    }
    printf("\n");
}

void write_square(int col, int row) {
    write_line(col, '+', '-');

    for(int i = 0; i < row; i++) {
        for(int j = 0; j < 3; j++) {
            write_line(col, '|', ' ');
        }
        write_line(col, '+', '-');
    }
}

int main(){
  int row, col;
 
  /* 縦横何マスにするか入力してもらう */
  printf("何行にしますか？\n");
  fgets(buff, sizeof(buff), stdin);
  sscanf(buff, "%d", &row);

  printf("何列にしますか？\n");
  fgets(buff, sizeof(buff), stdin);
  sscanf(buff, "%d", &col);

  if (row < 1 || col < 1) {
    printf("縦横はそれぞれ1以上の整数を入力してください。\n");
    exit(1);
  }
  
  /* マスを表示する */
  write_square(col, row);
  return 0;
}
