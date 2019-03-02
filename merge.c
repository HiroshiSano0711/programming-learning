#include <stdio.h>

void merge();

int main(int argc, char const *argv[]){
  FILE *file_a, *file_b, *out_file;
  int x;

  file_a = fopen("aaa", "wb");
  file_b = fopen("bbb", "wb");

  printf("Enter\n");

  while(scanf("%d", &x), x){
    fwrite(&x, sizeof(int), 1, file_a);
  }

  while(scanf("%d", &x), x){
    fwrite(&x, sizeof(int), 1, file_b);
  }

  fclose(file_a); fclose(file_b);

  merge();
  out_file = fopen("ccc", "rb");

  while(fread(&x, sizeof(int), 1, out_file)){
    printf("%4d", x);
  }
  fclose(out_file);
  return 0;
}

void merge(){
  FILE *file_a, *file_b, *out_file;
  int a, b, size = sizeof(int);

  file_a = fopen("aaa", "rb");
  file_b = fopen("bbb", "rb");

  out_file = fopen("ccc", "wb");

  fread(&a, size, 1, file_a);
  fread(&b, size, 1, file_b);

  while(!feof(file_a) && !feof(file_b)){
    printf("1");
    if(a < b){
      printf("2");
      fwrite(&a, size, 1, out_file);
      fread(&a, size, 1, file_a);
    }else{
      printf("3");
      fwrite(&b, size, 1, out_file);
      fread(&b, size, 1, file_b);
    }
  }

  while(!feof(file_a)){
    printf("4");
    fwrite(&a, size, 1, out_file);
    fread(&a, size, 1, file_a);
  }

  while(!feof(file_b)){
    printf("5");
    fwrite(&b, size, 1, out_file);
    fread(&b, size, 1, file_b);
  }

  fclose(file_a);
  fclose(file_b);
  fclose(out_file);
}