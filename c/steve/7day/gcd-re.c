#include <stdio.h>
#include <assert.h>

char buff[100];

int gcd(int a_x, int a_y){
    printf("x = %d y = %d", a_x, a_y);
    if (a_y == 0) {
        printf(" 式 0\n");
        printf("result\n");
        return a_x;
    }
    if (a_x < a_y) {
        //式1
        printf(" 式 1\n");
        return gcd(a_y, a_x);
    } else {
        //式2
        printf(" 式 2\n");
        return gcd(a_x % a_y, a_y);
    }
    assert(0);
}

int main(){
    int x, y, c;
    int r;
    c = 0;
    while (1){
        printf("input x and y for gcd ");
        c = scanf("%d %d", &x, &y);
        if (c == 2) break;
    }
    if (x < 0) x *= -1;
    if (y < 0) y *= -1;
    r = gcd(x, y);
    printf("gcd = %d\n", r);
}