#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct node {
    char *name;
    long num;
    struct node *next;
};

typedef struct node NODE;
NODE *start, *end, *getnode();

NODE *getnode();
void printlist();
void loadlist();
void savelist();
void insert(NODE *p, char *str, long ii);
void delete(NODE *p);

int main(){
    char str[100], ch;
    long ii;
    int indic, found;
    NODE *p;

    start = end = getnode();

    while(1){
        printf(">>");
        scanf("%s", str);
        if (str[0] == '.'){
            switch (toupper(str[1])){
                case 'L': loadlist(); break;
                case 'P': printlist(); break;
                case 'S': savelist(); break;
                case 'Q': exit(0);
                default: printf("\n wrong command; use L P S or Q\n");
            }
        } else {
            end->name = str;
            p = start;
            while((indic = strcmp(p->name, str)) > 0)
                p = p->next;
            found = p != end && indic == 0;

            // '?'の時は表示
            // '/'の時は削除
            if (scanf("%ld", &ii) == 0){
                ch = getchar();
                if ((ch == '?' || ch == '/') && !found)
                    printf("Unknown name\n");
                else if(ch == '?')
                    printf("\n%-40s %8ld\n", str, p->num);
                else if(ch == '/')
                    delete(p);
                else {
                    printf("a name must be followed by a number.\n");
                    printf("a qustion mark, or a slash.\n");
                }
            } else {
                // 更新または挿入
                if (found)
                    p->num = ii;
                else
                    insert(p, str, ii);
            }
        }
    }
}

NODE *getnode(){
    NODE *p;
    p = (NODE *)malloc(sizeof(NODE));
    if (p == NULL)
        printf("Not enough memory\n");
    return p;
}

void printlist(){
    NODE *p;
    printf("\n\nContents:\n\n");
    p = start;
    while (p != end){
        printf("\n%-40s %8ld\n", p->name, p->num);
        p = p->next;
    }
}

// ファイルからデータを読み込んでリストの末尾に追加していく。
void loadlist(){
    NODE *p;
    char filnam[50], str[100];
    long ii;
    FILE *fp;
    if (start != end){
        printf("List is not empty\n"); return;
    }
    printf("File name: "); scanf("%s", filnam);
    fp = fopen(filnam, "r");
    if(fp == NULL){
        printf("Unknown File"); return;
    }
    while (fscanf(fp, "%s %ld", str, &ii) == 2){
        p = end;
        end = getnode();
        p->next = end;
        p->name = malloc(strlen(str) + 1);
        strcpy(p->name, str);
        p->num = ii;
    }
    fclose(fp);
}

void savelist(){
    NODE *p;
    char filnam[50];
    FILE *fp;
    printf("File name: "); scanf("%s", filnam);
    fp = fopen(filnam, "r");
    p = start;
    while(p != end){
        fprintf(fp, "%s %ld\n", p->name, p->num);
        p = p->next;
    }
    fclose(fp);
}

void insert(NODE *p, char *str, long ii){
    NODE *q;
    q = getnode();
    if(p == end)
        end = q;
    else
        *q = *p;
    p->next = q;
    p->name = malloc(strlen(str) + 1);
    strcpy(p->name, str);
    p->num = ii;
}

void delete(NODE *p){
    NODE *q;
    free(p->name);
    q = p->next;
    if (q == end)
        end = p;
    else
        *p = *q;
    free(q);
}
