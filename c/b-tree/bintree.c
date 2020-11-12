#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <ctype.h>

struct node {
  char *pword;
  int count;
  struct node *left, *right;
};
typedef struct node NODE;
char buffer[100];

int fillbuffer(FILE *fp);
void printtree(NODE *p);


int main(){
  NODE *root, *ptr, *buildtree(), *search();
  root = NULL;
  root = buildtree(root);

  printf("\n Frequency distribution: \n\n");
  printtree(root);
  while(printf("\n\n Enter a word, or type &&& to stop: "),
    fillbuffer(stdin),
    strcmp(buffer, "&&&")
  ){
    ptr = search(root);
    if(ptr == NULL){
      printf("Does not occur \n");
    }else{
      printf("Number of occurrences: %d\n", ptr->count);
    }
  }
  return 0;
}

NODE *buildtree(NODE *root){
  char filnam[40];
  FILE *fp;
  NODE *addnode();
  int indic;

  printf("Input file: "); scanf("%s", filnam);
  fp = fopen(filnam, "r");
  if(fp == NULL){
    printf("File not available"); exit(1);
  }
  while((indic = fillbuffer(fp))){
    if(indic > 0){
      root = addnode(root);
    }
  }
  fclose(fp);
  return root;
}

int fillbuffer(FILE *fp){
  char *dest, *source, ch;
  if(fscanf(fp, "%s", buffer) <= 0){
    return 0;
  }
  if(strcmp(buffer, "&&&") == 0){
    return 1;
  }
  dest = source = buffer;
  while((ch = *source++)){
    ch = toupper(ch);
    if(isalpha(ch)){
      *dest++ = ch;
    }
  }
  *dest = '\0';
  return dest > buffer ? 1 : -1;
}

NODE *addnode(NODE *p){
  char *my_alloc();
  int indic;

  if(p == NULL){
    p = (NODE *)my_alloc(sizeof(NODE));
    p->pword = my_alloc(strlen(buffer) + 1);
    strcpy(p->pword, buffer);
    p->count = 1; p->left = p->right = NULL;
  }else{
    indic =strcmp(buffer, p->pword);
    if(indic < 0){
      p->left =addnode(p->left);
    }else if(indic > 0){
      p->right =addnode(p->right);
    }else{
      p->count++;
    }
  }
  return p;
}

char *my_alloc(int n){
  char *p;
  p = malloc(n);
  if(p == NULL){
    printf("Not enough memory\n"); exit(1);
  }
  return p;
}

void printtree(NODE *p){
  if(p != NULL){
    printtree(p->left);
    printf("%5d %s\n", p->count, p->pword);
    printtree(p->right);
  }
}

NODE *search(NODE *p){
  int indic;
  if(p == NULL){
    return NULL;
  }
  indic = strcmp(buffer, p->pword);
  return indic < 0 ? search(p->left) : indic > 0 ? search(p->right) : p;
}
