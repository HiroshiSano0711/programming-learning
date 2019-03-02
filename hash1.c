#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

#define LEN 1000

struct {
  char k[21]; int d;
} a[LEN];

int store(char *, int);
int lookup(char *, int *);
int hash(char *);

int main(int argc, char const *argv[]){
  FILE *fp;
  char key[100];
  int dat;

  fp = fopen("data", "r");

  if(fp == NULL){
    printf("File DATA ???"); exit(1);
  }
  while(fscanf(fp, "%s %d", key, &dat) > 0){
    key[20] = '\0';
    if(store(key, dat) == 0){
      printf("Table full or duplicate key: (%s, %d)", key, dat);
    }
  }

  fclose(fp);

  while(printf("\nEnter a string, or ! to stop: "),
        scanf("%s", key),
        key[20] = '\0',
        strcmp(key, "!")){
    if(lookup(key, &dat)){
      printf("Data fiels: %6d\n", dat);
    }else{
      printf("Key not stored in hash table\n");
    }
  }
  return 0;
}

int store(char *key, int dat){
  int i, count = 0;
  i = hash(key);
  while(strlen(a[i].k)){
    if(strcmp(a[i].k, key) == 0 || ++count == LEN){
      return 0;
    }
    if(++i == LEN){
      i = 0;
    }
  }
  strcpy(a[i].k, key); a[i].d = dat;
  return 1;
}

int lookup(char *key, int *pdat){
  int i, count = 0;
  i = hash(key);
  while(strcmp(a[i].k, key)){
    if(strlen(a[i].k) == 0 || ++count == LEN){
      return 0;
    }
    if(++i == LEN){
      i = 0;
    }
  }
  *pdat = a[i].d;
  return 1;
}

int hash(char *key){
  int slen = strlen(key);
  return (101 * key[0] + 103 * key[slen - 1] + 107 * slen) % LEN;
}
