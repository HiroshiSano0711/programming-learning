#include <stdio.h>
#include <stdlib.h>

FILE *fp;
char buf;
int nextchar(void);
int expression(void);
void error(char *);
int term(void);
int factor(void);

int main(){
    char filnam[25];
    int x;
    printf("This program read an input file. containing\n");
    printf("a VSL program, such as, ex. (3-2*5) \n\n");
    printf("Name of input file: "); scanf("%s", filnam);

    fp = fopen(filnam, "r");
    if (fp == NULL){
        error("File not available");
    }

    printf("\nVSL program read from file: \n\n");

    if (nextchar() != '{'){
        error("Open brace ({) expected");
    }

    buf = nextchar();
    x = expression();

    printf("\n\nComputed value: %d\n", x);

    if (buf != '}'){
        error("Close brace ({) expected");
    }
    fclose(fp);
    return 0;
}

int nextchar(void){
    int ch;
    do {
        ch = getc(fp);
        if (ch == EOF){
            error("End of file reached");
        }
        putchar(ch);
    } while (ch == ' ' || ch == '\n');
    return ch;
}

void error(char *str){
    printf("\nError: %s\n", str);
    exit(1);
}

int expression(){
    int x, y;
    char optor;
    x = term();
    while (buf == '+' || buf == '-'){
        optor = buf;
        buf = nextchar();
        y = term();
        if (optor == '+'){
            x += y;
        } else {
            x -= y;
        }
    }
    return x;
}

int term(){
    int x;
    x = factor();
    while (buf == '*'){
        buf = nextchar();
        x *= factor();
    }
    return x;
}

int factor(){
    int x;
    if (buf >= '0' && buf <= '9'){
        x = buf - '0';
    } else if (buf == '('){
        buf = nextchar();
        x = expression();
        if (buf != ')'){
            error("')' expected");
        }
    } else {
        error("Digit or '(' expected");
    }
    buf = nextchar();
    return x;
}
