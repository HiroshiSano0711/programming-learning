#include <stdio.h>
#include <stdlib.h>

// 演習問題133p 1
int main(){
    struct node {
        int num;
        struct node *next;
    };
    typedef struct node NODE;
    NODE *start = NULL;
    NODE *p, *q;
    int x;

    while(scanf("%d", &x) > 0){
        p = (struct node *)malloc(sizeof(struct node));
        if(p == NULL){
            printf("Not enough memory"); exit(1);
        }
        p->num = x;
        p->next = NULL;
        if(start == NULL) {
            start = p;
        } else {
            q = start;
            while(q->next != NULL){
                q = q->next;
            }
            q->next = p;
        }
    }

    for(p = start; p != NULL; p = p->next){
        printf("%5d\n", p->num);
    }
    return 0;
}
