#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void filqsort();
void fqsort(long left, long right);

int size = sizeof(float);
FILE *f;
char tmpfil[25];

int main(int argc, char const *argv[]){
    char infil[25], outfil[25];
    FILE *fpin, *fpout;
    float x;
    long t0, t1; int count = 0, dt;
    int i = 0;

    printf("Name of input file:      "); scanf("%s", infil);
    printf("Name of scratch file:    "); scanf("%s", tmpfil);
    printf("Name of output file:     "); scanf("%s", outfil);

    fpin = fopen(infil, "r");
    if(fpin == NULL){
        printf("Unknown name\n");
        exit(1);
    }

    f = fopen(tmpfil, "wb");

    while(fscanf(fpin, "%f", &x) > 0) {
        fwrite(&x, size, 1, f); count++;
    }
    fclose(fpin); fclose(f);

    t0 = clock();
    filqsort();
    t1 = clock(); dt = t1 - t0;
    printf("nmsort n = %d, computing time: %d s\n", count, dt);

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

void filqsort(){
    long left, right;
    f = fopen(tmpfil, "rb+");
    left = 0L;
    fseek(f, (long)-size, 2); right = ftell(f) / size;
    fqsort(left, right);
    fclose(f);
}

void fqsort(long left, long right){
    long i = left, j = right, middle;
    float x, xi, xj;

    do {
        middle = left + ((right - left) >> 1);
        fseek(f, middle * size, 0);
        fread(&x, size, 1, f);

        do {
            while(fseek(f, i * size, 0), fread(&xi, size, 1, f), xi < x)
                i++;
            while(fseek(f, j * size, 0), fread(&xj, size, 1, f), xj > x)
                j--;
            if (i > j)
                break;
            fseek(f, i * size, 0); fwrite(&xj, size, 1, f);
            fseek(f, j * size, 0); fwrite(&xi, size, 1, f);
        } while (++i <= --j);
        if (j - left < right - i){
            if (left < j)
                fqsort(left, j);
            left = i; j = right;
        } else {
            if (i < right)
                fqsort(i, right);
            right = j; i = left;
        }
    } while (left < right);
}
