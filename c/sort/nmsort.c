#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void nmsort();
void distribute();
void copyarun();
void merge();

int size = sizeof(float), number_of_runs;
FILE *f, *fa, *fb;
char tmpfil[25], tmpfila[25], tmpfilb[25];

/*

TODO: ファイルのエラー処理を確認する
10バイトのファイルを100バイト読み込んでみて
- freadの返り値
- feofの値
- ferrorの値
を確認する。

その上で、どのようにエラーを処理すれば良いかを考える

*/

int main(){
  char infil[25], outfil[25];
  FILE *fpin, *fpout;
  float x;
  clock_t start, stop;
  int count = 0, diff_time;
  int i = 0;

  printf("Name of input file:   "); scanf("%s", infil);
  printf("Name of scratch file 1:"); scanf("%s", tmpfil);
  printf("Name of scratch file 2:"); scanf("%s", tmpfila);
  printf("Name of scratch file 3:"); scanf("%s", tmpfilb);
  printf("Name of output file:   "); scanf("%s", outfil);

  fpin = fopen(infil, "r");

  if(fpin == NULL){
    printf("Unknown name\n"); exit(1);
  }

  f = fopen(tmpfil, "wb");

  while(fscanf(fpin, "%f", &x) > 0){
    fwrite(&x, size, 1, f); count++;
  }

  fclose(fpin); fclose(f);

  start = clock();
  nmsort();
  stop = clock(); diff_time = stop - start;
  printf("nmsort n = %d, computing time: %d s\n", count, diff_time);

  fpout = fopen(outfil, "w");
  f = fopen(tmpfil, "rb");

  while(fread(&x, size, 1, f) > 0){
    fprintf(fpout, "%8.2f", x); i++;
    if(i == 10){
      fprintf(fpout, "\n"); i = 0;
    }
  }

  fclose(fpout);
  fclose(f);
  f = fopen(tmpfil, "wb");
  fclose(f);

  return 0;
}

// natural merge sortの略
void nmsort(){
  do {
    distribute();
    merge();
  } while (number_of_runs > 1);

  fa = fopen(tmpfila, "wb"); fclose(fa);
  fb = fopen(tmpfilb, "wb"); fclose(fb);
}

// 連を分ける
void distribute(){
  float x;
  f = fopen(tmpfil, "rb");
  fa = fopen(tmpfila, "wb");
  fb = fopen(tmpfilb, "wb");
  fread(&x, size, 1, f);

  while(!feof(f)){
    copyarun(f, fa, &x);
    if(feof(f))
      break;
    copyarun(f, fb, &x);
  }
  fclose(f); fclose(fa); fclose(fb);
}

// ファイルから読み込んで書き込む
void copyarun(FILE *in, FILE *out, float *pnext){
  float old;
  do {
    fwrite(pnext, size, 1, out);
    old = *pnext;
    fread(pnext, size, 1, in);
  } while (!(feof(in) || *pnext < old));
  number_of_runs++;
}

// 2つのファイルから値を読み込んで比較し1つのファイルにマージする
void merge(){
  float a, b, old;
  number_of_runs = 0;

  fa = fopen(tmpfila, "rb");
  fb = fopen(tmpfilb, "rb");
  f = fopen(tmpfil, "wb");

  fread(&a, size, 1, fa);
  fread(&b, size, 1, fb);

  while(!feof(fa) && !feof(fb)){
    if(a < b){
      fwrite(&a, size, 1, f);
      old = a;
      fread(&a, size, 1, fa);
      if(feof(fa) || a < old){ // ファイルの終了時 or 次の連の判定
        copyarun(fb, f, &b);
      }
    }else{
      fwrite(&b, size, 1, f);
      old = b;
      fread(&b, size, 1, fb);
      if(feof(fb) || b < old){ // ファイルの終了時 or 次の連の判定
        copyarun(fa, f, &a);
      }
    }
  }

  while(!feof(fa)){
    copyarun(fa, f, &a);
  }
  while(!feof(fb)){
    copyarun(fb, f, &b);
  }

  fclose(f); fclose(fa); fclose(fb);
}
