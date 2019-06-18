#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void nmsort();
void distribute();
void copyarun();
void merge();

int size = sizeof(float), number_of_runs;
FILE *working_file, *fa, *fb; // 作業するファイル

char tmpfil[25], tmpfila[25], tmpfilb[25];

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

  working_file= fopen(tmpfil, "wb");

  while(fscanf(fpin, "%f", &x) > 0){
    fwrite(&x, size, 1, working_file); count++;
  }

  fclose(fpin); fclose(working_file);

  start = clock();
  nmsort();
  stop = clock();; diff_time = stop - start;
  printf("nmsort n = %d, computing time: %d s\n", count, diff_time);

  fpout = fopen(outfil, "w");

  working_file = fopen(tmpfil, "rb");
  while(fread(&x, size, 1, working_file) > 0){
    fprintf(fpout, "%8.2f", x); i++;
    if(i == 10){
      fprintf(fpout, "\n"); i = 0;
    }
  }

  fclose(fpout);
  fclose(working_file);
  working_file = fopen(tmpfil, "wb");
  fclose(working_file);

  return 0;
}

void nmsort(){
  do
  {
    distribute();
    merge();
  } while (number_of_runs > 1);

  fa = fopen(tmpfila, "wb"); fclose(fa);
  fb = fopen(tmpfilb, "wb"); fclose(fb);
}

void distribute(){
  float x;
  working_file = fopen(tmpfil, "rb");
  fa = fopen(tmpfila, "rb");
  fb = fopen(tmpfilb, "rb");
  fread(&x, size, 1, working_file);

  while(!feof(working_file)){
    copyarun(working_file, fa, &x);

    if(feof(working_file)){
      break;
    }
    copyarun(working_file, fb, &x);
  }
  fclose(working_file); fclose(fa); fclose(fb);
}

void copyarun(FILE *in, FILE *out, float *pnext){
  float old;
  do
  {
    fwrite(pnext, size, 1, out);
    old = *pnext;
    fread(pnext, size, 1, in);
  } while (!(feof(in)) || *pnext < old);
  number_of_runs++;
}

void merge(){
  float a, b, old;
  number_of_runs = 0;

  fa = fopen(tmpfila, "rb");
  fb = fopen(tmpfilb, "rb");
  working_file = fopen(tmpfil, "wb");

  fread(&a, size, 1, fa);
  fread(&b, size, 1, fb);

  while(!feof(fa) && !feof(fb)){
    if(a < b){
      fwrite(&a, size, 1, working_file);
      old = a;
      fread(&a, size, 1, fa);
      if(feof(fa) || a < old){
        copyarun(fb, working_file, &b);
      }
    }else{
      fwrite(&b, size, 1, working_file);
      old = b;
      fread(&b, size, 1, fb);
      if(feof(fb) || b < old){
        copyarun(fa, working_file, &a);
      }
    }
  }

  while(!feof(fa)){
    copyarun(fa, working_file, &a);
  }
  while(!feof(fb)){
    copyarun(fb, working_file, &b);
  }

  fclose(working_file); fclose(fa); fclose(fb);
}







