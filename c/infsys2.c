#include <stdio.h>
#include <stdlib.h>

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
    
  }
  
  
}