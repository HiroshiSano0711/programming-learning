#include <stdio.h>
#include <stdlib.h>

struct node {
    int index;
    struct node *next;
};

typedef struct node NODE;

// ノードをポインタでつないで、出力する練習
// 構造体を使って、mallocでメモリを確保する。
int main(){
    NODE *current_node;
    NODE head;
    head.next = NULL;
    current_node = &head;

    for(int i = 0; i < 5; i++){
        NODE *new_node = (NODE *)malloc(sizeof(NODE));
        new_node->index = (i + 1)* 10;
        current_node->next = new_node;
        current_node = new_node;
    }

    NODE *p = head.next;
    while(p){
        printf("%d\n", p->index);
        p = p->next;
    }

    return 0;
}
