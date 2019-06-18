#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

struct node {
    char *pword; int count; struct node *left, *right;
};

typedef struct node NODE;
char buffer[100];

int main(int argc, char const *argv[]){
    NODE *root, *ptr, *buildtree(), *search();
    root = NULL;
    root = builtree(root);

    printf("\n Frequency distibution: \n\n");

    printtree(root);

    while(printf("\n\n Enter a word, or type &&& to stop: "), fillbuffer(stdin), strcmp(buffer, "&&&")){
        ptr = search(root);

        if (ptr == NULL) {
            printf("Does not occur. \n");
        } else {
            printf("Number of occurrences: %d\n", ptr->count);
        }
    }

    return 0;
}

NODE *builtree(root)
NODE *root;
{
    char fillnam[40];
}