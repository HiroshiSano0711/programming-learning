#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct node {
  char *name;
  long num;
  struct node *left, *right;
};

typedef struct node NODE;
NODE *root = NULL;
FILE *fp;
long itemcount = 0;
char strbuf[100];
int intbuf;

void loadtree();

int main(int argc, char const *argv[]){
  char ch;
  NODE *p, *search(), *add_or_change();
  while(1){
    printf(">>");
    scanf("%s", strbuf);
    if(strbuf[0] == '.'){
      switch (toupper(strbuf[1])){
      case 'L': loadtree(); break;
      case 'P': printf("\n\nContents: \n\n");
                printtree(root); break;
      case 'Q': exit(0);
      case 'S': savetree(); break;
      default: printf("\nWrong command; user L P Q or S\n");
        break;
      }
    }else{
      if (scanf("%ld", &intbuf) == 0){
        ch = getchar();
        if (ch == '?' || ch == '/'){
          p = search(root);
          if (p == NULL){
            printf("Unknowon name\n");
          }else if (ch == '?'){
            printf("%8ld", p->num);
          }else{
            p->num = -1L;
            itemcount--;
          }
        }else{
          printf("A name must be followed by a number,");
          printf("a question mark, or a slach\n");
          while (ch != '\n'){
            ch = getchar();
          }
        }
      }else{
        root = add_or_change(root);
      }    
    }
  }
  return 0;
}

void loadtree(){
  char filnam[50];
  NODE *pbtree();

  if (itemcount){
    printf("Workfile is not empty\n"); return;
  }

  printf("File name: "); scanf("%s", filnam);
  fp = fopen(filnam, "r");

  if (fp == NULL){
    printf("Unknown file\n"); return;
  }
  if (fscanf(fp, "%d", &itemcount) == 0){
    printf("File %s does not begin with an item count\n", filnam);
    return;
  }
  root = pbtree(itemcount);
  fclose(fp);
}

NODE *pbtree(int n) {
  int nleft, nright;
  NODE *p;
  char *my_alloc();

  if (n == 0){
    return NULL;
  }

  nleft = n >> 1;
  nright = n - nleft - 1;
  p = (NODE *)my_alloc(sizeof(NODE));
  p->left = pbtree(nleft);

  if (fscanf(fp, "%s %ld", strbuf, &p->num) < 2) {
    printf("Error in input file\n"); return NULL;
  }
  p->name = my_alloc(strlen(strbuf) + 1);
  strcpy(p->name, strbuf);
  p->right = pbtree(nright);
  return p;
}

NODE *add_or_change(NODE *p){
  char *my_alloc();
  int indic;
  if (p == NULL){
    p = (NODE *)my_alloc(sizeof(NODE));
    p->name = my_alloc(strlen(strbuf) + 1);
    strcpy(p->name, strbuf);
    p->num = intbuf;
    p->left = p->right = NULL;
    itemcount++;
  } else {
    indic = strcmp(strbuf, p->name);
    if (indic < 0){
      p->left = add_or_change(p->left);
    } else if (indic > 0){
      p->right = add_or_change(p->right);      
    } else {
      if (p->num == -1L){ itemcount++; }
      p->num = intbuf;
    }
  }
  return p;
}

char *my_alloc(int n) {
  char *p, *malloc;
  p = malloc(n);
  if (p == NULL){
    printf("Not enough memory\n"); exit(1);
  }
  
}
