#include <stdio.h>
#include <stdlib.h>

struct node {
    int num; struct node *left, *right;
};

FILE *fp;

int main(){
    int n;
    struct node *root, *pbtree();
    fp = fopen("NUM.DAT", "r");
    fscanf(fp, "%d", &n);
    root = pbtree(n);
    fclose(fp);
    return 0;

struct node *pbtree(int n){
    int nleft, nright;
    struct node *p;

    if (n == 0) {
        return NULL;
    }

    nleft = (n -1) >> 1;
    nright = n - nleft - 1;

    p = (struct node *)malloc(sizeof(struct node));
    p->left = pbtree(nleft);
    fscanf(fp, "%d", &p->num);
    p->right = pbtree(nright);

    printf("%d", &p->left);
    return p;
}
