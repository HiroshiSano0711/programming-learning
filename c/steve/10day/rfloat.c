#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

float rdflo(void) {
    float x = 0.0, y = 0.0;
    int leng = 0;
    int dot = 0;
    int neg = 0;
    int ch;

    ch = getchar();
    if(ch == '+')
        neg = 0;
    if(ch == '-')
        neg = 1;

    while (1) {
        if (!dot && ch == '.') {
            dot = 1;
            printf("dot\n");
            ch = getchar();
            continue;
        }
        if (ch == EOF || ch == '\n') {
            printf("EOF\n");
            break;
        }
        if (!isdigit(ch)) {
            printf("数字を入力してください");
            exit(1);
        }
        if (dot) {
            printf("y ch = %c\n", ch);
            y = y * 10.0 + (ch - '0');
            leng++;
        } else {
            printf("x ch = %c\n", ch);
            x = x * 10.0 + (ch -'0');
        }
        ch = getchar();
    }
    y = y / pow(10.0 ,leng);
    return (x + y) * (neg ? -1.0 : 1.0);
}

int main() {
    float x;
    x = rdflo();
    printf("main x = %f\n", x);
}
