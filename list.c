#include <stdio.h>
#include <stdlib.h>

int main()
{
  int x;
  struct node {
    int num;
    struct node *next;
  } *start, *p;

  start = NULL;
  printf("Enter a sequence of integers, followed by #:\n");

  while(scanf("%d", &x) > 0){
    p = start;
    start = (struct node *)malloc(sizeof(struct node));
    if(start == NULL){
      printf("Not enough memory"); exit(1);
    }
    start->num = x;
    start->next = p;
  }

  printf("\nIn reserve order, the following numbers were read: \n");
  for(p = start; p != NULL; p = p->next){
    printf("%5d\n", p->num);
  }

  return 0;
}