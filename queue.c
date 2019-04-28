#include <stdio.h>
#include <stdlib.h>

int main(){
    int x;
    struct node {
        int num;
        struct node *link;
    } *old, *new = NULL, *p;

    char ch;

    printf("Each time, enter: \n\n");
    printf(" ! followed by an integer to be stored\n");
    printf(" ? (to print the oldest integer in the queue)\n");

    while(1){
        do {
            ch = getchar();
        }while(ch != '!' && ch != '?' && ch != '$');

        if (ch == '!') {
            if (scanf("%d", &x) > 0) {
                p = (struct node *)malloc(sizeof(struct  node));
                if (p == NULL) {
                    printf("Memory full: use ? first, or use $\n");
                } else {
                    if (new == NULL) {
                        old = p;
                    } else {
                        new->link = p;
                    }
                    p->num = x;
                    new = p;
                }
            } else {
                printf("Integer expected\n");
            }
        } else if(ch == '?') {
            if (new == NULL) {
                printf("Use !... first, or use $\n");
            } else {
                printf("%30d\n", old->num);
                p = old;
                if (old == new) {
                    new = NULL;
                }else {
                    old = old->link;
                }
                free(p);
            }
        } else {
            break;
        }
    }
    return 0;
}
